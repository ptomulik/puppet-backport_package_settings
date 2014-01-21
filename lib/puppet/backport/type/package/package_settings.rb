package = Puppet::Type.type(:package)

unless package.features.include? :package_settings
  package.feature :package_settings, "The provider accepts package_settings to be
      ensured for the given package. The meaning and format of these settings is
      provider-specific.",
      :methods => [:package_settings_insync?, :package_settings, :package_settings=]

  package.newproperty(:package_settings, :required_features=>:package_settings) do
      desc "Package settings. The definition of package settings is provider
        specific. In general, these are certain properties which alter contents
        of a package being installed. An example of package settings are the
        FreeBSD ports options.

        The package_settings attribute is a property. This means that the
        options can be enforced during package installation and
        verified/retrieved for packages that are already installed.

        For example, portsng provider
        ([ptomulik-portsng](https://github.com/ptomulik/puppet-portsng)) 
        on FreeBSD implements the package settings as port build options (the
        ones you normally set with make config). There is a simple usage
        example for this particular provider:

            package { 'www/apache22':
              package_settings => { 'SUEXEC' => false },
              provider => portsng
            }

        The above manifest ensures, that apache22 is compiled without SUEXEC
        module.

        Despite the package_settings are provider specific, the typical
        behavior, when you change package_settings in  your manifest, is to
        reinstall package with new settings.
        "

      validate do |value|
        if provider.respond_to?(:package_settings_validate)
          provider.package_settings_validate(value)
        else
          super(value)
        end
      end

      munge do |value|
        if provider.respond_to?(:package_settings_munge)
          provider.package_settings_munge(value)
        else
          super(value)
        end
      end

      def insync?(is)
        provider.package_settings_insync?(should, is)
      end

      def should_to_s(newvalue)
        if provider.respond_to?(:package_settings_should_to_s)
          provider.package_settings_should_to_s(should, newvalue)
        else
          super(newvalue)
        end
      end

      def is_to_s(currentvalue)
        if provider.respond_to?(:package_settings_is_to_s)
          provider.package_settings_is_to_s(should, currentvalue)
        else
          super(currentvalue)
        end
      end

      def change_to_s(currentvalue, newvalue)
        if provider.respond_to?(:package_settings_change_to_s)
          provider.package_settings_change_to_s(currentvalue, newvalue)
        else
          super(currentvalue,newvalue)
        end
      end
    end
end
