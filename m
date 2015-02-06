From: Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 0/8] hwmon: thermal: Odroid U3: Provide support for Odroid
 U3 fan
Date: Fri, 06 Feb 2015 17:59:00 +0100
Message-ID: <1423241948-31981-1-git-send-email-l.majewski@samsung.com>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1418897591-18332-1-git-send-email-l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukasz Majewski <l.majewski-AM3owJQeAb5mR6Xm/wNWPw@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Abhilash Kesavan <kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lukasz Majewski <l.majewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Presented patches add support for Odroid's U3 optional CPU FAN, which uses PWM
subsystem for low level control.

After successful probe it registers itself as a cooling device for thermal
subsystem. To preserve the ability to use this fan as a PWM device stubs for
thermal_of_cooling_device_register() and thermal_cdev_update() have been added.

Additionally, devices without support for DTS are still supported.

To provide correct functionality, new properties to device tree description for 
Exynos4412 and in particular Odroid U3 have been added.

Those patches were tested on Exynos4412 - Odroid U3 board.

Patches were applied on:
linux-soc-thermal/next branch (Linux 3.19-rc5)
SHA1: 252454f5cbda2c6b40c5d36f58cac2938437b85d

Kamil Debski (1):
  ARM: dts: Add pwm-fan node to the Odroid-U3 board

Lukasz Majewski (7):
  thermal: Provide stub for thermal_of_cooling_device_register()
    function
  thermal: Provide stub for thermal_cdev_update() function
  Documentation: dts: Documentation entry to explain how to use PWM FAN
    as a cooling device
  ARM: dts: Add properties to use pwm-fan device as a cooling device in
    Odroid U3
  hwmon: pwm-fan: Extract __set_pwm() function to only modify PWM duty
    cycle
  hwmon: pwm-fan: Read PWM FAN configuration from device tree
  hwmon: pwm-fan: Code for using PWM FAN as a cooling device

 .../devicetree/bindings/hwmon/pwm-fan.txt          |  20 +++
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |  44 ++++++
 drivers/hwmon/pwm-fan.c                            | 171 +++++++++++++++++++--
 include/linux/thermal.h                            |  22 ++-
 5 files changed, 239 insertions(+), 20 deletions(-)

-- 
2.0.0.rc2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
