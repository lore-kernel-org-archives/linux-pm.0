From: Liam Breck <liam@networkimprov.net>
Subject: Re: [04/15] power: supply: bq24190_charger: Add no_register_reset
 pdata flag
Date: Sat, 18 Mar 2017 11:51:23 -0700
Message-ID: <CAKvHMgQ-hnS_XkL_7Mwkm94hNDc9Q++xHBAOUK1bKmvO=YnSXQ@mail.gmail.com>
References: <20170318071019.4561-1-liam@networkimprov.net> <6ad6ecd2-ea0f-b613-8519-66ad424c623a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36417 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdCRSv0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Mar 2017 14:51:26 -0400
Received: by mail-it0-f67.google.com with SMTP id u69so9914793ita.3
        for <linux-pm@vger.kernel.org>; Sat, 18 Mar 2017 11:51:25 -0700 (PDT)
In-Reply-To: <6ad6ecd2-ea0f-b613-8519-66ad424c623a@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Liam Breck <kernel@networkimprov.net>

On Sat, Mar 18, 2017 at 7:13 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 18-03-17 08:10, Liam Breck wrote:
>>
>> [dropped CC's not relevant to BQ24190; pls re-add anyone appropriate]
>>
>> Hi Hans,
>>
>> I am the de facto maintainer of BQ24190, with help from Tony. I contracted
>> the original author to
>> create the driver. I'm not aware of anyone else relying on it at present.
>
>
> Hi Liam, nice to meet you.
>
>> Pls rebase to -next (!) and post BQ24190 changes in a separate patchset.
>
>
> Ok, I will rebase these patches on top of
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next

Yep.

>> Reference any
>>
>> dependencies in other patchsets with Depends-on lines in patch
>> descriptions linking to
>> patchwork.kernel.org. If any dependency might be controversial, pls defer
>> the BQ24190 patchset til
>> controversy resolves.
>
> There are no dependencies for the BQ24190 patches, they are a dependency for
> some of the other changes but they can go upstream as is.

The extcon driver elsewhere in patchset?

>> You may be interested in these, which I will support in BQ24190 in near
>> future:
>> https://patchwork.kernel.org/patch/9626487/
>> https://patchwork.kernel.org/patch/9626491/
>
>
> Yeah those are not going to matter for the use-case I'm looking at.
> I've a feeling you've only looked at the bq24190 patches and not the
> rest of the set. There is a reason I posted these all together as I
> mentioned in the cover-letter:
>
> "I'm sending this as a single series so that people can see how all the bits
> fit together."

Reading the entire patchset may be a lot to ask some folks, altho I
did. It's best to give relevant background in each patch description.

> Anyways I will try to clarify things by answering you questions /
> responding to your remarks.
>
>> Further comments below...
>>
>> On Fri, 17 Mar 2017 10:55:16 +0100, Hans de Goede wrote:
>>
>>> On some platforms the register have been setup with platform specific
>>> values by the firmware and should not be reset.
>>
>>
>> Pls describe this mysterious, meddling firmware. Who wrote it, when does
>> it run, on what devices,
>> etc? Include URLs to docs, etc. BTW it's not really "firmware" if it runs
>> on the main cpu, IMO.
>> A boot loader is not firmware.
>
>
> So not all the world runs on ARM and not all devices using the
> TI BQ24190 (and variants) use an ARM processor or devicetree
> for that matter). Having worked on both ARM and x86 quite a bit
> I've a feeling that you are approaching my patchset with somewhat
> of an ARM focussed pov.
>
> The primary device I'm trying to get battery/charger monitoring
> working for is the GPDwin: http://www.gpd.hk/gpdwin.asp
>
> Which is an Intel Cherrytrail using machine with an Intel
> Cherrytrail Whiskey Cove PMIC.
>
> The firmware I'm talking about here is the EFI system firmware
> which boots the machine aka the BIOS.

Mention all of the above in patch descriptions.

>> We probably don't want to disable register_reset in all circumstances. Can
>> you record the
>> firmware's settings for charger?
>
>
> Yes after a (re)boot they are always reset to the same values.

So record those settings in a platform_data field. That's your
external config in this case.

The driver does a register_reset on resume so it has a consistent
state with chip.

>> I suspect we should replay them in set_mode_host() -- to be
>> renamed set_operating_params in forthcoming patchset.
>
>
> That is not going to work, the Cherrytrail Whiskey Cove PMIC
> is used on many different boards and there is no way to get
> the info from the firmware other then reading it back from
> the chip, hence the no_register_reset flag.

