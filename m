From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH 2/4] power: add axp20x-battery driver
Date: Wed, 06 Jul 2016 15:48:27 +0800
Message-ID: <1108451467791307@web8g.yandex.ru>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
	 <20160701092926.32005-2-icenowy@aosc.xyz> <577B44FD.6040404@mailbox.org>
	 <4101467707611@web7h.yandex.ru> <577C8A6D.8000409@computerlinguist.org>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBUHP6K5QKGQEYZYWLTQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <577C8A6D.8000409-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>, "wens-jdAy2FN1RRM@public.gmane.org" <wens-jdAy2FN1RRM@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



06.07.2016, 12:35, "Michael Haas" <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>:
> Hi There,
>
> On 05.07.2016 10:33, Icenowy Zheng wrote:
>> =C2=A0On 01.07.2016 11:29, Icenowy Zheng wrote:
>
>>>> =C2=A0=C2=A0=C2=A0+
>>>> =C2=A0=C2=A0=C2=A0+static enum power_supply_property axp22x_battery_pr=
operties[] =3D {
>>>> =C2=A0=C2=A0=C2=A0+ POWER_SUPPLY_PROP_CAPACITY,
>>>> =C2=A0=C2=A0=C2=A0+ POWER_SUPPLY_PROP_HEALTH,
>>>> =C2=A0=C2=A0=C2=A0+ POWER_SUPPLY_PROP_PRESENT,
>>>> =C2=A0=C2=A0=C2=A0+ POWER_SUPPLY_PROP_STATUS,
>>>> =C2=A0=C2=A0=C2=A0+ POWER_SUPPLY_PROP_CURRENT_NOW,
>>>> =C2=A0=C2=A0=C2=A0+ POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>>> =C2=A0=C2=A0=C2=A0+};
>
> Here's what Bruno's driver supports:
>
> static enum power_supply_property axp20x_battery_power_properties[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_PRESENT,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_ONLINE,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_STATUS,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_VOLTAGE_NOW,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_CURRENT_NOW,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_CURRENT_MAX,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_HEALTH,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_TECHNOLOGY,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* POWER_SUPPLY_PROP_POWER_NOW, */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* POWER_SUPPLY_PROP_CHARGE_NOW, */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_CAPACITY,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_TEMP,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
> };
>
>>>> =C2=A0=C2=A0=C2=A0+
>>>> =C2=A0=C2=A0=C2=A0+static int axp20x_battery_probe(struct platform_dev=
ice *pdev)
>>>> =C2=A0=C2=A0=C2=A0+{
>>>> =C2=A0=C2=A0=C2=A0+ struct axp20x_dev *axp20x =3D dev_get_drvdata(pdev=
->dev.parent);
>>>> =C2=A0=C2=A0=C2=A0+ struct power_supply_config psy_cfg =3D {};
>>>> =C2=A0=C2=A0=C2=A0+ struct axp20x_battery *power;
>>>> =C2=A0=C2=A0=C2=A0+ static const char * const axp22x_irq_names[] =3D {
>>>> =C2=A0=C2=A0=C2=A0+ "BATT_PLUGIN", "BATT_REMOVAL", "BATT_ENT_ACT_MODE"=
,
>>>> =C2=A0=C2=A0=C2=A0+ "BATT_EXIT_ACT_MODE", "CHARG", "CHARG_DONE", NULL =
};
>
> And here are the interrupts handled:
>
> static const char * const irq_names[] =3D { "BATT_HOT", "BATT_COLD",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"BATT_PLUGIN", "BAT=
T_REMOVAL", "BATT_ACTIVATE",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"BATT_ACTIVATED", "=
BATT_CHARGING", "BATT_CHARGED",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"BATT_CHG_CURR_LOW"=
, "BATT_POWER_LOW_WARN",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"BATT_POWER_LOW_CRI=
T" };
>
> There are a couple of issues with the version of Bruno's driver that I ha=
ve:
>
> * power management is disabled (in the driver, not in the charger) -
> think suspend/resume
> * the temperature sensor data is not turned into a temperature value
> correctly
> * the IRQ handlers need to be cleaned up (remove logging)
> * device tree binding documentation is missing
>
> Other than that, it's basically working and I have been using it at
> least for some testing.
>
> The device tree bindings support:
> * OCV curve support
> * battery resistance
> * battery capacity
> * temp sensor settings
>
> You can find my copy of Bruno's driver here:
> https://github.com/mhaas/linux-sunxi/blob/axp209-charger/drivers/power/ax=
p20x_fuel_gauge.c
>
> Thanks,
>
> Michael

Michael Haas:
I'm grateful for you providing your axp20x_fuel_gauge.c copy.

I will try to tidy it up and add support for axp22x.

Thanks,

Icenowy

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
