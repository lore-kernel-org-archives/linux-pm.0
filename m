From: Chen-Yu Tsai <wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 0/9] ARM: sun8i: a83t: Enable USB OTG
Date: Thu, 21 Mar 2019 16:48:41 +0800
Message-ID: <20190321084850.20769-1-wens@kernel.org>
Reply-To: wens-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBAFAZXSAKGQEZCDPJ6Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Hi everyone,

This is v3 of my A83T USB power supply / OTG series. Changes since v2:

  - Added Rob's ack for dt bindings patch
  - Rebased onto v5.1-rc1

Changes since v1:

  - Added Lee's ack for mfd patch
  - Make axp803_usb_power_supply_resources[] const

This series has since been tested. Both host mode and gadget mode work
well. However this SoC seems to have a glitch in hardware. After host
mode is used by plugging in a host mode cable, the hardware will not
revert back to gadget mode if a standard USB cable is plugged in. Host
mode continues to work however. This will likely have to be addressed
with some workaround in either the musb driver or our USB PHY driver.

The patches have no cross-tree dependencies, so each part can go through
their respective trees (power-supply / mfd / arm-soc).

I also have some follow-up patches to enable the USB power supply on
AXP803 / A64. It's the boiler-plate mfd cell and device node addition.

Original cover letter follows:

This series enables USB OTG on the A83T boards. The AXP813/AXP818 PMICs
used with the A83T have the same behavior as the AXP221 and AXP223,
where if the N_VBUSEN pin is driven high, the VBUS sensing interrupts
stop working. In the past Hans made a polling workaround in the USB PHY
driver. In this series polling is added to the power supply driver.

The power supply driver work was started by Quentin, and shared with me
when I expressed interest in getting USB OTG to work some time ago.
Neither of us got around to finishing it, until now that is.

Patch 1 adds a new compatible string for the AXP813 VBUS power supply
part.

Patch 2 is a bit of cleanup work for the driver.

Patch 3 allows disabling VBUS input current limiting on the AXP20x /
AXP22x PMICs. While not strictly related to this series, I found it
easier to just send everything together. This patch depends on the
previous one.

Patch 4 adds the VBUS status polling feature. This is enabled on AXP221
and all later PMICs.

Patch 5 factors out code to read out the configured input current limit
for the AXP20x and AXP22x PMICs. As the AXP813 uses different values,
factoring out the code based on model will make the main function more
readable.

Patch 6 adds support for the AXP813 VBUS power supply. checkpatch.pl
reports a few warnings for this patch:

    WARNING: Possible switch case/default not preceded by break or
    fallthrough comment
    #100: FILE: drivers/power/supply/axp20x_usb_power.c:306:
    +       case 1500000:

    WARNING: Possible switch case/default not preceded by break or
    fallthrough comment
    #101: FILE: drivers/power/supply/axp20x_usb_power.c:307:
    +       case 2000000:

    WARNING: Possible switch case/default not preceded by break or
    fallthrough comment
    #102: FILE: drivers/power/supply/axp20x_usb_power.c:308:
    +       case 2500000:

However they seem to be a false positive. The preceding line of the
reported lines is a return statement, which is definitely not a
fallthrough.

Patch 7 adds an mfd cell for the newly supported VBUS power supply.

Patch 8 adds a device node for the VBUS power supply to the common
axp81x dtsi file.

Patch 9 enables USB OTG on the Cubietruck Plus and Bananapi M3.

Please have a look, and also test it on boards you have, and don't
limit it to just the A83T ones. As mentioned above, the polling feature
affects all boards that have an AXP221 or newer PMIC.

I haven't removed the polling workaround from the USB PHY driver yet.
That would be the next step after this series is merged, and preferrably
a release has passed.


Regards
ChenYu


Chen-Yu Tsai (5):
  dt-bindings: power: supply: axp20x_usb_power: add axp813 compatible
  power: supply: axp20x_usb_power: Fix typo in VBUS current limit macros
  power: supply: axp20x_usb_power: allow disabling input current
    limiting
  power: supply: axp20x_usb_power: use polling to detect vbus status
    change
  ARM: dts: sun8i: a83t: Enable USB OTG controller on some boards

Quentin Schulz (4):
  power: supply: axp20x_usb_power: add function to get max current
  power: supply: axp20x_usb_power: add support for AXP813
  mfd: axp20x: add USB power supply mfd cell to AXP813
  ARM: dtsi: axp81x: add USB power supply node

 .../power/supply/axp20x_usb_power.txt         |   1 +
 arch/arm/boot/dts/axp81x.dtsi                 |   4 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  |  12 ++
 .../boot/dts/sun8i-a83t-cubietruck-plus.dts   |  12 ++
 drivers/mfd/axp20x.c                          |  11 ++
 drivers/power/supply/axp20x_usb_power.c       | 184 +++++++++++++++---
 6 files changed, 197 insertions(+), 27 deletions(-)

-- 
2.20.1
