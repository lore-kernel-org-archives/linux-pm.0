From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v3 2/4] power: bq24190_charger: Clean up extcon code
Date: Sun, 2 Apr 2017 15:03:20 -0700
Message-ID: <CAKvHMgQ6gJ822W_hXO8jGAq_vr4L8NaFJpNHA5sKYJ+kTRtQgg@mail.gmail.com>
References: <20170401202519.16280-1-liam@networkimprov.net>
 <20170401202519.16280-3-liam@networkimprov.net> <6dbb405d-a840-7216-395f-7e4fa327cd70@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:32938 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbdDBWDW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Apr 2017 18:03:22 -0400
Received: by mail-it0-f66.google.com with SMTP id w11so6662041itb.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Apr 2017 15:03:21 -0700 (PDT)
In-Reply-To: <6dbb405d-a840-7216-395f-7e4fa327cd70@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Liam Breck <kernel@networkimprov.net>

G'day Hans,

On Sun, Apr 2, 2017 at 5:27 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 01-04-17 22:25, Liam Breck wrote:
>>
>> From: Liam Breck <kernel@networkimprov.net>
>>
>> Polishing and fixes for initial extcon patch.
>>
>> Fixes: 4db249b6f3b4 ("power: supply: bq24190_charger: Use extcon to
>> determine ilimit, 5v boost")
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Liam Breck <kernel@networkimprov.net>
>> ---
>>  drivers/power/supply/bq24190_charger.c | 75
>> ++++++++++++++++------------------
>>  1 file changed, 36 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/power/supply/bq24190_charger.c
>> b/drivers/power/supply/bq24190_charger.c
>> index 64a48b9..ae27cdc 100644
>> --- a/drivers/power/supply/bq24190_charger.c
>> +++ b/drivers/power/supply/bq24190_charger.c
>> @@ -38,12 +38,13 @@
>>  #define BQ24190_REG_POC_WDT_RESET_SHIFT                6
>>  #define BQ24190_REG_POC_CHG_CONFIG_MASK                (BIT(5) | BIT(4))
>>  #define BQ24190_REG_POC_CHG_CONFIG_SHIFT       4
>> -#define BQ24190_REG_POC_CHG_CONFIG_CHARGE      1
>> -#define BQ24190_REG_POC_CHG_CONFIG_OTG         2
>>  #define BQ24190_REG_POC_SYS_MIN_MASK           (BIT(3) | BIT(2) | BIT(1))
>>  #define BQ24190_REG_POC_SYS_MIN_SHIFT          1
>>  #define BQ24190_REG_POC_BOOST_LIM_MASK         BIT(0)
>>  #define BQ24190_REG_POC_BOOST_LIM_SHIFT                0
>> +#define BQ24190_REG_POC_CHG_CONFIG_DISABLE     0
>> +#define BQ24190_REG_POC_CHG_CONFIG_CHARGE      1
>> +#define BQ24190_REG_POC_CHG_CONFIG_OTG         2
>>
>>  #define BQ24190_REG_CCC                0x02 /* Charge Current Control */
>>  #define BQ24190_REG_CCC_ICHG_MASK              (BIT(7) | BIT(6) | BIT(5)
>> | \
>
>
> This is inconsistent with existing defines which put value defines
> like this together with the MASK and SHIFT defines as I did,
> see BQ24190_REG_VPRS_PN_* defines for example.

Ah, Mark wrote this differently than either of us. I'll apply his
style in next rev, thanks.


>> @@ -173,8 +174,9 @@ struct bq24190_dev_info {
>>   */
>>
>>  /* REG00[2:0] (IINLIM) in uAh */
>> -static const int bq24190_iinlim_values[] = {
>> -       100000, 150000, 500000, 900000, 1200000, 1500000, 2000000, 3000000
>> };
>> +static const int bq24190_isc_iinlim_values[] = {
>> +        100000,  150000,  500000,  900000, 1200000, 1500000, 2000000,
>> 3000000
>> +};
>>
>>  /* REG02[7:2] (ICHG) in uAh */
>>  static const int bq24190_ccc_ichg_values[] = {
>> @@ -1298,16 +1300,17 @@ static void bq24190_extcon_work(struct work_struct
>> *work)
>>  {
>>         struct bq24190_dev_info *bdi =
>>                 container_of(work, struct bq24190_dev_info,
>> extcon_work.work);
>> -       int ret, iinlim = 0;
>> +       int error, iinlim = 0;
>>
>> -       ret = pm_runtime_get_sync(bdi->dev);
>> -       if (ret < 0) {
>> -               dev_err(bdi->dev, "Error getting runtime-pm ref: %d\n",
>> ret);
>> +       error = pm_runtime_get_sync(bdi->dev);
>> +       if (error < 0) {
>
>
> The replacing of ret with error is an IMHO useless style change
> and if you insist on doing this belongs in a separate patch you are
> batching way to much different changes together in a single commit here.

ret is for use with return. There are examples of the above already in the code.

>> +               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
>> +               pm_runtime_put_noidle(bdi->dev);
>
>
> This _really_ belongs in your "power: bq24190_charger: Uniform
> pm_runtime_get() failure handling"
> patch.

There are examples of the above already in the code. The patch you
refer to fixes another patch.

>>                 return;
>>         }
>>
>> -       if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_SDP) == 1)
>> -               iinlim = 500000;
>> +       if      (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_SDP) == 1)
>> +               iinlim =  500000;
>
>
> Another useless style change and this sort of indentation is quite uncommon
> in the kernel, please don't do this.

The rationale for this alignment is immediately apparent.

>>         else if (extcon_get_state(bdi->extcon, EXTCON_CHG_USB_CDP) == 1 ||
>>                  extcon_get_state(bdi->extcon, EXTCON_CHG_USB_ACA) == 1)
>>                 iinlim = 1500000;
>> @@ -1315,33 +1318,25 @@ static void bq24190_extcon_work(struct work_struct
>> *work)
>>                 iinlim = 2000000;
>>
>>         if (iinlim) {
>> -               ret = bq24190_set_field_val(bdi, BQ24190_REG_ISC,
>> -                               BQ24190_REG_ISC_IINLIM_MASK,
>> -                               BQ24190_REG_ISC_IINLIM_SHIFT,
>> -                               bq24190_iinlim_values,
>> -                               ARRAY_SIZE(bq24190_iinlim_values),
>> -                               iinlim);
>> -               if (ret)
>> -                       dev_err(bdi->dev, "Can't set IINLIM: %d\n", ret);
>> +               error = bq24190_set_field_val(bdi, BQ24190_REG_ISC,
>> +                                             BQ24190_REG_ISC_IINLIM_MASK,
>> +
>> BQ24190_REG_ISC_IINLIM_SHIFT,
>> +                                             bq24190_isc_iinlim_values,
>> +
>> ARRAY_SIZE(bq24190_isc_iinlim_values),
>> +                                             iinlim);
>> +               if (error < 0)
>> +                       dev_err(bdi->dev, "Can't set IINLIM: %d\n",
>> error);
>>         }
>
>
> As said the s/ret/error/ stuff really should be in a different patch.
>
>
>> -       /*
>> -        * If no charger has been detected and host mode is requested,
>> activate
>> -        * the 5V boost converter, otherwise deactivate it.
>> -        */
>> -       if (!iinlim && extcon_get_state(bdi->extcon, EXTCON_USB_HOST) ==
>> 1) {
>> -               ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>> -                                        BQ24190_REG_POC_CHG_CONFIG_MASK,
>> -                                        BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>> -                                        BQ24190_REG_POC_CHG_CONFIG_OTG);
>> -       } else {
>> -               ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
>> -                                        BQ24190_REG_POC_CHG_CONFIG_MASK,
>> -                                        BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>> -
>> BQ24190_REG_POC_CHG_CONFIG_CHARGE);
>> -       }
>> -       if (ret)
>> -               dev_err(bdi->dev, "Can't set CHG_CONFIG: %d\n", ret);
>> +       /* Set OTG 5V boost: on if no charger detected and in USB host
>> mode, else off */
>> +       error = bq24190_write_mask(bdi, BQ24190_REG_POC,
>> +                                  BQ24190_REG_POC_CHG_CONFIG_MASK,
>> +                                  BQ24190_REG_POC_CHG_CONFIG_SHIFT,
>> +                       !iinlim && extcon_get_state(bdi->extcon,
>> EXTCON_USB_HOST) == 1
>> +                                ? BQ24190_REG_POC_CHG_CONFIG_OTG
>> +                                : BQ24190_REG_POC_CHG_CONFIG_CHARGE);
>> +       if (error < 0)
>> +               dev_err(bdi->dev, "Can't set CHG_CONFIG: %d\n", error);
>
>
> The new code here is IMHO close to unreadable with the actual condition
> hidden
> 3 lines down into the function-call arguments and all that to save 3 lines
> of
> code: NACK.