This isn't about the PMIC. You need to know how boot code for a
certain device configures the charger. Encode that knowledge in
platform_data. Also have you asked the vendor for docs?

>> What generates your platform_data objects?
>
>
> The last patch in the patch-set shows this. The
> Cherrytrail Whiskey Cove PMIC does charger type detection
> and has a fuelgauge, but it does not contain a battery
> charger itself. Instead it contains an i2c controller
> to which an external charger chip, one of the
> TI BQ24190 variants, gets connected.

More useful background for patch descriptions :-)

Given that design, it sounds like the PMIC driver should be the point
of contact with userspace, and use sysfs
(/sys/class/power_supply/bq24190-charger/f_*) to get/set charger
stats. We can amend the driver to extend that feature. (Also a good
way to test chip knobs.)

Some TI fuel gauges also work this way - I2C link to external charger.

> The driver for this i2c-controller calls i2c_new_device
> with i2c_board_info describing the BQ24190 charger
> after calling i2c_add_adapter().
>
>> Are you forced to use platform_data for some reason?
>
>
> Since this is info being passed around inside the kernel
> using platform_data is a hell of a lot simpler (and cleaner
> no need to check types, etc on the receiving side) then
> using device-properties. Device-properties are nice when
> getting info from firmware, but this is not that.

OK

> Also one of the things passed is actually a function
> pointer to a function to get extra power_supply_properties
> from the fuel-gauge, and passing function pointers certainly
> is not something which should be done through device-props.
>
>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>>
>> Add to all BQ24190 patches:
>> Cc: Liam Breck <kernel@networkimprov.net>
>> Cc: Tony Lindgren <tony@atomide.com>
>>
>> Pls don't CC me on the related patchsets.
>>
>>> ---
>>>  drivers/power/supply/bq24190_charger.c | 5 +++++
>>>  include/linux/power/bq24190_charger.h  | 1 +
>>>  2 files changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/power/supply/bq24190_charger.c
>>> b/drivers/power/supply/bq24190_charger.c
>>> index a4f0849..c92a40e4 100644
>>> --- a/drivers/power/supply/bq24190_charger.c
>>> +++ b/drivers/power/supply/bq24190_charger.c
>>> @@ -151,6 +151,7 @@ struct bq24190_dev_info {
>>>         struct device                   *dev;
>>>         struct power_supply             *charger;
>>>         struct power_supply             *battery;
>>> +       struct bq24190_platform_data    *pdata;
>>
>>
>> Use a register settings array/struct here, instead of platform-data. None
>> of your other patches need
>> to retain pdata.
>
>
> Sure I can make a 1:1 copy of each field in pdata here, but that
> is just more lines of code for the same result.

I mean record the chip's UEFI-supplied state here. Currently
no_register_reset appears to be the only pdata field used after
probe()

>>
>>>         char                            model_name[I2C_NAME_SIZE];
>>>         kernel_ulong_t                  model;
>>>         unsigned int                    gpio_int;
>>> @@ -506,6 +507,9 @@ static int bq24190_register_reset(struct
>>> bq24190_dev_info *bdi)
>>>         int ret, limit = 100;
>>>         u8 v;
>>>
>>> +       if (bdi->pdata && bdi->pdata->no_register_reset)
>>> +               return 0;
>>> +
>>>         /* Reset the registers */
>>>         ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>>>                         BQ24190_REG_POC_RESET_MASK,
>>> @@ -1339,6 +1343,7 @@ static int bq24190_probe(struct i2c_client *client,
>>>         bdi->client = client;
>>>         bdi->dev = dev;
>>>         bdi->model = id->driver_data;
>>> +       bdi->pdata = client->dev.platform_data;
>>>         strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
>>>         mutex_init(&bdi->f_reg_lock);
>>>         bdi->f_reg = 0;
>>> diff --git a/include/linux/power/bq24190_charger.h
>>> b/include/linux/power/bq24190_charger.h
>>> index 9f02837..cb49717 100644
>>> --- a/include/linux/power/bq24190_charger.h
>>> +++ b/include/linux/power/bq24190_charger.h
>>> @@ -11,6 +11,7 @@
>>>
>>>  struct bq24190_platform_data {
>>>         unsigned int    gpio_int;       /* GPIO pin that's connected to
>>> INT# */
>>> +       bool no_register_reset;
>>>  };
>>>
>>>  #endif
>>
>>
>> Thanks,
>> Liam
>>
>
> Regards,
>
> Hans
