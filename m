From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v6 4/6] power: supply: core: Add some helpers to use the
 battery OCV capacity table
Date: Fri, 2 Nov 2018 01:30:09 +0800
Message-ID: <CAMz4kuJg5QKg2kGhU8kHgmM-Yrhe_kw1=Ph4-9_x3YX8BWY1xw@mail.gmail.com>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <f1529c567a340e4d31354a4b117954eeebf89942.1540189330.git.baolin.wang@linaro.org>
 <CAMz4kuJm5eO1QwW7L+QyD_5VcTWqtq4gz9m_QDpQ-zn4zzukvQ@mail.gmail.com> <20181101135005.cqufebdryffm6ray@qschulz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181101135005.cqufebdryffm6ray@qschulz>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>, Craig Tatlor <ctatlor97@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, maxime.ripard@bootlin.com, Hans de Goede <hdegoede@redhat.com>, icenowy@aosc.io
List-Id: linux-pm@vger.kernel.org

Hi Quentin,

On 1 November 2018 at 21:50, Quentin Schulz <quentin.schulz@bootlin.com> wrote:
> Hi Baolin,
>
> On Thu, Nov 01, 2018 at 03:22:18PM +0800, Baolin Wang wrote:
>> Hi Quentin,
>>
>> On 29 October 2018 at 22:48, Quentin Schulz <quentin.schulz@bootlin.com> wrote:
> [...]
>> >
>> >> +             return len;
>> >> +     } else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
>> >> +             dev_err(&psy->dev, "Too many temperature values\n");
>> >> +             return -EINVAL;
>> >> +     } else if (len > 0) {
>> >> +             of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
>> >> +                                        info->ocv_temp, len);
>> >> +     }
>> >> +
>> >> +     for (index = 0; index < len; index++) {
>> >
>> > This won't work as intended as we can reach this part of the code with
>> > len = -EINVAL;
>>
>> No, the condition (index < len) is false if len = -EINVAL, maybe one
>> reason keep index as 'int' type.
>>
>
> Ugh. Next time I'll make sure my brain is wired before reviewing a
> patch, sorry :)

No worries, just make things clear :)

