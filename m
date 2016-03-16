From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH V7 03/12] thermal: tegra: get rid of PDIV/HOTSPOT hack
Date: Wed, 16 Mar 2016 11:48:48 +0800
Message-ID: <56E8D7A0.9070704@nvidia.com>
References: <1457665763-29781-1-git-send-email-wni@nvidia.com> <1457665763-29781-4-git-send-email-wni@nvidia.com> <20160314200539.GH1872@localhost.localdomain> <56E7AA01.4000305@nvidia.com> <20160315195624.GE26619@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160315195624.GE26619@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8816=E6=97=A5 03:56, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>=20
> On Tue, Mar 15, 2016 at 02:21:53PM +0800, Wei Ni wrote:
>>
>>
>> On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 04:05, Eduardo Valentin wrote=
:
>>>> Old Signed by an unknown key
>>>
>>> On Fri, Mar 11, 2016 at 11:09:14AM +0800, Wei Ni wrote:
>>>> Get rid of T124-specific PDIV/HOTSPOT hack.
>>>> tegra-soctherm.c contained a hack to set the SENSOR_PDIV and
>>>> SENSOR_HOTSPOT_OFFSET registers - it just did two writes of
>>>> T124-specific opaque values.  Convert these into a form that can b=
e
>>>> substituted on a per-chip basis, and into structure fields that ha=
ve
>>>> at least some independent meaning.
>>>>
>>>> Signed-off-by: Wei Ni <wni@nvidia.com>
>>>> ---
>>>>  drivers/thermal/tegra/tegra-soctherm.c | 18 ++++++++++++++----
>>>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/tegra/tegra-soctherm.c b/drivers/ther=
mal/tegra/tegra-soctherm.c
>>>> index b3ec0faa2bee..b4b791ebfbb6 100644
>>>> --- a/drivers/thermal/tegra/tegra-soctherm.c
>>>> +++ b/drivers/thermal/tegra/tegra-soctherm.c
>>>> @@ -48,14 +48,12 @@
>>>>  #define SENSOR_CONFIG2_THERMB_SHIFT		0
>>>> =20
>>>>  #define SENSOR_PDIV				0x1c0
>>>> -#define SENSOR_PDIV_T124			0x8888
>>>>  #define SENSOR_PDIV_CPU_MASK			(0xf << 12)
>>>>  #define SENSOR_PDIV_GPU_MASK			(0xf << 8)
>>>>  #define SENSOR_PDIV_MEM_MASK			(0xf << 4)
>>>>  #define SENSOR_PDIV_PLLX_MASK			(0xf << 0)
>>>> =20
>>>>  #define SENSOR_HOTSPOT_OFF			0x1c4
>>>> -#define SENSOR_HOTSPOT_OFF_T124			0x00060600
>>>>  #define SENSOR_HOTSPOT_CPU_MASK			(0xff << 16)
>>>>  #define SENSOR_HOTSPOT_GPU_MASK			(0xff << 8)
>>>>  #define SENSOR_HOTSPOT_MEM_MASK			(0xff << 0)
>>>> @@ -436,6 +434,7 @@ static int tegra_soctherm_probe(struct platfor=
m_device *pdev)
>>>>  	struct resource *res;
>>>>  	unsigned int i;
>>>>  	int err;
>>>> +	u32 pdiv, hotspot;
>>>> =20
>>>>  	const struct tegra_tsensor *tsensors =3D t124_tsensors;
>>>>  	const struct tegra_tsensor_group **ttgs =3D tegra124_tsensor_gro=
ups;
>>>> @@ -493,8 +492,19 @@ static int tegra_soctherm_probe(struct platfo=
rm_device *pdev)
>>>>  			goto disable_clocks;
>>>>  	}
>>>> =20
>>>> -	writel(SENSOR_PDIV_T124, tegra->regs + SENSOR_PDIV);
>>>> -	writel(SENSOR_HOTSPOT_OFF_T124, tegra->regs + SENSOR_HOTSPOT_OFF=
);
>>>> +	/* Program pdiv and hotspot offsets per THERM */
>>>> +	pdiv =3D readl(tegra->regs + SENSOR_PDIV);
>>>> +	hotspot =3D readl(tegra->regs + SENSOR_HOTSPOT_OFF);
>>>> +	for (i =3D 0; i < TEGRA124_SOCTHERM_SENSOR_NUM; ++i) {
>>>> +		pdiv =3D REG_SET_MASK(pdiv, ttgs[i]->pdiv_mask,
>>>> +				    ttgs[i]->pdiv);
>>>> +		if (ttgs[i]->id !=3D TEGRA124_SOCTHERM_SENSOR_PLLX)
>>>> +			hotspot =3D  REG_SET_MASK(hotspot,
>>>> +						ttgs[i]->pllx_hotspot_mask,
>>>> +						ttgs[i]->pllx_hotspot_diff);
>>>> +	}
>>>> +	writel(pdiv, tegra->regs + SENSOR_PDIV);
>>>> +	writel(hotspot, tegra->regs + SENSOR_HOTSPOT_OFF);
>>>
>>> Is the above logic the same for all supported chips? e.g. do we alw=
ays
>>> skip pllx for hotspot configuration?
>>
>> Yes, this logic support Tegra124, Tegra210, and Tegra132 which I wil=
l send out
>> in next series.
>=20
>=20
> Ok. Could you please add a comment then explaining why pllx is not
> needed for the hotspot configuration?

This is the hotspot offset from PLLX, so we doesn't need to configure f=
or PLLX,
the Tegra DRM introduced it.
I will add comment for it.

>=20
>>
>>>
>>>
>>>> =20
>>>>  	/* Initialize thermctl sensors */
>>>> =20
>>>> --=20
>>>> 1.9.1
>>>>
>>>
>>> * Unknown Key
>>> * 0x7DA4E256
>>>
>=20
> * Unknown Key
> * 0x7DA4E256
>=20
