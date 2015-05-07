From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] power_supply: Add support for Richtek rt9455 battery
 charger
Date: Thu, 7 May 2015 10:22:58 +0300
Message-ID: <20150507072258.GP10973@lpalcu-linux>
References: <1430843530-26252-1-git-send-email-anda-maria.nicolae@intel.com>
 <20150506114003.GM10973@lpalcu-linux>
 <554A360C.7020401@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <554A360C.7020401-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Anda,

On Wed, May 06, 2015 at 06:41:00PM +0300, Anda-Maria Nicolae wrote:
(...)
> >>Updates from v2 version:
> >>- removed unused masks and keep the used ones. I have tried to access mask field
> >>from struct regmap_field, but I have received the following compilation error:
> >>"dereferencing pointer to incomplete type". I think this happens because I include
> >>the file include/linux/regmap.h and in this file struct regmap_field is only declared
> >>and not defined. Struct regmap_field is defined in drivers/base/regmap/internal.h.
> >>If I include this file, compilation works. But I do not think it is a good idea
> >>to include it; I did not find any other driver which includes this file. I also
> >>could not find any driver that accesses mask field from struct regmap_field.
> >If you want to go this path, which looks promising since you can get rid
> >of all mask macros, you don't need regmap_field to compute your masks.
> >You need reg_field (include/linux/regmap.h). When you setup your fields,
> >you use:
> >
> >static const struct reg_field rt9455_reg_fields[] = {...};
> >
> >Hence, you have access to both msb and lsb of each field and you can
> >easily compute your mask. Just an idea.
> >
> Because the masks are constant, I believe it is better to define
> macros for them instead of calculating every time the driver uses
> one of them. This is why I wanted to use mask field: to avoid
> calculating them and to remove the macros.
How about using a macro like the one below?

GET_MASK(fid)	(BIT(rt9455_reg_fields[fid].msb] + 1) - BIT(rt9455_reg_fields[fid].lsb))

You can just do: v & GET_MASK(F_TSDI)

instead of: v & RT9455_REG_IRQ1_TSDI_MASK

It looks simple enough and uses the information that you already have when
declaring the reg_fields. The runtime performance will not be impacted
since the compiler will compute the value at compile time. Does that
sound good to you?

> >>For instance, drivers/pwm/pwm-sti.c at lines 157, 158, also uses masks.
> >>
> >>- I have also kept REG_FIELD definitions for interrupt registers, since, for instance,
> >>I use F_BATAB to check battery presence property.
> >>
> >>- cached regs 0x05 and 0x06. Also, I have added rt9455_is_writeable_reg function
> >>for writeable_reg field of regmap_config.
> >>
> >>- used POWER_STATUS_DISCHARGING, replaced break with and replaced it with return and
> >>indented it correctly. I spent some time on this and I finally understood what is happening.
> >>So, if PWR_RDY bit is set, but STAT bits value is 0, the charger may be in one
> >>of the following cases:
> >>1. CHG_EN bit is 0.
> >>2. CHG_EN bit is 1 but the battery is not connected.
> >>In any of these cases, POWER_SUPPLY_STATUS_NOT_CHARGING is returned.
> >>If the PWR_RDY bit is cleared, POWER_SUPPLY_STATUS_DISCHARGING is returned.
> >>
> >>- used VOREG bits value instead of VMREG in functions rt9455_charger_get_voltage_max()/
> >>rt9455_charger_set_voltage_max(). Although RT9455 charger has VMREG bits which,
> >>according to the datasheet, represent "Maximum battery regulation voltage", the
> >>charger never uses VMREG value as maximum threshold for battery voltage. This
> >>happens because TE and TE_SHDN_EN bits are set during rt9455_probe(), and charging
> >>operation is terminated when charging current is less than ICHRG x IEOC. When charging
> >>operation is terminated, battery voltage is almost equal to VOREG. Therefore,
> >>VMREG value is not taken into account. This is the reason why VOREG value is
> >>set/returned in these functions.
> >Something's not right... What happens in the following scenario:
> >VMREG=4.2V (default value) and user sets VOREG=4.45V? Did you test this
> >case. I really doubt VMREG field is not used at all. Of course, you can set
> >VMREG to maximum value in which case VMREG doesn't really matter.
> 
> I have set VMREG to its maximum value in rt9455_hw_init() function.
> Please take a look at my last patch.
Yes, I saw that.

> Yes, I have tested this case with a battery whose voltage is 3.97V,
> VOREG = 4.45V and VMREG = 4.2V. The charger drains current from the
> power source. If I set VOREG to 4V, from 4.45V, Charge done
> interrupt is triggered and no current is drained from the power
> source. If I increase VMREG to 4.45V, and keep VOREG to 4V, no input
> current is drained from the power source, but if I increase VOREG to
> 4.2V, the charger drains current from the power source. This is why
> I have decided to use VOREG instead of VMREG.
OK, the behavior you're describing looks as expected. But VMREG and
VOREG is about voltages, not currents. Did you measure the output
voltage when VOREG=4.45V and VMREG=4.2? What is it? I suspect it will be
4.2V.

So, my point is, I'm pretty sure VMREG is not ignored if one chooses to
use it.

(...)
> >>+
> >>+static int rt9455_charger_set_voltage(struct rt9455_info *info,
> >>+				      const union power_supply_propval *val)
> >>+{
> >>+	return rt9455_set_field_val(info, F_VOREG,
> >>+				    rt9455_voreg_values,
> >>+				    ARRAY_SIZE(rt9455_voreg_values),
> >>+				    val->intval);
> >>+}
> >>+
> >>+static int rt9455_charger_set_voltage_max(struct rt9455_info *info,
> >>+					  const union power_supply_propval *val)
> >>+{
> >>+	/*
> >>+	 * Although RT9455 charger has VMREG bits which, according to the
> >>+	 * datasheet, represent "Maximum battery regulation voltage", the
> >>+	 * charger never uses VMREG value as maximum threshold for battery
> >>+	 * voltage. This happens because TE and TE_SHDN_EN bits are set during
> >>+	 * rt9455_probe(), and charging operation is terminated when charging
> >>+	 * current is less than ICHRG x IEOC. When charging operation is
> >>+	 * terminated, battery voltage is almost equal to VOREG. Therefore,
> >>+	 * VMREG value is not taken into account. This is the reason why VOREG
> >>+	 * value is set in this function.
> >>+	 */
> >>+	return rt9455_set_field_val(info, F_VOREG,
> >>+				    rt9455_voreg_values,
> >>+				    ARRAY_SIZE(rt9455_voreg_values),
> >>+				    val->intval);
> >>+}
> >Apparently, rt9455_charger_set_voltage_max() and
> >rt9455_charger_set_voltage() do the same thing?
> 
> Yes, they do the same thing. If I increase VMREG instead of VOREG,
> the charger does not drain current if the battery voltage is almost
> equal to VOREG and I think the user wants the contrary.
I'm sorry but your explanation has nothing to do with the fact that you
are duplicating code here... You could've had one function, instead of
2. Never mind though, it looks like you decided not to have these
properties writable and these functions will probably be gone
altogether.

laurentiu 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