>
> [...]
>> >> +             if (!info->ocv_table[index]) {
>> >> +                     power_supply_put_battery_info(psy, info);
>> >> +                     return -ENOMEM;
>> >> +             }
>> >> +
>> >> +             for (i = 0; i < tab_len; i++) {
>> >> +                     table[i].ocv = be32_to_cpu(*list++);
>> >> +                     table[i].capacity = be32_to_cpu(*list++);
>> >
>> > Please check these are valid values.
>>
>> Um, It is hard to validate the values for OCV and capacity, because
>> now we do not know each battery's parameters. Any good suggestion?
>>
>
> You know the capacity is between 0 and 100 (since it's an unsigned
> value, checking against 100 is enough), that's a good start.

Yeah, we can validate the percent values.

>
> For the OCV, I'd say it's basically between the minimum and maximum
> voltage a battery can hold. I don't know enough about batteries to
> give the correct bounds unfortunately :(

But in this function, we may can not know the minimum and maximum
voltage of a battery. Some drivers will set the minimum and maximum
voltage in their drivers. So I would like to move the OCV values
validation to drivers.

>
> [...]
>> > What is the use case for letting a user call this function? I can
>> > understand you want to delete the arrays if they're invalid in the
>> > get_function, which could be done thanks to a goto statement or with
>> > this function if you really want (if it does not mess with refs) but I
>> > don't see why you want to export this function.
>>
>> Cause some drivers will copy the OCV tables into their own structures,
>> one helper function to help to free memory of battery information. In
>> future, this can be expanded to clean up more resources of battery
>> information.
>>
>
> Couldn't they only use a pointer to the appropriate table? Or do you
> plan on the drivers directly modifying the table but wanting to keep a
> clean copy on the core side?
>
> I find it weird to free the tables. I'd suppose that a driver wants to
> keep all tables available to be able to chose the appropriate one
> depending on the current temperature of the battery (which is what
> power_supply_batinfo_ocv2cap is for if I understood correctly) and not
> only at definite time (probe function for the driver you attached to the
> patch series IIRC). If you need to keep all tables, why would you want
> to copy them to the driver and not keep them in the core and use a
> pointer to the table in current use?
>
> I'm sure I'm missing something, let me know what it is. Thanks.

Some drivers won't use all of the battery information in struct
power_supply_battery_info, so they can copy the required fields into
their drivers' data structure instead of holding all fields in struct
power_supply_battery_info, which can save some memory (especially we
introduced temperature tables for struct power_supply_battery_info).
So for this case, we only use the OCV table in struct
power_supply_battery_info, I did not use one pointer to the struct
power_supply_battery_info, just copy the required OCV tables into my
data structure and ignore other fields. So I should free the OCV
tables of battery information. Hope I make things clear here.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/power/supply/axp20x_battery.c#L604
[2] https://elixir.bootlin.com/linux/latest/source/drivers/power/supply/bq24190_charger.c#L1673

>
> [...]
>> > I would like to give my specific use case of the OCV on X-Powers PMICs
>> > so that hopefully we can get things sorted out before it's too late to
>> > make modifications that might be needed.
>> >
>> > I'm adding a few people on Cc that work on the X-Power PMICs so that
>> > hopefully we can have all the correct pieces of information and go
>> > towards the right solution.
>> >
>> > In the AXP818/AXP288 datasheet[1] (p.57), we have access to OCV values
>> > and battery RDC register.
>> >
>> > The hardware learns from the battery or from the given OCV and RDC
>> > values and then updates the returned battery capacity accordingly (in
>> > another register).
>> > I've 32 values (see the issue with a max of 20 values?) to be written in
>>
>> I think you misunderstood the 20, it is means we can have max 20 OCV tables now.
>>
>
> Indeed, misread the patch, thanks for clarifying.
>
>> > different registers that represent the battery capacity at a given
>> > voltage. I do not have to do any computation on the kernel side, I just
>> > have to set the registers with the correct values and the battery
>> > capacity will be auto-updated by the PMIC. With this patch series,
>> > should I just call power_supply_get_battery_info, get the OCV tables and
>>
>> I think so.
>>
>> > do my thing in the driver? Could we have a more generic way to do it
>> > (does it make sense to have a generic one?)?
>>
>> Sorry, maybe I did not follow you here. You said your hardware will
>> help to get the capacity automatically if you set the register, so
>> what generic way you want to introduce? Could you elaborate on?
>>
>
> I think I got my thoughts tangled-up, I can't honestly find a generic
> way right now.

OK.

>
>> >
>> > We also definitely need a sysfs entry so that the user can enter the new
>> > values of the RDC/OCV since it changes during the life cycle of the
>> > battery IIRC.
>>
>> Why it changed? Due to different temperatures or other factors? If the
>> factor is temperature, I think we have supplied one generic way:
>> https://lore.kernel.org/patchwork/patch/1002350/
>>
>
> Apparently age is a factor in the OCV curve. I don't know if it's
> substantial enough to care about though.
>
> Anyway, I have a very strong bias towards not having to modify the
> Device Tree or recompile the kernel when a piece of hardware can be
> replaced easily by something different. I see the battery as such a
> piece of hardware. I understand the need to define the battery that
> comes with a product but I also like to let the users switch the battery
> (for a bigger one for example) without getting their hands dirty with
> getting the kernel sources, recompiling, etc.
>
> What if the provided OCV curves are not the best ones and the user has
> found better ones?
>
> For that, I like to let the user configure parameters that impact the
> battery after we've optionaly set the default one.
>
> I'd be mad to have to recompile the Device Tree or kernel when switching
> devices on a USB bus for example.
>
> Does that make sense?

Yes, understood. But I can not add this feature in my patch series,
since we have no this usage for SC27xx FGU. So I think it will be good
to submit one separate patch, which can let other guys focus on your
case and maybe give a better solution. Thanks for your comments.

-- 
Baolin Wang
Best Regards
