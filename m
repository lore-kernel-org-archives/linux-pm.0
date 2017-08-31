From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity
 values for bq27421
Date: Thu, 31 Aug 2017 13:19:03 -0700
Message-ID: <CAKvHMgTGDb=JVCMpTo4ZXwRVc9s4BweAFzwGGNoewZwaT3=4LA@mail.gmail.com>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com>
 <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com>
 <7428DD60-FE09-41C4-9DBC-FFDCB9D0B591@goldelico.com> <CAKvHMgT8MDpussUYJ_AKELXzCbQxz2BYrF0ZM-S_on=9+oatEQ@mail.gmail.com>
 <3A487394-3755-4EA0-86C6-6855DA0AC547@goldelico.com> <CAKvHMgT6AHfjnXvD5jeWP_9wAm_GQNJxm=Nm1jH32NeaVZjdYw@mail.gmail.com>
 <A3715C96-BA15-4F3F-B0F1-017A5D31FFB0@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36609 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdHaUTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Aug 2017 16:19:05 -0400
In-Reply-To: <A3715C96-BA15-4F3F-B0F1-017A5D31FFB0@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com

Hi,

This may be a fix that allows >0 input from DT, but won't try to
program the register since the first 3 fields aren't compatible:

... bq27500_dm_regs[] = {
...
  [bq27xxx_dm_design_energy] = {  0,  0, 0,    0, 65535 }, /* missing on chip */
NB: align columns with other rows

Pls CC me on patch posts. You left me off your last series.

Cpl more comments below...

On Thu, Aug 31, 2017 at 2:35 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> Hi Liam,
>
>> Am 31.08.2017 um 10:58 schrieb Liam Breck <liam@networkimprov.net>:
>>
>> On Wed, Aug 30, 2017 at 11:58 PM, H. Nikolaus Schaller
>> <hns@goldelico.com> wrote:
>>> Hi Liam,
>>>
>>>> Am 30.08.2017 um 13:24 schrieb Liam Breck <liam@networkimprov.net>:
>>>>
>>>> Hi Nikolaus,
>>>>
>>>> On Wed, Aug 30, 2017 at 2:30 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>>>> Hi Liam and Sebastian,
>>>>>
>>>>>> Am 29.08.2017 um 22:20 schrieb Liam Breck <liam@networkimprov.net>:
>>>>>>
>>>>>> Hi Nikolaus, thanks for the patch...
>>>>>>
>>>>>> On Tue, Aug 29, 2017 at 1:10 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>>>>>> Tested on Pyra prototype with bq27421.
>>>>>>>
>>>>>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>>>>>> ---
>>>>>>> drivers/power/supply/bq27xxx_battery.c | 2 +-
>>>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
>>>>>>> index b6c3120ca5ad..e3c878ef7c7e 100644
>>>>>>> --- a/drivers/power/supply/bq27xxx_battery.c
>>>>>>> +++ b/drivers/power/supply/bq27xxx_battery.c
>>>>>>> @@ -688,7 +688,7 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
>>>>>>> #define bq27545_dm_regs 0
>>>>>>> #endif
>>>>>>>
>>>>>>> -#if 0 /* not yet tested */
>>>>>>> +#if 1 /* tested on Pyra */
>>>>>>> static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
>>>>>>
>>>>>> I think we can drop the #if and #else...#endif so it's just the
>>>>>> dm_regs table, as with bq27425.
>>>>>
>>>>> I have fixed that and did take the chance to update my OpenPandora
>>>>> kernel so that I also could test and make the bq27500 working.
>>>>
>>>> Is this gauge on the board or in the battery?
>>>
>>> It is on the board.
>>>
>>>> If in the battery,
>>>> monitored-battery should not be used.
>>>>
>>>> For a gauge on the board, if a user changes the battery to a different
>>>> type, they need to update the dtb.
>>>
>>> Well, that is a little difficult to control, but here we have only
>>> one standard Pandora cell. There may exist replacements with different
>>> capacity, but that should not be our problem...
>>>
>>>>
>>>> I assume you built with config_battery_bq27xxx_dt_updates_nvm?
>>>
>>> Yes.
>>>
>>>>
>>>>> The biggest hurdle was to find out that I have to change the
>>>>> compatible string to "ti,bq27500-1" to get non-NULL dm_regs...
>>>>>
>>>>> [   12.765930] bq27xxx_battery_i2c_probe name=bq27500-1-0
>>>>> [   12.771392] bq27xxx_battery_i2c_probe call setup
>>>>> [   12.874816] bq27xxx_battery_setup
>>>>> [   12.904266] bq27xxx_battery_setup: dm_regs=bf0520e0
>>>>> [   12.933380] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name attribute, please fix
>>>>> [   13.234893] bq27xxx_battery_settings
>>>>> [   13.238891] bq27xxx-battery 2-0055: invalid battery:energy-full-design-microwatt-hours 14800000
>>>>
>>>> The chip does not support this param, so it should be zero, as it has
>>>> to be set if charge-full-design-* is set. Can you try that?
>>>
>>> Hm. IMHO the DT should describe what the battery has and the driver should simply ignore
>>> values it can't handle or reject them but do the best out of it. Telling the driver to ignore
>>> a value by setting to 0 would IMHO be the wrong approach.
>>
>> The driver requires that if either charge- or energy-full-design is
>> set, then the other must be. Setting one and leaving the other at
>> default would be an error. Allowing any value for a field unsupported
>> by the chip, when supported field values must be within a range, isn't
>> useful for hw development or production scenarios. The solution for
>> shipped equipment is to drop the monitored-battery ref; see below.
>>
>>> We are also working on the generic-adc-battery driver that makes use of the same battery DT
>>> node so that people can choose if they want to configure a kernel for fuel gauge or
>>> g-a-b or even both.
>>>
>>>>
>>>>> [   13.312469] bq27xxx_battery_set_config
>>>>> [   13.407745] bq27xxx_battery_unseal
>>>>> [   13.455993] bq27xxx_battery_update_dm_block
>>>>> [   13.460418] bq27xxx-battery 2-0055: update terminate-voltage to 3200
>>>>> [   13.694885] bq27xxx_battery_seal
>>>>
>>>> We need to see output after a reboot.
>>>
>>> This was the value after first boot with the new driver enabled.
>>>
>>> A second boot after removing and reinserting battery shows:
>>>
>>> [   11.256713] bq27xxx_battery_setup
>>> [   11.256744] bq27xxx_battery_setup: dm_regs=bf05b0e0
>>> [   11.257690] (NULL device *): hwmon: 'bq27500-1-0' is not a valid name attribute, please fix
>>> [   11.258056] bq27xxx_battery_settings
>>> [   11.258300] bq27xxx-battery 2-0055: invalid battery:energy-full-design-microwatt-hours 14800000
>>> [   11.258300] bq27xxx_battery_set_config
>>> [   11.258331] bq27xxx_battery_unseal
>>
>> No mention of terminate-voltage in that run?
>
> No, I didn't see it again.

In the previous run terminate-voltage appeared after battery_unseal.
Did you dmesg | grep bq27 ?

>> Or is this truncated?
>> Looks like you didn't set energy-* to zero, so I can't tell if charge-* works.
>
> Seems to need more experimentation (and more time for it).
>
>>
>>>> Note that this chip has NVM so
>>>> these settings persist without power.
>>>
>>> Yes I know. Up to now the bq27500 has been programmed during production test
>>> by some special flashing tool. Now as the kernel driver has this capability,
>>> we should make (optionally) use of it.
>>
>> The kernel driver has this feature primarily for gauges that lack NVM.
>> It sets those without config_battery_bq27xxx_dt_updates_nvm. The NVM
>> programming feature is for hw development and/or production. I don't
>> recommend it for shipped equipment.
>
> Mostly agreed...
>
>>
>>>>
>>>>> Does this look ok for
>>>>>
>>>>>       bat: battery {
>>>>>               compatible = "simple-battery", "openpandora-battery";
>>>>>               voltage-min-design-microvolt = <3200000>;
>>>>>               energy-full-design-microwatt-hours = <14800000>;
>>>>>               charge-full-design-microamp-hours = <4000000>;
>>>>>       };
>>>>>
>>>>> ?
>>>
>>> I mainly had some initial doubts that it did not tell something like
>>> "update design-capacity" to 4000 or "design-capacity has 4000"
>>>
>>> Ah, I see:
>>>
>>>                /* assume design energy & capacity are in same block */
>>>
>>> This means the bq27500 never programs capacity because we can't specify energy.
>>> So I't suggest to revise this rule and coupling of energy and capacity setting.
>>
>> No, it failed to set charge-* because energy-* is out of range. Fix
>> that and it should just emit a warning about energy-* "buffer does not
>> match dm spec"
>
> Here I strongly disagree. The DT property should describe the battery and not
> a limitation of the fuel gauge chip or the value is not in the range of what
> the chip expects.
>
> IMHO, if the fuel gauge driver can't handle, it should not require to tamper
> with the battery DT description making it wrong and unuseable for other purposes.

You are right that we use DT:battery as config for the case of NVM hw
development/manufacture (requiring custom kernel build). It is
expedient since we have DT inputs for non-NVM chips.

But upstream dts cannot use monitored-battery to program NVM chips, as
it won't (ever) work on normal kernels. You can argue that
monitored-battery should cause a warning if an NVM chip has different
settings, and we do that!

>>
>>>>>
>>>>> I will send a patch for enabling both fuel gauges and the omap3-pandora-common.dtsi asap.
>>>>
>>>> You probably don't want this in upstream dts, as it only programs the
>>>> gauge if the kernel has the above config option. If the box runs a
>>>> stock distro, it won't work. A custom-built kernel with the above dts
>>>> programs the gauge unless the user sets the module param
>>>> dt_monitored_battery_updates_nvm=0. The requisite dtb should be
>>>> packaged with the custom-built kernel, and deployed with awareness of
>>>> the actual battery present.
>>>
>>> Imho, DT can and should describe all properties of the standard OpenPandora
>>> battery (and not missing registers of the bq27500).
>>>
>>> Using this information or not should be defined by different defconfigs.
>>
>> Just omit monitored-battery from the bq27500 node on shipped devices.
>> We shall not program NVM on a stock kernel.
>> And unfortunately you can't send an NVM gauge temporary params.
>
> Isn't this what the defconfigs are for?
>
> A stock kernel should keep CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM disabled
> and I haven't seen that it is enabled in a stock defconfig.
>
> A production kernel (or user wanting to play with it) can enable. But
> should not change the DTB.

Where I previously said "for hw development/production" the latter
term means manufacture, ie a kernel for use on assembly line for
config/test. config...dt_updates_nvm shall not be set in a defconfig,
distro, or shipped hw.

> I have done the same mistake to mis-use DT as "configuration" or ask users to
> install different DTB several times myself and was heavily criticized,
> because maintainers clearly said DT should *describe* hardware and not configure
> kernel features. I.e. there should be only one DTB for each board.
>
> Hence I would expect them to say: if the bq27500 monitors the battery
> it should be described by the DT. And if the battery has some
> energy-full-design-microwatt-hours, it should be there and not a "0" or
> omission.
>
> But that is just *my* 2ct. DT maintainers should finally say something.
>
>>
>> NB: the DT battery node is new and all the implications have not been
>> discovered.
>>
>> This BQ27 feature was begun in December of last year, and I'm a little
>> tired of thinking about it.
>
> I fully understand :) I have some patches in tiresome discussion since ca. 3 years...
>
>>  Feel free to suggest improvements, but be
>> aware that we might have already considered and rejected them :-)
>
>
> We had observed this issue for the RAM only fuel gauge bq27421 a while ago
> (I think even before December) and had started our own patch set. Grazvydas
> recently had made it working on some older kernel which is now superseded by
> your patch set. So you were faster in submitting a solution (and yours is
> even more general than what we had ever thought about).
>
> So I am very pleased with that we have a big step forward for the bq27421
> based device. Making the bq27500 in the OpenPandora fool proof isn't that important
> for the moment so we can postpone it.
>
> BR and thanks for all the work,

Feel free to send me a Pyra prototype or first-production unit  :-)
We're also working on an omap device, tho not a "handheld"
