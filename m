From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity
 values for bq27421
Date: Wed, 30 Aug 2017 04:24:37 -0700
Message-ID: <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com>
 <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com> <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:38104 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbdH3LYj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2017 07:24:39 -0400
In-Reply-To: <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com

Hi Nikolaus,

On Wed, Aug 30, 2017 at 2:30 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> Hi Liam and Sebastian,
>
>> Am 29.08.2017 um 22:20 schrieb Liam Breck <liam@networkimprov.net>:
>>
>> Hi Nikolaus, thanks for the patch...
>>
>> On Tue, Aug 29, 2017 at 1:10 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> Tested on Pyra prototype with bq27421.
>>>
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> drivers/power/supply/bq27xxx_battery.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>> index b6c3120ca5ad..e3c878ef7c7e 100644
>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>> @@ -688,7 +688,7 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
>>> #define bq27545_dm_regs 0
>>> #endif
>>>
>>> -#if 0 /* not yet tested */
>>> +#if 1 /* tested on Pyra */
>>> static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
>>
>> I think we can drop the #if and #else...#endif so it's just the
>> dm_regs table, as with bq27425.
>
> I have fixed that and did take the chance to update my OpenPandora
> kernel so that I also could test and make the bq27500 working.

Is this gauge on the board or in the battery? If in the battery,
monitored-battery should not be used.

For a gauge on the board, if a user changes the battery to a different
type, they need to update the dtb.

I assume you built with config_battery_bq27xxx_dt_updates_nvm?

> The biggest hurdle was to find out that I have to change the
> compatible string to "ti,bq27500-1" to get non-NULL dm_regs...
>
> [   12.765930] bq27xxx_battery_i2c_probe name=bq27500-1-0
> [   12.771392] bq27xxx_battery_i2c_probe call setup
> [   12.874816] bq27xxx_battery_setup
> [   12.904266] bq27xxx_battery_setup: dm_regs=bf0520e0
> [   12.933380] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name attribute, please fix
> [   13.234893] bq27xxx_battery_settings
> [   13.238891] bq27xxx-battery 2-0055: invalid battery:energy-full-design-microwatt-hours 14800000

The chip does not support this param, so it should be zero, as it has
to be set if charge-full-design-* is set. Can you try that?

> [   13.312469] bq27xxx_battery_set_config
> [   13.407745] bq27xxx_battery_unseal
> [   13.455993] bq27xxx_battery_update_dm_block
> [   13.460418] bq27xxx-battery 2-0055: update terminate-voltage to 3200
> [   13.694885] bq27xxx_battery_seal

We need to see output after a reboot. Note that this chip has NVM so
these settings persist without power.

> Does this look ok for
>
>         bat: battery {
>                 compatible = "simple-battery", "openpandora-battery";
>                 voltage-min-design-microvolt = <3200000>;
>                 energy-full-design-microwatt-hours = <14800000>;
>                 charge-full-design-microamp-hours = <4000000>;
>         };
>
> ?
>
> I will send a patch for enabling both fuel gauges and the omap3-pandora-common.dtsi asap.

You probably don't want this in upstream dts, as it only programs the
gauge if the kernel has the above config option. If the box runs a
stock distro, it won't work. A custom-built kernel with the above dts
programs the gauge unless the user sets the module param
dt_monitored_battery_updates_nvm=0. The requisite dtb should be
packaged with the custom-built kernel, and deployed with awareness of
the actual battery present.
