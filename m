From: <ilialin@codeaurora.org>
Subject: RE: [PATCH v12 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Thu, 24 May 2018 16:03:15 +0300
Message-ID: <000501d3f35f$96794910$c36bdb30$@codeaurora.org>
References: <1527152242-31281-1-git-send-email-ilialin@codeaurora.org> <1527152242-31281-2-git-send-email-ilialin@codeaurora.org> <860be68b-cac0-9efc-b3c7-cc75b391a4c3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <860be68b-cac0-9efc-b3c7-cc75b391a4c3@arm.com>
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Sudeep Holla' <sudeep.holla@arm.com>, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Thursday, May 24, 2018 15:52
> To: Ilia Lin <ilialin@codeaurora.org>; vireshk@kernel.org; nm@ti.com;
> sboyd@kernel.org; robh@kernel.org; mark.rutland@arm.com;
> rjw@rjwysocki.net
> Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-pm@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v12 1/2] cpufreq: Add Kryo CPU scaling driver
>=20
> Hi Ilia,
>=20
>=20
> On 24/05/18 09:57, Ilia Lin wrote:
> > In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO
> > processors, the CPU frequency subset and voltage value of each OPP
> > varies based on the silicon variant in use. Qualcomm Process Voltage
> > Scaling Tables defines the voltage and frequency value based on the
> > msm-id in SMEM and speedbin blown in the efuse combination.
> > The qcom-cpufreq-kryo driver reads the msm-id and efuse value from =
the
> > SoC to provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each =
OPP
> > of
> > operating-points-v2 table when it is parsed by the OPP framework.
> >
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm          |  10 ++
> >  drivers/cpufreq/Makefile             |   1 +
> >  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
> >  drivers/cpufreq/qcom-cpufreq-kryo.c  | 194
> > +++++++++++++++++++++++++++++++++++
> >  4 files changed, 208 insertions(+)
> >  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
> >
> > diff --git a/drivers/cpufreq/Kconfig.arm =
b/drivers/cpufreq/Kconfig.arm
> > index de55c7d..0bfd40e 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -124,6 +124,16 @@ config ARM_OMAP2PLUS_CPUFREQ
> >  	depends on ARCH_OMAP2PLUS
> >  	default ARCH_OMAP2PLUS
> >
> > +config ARM_QCOM_CPUFREQ_KRYO
> > +	bool "Qualcomm Kryo based CPUFreq"
> > +	depends on QCOM_QFPROM
> > +	depends on QCOM_SMEM
> > +	select PM_OPP
> > +	help
> > +	  This adds the CPUFreq driver for Qualcomm Kryo SoC based boards.
> > +
> > +	  If in doubt, say N.
> > +
> >  config ARM_S3C_CPUFREQ
> >  	bool
> >  	help
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile =
index
> > 8d24ade..fb4a2ec 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -65,6 +65,7 @@ obj-$(CONFIG_MACH_MVEBU_V7)		+=3D
> mvebu-cpufreq.o
> >  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+=3D omap-cpufreq.o
> >  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+=3D pxa2xx-cpufreq.o
> >  obj-$(CONFIG_PXA3xx)			+=3D pxa3xx-cpufreq.o
> > +obj-$(CONFIG_ARM_QCOM_CPUFREQ_KRYO)	+=3D qcom-cpufreq-
> kryo.o
> >  obj-$(CONFIG_ARM_S3C2410_CPUFREQ)	+=3D s3c2410-cpufreq.o
> >  obj-$(CONFIG_ARM_S3C2412_CPUFREQ)	+=3D s3c2412-cpufreq.o
> >  obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+=3D s3c2416-cpufreq.o
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> > b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index 3b585e4..77d6ab8 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -118,6 +118,9 @@
> >
> >  	{ .compatible =3D "nvidia,tegra124", },
> >
> > +	{ .compatible =3D "qcom,apq8096", },
> > +	{ .compatible =3D "qcom,msm8996", },
> > +
> >  	{ .compatible =3D "st,stih407", },
> >  	{ .compatible =3D "st,stih410", },
> >
> > diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c
> > b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > new file mode 100644
> > index 0000000..9fe379c
> > --- /dev/null
> > +++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
> > @@ -0,0 +1,194 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +/*
> > + * In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO
> > +processors,
> > + * the CPU frequency subset and voltage value of each OPP varies
> > + * based on the silicon variant in use. Qualcomm Process Voltage
> > +Scaling Tables
> > + * defines the voltage and frequency value based on the msm-id in
> > +SMEM
> > + * and speedbin blown in the efuse combination.
> > + * The qcom-cpufreq-kryo driver reads the msm-id and efuse value =
from
> > +the SoC
> > + * to provide the OPP framework with required information.
> > + * This is used to determine the voltage and frequency value for =
each
> > +OPP of
> > + * operating-points-v2 table when it is parsed by the OPP =
framework.
> > + */
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_opp.h>
> > +#include <linux/slab.h>
> > +#include <linux/soc/qcom/smem.h>
> > +
> > +#define MSM_ID_SMEM	137
> > +
> > +enum _msm_id {
> > +	MSM8996V3 =3D 0xF6ul,
> > +	APQ8096V3 =3D 0x123ul,
> > +	MSM8996SG =3D 0x131ul,
> > +	APQ8096SG =3D 0x138ul,
> > +};
> > +
> > +enum _msm8996_version {
> > +	MSM8996_V3,
> > +	MSM8996_SG,
> > +	NUM_OF_MSM8996_VERSIONS,
> > +};
> > +
> > +static enum _msm8996_version __init
> > +qcom_cpufreq_kryo_get_msm_id(void)
> > +{
> > +	size_t len;
> > +	u32 *msm_id;
> > +	enum _msm8996_version version;
> > +
> > +	msm_id =3D qcom_smem_get(QCOM_SMEM_HOST_ANY,
> MSM_ID_SMEM, &len);
> > +	/* The first 4 bytes are format, next to them is the actual msm-id =
*/
> > +	msm_id++;
> > +
> > +	switch ((enum _msm_id)*msm_id) {
> > +	case MSM8996V3:
> > +	case APQ8096V3:
> > +		version =3D MSM8996_V3;
> > +		break;
> > +	case MSM8996SG:
> > +	case APQ8096SG:
> > +		version =3D MSM8996_SG;
> > +		break;
> > +	default:
> > +		version =3D NUM_OF_MSM8996_VERSIONS;
> > +	}
> > +
> > +	return version;
> > +}
> > +
> > +static int qcom_cpufreq_kryo_probe(struct platform_device *pdev) {
> > +	struct opp_table *opp_tables[NR_CPUS] =3D {0};
> > +	struct platform_device *cpufreq_dt_pdev;
> > +	enum _msm8996_version msm8996_version;
> > +	struct nvmem_cell *speedbin_nvmem;
> > +	struct device_node *np;
> > +	struct device *cpu_dev;
> > +	unsigned cpu;
> > +	u8 *speedbin;
> > +	u32 versions;
> > +	size_t len;
> > +	int ret;
> > +
> > +	cpu_dev =3D get_cpu_device(0);
> > +	if (NULL =3D=3D cpu_dev)
> > +		return -ENODEV;
> > +
> > +	msm8996_version =3D qcom_cpufreq_kryo_get_msm_id();
> > +	if (NUM_OF_MSM8996_VERSIONS =3D=3D msm8996_version) {
> > +		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> > +		return -ENODEV;
> > +	}
> > +
> > +	np =3D dev_pm_opp_of_get_opp_desc_node(cpu_dev);
> > +	if (IS_ERR(np))
> > +		return PTR_ERR(np);
> > +
> > +	if (!of_device_is_compatible(np, "operating-points-v2-kryo-cpu")) =
{
> > +		of_node_put(np);
> > +		return -ENOENT;
> > +	}
> > +
> > +	speedbin_nvmem =3D of_nvmem_cell_get(np, NULL);
> > +	of_node_put(np);
> > +	if (IS_ERR(speedbin_nvmem)) {
> > +		dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
> > +			PTR_ERR(speedbin_nvmem));
> > +		return PTR_ERR(speedbin_nvmem);
> > +	}
> > +
> > +	speedbin =3D nvmem_cell_read(speedbin_nvmem, &len);
> > +	nvmem_cell_put(speedbin_nvmem);
> > +
> > +	switch (msm8996_version) {
> > +	case MSM8996_V3:
> > +		versions =3D 1 << (unsigned int)(*speedbin);
> > +		break;
> > +	case MSM8996_SG:
> > +		versions =3D 1 << ((unsigned int)(*speedbin) + 4);
> > +		break;
> > +	default:
> > +		BUG();
> > +		break;
> > +	}
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		cpu_dev =3D get_cpu_device(cpu);
> > +		if (NULL =3D=3D cpu_dev) {
> > +			ret =3D -ENODEV;
> > +			goto free_opp;
> > +		}
> > +
> > +		opp_tables[cpu] =3D
> dev_pm_opp_set_supported_hw(cpu_dev,
> > +							      &versions, 1);
> > +		if (IS_ERR(opp_tables[cpu])) {
> > +			ret =3D PTR_ERR(opp_tables[cpu]);
> > +			dev_err(cpu_dev, "Failed to set supported
> hardware\n");
> > +			goto free_opp;
> > +		}
> > +	}
> > +
> > +	cpufreq_dt_pdev =3D platform_device_register_simple("cpufreq-dt", =
-
> 1,
> > +							  NULL, 0);
> > +	if (!IS_ERR(cpufreq_dt_pdev))
> > +		return 0;
> > +
> > +	ret =3D PTR_ERR(cpufreq_dt_pdev);
> > +	dev_err(cpu_dev, "Failed to register platform device\n");
> > +
> > +free_opp:
> > +	for_each_possible_cpu(cpu) {
> > +		if (IS_ERR_OR_NULL(opp_tables[cpu]))
> > +			break;
> > +		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static struct platform_driver qcom_cpufreq_kryo_driver =3D {
> > +	.probe =3D qcom_cpufreq_kryo_probe,
> > +	.driver =3D {
> > +		.name =3D "qcom-cpufreq-kryo",
> > +	},
> > +};
> > +
> > +/*
> > + * Since the driver depends on smem and nvmem drivers, which may
> > + * return EPROBE_DEFER, all the real activity is done in the probe,
> > + * which may be defered as well. The init here is only registering
> > + * the driver and the platform device.
> > + */
> > +static int __init qcom_cpufreq_kryo_init(void) {
> > +	int ret;
> > +
> > +	ret =3D platform_driver_register(&qcom_cpufreq_kryo_driver);
> > +	if (unlikely(ret < 0))
> > +		return ret;
> > +
> > +	ret =3D PTR_ERR_OR_ZERO(platform_device_register_simple(
> > +		"qcom-cpufreq-kryo", -1, NULL, 0));
>=20
>=20
> You simply can't do this unconditionally here. This will blow up on =
platforms
> where this driver is not supposed to work. The probe will be called on =
non-
> QCOM or non-Kryo QCOM platforms and I reckon it will crash trying to
> execute something in qcom_smem_get.

What do you mean by 'unconditionally'?
The driver depends on the smem and nvmem drivers, which depend on =
ARCH_QCOM:
 +	depends on QCOM_QFPROM
 +	depends on QCOM_SMEM

And if SMEM read in the probe returns something other than Kryo, it will =
exit.

>=20
> --
> Regards,
> Sudeep
