From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Update 2x][PATCH 7/7] cpufreq: Separate CPU device registration
 from CPU online
Date: Wed, 29 Jul 2015 16:02:58 +0200
Message-ID: <CAJZ5v0h7MiSJ+Sus1g8prBN3O6y98JDUPBQ=vjCQ1KG_yP22+A@mail.gmail.com>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
	<1739669.kedIsxdRK2@vostro.rjw.lan>
	<1702607.RH80fBCN6J@vostro.rjw.lan>
	<3091538.g8dYBumqSx@vostro.rjw.lan>
	<20150729053248.GC21493@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34998 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbbG2ODA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 10:03:00 -0400
In-Reply-To: <20150729053248.GC21493@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi Viresh,

On Wed, Jul 29, 2015 at 7:32 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 29-07-15, 03:03, Rafael J. Wysocki wrote:
>> +static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>> +{
>> +     unsigned cpu = dev->id;
>> +     int ret;
>> +
>> +     dev_dbg(dev, "%s: adding CPU%u\n", __func__, cpu);
>> +
>> +     if (cpu_online(cpu)) {
>> +             ret = cpufreq_online(cpu);
>
> I will do return right here ...
>
>> +     } else {
>
> ... and this else will not be required anymore.

No.

You'd still need policy, so its definition and initialization would stay there.

The only thing you can save by doing that change is the ret variable,
but I like the code more the way it is.

>> +             /*
>> +              * A hotplug notifier will follow and we will handle it as CPU
>> +              * online then.  For now, just create the sysfs link, unless
>> +              * there is no policy or the link is already present.
>> +              */
>> +             struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>> +
>> +             ret = policy && !cpumask_test_and_set_cpu(cpu, policy->real_cpus)
>> +                     ? add_cpu_dev_symlink(policy, cpu) : 0;
>> +     }
>> +
>> +     return ret;
>> +}
>
> Looks good otherwise.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks,
Rafael
