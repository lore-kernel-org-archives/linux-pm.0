From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 00/11] Hookup typec power-negotation to the PMIC and charger
Date: Wed, 30 Aug 2017 11:48:03 +0200
Message-ID: <20170830094814.17758-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

Hi All,

Here is v3 of my typec power-negotation hookup series. New this version:
- Drop a few patches merged into linux-power-supply.git/for-next
- Drop the "power: supply: bq24190_charger: Remove extcon handling"
  patch *for now*, this can only be merged once all the other patches are
  in place (and extcon handling is no longer needed)
- Address some review comments in some of the other patches, see the
  per patch changelogs inside the commit messages

I believe that this series is ready for merging now and I would like to
ask the various subsys maintainers to pick up and merge these patches.
All the patches can be merged independent of eachother with the exception
of the last 2 patches:

i2c-cht-wc: Add device-properties for fusb302 integration
platform/x86: intel_cht_int33fe: Update fusb302 type string, add properties

Which should not be merged until all the other patches are in place.

For reference below is the cover letter of v2 of this patch.

Regards,

Hans


v2 series cover letter:

This series implements a number of typec changes discussed a while back:

- It exports the negotiated voltage and max-current in the form of a
  power-supply class device which represents the USB Type-C power-brick
  (adapter/charger)
- It adds a power_supply_set_input_current_limit_from_supplier helper
  function which charger drivers can use to get the max-current from
  their supplier
- It adds regulator support to the charger IC on the device I've. The
  exported regulator controls the 5v boost convertor which generates the
  5V USB vbus which gets output when the Type-C port is in host / power-src
  mode
- It adds a bunch of misc. related fixes and glue code to tie everything
  together

One thing which was undecided in the previous discussion was how to make
port-controller drivers hookup to external ICs (e.g. a non Type-C aware PMIC)
to decect the input-current-limit for USB2 power-sources (through e.g. BC1.2
detection). Since a number of existing drivers, including the one for the
PMIC used on the 2 mini laptops I'm working on, already use the extcon
framework to communicate the detected USB2 charger-type, I've decided to
simply hook into this existing code. As this patch set shows this can be
done with zero changes to the existing PMIC/extcon drivers.

With this series the GPD win and GPD pocket mini laptops both fully
support any type of Type-C charging. When hooked up with:
-A -> C cable and plugged into a regular port they charge at 5V 0.5A
-A -> C cable and plugged into a dedictaed charger they charge at 5V 2A
-C -> C cable and plugged into a fixed 5V 3A charger, at 5V 3A
-C -> C cable and plugged into a PD capable charger, which delivers max 12V, 2A
 they charge at 12V, 2A

And when a Type-C to USB-A receptacle (so host mode) cable gets plugged in
the port correctly supplies 5V to any plugged in USB-A peripherals.

This is v2 of this series, which has the following changes (see
changelog inside individual patches for details):

-Add "i2c: Allow overriding dev_name through board_info" patch, this is
 necessary for getting stable dev_names which are necessary for specifying
 regulator-mappings through regulator_init_data
-Use regulator_init_data to specify mapping,  drop "staging: typec:
 fusb302: Add support for fcs,vbus-regulator-name device-property" patch
-Merged helper code for port-c related extcon / power_supply handling
 directly into the fusb302 patches using the code, rather then trying
 to add generic helpers even though there is only 1 user
