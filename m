From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine documentation
Date: Mon, 30 Jan 2017 02:54:06 -0800
Message-ID: <CAKvHMgQi1tRyUXh0504rP8VUVkFVPt_4NnYTOrBXeO4dde6KMg@mail.gmail.com>
References: <20170122071404.9654-3-matt@ranostay.consulting>
 <20170122222212.27086-1-liam@networkimprov.net> <CAKvHMgRYqh_fksDXq2Jv1t6p9ckCOgR+O6gxRTdpd=9r8y__Bg@mail.gmail.com>
 <CAJ_EiSSPeWj+q+R5=HVVrsb39208-Gmj5_7T=ic6mYLxFuekNQ@mail.gmail.com>
 <20170129172006.jsjfxrehynfegpfr@earth> <CAKvHMgSYXYyW7AEHaa_wkh3UQyE6wJPYV66HAugBf3wHOeoSmg@mail.gmail.com>
 <20170130023012.b2vnye6vb4yoawcq@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:32894 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbdA3Kzw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 05:55:52 -0500
In-Reply-To: <20170130023012.b2vnye6vb4yoawcq@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>

On Sun, Jan 29, 2017 at 6:30 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Sun, Jan 29, 2017 at 03:22:31PM -0800, Liam Breck wrote:
>> On Sun, Jan 29, 2017 at 9:20 AM, Sebastian Reichel <sre@kernel.org> wrote:
>> > On Wed, Jan 25, 2017 at 11:02:03PM -0800, Matt Ranostay wrote:
>> >> On Wed, Jan 25, 2017 at 10:19 PM, Liam Breck <liam@networkimprov.net> wrote:
>> >> > On Sun, Jan 22, 2017 at 2:22 PM, Liam Breck <liam@networkimprov.net> wrote:
>> >> >
>> >> >> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> >> >> new file mode 100644
>> >> >> index 000000000000..398b4d622883
>> >> >> --- /dev/null
>> >> >> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> >> >> @@ -0,0 +1,34 @@
>> >> >> +Battery Characteristics
>> >> >> +
>> >> >> +Required Properties:
>> >> >> + - compatible: Must be "fixed-battery"
>> >> >> +
>> >> >> +Optional Properties:
>> >> >> + - termination-microvolt: dead battery voltage
>> >> >> + - design-microwatt-hours: battery design energy
>> >> >> + - design-microamp-hours: battery design capacity
>> >> >
>> >> > Also I suspect the members of struct power_supply_battery_info should
>> >> > use the same names as appear in dts:
>> >>
>> >> These are internal and we can't be thinking just device tree.. ACPI
>> >> and platform data is also an option.
>> >
>> > well platform data just uses the struct. ACPI is probably not
>> > relevant, since in ACPI world one usually has smart batteries.
>> > But yes, the names can be different.
>> >
>> > The important part is, that the API is used correctly, so it
>> > should be clear what each property is used for. For example
>> > termination_microvolt is not clear: Is this charge termination
>> > voltage or system shutdown voltage? Also we do not need to add
>> > "micro", since the power-supply subsystem always uses micro
>> > based units.
>>
>> It's the min battery voltage. So...
>> drained_voltage, depleted_voltage, sapped_voltage, spent_voltage...
>
> This is often called EOD (end of discharge) voltage, so let's use
> end_of_discharge_voltage.

How's this?

Optional Properties:
  - end-of-discharge-microvolt: dead battery voltage
  - design-microwatt-hours: battery design energy
  - design-microamp-hours: battery design capacity

struct power_supply_battery_info {
   int design_energy_uwh;  /* microWatt-hours */
   int design_current_uah;  /* microAmp-hours */
   int end_of_discharge_uv; /* microVolts */
};

Default value for unset DT properties will be -EINVAL, since 0 is
valid for design_* on the chips.
