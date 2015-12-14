From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 01/20] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Mon, 14 Dec 2015 17:44:57 +0900
Message-ID: <566E8189.7040505@samsung.com>
References: <989487615.658131450081722610.JavaMail.weblogic@epmlwas07b>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49556 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578AbbLNIpJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 03:45:09 -0500
In-reply-to: <989487615.658131450081722610.JavaMail.weblogic@epmlwas07b>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, =?UTF-8?B?7YGs7Ims7Iuc7Yag7ZSE?= <k.kozlowski@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 2015=EB=85=84 12=EC=9B=94 14=EC=9D=BC 17:28, MyungJoo Ham wrote:
>>  =20
>>  This patch adds the generic exynos bus frequency driver for AMBA AX=
I bus
>> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung Exyn=
os SoC
>> have the common architecture for bus between DRAM and sub-blocks in =
SoC.
>> This driver can support the generic bus frequency driver for Exynos =
SoCs.
>>
>> In devicetree, Each bus block has a bus clock, regulator, operation-=
point
>> and devfreq-event devices which measure the utilization of each bus =
block.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> [linux.amoon: Tested on Odroid U3]
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>>
>=20
> Chanwoo, could you please show me testing this set of patches in your=
 site?
> Please let me know when is ok to visit you.
> (I do not have exynos machines right now.)

Sure. I can show it tomorrow whenever you want.
Before visiting to me, just let me know. I'll prepare the demonstartion=
=2E

Regards,
Chanwo oChoi

