From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH v3 5/7] PM / devfreq: exynos5250: migrate to common-clock
Date: Wed, 16 Jul 2014 23:30:32 +0530
Message-ID: <CAM4voakROn7-J7Gu0u3NA=6yVUAqjNZ3TFkL8wjmreWAhhBXOA@mail.gmail.com>
References: <1400779322-4410-6-git-send-email-a.kesavan@samsung.com>
	<1405449332-26350-1-git-send-email-a.kesavan@samsung.com>
	<53C65C0C.10200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:49426 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbaGPSAd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 14:00:33 -0400
In-Reply-To: <53C65C0C.10200@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: "myungjoo.ham" <myungjoo.ham@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, devicetree <devicetree@vger.kernel.org>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>

Hi Tomasz,

On Wed, Jul 16, 2014 at 4:33 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Abhilash, Andrew,
>
> Please see my comments inline.
>
> On 15.07.2014 20:35, Abhilash Kesavan wrote:
>> From: Andrew Bresticker <abrestic@chromium.org>
>>
>> Use the common-clock framework to scale frequencies for the various
>> peripheral clocks on the Exynos5250.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>  drivers/devfreq/exynos/exynos5_bus.c |  131 ++++++++++++++++++++++++++++++----
>>  1 file changed, 119 insertions(+), 12 deletions(-)
>
> [snip]
>
>> +
>>  static struct int_bus_opp_table exynos5_int_opp_table[] = {
>>       {LV_0, 266000, 1025000},
>>       {LV_1, 200000, 1025000},
>> @@ -75,6 +85,98 @@ static struct int_bus_opp_table exynos5_int_opp_table[] = {
>>       {0, 0, 0},
>>  };
>>
>> +static struct int_clk_table aclk_166[] = {
>> +     {LV_0, 167000},
>> +     {LV_1, 111000},
>> +     {LV_2,  84000},
>> +     {LV_3,  84000},
>> +     {LV_4,  42000},
>> +};
>
> [snip]
>
>> +static struct int_clk_table aclk_300_gscl[] = {
>> +     {LV_0, 267000},
>> +     {LV_1, 267000},
>> +     {LV_2, 267000},
>> +     {LV_3, 200000},
>> +     {LV_4, 100000},
>> +};
>
> Shouldn't you manage this using OPP framework and parse this from DT?
OK, one of the questions I had was about the handling of virtual INT
bus levels (frequencies and voltages). I have consolidated my
understanding of how the bindings should look and questions I had in
the driver thread.
>
>> +
>> +#define EXYNOS5_INT_CLK(name, tbl) {         \
>> +     .clk_name = name,                       \
>> +     .freq_table = tbl,                      \
>> +}
>
> [snip]
>
>> @@ -320,16 +427,16 @@ static int exynos5_busfreq_int_probe(struct platform_device *pdev)
>>       rcu_read_unlock();
>>       data->curr_freq = initial_freq;
>>
>> -     err = clk_set_rate(data->int_clk, initial_freq * 1000);
>> +     err = exynos5_int_setvolt(data, initial_volt);
>> +     if (err)
>> +             return err;
>> +
>> +     err = exynos5_int_set_rate(data, initial_freq);
>>       if (err) {
>>               dev_err(dev, "Failed to set initial frequency\n");
>>               return err;
>>       }
>>
>> -     err = exynos5_int_setvolt(data, initial_volt);
>> -     if (err)
>> -             return err;
>> -
>
> Whether voltage or rate should be set first depends on current settings
> and initial_{freq,volt}. Also it might be more convenient to simply call
> exynos5_busfreq_int_target() here.
Wouldn't setting voltage first always be safe ? Yes, just calling
target would be better. Will modify.

Regards,
Abhilash
>
> Best regards,
> Tomasz
