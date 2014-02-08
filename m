From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v2 1/2] PM / OPP: Allow boost frequency to be looked up
 from device tree
Date: Sat, 8 Feb 2014 10:40:01 +0530
Message-ID: <CAJuA9agT4PC6YOmhCwKQ=58qaGEr1qSuhTpX57ro1pEuk++Miw@mail.gmail.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
	<1391786342-11812-2-git-send-email-thomas.ab@samsung.com>
	<52F50346.7040707@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:49674 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbaBHFKE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 8 Feb 2014 00:10:04 -0500
In-Reply-To: <52F50346.7040707@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <Sudeep.Holla@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, Nishanth Menon <nm@ti.com>

On Fri, Feb 7, 2014 at 9:31 PM, Sudeep Holla <Sudeep.Holla@arm.com> wrote:
> On 07/02/14 15:19, Thomas Abraham wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
>> support for CPU boost mode. This patch adds support for finding available
>> boost frequencies from device tree and marking them as usable in boost mode.
>>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Lukasz Majewski <l.majewski@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>>  drivers/base/power/opp.c |   34 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
>> index fa41874..b636826 100644
>> --- a/drivers/base/power/opp.c
>> +++ b/drivers/base/power/opp.c
>> @@ -628,7 +628,8 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>>       struct device_opp *dev_opp;
>>       struct dev_pm_opp *opp;
>>       struct cpufreq_frequency_table *freq_table;
>> -     int i = 0;
>> +     int i = 0, j, len, ret;
>> +     u32 *boost_freqs = NULL;
>>
>>       /* Pretend as if I am an updater */
>>       mutex_lock(&dev_opp_list_lock);
>> @@ -650,10 +651,35 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>>               return -ENOMEM;
>>       }
>>
>> +     if (of_find_property(dev->of_node, "boost-frequency", &len)) {
>> +             if (len == 0 || (len & (sizeof(u32) - 1)) != 0) {
>> +                     dev_err(dev, "%s: invalid boost frequency\n", __func__);
>> +                     ret = -EINVAL;
>> +                     goto err_boost;
>> +             }
>> +
>> +             boost_freqs = kzalloc(len, GFP_KERNEL);
>> +             if (!boost_freqs) {
>> +                     dev_warn(dev, "%s: no memory for boost freq table\n",
>> +                                     __func__);
>> +                     ret = -ENOMEM;
>> +                     goto err_boost;
>> +             }
>> +             of_property_read_u32_array(dev->of_node, "boost-frequency",
>> +                     boost_freqs, len / sizeof(u32));
>> +     }
>> +
>>       list_for_each_entry(opp, &dev_opp->opp_list, node) {
>>               if (opp->available) {
>>                       freq_table[i].driver_data = i;
>>                       freq_table[i].frequency = opp->rate / 1000;
>> +                     for (j = 0; j < len / sizeof(u32) && boost_freqs; j++) {
>> +                             if (boost_freqs[j] == freq_table[i].frequency) {
>> +                                     freq_table[i].driver_data =
>> +                                                     CPUFREQ_BOOST_FREQ;
>> +                                     break;
>> +                             }
>> +                     }
>>                       i++;
>>               }
>>       }
> IIRC you had mentioned that the boost-opp was not limited to be a cpufreq, but
> this change seems to be cpufreq only.

Yes, but as you have initiated the discussion on extending the OPP
binding, this has been limited to cpufreq only. If the new OPP library
has support for listing boost frequency, this can be migrated to the
new OPP libaray.

Thanks,
Thomas.

>
> Regards,
> Sudeep
>
