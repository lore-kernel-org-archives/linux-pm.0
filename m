From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] cpufreq: Preserve policy structure across suspend/resume
Date: Mon, 15 Jul 2013 17:23:43 +0530
Message-ID: <51E3E2C7.50107@linux.vnet.ibm.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <CAKohpom+WcTcefCZitgZQcSjTPsgXsa6VKQF5y6GJA31-rBm0w@mail.gmail.com> <51E3C950.90503@linux.vnet.ibm.com> <5802844.Fghi6KKD2P@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:47648 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755907Ab3GOL5Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 07:57:16 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 15 Jul 2013 21:45:00 +1000
In-Reply-To: <5802844.Fghi6KKD2P@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/15/2013 05:05 PM, Rafael J. Wysocki wrote:
> On Monday, July 15, 2013 03:35:04 PM Srivatsa S. Bhat wrote:
>> On 07/15/2013 03:25 PM, Viresh Kumar wrote:
>>> Hi Srivatsa,
>>>
>>> I may be wrong but it looks something is wrong in this patch.
>>>
>>> On 12 July 2013 03:47, Srivatsa S. Bhat
>>> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>>
>>>> @@ -1239,29 +1263,40 @@ static int __cpufreq_remove_dev(struct device *dev,
>>>>         if ((cpus == 1) && (cpufreq_driver->target))
>>>>                 __cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
>>>>
>>>> -       pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
>>>> -       cpufreq_cpu_put(data);
>>>> +       if (!frozen) {
>>>> +               pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
>>>> +               cpufreq_cpu_put(data);
>>>
>>> So, we don't decrement usage count here. But we are still increasing
>>> counts on cpufreq_add_dev after resume, isn't it?
>>>
>>> So, we wouldn't be able to free policy struct once all the cpus of a
>>> policy are removed after suspend/resume has happened once.
>>>
>>
>> Actually even I was wondering about this while writing the patch and
>> I even tested shutdown after multiple suspend/resume cycles, to verify that
>> the refcount is messed up. But surprisingly, things worked just fine.
>>
>> Logically there should've been a refcount mismatch and things should have
>> failed, but everything worked fine during my tests. Apart from suspend/resume
>> and shutdown tests, I even tried mixing a few regular CPU hotplug operations
>> (echo 0/1 to sysfs online files), but nothing stood out.
>>
>> Sorry, I forgot to document this in the patch. Either the patch is wrong
>> or something else is silently fixing this up. Not sure what is the exact
>> situation.
> 
> OK, so I'm not going to queue [2-8/8] up until we find out what's going on
> here (and until Toralf tells me that it doesn't break his system any more).
> 

Ok, that sounds good.

> I've queued up [1/8] for 3.11 already.
> 

Thank you!
 
Regards,
Srivatsa S. Bhat

