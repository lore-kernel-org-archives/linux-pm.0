From: Liam Breck <liam@networkimprov.net>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset
 pdata flag
Date: Sat, 18 Mar 2017 17:57:44 -0700
Message-ID: <CAKvHMgTYqypPiv0KcoFZqpojq50yUDoU=HL8uiwPyKP7HLTy1A@mail.gmail.com>
References: <20170318071019.4561-1-liam@networkimprov.net> <6ad6ecd2-ea0f-b613-8519-66ad424c623a@redhat.com>
 <CAKvHMgQ-hnS_XkL_7Mwkm94hNDc9Q++xHBAOUK1bKmvO=YnSXQ@mail.gmail.com> <6a0e54e3-581d-6162-b521-82b7567b6e74@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35342 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdCSA5q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Mar 2017 20:57:46 -0400
Received: by mail-it0-f66.google.com with SMTP id y18so10864187itc.2
        for <linux-pm@vger.kernel.org>; Sat, 18 Mar 2017 17:57:45 -0700 (PDT)
In-Reply-To: <6a0e54e3-581d-6162-b521-82b7567b6e74@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

Hi Hans,

I realize you put a ton of work into this patchset. Pls know that I
want you to end up with a solution that both works for you, and makes
the charger driver more generally useful. All of my critique is
offered in good faith, and not meant as rejection. I genuinely regret
it if you feel otherwise.

Pls consider my feedback for a couple days; I put a lot of thought into it.

On Sat, Mar 18, 2017 at 3:51 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 18-03-17 19:51, Liam Breck wrote:
>>
>> On Sat, Mar 18, 2017 at 7:13 AM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> On 18-03-17 08:10, Liam Breck wrote:
>>>>
>>>>
>>>> [dropped CC's not relevant to BQ24190; pls re-add anyone appropriate]
>>>>
>>>> Hi Hans,
>>>>
>>>> I am the de facto maintainer of BQ24190, with help from Tony. I
>>>> contracted
>>>> the original author to
>>>> create the driver. I'm not aware of anyone else relying on it at
>>>> present.
>>>
>>>
>>>
>>> Hi Liam, nice to meet you.
>>>
>>>> Pls rebase to -next (!) and post BQ24190 changes in a separate patchset.
>>>
>>>
>>>
>>> Ok, I will rebase these patches on top of
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next
>>
>>
>> Yep.
>>
>>>> Reference any
>>>>
>>>> dependencies in other patchsets with Depends-on lines in patch
>>>> descriptions linking to
>>>> patchwork.kernel.org. If any dependency might be controversial, pls
>>>> defer
>>>> the BQ24190 patchset til
>>>> controversy resolves.
>>>
>>>
>>> There are no dependencies for the BQ24190 patches, they are a dependency
>>> for
>>> some of the other changes but they can go upstream as is.
>>
>>
>> The extcon driver elsewhere in patchset?
>
>
> That is only a runtime dependency and only when the extcon_name is
> set in the platform_data, the patches can be merged upstream without
> this (no compile / linktime dependency). Even runtime things will
> not explode if the extcon driver is not there and asked for in
> platform data, the probe() function will then simply return -EPROBE_DEFER.
>
>
>>
>>>> You may be interested in these, which I will support in BQ24190 in near
>>>> future:
>>>> https://patchwork.kernel.org/patch/9626487/
>>>> https://patchwork.kernel.org/patch/9626491/
>>>
>>>
>>>
>>> Yeah those are not going to matter for the use-case I'm looking at.
>>> I've a feeling you've only looked at the bq24190 patches and not the
>>> rest of the set. There is a reason I posted these all together as I
>>> mentioned in the cover-letter:
>>>
>>> "I'm sending this as a single series so that people can see how all the
>>> bits
>>> fit together."
>>
>>
>> Reading the entire patchset may be a lot to ask some folks, altho I
>> did. It's best to give relevant background in each patch description.
>>
>>> Anyways I will try to clarify things by answering you questions /
>>> responding to your remarks.
>>>
>>>> Further comments below...
>>>>
>>>> On Fri, 17 Mar 2017 10:55:16 +0100, Hans de Goede wrote:
>>>>
>>>>> On some platforms the register have been setup with platform specific
>>>>> values by the firmware and should not be reset.
>>>>
>>>>
>>>>
>>>> Pls describe this mysterious, meddling firmware. Who wrote it, when does
>>>> it run, on what devices,
>>>> etc? Include URLs to docs, etc. BTW it's not really "firmware" if it
>>>> runs
>>>> on the main cpu, IMO.
>>>> A boot loader is not firmware.
>>>
>>>
>>>
>>> So not all the world runs on ARM and not all devices using the
>>> TI BQ24190 (and variants) use an ARM processor or devicetree
>>> for that matter). Having worked on both ARM and x86 quite a bit
>>> I've a feeling that you are approaching my patchset with somewhat
>>> of an ARM focussed pov.
>>>
>>> The primary device I'm trying to get battery/charger monitoring
>>> working for is the GPDwin: http://www.gpd.hk/gpdwin.asp
>>>
>>> Which is an Intel Cherrytrail using machine with an Intel
>>> Cherrytrail Whiskey Cove PMIC.
>>>
>>> The firmware I'm talking about here is the EFI system firmware
>>> which boots the machine aka the BIOS.
>>
>>
>> Mention all of the above in patch descriptions.
>>
>>>> We probably don't want to disable register_reset in all circumstances.
>>>> Can
>>>> you record the
>>>> firmware's settings for charger?
>>>
>>>
>>>
>>> Yes after a (re)boot they are always reset to the same values.
>>
>>
>> So record those settings in a platform_data field. That's your
>> external config in this case.
>
>
> Assuming the platform_data has sane values like uA that means
> re-implementing most of the bq24190 driver in the code filling
> the platform data (to go from register values to uA) that does
> not seem like a sane approach when a simple do not reset
> flag suffices. Note also see below for another way to deal
> with this.

