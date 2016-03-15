From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V7 03/12] thermal: tegra: get rid of PDIV/HOTSPOT hack
Date: Tue, 15 Mar 2016 14:21:53 +0800
Message-ID: <56E7AA01.4000305@nvidia.com>
References: <1457665763-29781-1-git-send-email-wni@nvidia.com> <1457665763-29781-4-git-send-email-wni@nvidia.com> <20160314200539.GH1872@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160314200539.GH1872-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 04:05, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>=20
> On Fri, Mar 11, 2016 at 11:09:14AM +0800, Wei Ni wrote:
>> Get rid of T124-specific PDIV/HOTSPOT hack.
>> tegra-soctherm.c contained a hack to set the SENSOR_PDIV and
>> SENSOR_HOTSPOT_OFFSET registers - it just did two writes of
>> T124-specific opaque values.  Convert these into a form that can be
>> substituted on a per-chip basis, and into structure fields that have
>> at least some independent meaning.
>>
>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/thermal/tegra/tegra-soctherm.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/tegra-soctherm.c b/drivers/therma=
l/tegra/tegra-soctherm.c
>> index b3ec0faa2bee..b4b791ebfbb6 100644
>> --- a/drivers/thermal/tegra/tegra-soctherm.c
>> +++ b/drivers/thermal/tegra/tegra-soctherm.c
>> @@ -48,14 +48,12 @@
>>  #define SENSOR_CONFIG2_THERMB_SHIFT		0
>> =20
>>  #define SENSOR_PDIV				0x1c0
>> -#define SENSOR_PDIV_T124			0x8888
>>  #define SENSOR_PDIV_CPU_MASK			(0xf << 12)
>>  #define SENSOR_PDIV_GPU_MASK			(0xf << 8)
>>  #define SENSOR_PDIV_MEM_MASK			(0xf << 4)
>>  #define SENSOR_PDIV_PLLX_MASK			(0xf << 0)
>> =20
>>  #define SENSOR_HOTSPOT_OFF			0x1c4
>> -#define SENSOR_HOTSPOT_OFF_T124			0x00060600
>>  #define SENSOR_HOTSPOT_CPU_MASK			(0xff << 16)
>>  #define SENSOR_HOTSPOT_GPU_MASK			(0xff << 8)
>>  #define SENSOR_HOTSPOT_MEM_MASK			(0xff << 0)
>> @@ -436,6 +434,7 @@ static int tegra_soctherm_probe(struct platform_=
device *pdev)
>>  	struct resource *res;
>>  	unsigned int i;
>>  	int err;
>> +	u32 pdiv, hotspot;
>> =20
>>  	const struct tegra_tsensor *tsensors =3D t124_tsensors;
>>  	const struct tegra_tsensor_group **ttgs =3D tegra124_tsensor_group=
s;
>> @@ -493,8 +492,19 @@ static int tegra_soctherm_probe(struct platform=
_device *pdev)
>>  			goto disable_clocks;
>>  	}
>> =20
>> -	writel(SENSOR_PDIV_T124, tegra->regs + SENSOR_PDIV);
>> -	writel(SENSOR_HOTSPOT_OFF_T124, tegra->regs + SENSOR_HOTSPOT_OFF);
>> +	/* Program pdiv and hotspot offsets per THERM */
>> +	pdiv =3D readl(tegra->regs + SENSOR_PDIV);
>> +	hotspot =3D readl(tegra->regs + SENSOR_HOTSPOT_OFF);
>> +	for (i =3D 0; i < TEGRA124_SOCTHERM_SENSOR_NUM; ++i) {
>> +		pdiv =3D REG_SET_MASK(pdiv, ttgs[i]->pdiv_mask,
>> +				    ttgs[i]->pdiv);
>> +		if (ttgs[i]->id !=3D TEGRA124_SOCTHERM_SENSOR_PLLX)
>> +			hotspot =3D  REG_SET_MASK(hotspot,
>> +						ttgs[i]->pllx_hotspot_mask,
>> +						ttgs[i]->pllx_hotspot_diff);
>> +	}
>> +	writel(pdiv, tegra->regs + SENSOR_PDIV);
>> +	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
>=20
> Is the above logic the same for all supported chips? e.g. do we alway=
s
> skip pllx for hotspot configuration?

Yes, this logic support Tegra124, Tegra210, and Tegra132 which I will s=
end out
in next series.

>=20
>=20
>> =20
>>  	/* Initialize thermctl sensors */
>> =20
>> --=20
>> 1.9.1
>>
>=20
> * Unknown Key
> * 0x7DA4E256
>=20
