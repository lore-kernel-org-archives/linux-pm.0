From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine documentation
Date: Wed, 25 Jan 2017 23:02:03 -0800
Message-ID: <CAJ_EiSSPeWj+q+R5=HVVrsb39208-Gmj5_7T=ic6mYLxFuekNQ@mail.gmail.com>
References: <20170122071404.9654-3-matt@ranostay.consulting>
 <20170122222212.27086-1-liam@networkimprov.net> <CAKvHMgRYqh_fksDXq2Jv1t6p9ckCOgR+O6gxRTdpd=9r8y__Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36027 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdAZHCF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jan 2017 02:02:05 -0500
Received: by mail-qt0-f170.google.com with SMTP id k15so59798325qtg.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2017 23:02:04 -0800 (PST)
In-Reply-To: <CAKvHMgRYqh_fksDXq2Jv1t6p9ckCOgR+O6gxRTdpd=9r8y__Bg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>

On Wed, Jan 25, 2017 at 10:19 PM, Liam Breck <liam@networkimprov.net> wrote:
> On Sun, Jan 22, 2017 at 2:22 PM, Liam Breck <liam@networkimprov.net> wrote:
>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> new file mode 100644
>> index 000000000000..398b4d622883
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -0,0 +1,34 @@
>> +Battery Characteristics
>> +
>> +Required Properties:
>> + - compatible: Must be "fixed-battery"
>> +
>> +Optional Properties:
>> + - termination-microvolt: dead battery voltage
>> + - design-microwatt-hours: battery design energy
>> + - design-microamp-hours: battery design capacity
>
> Also I suspect the members of struct power_supply_battery_info should
> use the same names as appear in dts:

These are internal and we can't be thinking just device tree.. ACPI
and platform data is also an option.

>
> +struct power_supply_battery_info {
> +  int design_microwatt_hours;
> +  int design_microamp_hours;
> +  int termination_microvolt;
> etc
