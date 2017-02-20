From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v19 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Mon, 20 Feb 2017 16:51:06 +0800
Message-ID: <cover.1487578977.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently the Linux kernel does not provide any standard integration of this
feature that integrates the USB subsystem with the system power regulation
provided by PMICs meaning that either vendors must add this in their kernels
or USB gadget devices based on Linux (such as mobile phones) may not behave
as they should. Thus provide a standard framework for doing this in kernel.

Now introduce one user with wm831x_power to support and test the usb charger.
Another user introduced to support charger detection by Jun Li:
https://www.spinics.net/lists/linux-usb/msg139425.html
Moreover there may be other potential users will use it in future. 

1. Before v19 patchset we've fixed below issues in extcon subsystem and usb
phy driver, now all were merged. (Thanks for Neil's suggestion)
(1) Have fixed the inconsistencies with USB connector types in extcon subsystem
by following links:
https://lkml.org/lkml/2016/12/21/13
https://lkml.org/lkml/2016/12/21/15
https://lkml.org/lkml/2016/12/21/79
https://lkml.org/lkml/2017/1/3/13

(2) Instead of using 'set_power' callback in phy drivers, we will introduce
USB charger to set PMIC current drawn from USB configuration, moreover some
'set_power' callbacks did not implement anything to set PMIC current, thus
remove them by following links:
https://lkml.org/lkml/2017/1/18/436
https://lkml.org/lkml/2017/1/18/439
https://lkml.org/lkml/2017/1/18/438
Now only two phy drivers (phy-isp1301-omap.c and phy-gpio-vbus-usb.c) still
used 'set_power' callback to set current, we can remove them in future. (I
have no platform with enabling these two phy drivers, so I can not test them
if I converted 'set_power' callback to USB charger.)

2. Some issues pointed by Neil Brown were sill kept in this v19 patchset, and
I expalined each issue and may be need discuss again:
(1) Change all usb phys to register an extcon and to send appropriate notifications.
Firstly, now only 3 USB phy drivers (phy-qcom-8x16-usb.c, phy-omap-otg.c and
phy-msm-usb.c) had registered an extcon, mostly did not. I can not change all
usb phys to register an extcon, since there are no extcon device to register
for these different phy drivers.
Secondly, I also agreed with Peter's comments: Not only USB PHY to register
an extcon, but also for the drivers which can detect USB charger type, it may
be USB controller driver, USB type-c driver, pmic driver, and these drivers
may not have an extcon device since the internal part can finish the vbus
detect.

(2) Change the notifier of usb_phy to be used consistently.
Now only 3 phy drivers (phy-generic.c, phy-ab8500-usb.c and phy-gpio-vbus-usb.c)
used the notifier of usb_phy. phy-generic.c and phy-gpio-vbus-usb.c were used to
send out the connect events, and phy-ab8500-usb.c also was used to send out the
MUSB connect events. There are no phy drivers will notify 'vbus_draw' information
by the notifier of usb_phy, which was used consistently now.
Moreover it is difficult to change the notifier of usb_phy to be used only to
communicate the 'vbus_draw' information, since we need to refactor and test these
related phy drivers, power drivers or some mfd drivers, which is a huge workload.

(3) Still keep charger_type_show() API.
Firstly I think we should combine all charger related information into one
place for users, which is convenient.
Secondly not only we get charger type from extcon, but also in some scenarios
we can get charger type from USB controller driver, USB type-c driver, pmic
driver, we should also need one place to export the charger type.

Changes since v18:
 Other issues addressed in this patchset:
 - Modify the method of looking up one USB charger instance, we assume there is
 only one USB charger in the system. But leaving things there to avoid any need
 for future refactoring to touch the usb_charger_register() interface.
 - Remove usb_charger_set_current() API.
 - Rename usb charger state.
 - Remove ->get_charger_type() interface.
 - Add some documentation for ->charger_detect() interface explicitly.
 - Fix one issue: reset current to default values when cable was unplugged.
 - Only notify the max current to power users, but users can get the min current
 by usb_charger_get_current() if users want to use the min current.
 - Other small optimizations.

Changes since v17:
 - Remove goto section in usb_charger_register() function.
 - Remove 'extern' in charger.h file.
 - Move the kfree() to usb_charger_exit() function.

Changes since v16:
 - Modify the charger current range with introducing the maximum and minimum
 current.
 - Remove the getting charger type method from power supply.
 - Add the getting charger type method from extcon system.
 - Introduce new usb_charger_get_current() API for users to get the maximum and
 minimum current.
 - Rename some APIs and other optimization.

Changes since v15:
 - Add charger state checking to avoid sending out duplicate notifies to users.
 - Add one work to notify power users the current has been changed.

Changes since v14:
 - Add kernel documentation for struct usb_cahrger.
 - Remove some redundant WARN() functions.

Changes since v13:
 - Remove the charger checking in usb_gadget_vbus_draw() function.
 - Rename some functions in charger.c file.
 - Rebase on git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git tags/usb-for-v4.8

Changes since v12:
 - Remove the class and device things.
 - Link usb charger to udc-core.ko.
 - Create one "charger" subdirectory which holds all charger-related attributes.

Changes since v11:
 - Reviewed and tested by Li Jun.

Changes since v10:
 - Introduce usb_charger_get_state() function to check charger state.
 - Remove the mutex lock in usb_charger_set_cur_limit_by_type() function
 in case will be issued in atomic context.

Baolin Wang (4):
  usb: gadget: Introduce the usb charger framework
  usb: gadget: Support for the usb charger framework
  usb: gadget: Integrate with the usb gadget supporting for usb charger
  power: wm831x_power: Support USB charger current limit management

 drivers/power/supply/wm831x_power.c |   63 +++
 drivers/usb/gadget/Kconfig          |    8 +
 drivers/usb/gadget/udc/Makefile     |    1 +
 drivers/usb/gadget/udc/charger.c    |  865 +++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/udc/core.c       |   19 +-
 include/linux/usb/charger.h         |  176 +++++++
 include/linux/usb/gadget.h          |    3 +
 include/uapi/linux/usb/charger.h    |   31 ++
 8 files changed, 1165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/gadget/udc/charger.c
 create mode 100644 include/linux/usb/charger.h
 create mode 100644 include/uapi/linux/usb/charger.h

-- 
1.7.9.5
