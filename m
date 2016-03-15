From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 12/13] thermal: convert tegra_thermal to use devm_thermal_zone_of_sensor_register
Date: Tue, 15 Mar 2016 13:42:12 +0800
Message-ID: <56E7A0B4.2050900@nvidia.com>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com> <1457559336-17652-13-git-send-email-edubezval@gmail.com> <56E1347F.8040406@nvidia.com> <20160314211607.GC4740@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160314211607.GC4740-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rui Zhang <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 05:16, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>=20
> On Thu, Mar 10, 2016 at 04:46:55PM +0800, Wei Ni wrote:
>>
>>
>> On 2016=E5=B9=B403=E6=9C=8810=E6=97=A5 05:35, Eduardo Valentin wrote=
:
>>> This changes the driver to use the devm_ version
>>> of thermal_zone_of_sensor_register and cleans
>>> up the  local points and unregister calls.
>>>
>>> Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>> Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
>>> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Signed-off-by: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  drivers/thermal/tegra_soctherm.c | 31 +++++++++-------------------=
---
>>>  1 file changed, 9 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/teg=
ra_soctherm.c
>>> index 74ea576..0018ccd 100644
>>> --- a/drivers/thermal/tegra_soctherm.c
>>> +++ b/drivers/thermal/tegra_soctherm.c
>>> @@ -168,7 +168,7 @@ struct tegra_soctherm {
>>>  	struct clk *clock_soctherm;
>>>  	void __iomem *regs;
>>> =20
>>> -	struct thermal_zone_device *thermctl_tzs[4];
>>> +#define ZONE_NUMBER		4
>>>  };
>>> =20
>>>  struct tsensor_shared_calibration {
>>> @@ -342,7 +342,7 @@ static const struct thermctl_zone_desc t124_the=
rmctl_temp_zones[] =3D {
>>>  static int tegra_soctherm_probe(struct platform_device *pdev)
>>>  {
>>>  	struct tegra_soctherm *tegra;
>>> -	struct thermal_zone_device *tz;
>>> +	struct thermal_zone_device *z;
>>>  	struct tsensor_shared_calibration shared_calib;
>>>  	struct resource *res;
>>>  	unsigned int i;
>>> @@ -408,36 +408,29 @@ static int tegra_soctherm_probe(struct platfo=
rm_device *pdev)
>>> =20
>>>  	/* Initialize thermctl sensors */
>>> =20
>>> -	for (i =3D 0; i < ARRAY_SIZE(tegra->thermctl_tzs); ++i) {
>>> +	for (i =3D 0; i < ZONE_NUMBER; ++i) {
>>>  		struct tegra_thermctl_zone *zone =3D
>>>  			devm_kzalloc(&pdev->dev, sizeof(*zone), GFP_KERNEL);
>>>  		if (!zone) {
>>>  			err =3D -ENOMEM;
>>> -			goto unregister_tzs;
>>> +			goto disable_clocks;
>>>  		}
>>> =20
>>>  		zone->reg =3D tegra->regs + t124_thermctl_temp_zones[i].offset;
>>>  		zone->shift =3D t124_thermctl_temp_zones[i].shift;
>>> =20
>>> -		tz =3D thermal_zone_of_sensor_register(&pdev->dev, i, zone,
>>> -						     &tegra_of_thermal_ops);
>>> -		if (IS_ERR(tz)) {
>>> -			err =3D PTR_ERR(tz);
>>> +		z =3D devm_thermal_zone_of_sensor_register(&pdev->dev, i, zone,
>>
>> I prefer to still use "tz", it seems this line isn't over 80 charact=
ers, or we
>> can add newline.
>=20
>=20
> Yeah,
>=20
>=20
>>
>>> +							 &tegra_of_thermal_ops);
>=20
> CHECK: Alignment should match open parenthesis
> #423: FILE: drivers/thermal/tegra_soctherm.c:423:
> +		tz =3D devm_thermal_zone_of_sensor_register(&pdev->dev, i, zone,
> +							 &tegra_of_thermal_ops);
>=20
> and if you align it, then, you get the warning:
> WARNING: line over 80 characters
> #423: FILE: drivers/thermal/tegra_soctherm.c:423:
> +							  &tegra_of_thermal_ops);
>=20
> And I did not want to add either of the above to the driver.=20
>=20
> But if you prefer tz over z, we can keep the first (check) then.
>=20
> What do you prefer?

Hmm, I see.
Ok, it's better to use "z" to resolve it.

Wei.
>=20
>=20
>=20
>=20
>=20
> * Unknown Key
> * 0x7DA4E256
>=20
