From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v2 1/2] PM / OPP: Allow boost frequency to be looked up
 from device tree
Date: Fri, 7 Feb 2014 21:08:03 +0530
Message-ID: <CAJuA9aiEDXyK8ABNznbzjk7s2uMfwo_diRpmLNsKBFd+pH=ffQ@mail.gmail.com>
References: <1391786342-11812-1-git-send-email-thomas.ab@samsung.com>
	<1391786342-11812-2-git-send-email-thomas.ab@samsung.com>
	<CAGo_u6qsh0wVLGjvqKmaXjDGVyy2tKgSzkh-t9RZCQS-JJND8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:61473 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbaBGPpB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2014 10:45:01 -0500
In-Reply-To: <CAGo_u6qsh0wVLGjvqKmaXjDGVyy2tKgSzkh-t9RZCQS-JJND8g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, dt list <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, rjw@rjwysocki.net, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, thomas.ab@samsung.com

On Fri, Feb 7, 2014 at 8:59 PM, Nishanth Menon <nm@ti.com> wrote:
> On Fri, Feb 7, 2014 at 9:19 AM, Thomas Abraham <ta.omasab@gmail.com> wrote:
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
>>         struct device_opp *dev_opp;
>>         struct dev_pm_opp *opp;
>>         struct cpufreq_frequency_table *freq_table;
>> -       int i = 0;
>> +       int i = 0, j, len, ret;
>> +       u32 *boost_freqs = NULL;
>>
>>         /* Pretend as if I am an updater */
>>         mutex_lock(&dev_opp_list_lock);
>> @@ -650,10 +651,35 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>>                 return -ENOMEM;
>>         }
>>
>> +       if (of_find_property(dev->of_node, "boost-frequency", &len)) {
>> +               if (len == 0 || (len & (sizeof(u32) - 1)) != 0) {
>> +                       dev_err(dev, "%s: invalid boost frequency\n", __func__);
>> +                       ret = -EINVAL;
>> +                       goto err_boost;
>> +               }
>> +
>> +               boost_freqs = kzalloc(len, GFP_KERNEL);
>> +               if (!boost_freqs) {
>> +                       dev_warn(dev, "%s: no memory for boost freq table\n",
>> +                                       __func__);
>> +                       ret = -ENOMEM;
>> +                       goto err_boost;
>> +               }
>> +               of_property_read_u32_array(dev->of_node, "boost-frequency",
>> +                       boost_freqs, len / sizeof(u32));
>> +       }
>> +
>>         list_for_each_entry(opp, &dev_opp->opp_list, node) {
>>                 if (opp->available) {
>>                         freq_table[i].driver_data = i;
>>                         freq_table[i].frequency = opp->rate / 1000;
>> +                       for (j = 0; j < len / sizeof(u32) && boost_freqs; j++) {
>> +                               if (boost_freqs[j] == freq_table[i].frequency) {
>> +                                       freq_table[i].driver_data =
>> +                                                       CPUFREQ_BOOST_FREQ;
>> +                                       break;
>> +                               }
>> +                       }
>
> What if any one of the boost_freqs are not contained in the enabled frequencies?

It is not used as a boost frequency because its corresponding voltage
is not known. If required a warning can be printed out for the same.

Thanks,
Thomas.

>
>>                         i++;
>>                 }
>>         }
>> @@ -663,8 +689,14 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>>         freq_table[i].frequency = CPUFREQ_TABLE_END;
>>
>>         *table = &freq_table[0];
>> +       kfree(boost_freqs);
>>
>>         return 0;
>> +
>> +err_boost:
>> +       kfree(freq_table);
>> +       mutex_unlock(&dev_opp_list_lock);
>> +       return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(dev_pm_opp_init_cpufreq_table);
>>
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