>=20
>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>> index 5134f9ee983d..375ebbb4fcfb 100644
>> --- a/drivers/devfreq/Makefile
>> +++ b/drivers/devfreq/Makefile
>> @@ -6,6 +6,7 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+=3D governor_po=
wersave.o
>>  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governor_userspace.o
>> =20
>>  # DEVFREQ Drivers
>> +obj-$(CONFIG_ARCH_EXYNOS)		+=3D exynos/
>>  obj-$(CONFIG_ARM_EXYNOS4_BUS_DEVFREQ)	+=3D exynos/
>>  obj-$(CONFIG_ARM_EXYNOS5_BUS_DEVFREQ)	+=3D exynos/
>=20
> CONFIG_ARCH_EXYNOS is true if
> 	CONFIG_ARM_EXYNOS4_BUS_DEVFREQ is true=20
> 	or
> 	CONFIG_ARM_EXYNOS5_BUS_DEVFREQ is true
> Thus, the two lines after you've added have become useless. (dead cod=
e)
>=20
> Please delete them.
>=20
> []
>> --- /dev/null
>> +++ b/drivers/devfreq/exynos/exynos-bus.c
> []
>> +static int exynos_bus_target(struct device *dev, unsigned long *fre=
q, u32 flags)
>> +{
>> +	struct exynos_bus *bus =3D dev_get_drvdata(dev);
>> +	struct dev_pm_opp *new_opp;
>> +	unsigned long old_freq, new_freq, old_volt, new_volt;
>> +	int ret =3D 0;
>> +
>> +	/* Get new opp-bus instance according to new bus clock */
>> +	rcu_read_lock();
>> +	new_opp =3D devfreq_recommended_opp(dev, freq, flags);
>> +	if (IS_ERR_OR_NULL(new_opp)) {
>> +		dev_err(dev, "failed to get recommed opp instance\n");
>> +		rcu_read_unlock();
>> +		return PTR_ERR(new_opp);
>> +	}
>> +
>> +	new_freq =3D dev_pm_opp_get_freq(new_opp);
>> +	new_volt =3D dev_pm_opp_get_voltage(new_opp);
>> +	old_freq =3D dev_pm_opp_get_freq(bus->curr_opp);
>> +	old_volt =3D dev_pm_opp_get_voltage(bus->curr_opp);
>> +	rcu_read_unlock();
>> +
>> +	if (old_freq =3D=3D new_freq)
>> +		return 0;
>> +
>> +	/* Change voltage and frequency according to new OPP level */
>> +	mutex_lock(&bus->lock);
>> +
>> +	if (old_freq < new_freq) {
>> +		ret =3D regulator_set_voltage(bus->regulator, new_volt, new_volt)=
;
>=20
> Setting the maximum volt same as the minimum volt is not recommended.
> Especially for any DVFS mechanisms, I recommend to set values as:
> min_volt =3D minimum voltage that does not harm the stability
> max_volt =3D maximum voltage that does not break the circuit
>=20
> Please refer to /include/linux/regulator/driver.h
> "@set_voltage" comments.
>=20
> For the rest of regulator_set_voltage usages, I'd say the same.
>=20
> []
>> +static int exynos_bus_get_dev_status(struct device *dev,
>> +				     struct devfreq_dev_status *stat)
>> +{
>> +	struct exynos_bus *bus =3D dev_get_drvdata(dev);
>> +	struct devfreq_event_data edata;
>> +	int ret;
>> +
>> +	rcu_read_lock();
>> +	stat->current_frequency =3D dev_pm_opp_get_freq(bus->curr_opp);
>> +	rcu_read_unlock();
>> +
>> +	ret =3D exynos_bus_get_event(bus, &edata);
>> +	if (ret < 0) {
>> +		stat->total_time =3D stat->busy_time =3D 0;
>> +		goto err;
>> +	}
>> +
>> +	stat->busy_time =3D (edata.load_count * 100) / bus->ratio;
>> +	stat->total_time =3D edata.total_count;
>> +
>> +	dev_dbg(dev, "Usage of devfreq-event : %ld/%ld\n", stat->busy_time=
,
>> +							stat->total_time);
>=20
> These two values are unsigned long.
>=20
> []
>> +static int exynos_bus_parse_of(struct device_node *np,
>> +			      struct exynos_bus *bus)
>> +{
>> +	struct device *dev =3D bus->dev;
>> +	unsigned long rate;
>> +	int i, ret, count, size;
>> +
>> +	/* Get the clock to provide each bus with source clock */
>> +	bus->clk =3D devm_clk_get(dev, "bus");
>> +	if (IS_ERR(bus->clk)) {
>> +		dev_err(dev, "failed to get bus clock\n");
>> +		return PTR_ERR(bus->clk);
>> +	}
>> +
>> +	ret =3D clk_prepare_enable(bus->clk);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get enable clock\n");
>> +		return ret;
>> +	}
>=20
> []
>=20
>> +err_regulator:
>> +	regulator_disable(bus->regulator);
>> +err_opp:
>> +	dev_pm_opp_of_remove_table(dev);
>> +
>> +	return ret;
>=20
> No clk_disable_unprepare() somewhere in the error handling routines?
>=20
> []
>=20
>> +#ifdef CONFIG_PM_SLEEP
>> +static int exynos_bus_resume(struct device *dev)
>> +{
> []
>> +		ret =3D regulator_enable(bus->regulator);
> []
>> +}
>> +
>> +static int exynos_bus_suspend(struct device *dev)
>> +{
> []
>> +		regulator_disable(bus->regulator);
> []
>> +}
>> +#endif
>=20
> Isn't there any possibility that you should not disable at suspend ca=
llbacks?
> If I remember correctly, we should not disable VDD-INT/VDD-MIF of Exy=
nos4412
> for suspend-to-RAM although it is "mostly" ok to do so, but not "alwa=
ys" ok.
>=20
> In such cases, I guess it should be "selectively" disabled for suspen=
d.
> (some regulators support special "low power if suspended" modes for s=
uch cases)
>=20
> []
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDx,=EF=BF=BD=C8=A7=EF=BF=BD=17=EF=BF=
=BD=EF=BF=BD=DC=A8}=EF=BF=BD=EF=BF=BD=EF=BF=BD=C6=A0z=EF=BF=BD&j:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=
=EF=BF=BD+zf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDi=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=
=1E=EF=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD?=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD&=EF=BF=BD)=DF=A2=1Bfl=3D=3D=3D
>=20

