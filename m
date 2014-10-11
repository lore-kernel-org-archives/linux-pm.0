From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8 1/5] thermal: rockchip: add driver for thermal
Date: Fri, 10 Oct 2014 23:20:15 -0700
Message-ID: <20141011062015.GA19734@dtor-ws>
References: <1412936381-22718-1-git-send-email-caesar.wang@rock-chips.com>
 <1412936381-22718-2-git-send-email-caesar.wang@rock-chips.com>
 <20141010174636.GB32974@dtor-ws>
 <5438C7BD.4010308@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5438C7BD.4010308@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, arnd@arndb.de, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Hi Caesar,

On Sat, Oct 11, 2014 at 02:01:33PM +0800, Caesar Wang wrote:
> Dear Dmitry,
>=20
> =E5=9C=A8 2014=E5=B9=B410=E6=9C=8811=E6=97=A5 01:46, Dmitry Torokhov =
=E5=86=99=E9=81=93:
> >Hi Caesar,
> >
> >On Fri, Oct 10, 2014 at 06:19:37PM +0800, Caesar Wang wrote:
> >>Thermal is TS-ADC Controller module supports
> >>user-defined mode and automatic mode.
> >>
> >>User-defined mode refers,TSADC all the control signals entirely by
> >>software writing to register for direct control.
> >>
> >>Automaic mode refers to the module automatically poll TSADC output,
> >>and the results were checked.If you find that the temperature High
> >>in a period of time,an interrupt is generated to the processor
> >>down-measures taken;If the temperature over a period of time High,
> >>the resulting TSHUT gave CRU module,let it reset the entire chip,
> >>or via GPIO give PMIC.
> >>
> >>Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
> >>Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> >>---
> >>  drivers/thermal/Kconfig            |   9 +
> >>  drivers/thermal/Makefile           |   1 +
> >>  drivers/thermal/rockchip_thermal.c | 628 ++++++++++++++++++++++++=
+++++++++++++
> >>  3 files changed, 638 insertions(+)
> >>  create mode 100644 drivers/thermal/rockchip_thermal.c
> >>
> >>diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> >>index f9a1386..24845ae 100644
> >>--- a/drivers/thermal/Kconfig
> >>+++ b/drivers/thermal/Kconfig
> >>@@ -133,6 +133,15 @@ config SPEAR_THERMAL
> >>  	  Enable this to plug the SPEAr thermal sensor driver into the L=
inux
> >>  	  thermal framework.
> >>+config ROCKCHIP_THERMAL
> >>+	tristate "Rockchip thermal driver"
> >>+	depends on ARCH_ROCKCHIP
> >>+	help
> >>+	  Rockchip thermal driver provides support for Temperature sensor
> >>+	  ADC (TS-ADC) found on Rockchip SoCs. It supports one critical
> >>+	  trip point. Cpufreq is used as the cooling device and will thro=
ttle
> >>+	  CPUs when the Temperature crosses the passive trip point.
> >>+
> >>  config RCAR_THERMAL
> >>  	tristate "Renesas R-Car thermal driver"
> >>  	depends on ARCH_SHMOBILE || COMPILE_TEST
> >>diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> >>index de0636a..930554f 100644
> >>--- a/drivers/thermal/Makefile
> >>+++ b/drivers/thermal/Makefile
> >>@@ -19,6 +19,7 @@ thermal_sys-$(CONFIG_CPU_THERMAL)	+=3D cpu_coolin=
g.o
> >>  # platform thermal drivers
> >>  obj-$(CONFIG_SPEAR_THERMAL)	+=3D spear_thermal.o
> >>+obj-$(CONFIG_ROCKCHIP_THERMAL)	+=3D rockchip_thermal.o
> >>  obj-$(CONFIG_RCAR_THERMAL)	+=3D rcar_thermal.o
> >>  obj-$(CONFIG_KIRKWOOD_THERMAL)  +=3D kirkwood_thermal.o
> >>  obj-y				+=3D samsung/
> >>diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/r=
ockchip_thermal.c
> >>new file mode 100644
> >>index 0000000..ceee2c1
> >>--- /dev/null
> >>+++ b/drivers/thermal/rockchip_thermal.c
> >>@@ -0,0 +1,628 @@
> >>+/*
> >>+ * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
> >>+ *
> >>+ * This program is free software; you can redistribute it and/or m=
odify it
> >>+ * under the terms and conditions of the GNU General Public Licens=
e,
> >>+ * version 2, as published by the Free Software Foundation.
> >>+ *
> >>+ * This program is distributed in the hope it will be useful, but =
WITHOUT
> >>+ * ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY or
> >>+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public L=
icense for
> >>+ * more details.
> >>+ */
> >>+
> >>+#include <linux/clk.h>
> >>+#include <linux/cpu_cooling.h>
> >>+#include <linux/interrupt.h>
> >>+#include <linux/io.h>
> >>+#include <linux/module.h>
> >>+#include <linux/of.h>
> >>+#include <linux/of_address.h>
> >>+#include <linux/of_irq.h>
> >>+#include <linux/platform_device.h>
> >>+#include <linux/thermal.h>
> >>+
> >>+/**
> >>+* If the temperature over a period of time High,
> >>+* the resulting TSHUT gave CRU module,let it reset the entire chip=
,
> >>+* or via GPIO give PMIC.
> >>+*/
> >>+enum reset_mde {
> >Can we spare one more letter? ;)
> >
>=20
> OK, maybe fix it as the follows:
>=20
> enum reset_mde {
>     TSADC_HT_RESET_CRU =3D 0,
>     TSADC_HT_PULL_GPIO,
> };

