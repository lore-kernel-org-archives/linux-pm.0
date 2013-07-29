From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: stable 3-10-3: strange output of "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 15:14:08 +0530
Message-ID: <51F63968.6060604@linux.vnet.ibm.com>
References: <51F40612.2050403@gmx.de>	<2111514.pxW5saG1J3@vostro.rjw.lan> <18359786.D7glpto546@vostro.rjw.lan>	<2368277.VjYrsHUseA@vostro.rjw.lan> <CAOh2x=n0-a9amv5cfwOotvCnhNksnNZOSVp4jWk400z71UQeWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOh2x=n0-a9amv5cfwOotvCnhNksnNZOSVp4jWk400z71UQeWQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/29/2013 01:21 PM, Viresh Kumar wrote:
> On Mon, Jul 29, 2013 at 4:50 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> Having a deeper look at it, though, I see that in fact the whole
>> cpufreq_cpu_put() is needed if the CPU is not the last one for the given
>> policy and is not needed at all otherwise (as described in the changelog
>> of the patch below).
>>
>> Srivatsa, does this make sense to you?
> 
> It makes atleast to me :)
> 
>> This is not the only bad thing that happens there, however, because
>> kobject_put() should only be called for the policy kobject at this
>> point if the CPU is not the last one for that policy.
>>
>> Namely, if the given CPU is the last one for that policy, the
>> policy kobject's refcount should be 1 at this point, as set by
>> cpufreq_add_dev_interface(), and only needs to be dropped once for
>> the kobject to go away.  This actually happens under the cpu == 1
>> check, so it need not be done before by cpufreq_cpu_put().
> 
> But I see one more issue with this code. For the last cpu we are just
> calling kobject_put() and not cpufreq_cpu_put() and hence call to
> module_put() is skipped. I am not sure, but that will probably cause
> a problem when we try to rmmod the module? But which module then?
> As we can't compile cpufreq.c as module.. So, is this part of code junk?
> And so can be removed?
> 

I tried to address this concern in my other mail to Rafael. (Sorry I
forgot to CC you on that!). Let me know what you think of that solution.

Regards,
Srivatsa S. Bhat

