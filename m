From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU
 offline/online locked
Date: Wed, 25 May 2016 02:48:51 +0200
Message-ID: <CAJZ5v0iYAEAcf2B=mNULbkDOeUmEX+igNJ0=kLXKXq-G=oGSqA@mail.gmail.com>
References: <19792191.esL3UuyORb@vostro.rjw.lan>
	<2500818.MtOb9b1ZsB@vostro.rjw.lan>
	<20160524121717.GY17585@vireshk-i7>
	<1494288.rDJLbL32aZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38139 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbcEYAsw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 20:48:52 -0400
In-Reply-To: <1494288.rDJLbL32aZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Wed, May 25, 2016 at 2:00 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, May 24, 2016 05:47:17 PM Viresh Kumar wrote:
>> On 24-05-16, 14:13, Rafael J. Wysocki wrote:
>> > I don't really get it why you don't like get/put_online_cpus() so much.
>>
>> Not that I don't like them, I just wanted to see if its possible to
>> work without any additional locking.
>>
>> Anyway, so the first version of your patch did the get_online_cpus()
>> around a bigger section of the code instead of just the
>> for_each_online_cpu() loop. Should we change that?
>
> It did that, because locking around the loop alone wouldn't close the
> races I'm concerned about.
>
> That said, those same races are possible when the cpufreq driver is
> loaded along with the cpufreq_stats module or is unloaded along with
> that module.  Again, if ether a CPU goes online or the cpufreq driver
> is loaded during cpufreq_stats_init(), the new CPU *or* a new policy
> may be missed by it.  Similarly, if either a CPU goes offline or
> the cpufreq driver is unloaded during cpufreq_stats_exit(), that
> CPU or a policy that has just gone away may be missed by it.
>
> The CPU "hotplug" locking is not sufficient to close the races related
> to the cpufreq driver load/unload, so an alternative approach is needed.
> IMO, however, changing the way the notifiers work is not the way to go
> here, because the problem is specific to the stats module.  Unless there
> are other users of the notifiers with the same problem, it should be
> addressed in the stats code.
>
> The stats code looks all pants to me now, TBH, and the way it uses notifiers
> (both policy notifiers and transition notifiers) is questionable at the very
> least.  It looks like it would just be better to redesign it from scratch.

I'm actually considering making the stats code non-modular.

It won't have a reason to use notifiers then and may be simplified
quite a bit this way.  As an added benefit, if it doesn't use the
transition notifier, it won't interfere with fast frequency switching
in the schedutil governor any more.

Are there any drawbacks?
