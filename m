From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/4] thermal: Add Tegra BPMP thermal sensor driver
Date: Fri, 30 Jun 2017 19:53:27 -0700
Message-ID: <20170701025325.GA11217@localhost.localdomain>
References: <20170616112825.31025-1-mperttunen@nvidia.com>
 <20170616112825.31025-4-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170616112825.31025-4-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, rui.zhang@intel.com, thierry.reding@gmail.com, jonathanh@nvidia.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hey Mikko,

Sorry for the late answer,

On Fri, Jun 16, 2017 at 02:28:25PM +0300, Mikko Perttunen wrote:
> On Tegra186, the BPMP (Boot and Power Management Processor) exposes an
> interface to thermal sensors on the system-on-chip. This driver
> implements access to the interface. It supports reading the
> temperature, setting trip points and receiving notification of a
> tripped trip point.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/thermal/Makefile             |   2 +-
>  drivers/thermal/tegra/Kconfig        |   7 +
>  drivers/thermal/tegra/Makefile       |   3 +-
>  drivers/thermal/tegra/bpmp-thermal.c | 253 +++++++++++++++++++++++++++++=
++++++
>  4 files changed, 263 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/thermal/tegra/bpmp-thermal.c
>=20
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 094d7039981c..c03dccdba7b8 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -54,7 +54,7 @@ obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) +=3D intel_bxt_pmi=
c_thermal.o
>  obj-$(CONFIG_INTEL_PCH_THERMAL)	+=3D intel_pch_thermal.o
>  obj-$(CONFIG_ST_THERMAL)	+=3D st/
>  obj-$(CONFIG_QCOM_TSENS)	+=3D qcom/
> -obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra/
> +obj-y				+=3D tegra/
>  obj-$(CONFIG_HISI_THERMAL)     +=3D hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)	+=3D mtk_thermal.o
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+=3D thermal-generic-adc.o
> diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/Kconfig
> index cec586ec7e4b..36e4b03bb98b 100644
> --- a/drivers/thermal/tegra/Kconfig
> +++ b/drivers/thermal/tegra/Kconfig
> @@ -10,4 +10,11 @@ config TEGRA_SOCTHERM
>  	  zones to manage temperatures. This option is also required for the
>  	  emergency thermal reset (thermtrip) feature to function.
> =20
> +config TEGRA_BPMP_THERMAL
> +	tristate "Tegra BPMP thermal sensing"
> +	depends on TEGRA_BPMP

Can you add COMPILE_TEST support here?

