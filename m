From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 00/26] ARM: pxa: magician: Rework HTC Magician support
Date: Thu, 17 Sep 2015 08:04:38 +0100
Message-ID: <20150917070438.GC3218@x1>
References: <55FA4756.9080309@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55FA4756.9080309@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: Petr Cvek <petr.cvek@tul.cz>
Cc: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, 17 Sep 2015, Petr Cvek wrote:

[...]

> Petr Cvek (26):
>   ARM: pxa: magician: Fix indentation in machine files
>   ARM: pxa: magician: Change comments to be more informative
>   ARM: pxa: magician: Print more specific error message for global
>     GPIOs
>   ARM: pxa: magician: Optimize debug messages for LCD power
>   ARM: pxa: magician: Change description of LCD power GPIO
>   ARM: pxa: magician: Add new discovered EGPIO pins
>   ARM: pxa: magician: Fix HTC Magician pin mux definitions
>   ARM: pxa: magician: Rename abstract LCD GPIOs
>   ARM: pxa: magician: Optimize powerup delays for Samsung LCD
>   ARM: pxa: magician: Optimize Samsung LCD refresh to 50Hz
>   ARM: pxa: magician: Optimize EGPIO initial values
>   ARM: pxa: magician: Rename charger cable detection EGPIOs
>   ARM: pxa: magician: Fix and add charging detection functions
>   ARM: pxa: magician: Fix platform data for both PXA27x I2C controlle=
rs
>   ARM: pxa: magician: Fix redundant GPIO request for pxaficp_ir
>   ARM: pxa: magician: Fix support for Intel Strata NOR Flash
>   ARM: pxa: magician: Fix wrongly enabled USB host ports
>   ARM: pxa: magician: Add support for ADS7846
>   ARM: pxa: magician: Add support for Omnivision OV9640 camera
>   ARM: pxa: magician: Add support for MAX1587A Vcore regulator
>   ARM: pxa: magician: Add support for PXA27x UDC
>   ARM: pxa: magician: Remove pdata for pasic3-leds
>   ARM: pxa: magician: Remove definition of the STUART port
>   ARM: pxa: magician: Add debug message for backlight brightness
>     function
>   ARM: pxa: magician: Add missing regulator for PWM backlight
>   ARM: pxa: magician: Move platform_add_devices() to the end of
>     magician_init()

Why have you sent me 26 patches which have absolutely nothing to do
with me?

>  arch/arm/mach-pxa/include/mach/magician.h |  78 +--
>  arch/arm/mach-pxa/magician.c              | 907 ++++++++++++++++++++=
+---------
>  2 files changed, 682 insertions(+), 303 deletions(-)
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