I am suggesting you treat platform_data like a DT node: fill it with
board-specific params. Don't compute the params, read them manually
via /sys/class/...-charger/f_* and hard-code them for this board. That
gives you control over the charger config. You've already found that
you need that given the high voltage setting.

>> The driver does a register_reset on resume so it has a consistent
>> state with chip.
>
>
> That assumes someone may be mucking with the chip during
> suspend which usually is not the case arguably this is a
> bad idea in general since if the chip is programmed with
> lower then reset charging limits it may now charge above
> the limits until the limits are re-applied.
>
> I really wonder what the reset is there for at all TBH,
> are there any cases where this really is necessary ?
> Maybe it would be best to just drop the reset altogether,
> or make it opt in rather then opt out.

The reason is to put the driver back into autonomous mode while we're
asleep. Otherwise we run in host mode.

>>>> I suspect we should replay them in set_mode_host() -- to be
>>>> renamed set_operating_params in forthcoming patchset.
>>>
>>>
>>>
>>> That is not going to work, the Cherrytrail Whiskey Cove PMIC
>>> is used on many different boards and there is no way to get
>>> the info from the firmware other then reading it back from
>>> the chip, hence the no_register_reset flag.
>>
>>
>> This isn't about the PMIC. You need to know how boot code for a
>> certain device configures the charger. Encode that knowledge in
>> platform_data.
>
>
> Again that info is already there in the registers and as long
> as we do not touch them we're fine. Also see above about
> needing to reproduce almost all of the bq24190 driver to
> actually fill in platform_data from the registers.
>
>> Also have you asked the vendor for docs?
>
>
> Yes I've asked both the manufacturer and the chip vendor (Intel)
> for docs, but I've not gotten an answer from either.

Maybe someone at Redhat could make a formal request on your behalf?

>>>> What generates your platform_data objects?
>>>
>>>
>>>
>>> The last patch in the patch-set shows this. The
>>> Cherrytrail Whiskey Cove PMIC does charger type detection
>>> and has a fuelgauge, but it does not contain a battery
>>> charger itself. Instead it contains an i2c controller
>>> to which an external charger chip, one of the
>>> TI BQ24190 variants, gets connected.
>>
>>
>> More useful background for patch descriptions :-)
>
>
> I can put this in the patch descriptions as example.
> but the patches are intended to be generally useful in case
> a similar external fuel gauge situation comes along, which
> is why I left the details out of the commit messages.

