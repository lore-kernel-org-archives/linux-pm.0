From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 00/18] Hookup typec power-negotation to the PMIC and charger
Date: Sun,  6 Aug 2017 14:35:37 +0200
Message-ID: <20170806123555.5124-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbdHFMgA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 6 Aug 2017 08:36:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org

Hi All,

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

Assuming this series gets a favorable review then the question becomes how
to merge this. This series has staging/typec, drivers/power/supply,
drivers/platform/x86 and drivers/i2c patches.

All these patches can be merged indepently, but the drivers/platform/x86
and drivers/i2c glue patches really should not be applied until the other
patches are in place.

Assuming no one nacks the concept of using a power-supply class device which
represents the USB Type-C power-brick, then all the typec and power patches
can be merged indepdently and as soon as they are deemed ready.

The only exception is the "power: supply: bq24190_charger: Remove extcon
handling" patch, which should not be merged until the drivers/i2c patch
removing the extcon handling from the bq24190 i2c-client instantiated there
has been merged.

Please let me know what you think and feel free to merge any patches you
like as is, then I can do a v2 addressing comments in the remaining patches.

Regards,

Hans
