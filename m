From: Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine documentation
Date: Mon, 30 Jan 2017 13:40:38 -0800
Message-ID: <CAKvHMgRp=duoWFzQPR58sHjuOE5R3p2tL3e0RNBUk7_f9mB6fg@mail.gmail.com>
References: <20170122071404.9654-3-matt@ranostay.consulting>
 <20170122222212.27086-1-liam@networkimprov.net> <CAKvHMgRYqh_fksDXq2Jv1t6p9ckCOgR+O6gxRTdpd=9r8y__Bg@mail.gmail.com>
 <CAJ_EiSSPeWj+q+R5=HVVrsb39208-Gmj5_7T=ic6mYLxFuekNQ@mail.gmail.com>
 <20170129172006.jsjfxrehynfegpfr@earth> <CAKvHMgSYXYyW7AEHaa_wkh3UQyE6wJPYV66HAugBf3wHOeoSmg@mail.gmail.com>
 <20170130023012.b2vnye6vb4yoawcq@earth> <CAKvHMgQi1tRyUXh0504rP8VUVkFVPt_4NnYTOrBXeO4dde6KMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKvHMgQi1tRyUXh0504rP8VUVkFVPt_4NnYTOrBXeO4dde6KMg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 30, 2017 at 2:54 AM, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org> wrote:
> On Sun, Jan 29, 2017 at 6:30 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> Hi,
>>
>> On Sun, Jan 29, 2017 at 03:22:31PM -0800, Liam Breck wrote:
>>> On Sun, Jan 29, 2017 at 9:20 AM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>> > On Wed, Jan 25, 2017 at 11:02:03PM -0800, Matt Ranostay wrote:
>>> >> On Wed, Jan 25, 2017 at 10:19 PM, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org> wrote:
>>> >> > On Sun, Jan 22, 2017 at 2:22 PM, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org> wrote:
>>> >> >
>>> >> >> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>>> >> >> new file mode 100644
>>> >> >> index 000000000000..398b4d622883
>>> >> >> --- /dev/null
>>> >> >> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>>> >> >> @@ -0,0 +1,34 @@
>>> >> >> +Battery Characteristics
>>> >> >> +
>>> >> >> +Required Properties:
>>> >> >> + - compatible: Must be "fixed-battery"
>>> >> >> +
>>> >> >> +Optional Properties:
>>> >> >> + - termination-microvolt: dead battery voltage
>>> >> >> + - design-microwatt-hours: battery design energy
>>> >> >> + - design-microamp-hours: battery design capacity
>>> >> >
>>> >> > Also I suspect the members of struct power_supply_battery_info should
>>> >> > use the same names as appear in dts:
>>> >>
>>> >> These are internal and we can't be thinking just device tree.. ACPI
>>> >> and platform data is also an option.
>>> >
>>> > well platform data just uses the struct. ACPI is probably not
>>> > relevant, since in ACPI world one usually has smart batteries.
>>> > But yes, the names can be different.
>>> >
>>> > The important part is, that the API is used correctly, so it
>>> > should be clear what each property is used for. For example
>>> > termination_microvolt is not clear: Is this charge termination
>>> > voltage or system shutdown voltage? Also we do not need to add
>>> > "micro", since the power-supply subsystem always uses micro
>>> > based units.
>>>
>>> It's the min battery voltage. So...
>>> drained_voltage, depleted_voltage, sapped_voltage, spent_voltage...
>>
>> This is often called EOD (end of discharge) voltage, so let's use
>> end_of_discharge_voltage.
>
> ...

Actually, let's use names from POWER_SUPPLY_PROP_*, as DT inputs may
be visible in sysfs, e.g. *_CHARGE_FULL_DESIGN. This would require new
enum elements in future for the BQ24190 properties I mentioned
up-thread.

That looks like:

Optional Properties:
   - voltage-min-design-microvolt: dead battery voltage
   - energy-full-design-microwatt-hours: battery design energy
   - charge-full-design-microamp-hours: battery design capacity

 struct power_supply_battery_info {
    int voltage_min_design_uv;   /* microVolts */
    int energy_full_design_uwh;  /* microWatt-hours */
    int charge_full_design_uah;  /* microAmp-hours */
 };

Default value for unset DT properties will be -EINVAL, since 0 is
valid for *_full_design_* on the chips.

~.~
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
