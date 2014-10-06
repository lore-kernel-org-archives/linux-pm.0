From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/2] cpufreq: cpu0: Improve debug about matching OPP
Date: Mon, 06 Oct 2014 08:50:06 +0200
Message-ID: <54323B9E.2020407@i2se.com>
References: <1412454365-17804-1-git-send-email-stefan.wahren@i2se.com>	<1412454365-17804-2-git-send-email-stefan.wahren@i2se.com> <CAKohpokKZ9bc_=CSsy8W000egE1hM60pH1pn2Uxcdxv3oYS1EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:62406 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaJFGuN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 02:50:13 -0400
In-Reply-To: <CAKohpokKZ9bc_=CSsy8W000egE1hM60pH1pn2Uxcdxv3oYS1EQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>

Am 06.10.2014 um 07:13 schrieb Viresh Kumar:
> On 5 October 2014 01:56, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> During test of new DT OPPs it's very helpful to print the matching
>> OPP in case of frequency change. So it will be easier to find frequency
>> rounding issues in the dts file.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>  drivers/cpufreq/cpufreq-cpu0.c |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
>> index a5f8c5f..ef3d618 100644
>> --- a/drivers/cpufreq/cpufreq-cpu0.c
>> +++ b/drivers/cpufreq/cpufreq-cpu0.c
>> @@ -57,6 +57,8 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
>>         old_freq = clk_get_rate(cpu_clk) / 1000;
>>
>>         if (!IS_ERR(cpu_reg)) {
>> +               unsigned long opp_freq;
>> +
>>                 rcu_read_lock();
>>                 opp = dev_pm_opp_find_freq_ceil(cpu_dev, &freq_Hz);
>>                 if (IS_ERR(opp)) {
>> @@ -66,9 +68,12 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
>>                         return PTR_ERR(opp);
>>                 }
>>                 volt = dev_pm_opp_get_voltage(opp);
>> +               opp_freq = dev_pm_opp_get_freq(opp);
>>                 rcu_read_unlock();
>>                 tol = volt * priv->voltage_tolerance / 100;
>>                 volt_old = regulator_get_voltage(cpu_reg);
>> +               dev_dbg(cpu_dev, "Found OPP: %ld kHz, %ld uV\n",
>> +                       opp_freq / 1000, volt);
> What about using dev_pm_opp_get_freq() directly in dev_dbg() instead of
> creating a separate variable?

I wasn't sure because of the read lock and wanted to avoid any delays.
If it's okay i will change it.

>
>>         }
>>
>>         dev_dbg(cpu_dev, "%u MHz, %ld mV --> %u MHz, %ld mV\n",
>> --
>> 1.7.9.5
>>


