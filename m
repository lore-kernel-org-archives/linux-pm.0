From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 00/15] Add Intel Cherry Trail Whiskey Cove PMIC support
Date: Fri, 17 Mar 2017 10:55:12 +0100
Message-ID: <20170317095527.10487-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi All,

Here is a patch-series adding support for the Intel Cherry Trail Whiskey
Cove PMIC. The first 2 patches have been send before and as such are
at v3 now, the rest is new. This series touches a lot of subsystems
(as usually is the case with mfd devices). I'm sending this as a single
series so that people can see how all the bits fit together.

Patches 1-13 do not have any interdependencies (other then runtime deps
which are not a problem for merging) and can be merged directly into
their resp. subsystems when they pass review.

Patch 14: power: supply: Add driver for Cherry Trail Whiskey Cove
PMIC Fuel Gauge, depends on the i2c-core changes from patches 11-13.

Patch 15: i2c-cht-wc: Add Intel Cherry Trail Whiskey Cove SMBUS
controller driver, depends on both the bq24190_charger patches as it
uses new bq24190_platform_data fields for the i2c_board_info->platform_data
for the i2c client it registers, as well as on patch 14 as it uses
the cht_wc_fg_get_property symbol that patch adds/exports.

Regards,

Hans
