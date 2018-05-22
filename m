From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/2] typec: tcpm: Populate fwnode for use in power_supply core
Date: Tue, 22 May 2018 16:16:22 +0100
Message-ID: <cover.1527000797.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

This patch set adds support for passing a fwnode pointer as part of the psy
config structure, when intialising the psy core, so that calling code can be
written to be agnostic of the HW description required for the platform. The TCPM
code is updated subsequently to make use of this new field.

For now the main FW support in the psy core is still just DT based but in the
future ACPI will likely be added and can use this field.

Adam Thomson (2):
  power: supply: Add fwnode pointer to power_supply_config struct
  typec: tcpm: Provide fwnode pointer as part of psy_cfg

 drivers/power/supply/power_supply_core.c | 4 +++-
 drivers/usb/typec/tcpm.c                 | 2 ++
 include/linux/power_supply.h             | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
1.9.1
