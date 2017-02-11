From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v5 1/8] devicetree: power: Add battery.txt
Date: Fri, 10 Feb 2017 18:03:41 -0800
Message-ID: <CAKvHMgSC9jBz7_RB6MK_jtZFELHwxxqotOk8A2VKOYwqet-kMA@mail.gmail.com>
References: <20170204091603.32242-1-liam@networkimprov.net>
 <20170204091603.32242-2-liam@networkimprov.net> <20170208215840.w4ptnq2wj4t5eeps@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34393 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbdBKCEa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2017 21:04:30 -0500
In-Reply-To: <20170208215840.w4ptnq2wj4t5eeps@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Matt Ranostay <matt@ranostay.consulting>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Wed, Feb 8, 2017 at 1:58 PM, Rob Herring <robh@kernel.org> wrote:
> On Sat, Feb 04, 2017 at 01:15:56AM -0800, Liam Breck wrote:
>> From: Matt Ranostay <matt@ranostay.consulting>
>>
>> From: Matt Ranostay <matt@ranostay.consulting>
>>
>> Documentation of static battery characteristics that can be defined
>> for batteries which cannot self-identify. This information is required
>> by fuel-gauge and charger chips for proper handling of the battery.
>
> I hope this is a common binding and not yet another battery binding.

Yes, Sebastian had us add support for this in power_supply_core with

int power_supply_get_battery_info(
  struct power_supply *psy,
  struct power_suppy_battery_info *info)


>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  .../devicetree/bindings/power/supply/battery.txt   | 39 ++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/battery.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
>> new file mode 100644
>> index 0000000..d663c48
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/battery.txt
>> @@ -0,0 +1,39 @@
>> +Battery Characteristics
>> +
>> +Required Properties:
>> + - compatible: Must be "fixed-battery"
>
> The "fixed" part seems a bit pointless. Just "battery" would be a
> bit generic. Don't you need to know the battery chemistry typically? Or
> number of cells?

Sebastian suggested fixed-battery to indicate a non-smart battery,
i.e. a pack without self-awareness besides a protection circuit.

I don't know what compatible would have for a smart battery. That
might be useful to establish now...

I'll be posting v6 shortly, with no change re compatible.

~.~
