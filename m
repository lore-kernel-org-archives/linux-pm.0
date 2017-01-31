From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v4 2/8] devicetree: power: add battery state machine documentation
Date: Tue, 31 Jan 2017 12:59:22 -0800
Message-ID: <CAKvHMgRL9g1oY7oYYv45zLw4dtQwDDchuOVeROHVTJ9vhRMF0g@mail.gmail.com>
References: <20170122071404.9654-3-matt@ranostay.consulting>
 <20170122222212.27086-1-liam@networkimprov.net> <20170129180619.di5ul4owkzjveoct@earth>
 <CAKvHMgTrFjjEWwK-NeGOF1o6KRQPXYUvcqWcDwaW+5ZKjQ7VZA@mail.gmail.com>
 <20170130023934.l5s7jwaozcjovqhc@earth> <CAKvHMgQFj1K2yLH3bRWYJDqB9qSVU_Gi_n2ZQB_scyg-TRCroA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33644 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdAaVHI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2017 16:07:08 -0500
In-Reply-To: <CAKvHMgQFj1K2yLH3bRWYJDqB9qSVU_Gi_n2ZQB_scyg-TRCroA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>, Rob Herring <robh@kernel.org>

On Sun, Jan 29, 2017 at 6:46 PM, Liam Breck <liam@networkimprov.net> wrote:
> On Sun, Jan 29, 2017 at 6:39 PM, Sebastian Reichel <sre@kernel.org> wrote:
>> Hi,
>>
>> On Sun, Jan 29, 2017 at 03:32:10PM -0800, Liam Breck wrote:
>>> On Sun, Jan 29, 2017 at 10:06 AM, Sebastian Reichel <sre@kernel.org> wrote:
>>> > On Sun, Jan 22, 2017 at 02:22:12PM -0800, Liam Breck wrote:
>>> ...
>>> >> +Batteries must be referenced by chargers and/or fuel-gauges
>>> >> +using a phandle. The phandle's property should be named
>>> >> +"monitored-battery".
>>> >> +
>>> >> +Example:
>>> >> +
>>> >> +     bat: battery {
>>> >> +             compatible = "fixed-battery";
>>> >> +             terminate-microvolt = <3700000>;
>>> >> +             design-microwatt-hours = <5290000>;
>>> >> +             design-microamp-hours = <1430000>;
>>> >> +     };
>>> >> +
>>> >> +     charger: charger@0 {
>>> >> +             ....
>>> >> +             monitored-battery = <&bat>;
>>> >> +             ...
>>> >> +     };
>>> >> +
>>> >> +     fuel_gauge: fuel_gauge@0 {
>>> >> +             ....
>>> >> +             monitored-battery = <&bat>;
>>> >> +             ...
>>> >> +     };
>>> >
>>> > The charger stuff does does not integrate well with
>>> > pre-existing support for power-supplies property
>>> > described in
>>> > Documentation/devicetree/bindings/power/supply/power_supply.txt
>>> >
>>> > I think the proper chain would be:
>>> >
>>> > bat: battery {
>>> >         compatible = "fixed-battery";
>>> >         terminate-microvolt = <3700000>;
>>> >         design-microwatt-hours = <5290000>;
>>> >         design-microamp-hours = <1430000>;
>>> > };
>>> >
>>> > fuel_gauge: fuel_gauge@0 {
>>> >         ...
>>> >         monitored-battery = <&bat>;
>>> >         power-supplies = <&charger>;
>>> >         ...
>>> > };
>>> >
>>> > charger: charger@0 {
>>> >         ...
>>> > };
>>> >
>>> > I added the power-supplies node to the fuel-gauge instead of the battery,
>>> > since fuel-gauge + fixed-battery is basically a smart battery.
>>>
>>> BQ24190 charger will need other params from a battery node. How does
>>> it get them in this scenario?
>>
>> It should be able to get all required properties from the bq27xxx.
>> Otherwise supporting smart batteries is impossible. What properties
>> do you need?
>
> These two, at a minimum:
>
> - precharge-microamps: maximum charge current during precharge
>   phase (typically 20% of battery capacity)
>
> - termination-microamps: a charge cycle terminates when the
>   battery voltage is above recharge threshold, and the current is below
>   this setting (typically 10% of battery capacity)

The relevant docs, see section 9.5.1.4
http://www.ti.com/lit/ds/symlink/bq24190.pdf#31

BQ27xxx doesn't know about these parameters, but they are
characteristics of a fixed-battery, since the values are based on its
capacity. Smart batteries may have a circuit to limit current during
these phases. The BQ24190 charger is intended for dumb batteries :-)

So I believe letting charger and fuel-gauge both reference
monitored-battery is the right scheme.

~.~