Patches are even more generally useful with scenario-specific descriptions :-)

>> Given that design, it sounds like the PMIC driver should be the point
>> of contact with userspace, and use sysfs
>> (/sys/class/power_supply/bq24190-charger/f_*) to get/set charger
>> stats. We can amend the driver to extend that feature. (Also a good
>> way to test chip knobs.)
>
>
> One driver poking into the sysfs files of another driver is
> not a sane intra driver interface, also this will require
> (again) duplicating much of the bq24190 driver for all the
> power_supply properties which it already implement.

Then consider the pseudo-driver concept. That would be generally
useful for any charger/gauge pairing. Both drivers would provide
callbacks to it.

> I really do not see what your objection is against the
> "power: supply: bq24190_charger: Add support for external fuel gauge"
> patch is, the changes to bq24190_charger.c are minimal it defines
> a clean, clear and simple interface. Where as the go through sysfs
> interface solution you are proposing is neither of these 3.
>
> I would appreciate it if you would actually think along with
> me in how we can make this all work together nicely, currently
> I'm getting the feeling that you want to make as little changes
> to the bq24190-charger code as possible, even if that means
> adding 10 times as much code elsewhere, that is not an acceptable
> solution IMHO.

I question your multiplier, but more code is better if it's generally
useful. Three of these patches look like board-specific expedients to
me.

>>
>> Some TI fuel gauges also work this way - I2C link to external charger.
>>
>>> The driver for this i2c-controller calls i2c_new_device
>>> with i2c_board_info describing the BQ24190 charger
>>> after calling i2c_add_adapter().
>>>
>>>> Are you forced to use platform_data for some reason?
>>>
>>>
>>>
>>> Since this is info being passed around inside the kernel
>>> using platform_data is a hell of a lot simpler (and cleaner
>>> no need to check types, etc on the receiving side) then
>>> using device-properties. Device-properties are nice when
>>> getting info from firmware, but this is not that.
>>
>>
>> OK
>>
>>> Also one of the things passed is actually a function
>>> pointer to a function to get extra power_supply_properties
>>> from the fuel-gauge, and passing function pointers certainly
>>> is not something which should be done through device-props.
>>>
>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>
>>>>
>>>>
>>>> Add to all BQ24190 patches:
>>>> Cc: Liam Breck <kernel@networkimprov.net>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>>
>>>> Pls don't CC me on the related patchsets.
>>>>
>>>>> ---
>>>>>  drivers/power/supply/bq24190_charger.c | 5 +++++
>>>>>  include/linux/power/bq24190_charger.h  | 1 +
>>>>>  2 files changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/drivers/power/supply/bq24190_charger.c
>>>>> b/drivers/power/supply/bq24190_charger.c
>>>>> index a4f0849..c92a40e4 100644
>>>>> --- a/drivers/power/supply/bq24190_charger.c
>>>>> +++ b/drivers/power/supply/bq24190_charger.c
>>>>> @@ -151,6 +151,7 @@ struct bq24190_dev_info {
>>>>>         struct device                   *dev;
>>>>>         struct power_supply             *charger;
>>>>>         struct power_supply             *battery;
>>>>> +       struct bq24190_platform_data    *pdata;
>>>>
>>>>
>>>>
>>>> Use a register settings array/struct here, instead of platform-data.
>>>> None
>>>> of your other patches need
>>>> to retain pdata.
>>>
>>>
>>>
>>> Sure I can make a 1:1 copy of each field in pdata here, but that
>>> is just more lines of code for the same result.
>>
>>
>> I mean record the chip's UEFI-supplied state here.
>
>
> Ok, so a flag get state from chip in platform_data would be
> an acceptable solution to me as then I can re-use all the
> code in bq24190_charger.c to go from register values to
> uA (and uV).

Yes, recording chip state in probe is an alternative to hard-coding
values in platform_data. But I think you should do the latter, so you
get a known charger config. Maybe a later version of the board has an
undesirable value.

>> Currently
>> no_register_reset appears to be the only pdata field used after
>> probe()
>
>
> The get_ext_bat_property callback also gets used after probe, but
> that could be a separate variable in bq24190_dev_info.

Um, well I already gave you my thoughts on this :-)
