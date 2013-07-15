From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] cpufreq: Preserve policy structure across suspend/resume
Date: Mon, 15 Jul 2013 15:35:04 +0530
Message-ID: <51E3C950.90503@linux.vnet.ibm.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <20130711221704.547.64296.stgit@srivatsabhat.in.ibm.com> <CAKohpom+WcTcefCZitgZQcSjTPsgXsa6VKQF5y6GJA31-rBm0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpom+WcTcefCZitgZQcSjTPsgXsa6VKQF5y6GJA31-rBm0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/15/2013 03:25 PM, Viresh Kumar wrote:
> Hi Srivatsa,
> 
> I may be wrong but it looks something is wrong in this patch.
> 
> On 12 July 2013 03:47, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> 
>> @@ -1239,29 +1263,40 @@ static int __cpufreq_remove_dev(struct device *dev,
>>         if ((cpus == 1) && (cpufreq_driver->target))
>>                 __cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
>>
>> -       pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
>> -       cpufreq_cpu_put(data);
>> +       if (!frozen) {
>> +               pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
>> +               cpufreq_cpu_put(data);
> 
> So, we don't decrement usage count here. But we are still increasing
> counts on cpufreq_add_dev after resume, isn't it?
> 
> So, we wouldn't be able to free policy struct once all the cpus of a
> policy are removed after suspend/resume has happened once.
> 

Actually even I was wondering about this while writing the patch and
I even tested shutdown after multiple suspend/resume cycles, to verify that
the refcount is messed up. But surprisingly, things worked just fine.

Logically there should've been a refcount mismatch and things should have
failed, but everything worked fine during my tests. Apart from suspend/resume
and shutdown tests, I even tried mixing a few regular CPU hotplug operations
(echo 0/1 to sysfs online files), but nothing stood out.

Sorry, I forgot to document this in the patch. Either the patch is wrong
or something else is silently fixing this up. Not sure what is the exact
situation.

Regards,
Srivatsa S. Bhat