The condition selects a value, not a function or register. This is the
common f(x, y, e ? z1 : z2) with longer terms. We could store the
condition in a bool before the call, but it fits fine on one line.

>>
>>         pm_runtime_mark_last_busy(bdi->dev);
>>         pm_runtime_put_autosuspend(bdi->dev);
>> @@ -1432,10 +1427,10 @@ static int bq24190_probe(struct i2c_client
>> *client,
>>         }
>>
>>         /*
>> -        * The extcon-name property is purely an in kernel interface for
>> -        * x86/ACPI use, DT platforms should get extcon via phandle.
>> +        * ACPI platforms should use device_property "extcon-name".
>> +        * Devicetree platforms should get extcon via phandle (not yet
>> supported).
>>          */
>> -       if (device_property_read_string(dev, "extcon-name", &name) == 0) {
>> +       if (!device_property_read_string(dev, "extcon-name", &name)) {
>
>
> We want to check for success here, not for 'not true" success == 0.

Sure; I'll go with that.

>>                 bdi->extcon = extcon_get_extcon_dev(name);
>>                 if (!bdi->extcon)
>>                         return -EPROBE_DEFER;
>> @@ -1498,8 +1493,10 @@ static int bq24190_probe(struct i2c_client *client,
>>                 bdi->extcon_nb.notifier_call = bq24190_extcon_event;
>>                 ret = devm_extcon_register_notifier(dev, bdi->extcon, -1,
>>                                                     &bdi->extcon_nb);
>> -               if (ret)
>> +               if (ret) {
>> +                       dev_err(dev, "Can't register extcon\n");
>>                         goto out5;
>> +               }
>>
>>                 /* Sync initial cable state */
>>                 queue_delayed_work(system_wq, &bdi->extcon_work, 0);
>
>
>
> Regards,
>
> Hans

Could you adjust your tone to be more collaborative and less cutting?
You only have this code for the Atom device because I designed and
built hardware with this part and hired Mark to write the driver from
scratch. I'd like a little goodwill in exchange! And also gratitude
for taking time to fix two of your patches.

I expect discussion of charger patches with an experienced kernel
contributor to look like these threads:

https://patchwork.kernel.org/project/linux-pm/list/?submitter=109&state=*&q=bq24190_charger%3A+Use+PM+runtime+autosuspend&archive=both

Thanks :-)