I meant to spell "mode" out, like this:

enum reset_mode {
	...
};

> >>+	CRU =3D 0,
> >>+	GPIO,
> >>+};
> >>+
> >>+/**
> >>+* The system has three Teperture Sensors.
> >>+* channel0 is reserve,channel1 is for CPU,and
> >>+* channel channel 2 is for GPU.
> >>+*/
> >>+enum sensor_id {
> >>+	RESERVE =3D 0,
> >>+	CPU,
> >>+	GPU,
> >>+	SENSOR_ID_END,
> >>+};
> >>+
> >>+struct rockchip_thermal_data {
> >>+	const struct rockchip_tsadc_platform_data *pdata;
> >>+	struct thermal_zone_device *tz[SENSOR_ID_END];
> >>+	struct thermal_cooling_device *cdev;
> >>+	void __iomem *regs;
> >>+
> >>+	unsigned long temp_passive;
> >>+	unsigned long hw_shut_temp;
> >>+	unsigned long alarm_temp;
> >>+	bool irq_enabled;
> >>+	int irq;
> >>+	int reset_mode;
> >>+	int chn;
> >>+
> >>+	struct clk *clk;
> >>+	struct clk *pclk;
> >>+};
> >>+
> >>+struct rockchip_tsadc_platform_data {
> >>+	unsigned long temp_passive;
> >>+	unsigned long hw_shut_temp;
> >>+	int reset_mode;
> >>+
> >>+	int (*irq_handle)(void __iomem *reg);
> >Why does it return int and not void? What is the return value of thi=
s?
>=20
> Fixed. instead of using void.
> >>+	int (*initialize)(int reset_mode, int chn, void __iomem *reg,
> >Why does it return int and not void? What is the return value of thi=
s?> +			  unsigned long hw_shut_temp);
>=20
> Ditto.
>=20
> >>+	int (*control)(void __iomem *reg, bool on);
> >>+	int (*code_to_temp)(u32 code);
> >>+	u32 (*temp_to_code)(int temp);
> >>+	void (*set_alarm_temp)(int chn, void __iomem *reg,
> >>+			       unsigned long alarm_temp);
> >>+};
> >>+
> >>+/* TSADC V2 Sensor info define: */
> >>+#define TSADCV2_AUTO_CON			0x04
> >>+#define TSADCV2_INT_EN				0x08
> >>+#define TSADCV2_INT_PD				0x0c
> >>+#define TSADCV2_DATA(chn)			(0x20+chn*0x04)
> >Unsafe macros. You want to enclose argument in parenthesis.
>=20
> Yeah.
> Hmmm, there is no thought of a good way to deal with it at the moment=
=2E
>=20
> Maybe do that as the follows,but should be a better way to deal.

No, I meant

#define TSADCV2_DATA(chn)	(0x20 + (chn) * 0x04)

This way one can safely pass expressions as argument, like
TSADCV2_DATA(i + 1) will evaluate properly.

Thanks.

--=20
Dmitry
