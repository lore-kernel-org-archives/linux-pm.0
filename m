From: Michael Haas <haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 2/4] power: add axp20x-battery driver
Date: Wed, 6 Jul 2016 06:34:53 +0200
Message-ID: <577C8A6D.8000409@computerlinguist.org>
References: <20160701092926.32005-1-icenowy@aosc.xyz>
 <20160701092926.32005-2-icenowy@aosc.xyz> <577B44FD.6040404@mailbox.org>
 <4101467707611@web7h.yandex.ru>
Reply-To: haas-bdq14YP6qtSV9CzYT+GlPGD2FQJk+8+b@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBCD4V7EG6QFRBBUV6K5QKGQECTQAIAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <4101467707611-tvSLaYVQeptuio3avFS2gg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: icenowy-ymACFijhrKM@public.gmane.org, "wens-jdAy2FN1RRM@public.gmane.org" <wens-jdAy2FN1RRM@public.gmane.org>, "maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org" <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi There,

On 05.07.2016 10:33, Icenowy Zheng wrote:
> On 01.07.2016 11:29, Icenowy Zheng wrote:

>>>   +
>>>   +static enum power_supply_property axp22x_battery_properties[] = {
>>>   + POWER_SUPPLY_PROP_CAPACITY,
>>>   + POWER_SUPPLY_PROP_HEALTH,
>>>   + POWER_SUPPLY_PROP_PRESENT,
>>>   + POWER_SUPPLY_PROP_STATUS,
>>>   + POWER_SUPPLY_PROP_CURRENT_NOW,
>>>   + POWER_SUPPLY_PROP_VOLTAGE_NOW,
>>>   +};

Here's what Bruno's driver supports:

static enum power_supply_property axp20x_battery_power_properties[] = {
     POWER_SUPPLY_PROP_PRESENT,
     POWER_SUPPLY_PROP_ONLINE,
     POWER_SUPPLY_PROP_STATUS,
     POWER_SUPPLY_PROP_VOLTAGE_NOW,
     POWER_SUPPLY_PROP_CURRENT_NOW,
     POWER_SUPPLY_PROP_CURRENT_MAX,
     POWER_SUPPLY_PROP_HEALTH,
     POWER_SUPPLY_PROP_TECHNOLOGY,
     POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
     POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
     /* POWER_SUPPLY_PROP_POWER_NOW, */
     POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
     /* POWER_SUPPLY_PROP_CHARGE_NOW, */
     POWER_SUPPLY_PROP_CAPACITY,
     POWER_SUPPLY_PROP_TEMP,
     POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
     POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
};

>>>   +
>>>   +static int axp20x_battery_probe(struct platform_device *pdev)
>>>   +{
>>>   + struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
>>>   + struct power_supply_config psy_cfg = {};
>>>   + struct axp20x_battery *power;
>>>   + static const char * const axp22x_irq_names[] = {
>>>   + "BATT_PLUGIN", "BATT_REMOVAL", "BATT_ENT_ACT_MODE",
>>>   + "BATT_EXIT_ACT_MODE", "CHARG", "CHARG_DONE", NULL };


And here are the interrupts handled:

static const char * const irq_names[] = { "BATT_HOT", "BATT_COLD",
         "BATT_PLUGIN", "BATT_REMOVAL", "BATT_ACTIVATE",
         "BATT_ACTIVATED", "BATT_CHARGING", "BATT_CHARGED",
         "BATT_CHG_CURR_LOW", "BATT_POWER_LOW_WARN",
         "BATT_POWER_LOW_CRIT" };



There are a couple of issues with the version of Bruno's driver that I have:

* power management is disabled (in the driver, not in the charger) - 
think suspend/resume
* the temperature sensor data is not turned into a temperature value 
correctly
* the IRQ handlers need to be cleaned up (remove logging)
* device tree binding documentation is missing

Other than that, it's basically working and I have been using it at 
least for some testing.

The device tree bindings support:
* OCV curve support
* battery resistance
* battery capacity
* temp sensor settings

You can find my copy of Bruno's driver here:
https://github.com/mhaas/linux-sunxi/blob/axp209-charger/drivers/power/axp20x_fuel_gauge.c

Thanks,

Michael
