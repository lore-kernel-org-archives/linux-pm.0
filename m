From: Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] imx: thermal: use CPU temperature grade info for thresholds
Date: Tue, 13 Oct 2015 07:16:05 -0700
Message-ID: <CAJ+vNU2jbuN0FbQEFvrd42wEAFFxoH+ESFnXxmjRWv861fLadw@mail.gmail.com>
References: <1430409757-16195-1-git-send-email-tharvey@gateworks.com>
	<CALHpu36RGN-7x1eK7PSjLtW3DPj1f4Rvaf-FSP4qR4G08mRMqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33874 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbbJMOQG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 10:16:06 -0400
Received: by oiak8 with SMTP id k8so10198068oia.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 07:16:06 -0700 (PDT)
In-Reply-To: <CALHpu36RGN-7x1eK7PSjLtW3DPj1f4Rvaf-FSP4qR4G08mRMqg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Jon Nettleton <jon.nettleton@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Anson Huang <b20788@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jul 30, 2015 at 12:19 AM, Jon Nettleton <jon.nettleton@gmail.com> wrote:
> On Thu, Apr 30, 2015 at 6:02 PM, Tim Harvey <tharvey@gateworks.com> wrote:
>> The IMX6Q/IMX6DL SoC's have a 2-bit temperature grade stored in OTP. Instead
>> of assuming 85C for passive cooling threshold and 105C for critical use
>> the thermal grade for these configurations. For IMX6SX which does not have
>> a temperature grade in OTP (according to the ref manual) assume 105C critical.
>> We will default the user-settable passive threshold to crit - 20C.
>>
>> Cc: Anson Huang <b20788@freescale.com>
>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>>  drivers/thermal/imx_thermal.c | 64 +++++++++++++++++++++++++++++++++----------
>>  1 file changed, 49 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
>> index 2ccbc07..c6a4eed 100644
>> --- a/drivers/thermal/imx_thermal.c
>> +++ b/drivers/thermal/imx_thermal.c
>> @@ -55,6 +55,7 @@
>>  #define TEMPSENSE2_PANIC_VALUE_SHIFT   16
>>  #define TEMPSENSE2_PANIC_VALUE_MASK    0xfff0000
>>
>> +#define OCOTP_MEM0                     0x0480
>>  #define OCOTP_ANA1                     0x04e0
>>
>>  /* The driver supports 1 passive trip point and 1 critical trip point */
>> @@ -64,12 +65,6 @@ enum imx_thermal_trip {
>>         IMX_TRIP_NUM,
>>  };
>>
>> -/*
>> - * It defines the temperature in millicelsius for passive trip point
>> - * that will trigger cooling action when crossed.
>> - */
>> -#define IMX_TEMP_PASSIVE               85000
>> -
>>  #define IMX_POLLING_DELAY              2000 /* millisecond */
>>  #define IMX_PASSIVE_DELAY              1000
>>
>> @@ -106,6 +101,7 @@ struct imx_thermal_data {
>>         int irq;
>>         struct clk *thermal_clk;
>>         const struct thermal_soc_data *socdata;
>> +       const char *temp_grade;
>>  };
>>
>>  static void imx_set_panic_temp(struct imx_thermal_data *data,
>> @@ -289,7 +285,8 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
>>         if (trip == IMX_TRIP_CRITICAL)
>>                 return -EPERM;
>>
>> -       if (temp > IMX_TEMP_PASSIVE)
>> +       /* do not allow passive to be set higher than critical - 20C */
>> +       if (temp > (data->temp_critical - (1000 * 20)))
>>                 return -EINVAL;
>>
>>         data->temp_passive = temp;
>> @@ -404,17 +401,50 @@ static int imx_get_sensor_data(struct platform_device *pdev)
>>         data->c1 = temp64;
>>         data->c2 = n1 * data->c1 + 1000 * t1;
>>
>> -       /*
>> -        * Set the default passive cooling trip point,
>> -        * can be changed from userspace.
>> -        */
>> -       data->temp_passive = IMX_TEMP_PASSIVE;
>> +       /* Assume Extended Commercial temperature grade limits (105C max) */
>> +       data->temp_grade = "unknown";
>> +       data->temp_critical = 105000;
>> +
>> +       /* For IMX6Q use OTP for thermal grade */
>> +       if (data->socdata->version == TEMPMON_IMX6Q) {
>> +               ret = regmap_read(map, OCOTP_MEM0, &val);
>> +               if (ret) {
>> +                       dev_err(&pdev->dev, "failed to read temp grade: %d\n",
>> +                               ret);
>> +                       return ret;
>> +               }
>> +
>> +               if (val == 0 || val == ~0) {
>> +                       dev_err(&pdev->dev, "invalid temp grade data\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               /* The maximum die temp is specified by the Temperature Grade */
>> +               switch ((val >> 6) & 0x3) {
>> +               case 0: /* Commercial (0 to 95C) */
>> +                       data->temp_grade = "Commercial";
>> +                       data->temp_critical = 95000;
>> +                       break;
>> +               case 1: /* Extended Commercial (-20 to 105C) */
>> +                       data->temp_grade = "Extended Commercial";
>> +                       data->temp_critical = 105000;
>> +                       break;
>> +               case 2: /* Industrial (-40 to 105C) */
>> +                       data->temp_grade = "Industrial";
>> +                       data->temp_critical = 105000;
>> +                       break;
>> +               case 3: /* Automotive (-40 to 125C) */
>> +                       data->temp_grade = "Automotive";
>> +                       data->temp_critical = 125000;
>> +                       break;
>> +               }
>> +       }
>>
>>         /*
>> -        * The maximum die temperature set to 20 C higher than
>> -        * IMX_TEMP_PASSIVE.
>> +        * Set the default passive cooling trip point to critical - 20C
>> +        * (can be changed from userspace)
>>          */
>> -       data->temp_critical = 1000 * 20 + data->temp_passive;
>> +       data->temp_passive = data->temp_critical - (1000 * 20);
>>
>>         return 0;
>>  }
>> @@ -559,6 +589,10 @@ static int imx_thermal_probe(struct platform_device *pdev)
>>                 return ret;
>>         }
>>
>> +       dev_info(&pdev->dev, "%s CPU temperature grade - "
>> +                "thresholds: crit:%ldC passive:%ldC\n", data->temp_grade,
>> +                data->temp_critical / 1000, data->temp_passive / 1000);
>> +
>>         /* Enable measurements at ~ 10 Hz */
>>         regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
>>         measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
>> --
>> 1.9.1
>>
>>
>
> I think this is a fine start and we can build off it.
>
> Acked-by: Jon Nettleton <jon@solid-run.com>

adding CC linux-pm@vger.kernel.org

Zhang / Eduardo,

This seems to have gotten missed - can you please review this for merge?

Regards,

Tim