> +	help
> +	 Enable this option for support for sensing system temperature of NVIDIA
> +	 Tegra systems-on-chip with the BPMP coprocessor (Tegra186).
> +
>  endmenu
> diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/Makef=
ile
> index 1ce1af2cf0f5..757abcd1feaf 100644
> --- a/drivers/thermal/tegra/Makefile
> +++ b/drivers/thermal/tegra/Makefile
> @@ -1,4 +1,5 @@
> -obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra-soctherm.o
> +obj-$(CONFIG_TEGRA_SOCTHERM)		+=3D tegra-soctherm.o
> +obj-$(CONFIG_TEGRA_BPMP_THERMAL)	+=3D bpmp-thermal.o
> =20
>  tegra-soctherm-y				:=3D soctherm.o soctherm-fuse.o
>  tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D tegra124-soctherm.o
> diff --git a/drivers/thermal/tegra/bpmp-thermal.c b/drivers/thermal/tegra=
/bpmp-thermal.c
> new file mode 100644
> index 000000000000..3465a201d1ac
> --- /dev/null
> +++ b/drivers/thermal/tegra/bpmp-thermal.c
> @@ -0,0 +1,253 @@
> +/*
> + * Copyright (c) 2015-2017, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * Author:
> + *	Mikko Perttunen <mperttunen@nvidia.com>
> + *	Aapo Vienamo	<avienamo@nvidia.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/thermal.h>
> +#include <linux/workqueue.h>
> +
> +#include <soc/tegra/bpmp.h>
> +#include <soc/tegra/bpmp-abi.h>
> +
> +struct tegra_bpmp_thermal_zone {
> +	struct tegra_bpmp_thermal *tegra;
> +	struct thermal_zone_device *tzd;
> +	struct work_struct tz_device_update_work;
> +	unsigned int idx;
> +};
> +
> +struct tegra_bpmp_thermal {
> +	struct device *dev;
> +	struct tegra_bpmp *bpmp;
> +	unsigned int num_zones;
> +	struct tegra_bpmp_thermal_zone *zones;
> +};
> +
> +static int tegra_bpmp_thermal_get_temp(void *data, int *out_temp)
> +{
> +	struct tegra_bpmp_thermal_zone *zone =3D data;
> +	struct mrq_thermal_host_to_bpmp_request req;
> +	union mrq_thermal_bpmp_to_host_response reply;
> +	struct tegra_bpmp_message msg;
> +	int err;
> +
> +	memset(&req, 0, sizeof(req));
> +	req.type =3D CMD_THERMAL_GET_TEMP;
> +	req.get_temp.zone =3D zone->idx;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.mrq =3D MRQ_THERMAL;
> +	msg.tx.data =3D &req;
> +	msg.tx.size =3D sizeof(req);
> +	msg.rx.data =3D &reply;
> +	msg.rx.size =3D sizeof(reply);
> +
> +	err =3D tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
> +	if (err)
> +		return err;
> +
> +	*out_temp =3D reply.get_temp.temp;
> +
> +	return 0;
> +}
> +
> +static int tegra_bpmp_thermal_set_trips(void *data, int low, int high)
> +{
> +	struct tegra_bpmp_thermal_zone *zone =3D data;
> +	struct mrq_thermal_host_to_bpmp_request req;
> +	struct tegra_bpmp_message msg;
> +
> +	memset(&req, 0, sizeof(req));
> +	req.type =3D CMD_THERMAL_SET_TRIP;
> +	req.set_trip.zone =3D zone->idx;
> +	req.set_trip.enabled =3D true;
> +	req.set_trip.low =3D low;
> +	req.set_trip.high =3D high;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.mrq =3D MRQ_THERMAL;
> +	msg.tx.data =3D &req;
> +	msg.tx.size =3D sizeof(req);
> +
> +	return tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
> +}
> +
> +static void tz_device_update_work_fn(struct work_struct *work)
> +{
> +	struct tegra_bpmp_thermal_zone *zone;
> +
> +	zone =3D container_of(work, struct tegra_bpmp_thermal_zone,
> +			    tz_device_update_work);
> +
> +	thermal_zone_device_update(zone->tzd, THERMAL_TRIP_VIOLATED);
> +}
> +
> +static void bpmp_mrq_thermal(unsigned int mrq, struct tegra_bpmp_channel=
 *ch,
> +			     void *data)
> +{
> +	struct mrq_thermal_bpmp_to_host_request *req;
> +	struct tegra_bpmp_thermal *tegra =3D data;
> +	int zone_idx;
> +
> +	req =3D (struct mrq_thermal_bpmp_to_host_request *)ch->ib->data;
> +
> +	if (req->type !=3D CMD_THERMAL_HOST_TRIP_REACHED) {
> +		dev_err(tegra->dev, "%s: invalid request type: %d\n",
> +			__func__, req->type);
> +		tegra_bpmp_mrq_return(ch, -EINVAL, NULL, 0);
> +		return;
> +	}
> +
> +	zone_idx =3D req->host_trip_reached.zone;
> +	if (zone_idx >=3D tegra->num_zones) {
> +		dev_err(tegra->dev, "%s: invalid thermal zone: %d\n",
> +			__func__, zone_idx);
> +		tegra_bpmp_mrq_return(ch, -EINVAL, NULL, 0);
> +		return;
> +	}
> +
> +	tegra_bpmp_mrq_return(ch, 0, NULL, 0);
> +
> +	schedule_work(&tegra->zones[zone_idx].tz_device_update_work);

Why not a thermal update right here?

> +}
> +
> +static int tegra_bpmp_thermal_get_num_zones(struct tegra_bpmp *bpmp,
> +					    int *num_zones)
> +{
> +	struct mrq_thermal_host_to_bpmp_request req;
> +	union mrq_thermal_bpmp_to_host_response reply;
> +	struct tegra_bpmp_message msg;
> +	int err;
> +
> +	memset(&req, 0, sizeof(req));
> +	req.type =3D CMD_THERMAL_GET_NUM_ZONES;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.mrq =3D MRQ_THERMAL;
> +	msg.tx.data =3D &req;
> +	msg.tx.size =3D sizeof(req);
> +	msg.rx.data =3D &reply;
> +	msg.rx.size =3D sizeof(reply);
> +
> +	err =3D tegra_bpmp_transfer(bpmp, &msg);
> +	if (err)
> +		return err;
> +
> +	*num_zones =3D reply.get_num_zones.num;
> +
> +	return 0;
> +}
> +
> +static const struct thermal_zone_of_device_ops tegra_bpmp_of_thermal_ops=
 =3D {
> +	.get_temp =3D tegra_bpmp_thermal_get_temp,
> +	.set_trips =3D tegra_bpmp_thermal_set_trips,
> +};
> +
> +static int tegra_bpmp_thermal_probe(struct platform_device *pdev)
> +{
> +	struct tegra_bpmp *bpmp =3D dev_get_drvdata(pdev->dev.parent);
> +	struct tegra_bpmp_thermal *tegra;
> +	struct thermal_zone_device *tzd;
> +	unsigned int i;
> +	int err;
> +
> +	tegra =3D devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> +	if (!tegra)
> +		return -ENOMEM;
> +
> +	tegra->dev =3D &pdev->dev;
> +	tegra->bpmp =3D bpmp;
> +
> +	err =3D tegra_bpmp_thermal_get_num_zones(bpmp, &tegra->num_zones);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to get the number of zones: %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	tegra->zones =3D devm_kcalloc(&pdev->dev, tegra->num_zones,
> +				    sizeof(*tegra->zones), GFP_KERNEL);
> +	if (!tegra->zones)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < tegra->num_zones; ++i) {
> +		int temp;
> +
> +		tegra->zones[i].idx =3D i;
> +		tegra->zones[i].tegra =3D tegra;
> +
> +		err =3D tegra_bpmp_thermal_get_temp(&tegra->zones[i], &temp);
> +		if (err < 0)
> +			continue;

Should we release the memory allocated for zones that fail to retrieve
temperature here, given that you are not going to use it elsewhere.

> +
> +		tzd =3D devm_thermal_zone_of_sensor_register(
> +			&pdev->dev, i, &tegra->zones[i],
> +			&tegra_bpmp_of_thermal_ops);
> +		if (IS_ERR(tzd)) {
> +			if (PTR_ERR(tzd) =3D=3D -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			continue;

same here?

> +		}
> +
> +		tegra->zones[i].tzd =3D tzd;
> +		INIT_WORK(&tegra->zones[i].tz_device_update_work,
> +			  tz_device_update_work_fn);
> +	}
> +
> +	err =3D tegra_bpmp_request_mrq(bpmp, MRQ_THERMAL, bpmp_mrq_thermal,
> +				     tegra);
> +	if (err) {
> +		dev_err(&pdev->dev, "failed to register mrq handler: %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	platform_set_drvdata(pdev, tegra);
> +
> +	return 0;
> +}
> +
> +static int tegra_bpmp_thermal_remove(struct platform_device *pdev)
> +{
> +	struct tegra_bpmp_thermal *tegra =3D platform_get_drvdata(pdev);
> +
> +	tegra_bpmp_free_mrq(tegra->bpmp, MRQ_THERMAL, tegra);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id tegra_bpmp_thermal_of_match[] =3D {
> +	{ .compatible =3D "nvidia,tegra186-bpmp-thermal" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, tegra_bpmp_thermal_of_match);
> +
> +static struct platform_driver tegra_bpmp_thermal_driver =3D {
> +	.probe =3D tegra_bpmp_thermal_probe,
> +	.remove =3D tegra_bpmp_thermal_remove,
> +	.driver =3D {
> +		.name =3D "tegra-bpmp-thermal",
> +		.of_match_table =3D tegra_bpmp_thermal_of_match,
> +	},
> +};
> +module_platform_driver(tegra_bpmp_thermal_driver);
> +
> +MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra BPMP thermal sensor driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.13.1
>=20
