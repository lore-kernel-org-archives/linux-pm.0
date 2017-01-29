From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine documentation
Date: Sun, 29 Jan 2017 15:32:10 -0800
Message-ID: <CAKvHMgTrFjjEWwK-NeGOF1o6KRQPXYUvcqWcDwaW+5ZKjQ7VZA@mail.gmail.com>
References: <20170122071404.9654-3-matt@ranostay.consulting>
 <20170122222212.27086-1-liam@networkimprov.net> <20170129180619.di5ul4owkzjveoct@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35526 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdA2Xkl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Jan 2017 18:40:41 -0500
In-Reply-To: <20170129180619.di5ul4owkzjveoct@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>

On Sun, Jan 29, 2017 at 10:06 AM, Sebastian Reichel <sre@kernel.org> wrote:
> On Sun, Jan 22, 2017 at 02:22:12PM -0800, Liam Breck wrote:
...
>> +Batteries must be referenced by chargers and/or fuel-gauges
>> +using a phandle. The phandle's property should be named
>> +"monitored-battery".
>> +
>> +Example:
>> +
>> +     bat: battery {
>> +             compatible = "fixed-battery";
>> +             terminate-microvolt = <3700000>;
>> +             design-microwatt-hours = <5290000>;
>> +             design-microamp-hours = <1430000>;
>> +     };
>> +
>> +     charger: charger@0 {
>> +             ....
>> +             monitored-battery = <&bat>;
>> +             ...
>> +     };
>> +
>> +     fuel_gauge: fuel_gauge@0 {
>> +             ....
>> +             monitored-battery = <&bat>;
>> +             ...
>> +     };
>
> The charger stuff does does not integrate well with
> pre-existing support for power-supplies property
> described in
> Documentation/devicetree/bindings/power/supply/power_supply.txt
>
> I think the proper chain would be:
>
> bat: battery {
>         compatible = "fixed-battery";
>         terminate-microvolt = <3700000>;
>         design-microwatt-hours = <5290000>;
>         design-microamp-hours = <1430000>;
> };
>
> fuel_gauge: fuel_gauge@0 {
>         ...
>         monitored-battery = <&bat>;
>         power-supplies = <&charger>;
>         ...
> };
>
> charger: charger@0 {
>         ...
> };
>
> I added the power-supplies node to the fuel-gauge instead of the battery,
> since fuel-gauge + fixed-battery is basically a smart battery.

BQ24190 charger will need other params from a battery node. How does
it get them in this scenario?
