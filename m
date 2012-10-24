From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: drivers/cpufreq/cpufreq_governor.c:46:53: sparse: incorrect type in argument 2 (different modifiers)
Date: Wed, 24 Oct 2012 02:33:52 +0200
Message-ID: <1574211.OHQpWS6lzF@vostro.rjw.lan>
References: <50862255.Foit2oXcLVE39lAk%fengguang.wu@intel.com> <CAKohpo=PF-MkG8KDRWSfoBXkK102r7WwToQ01UmfetvarRyK3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:33527 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933570Ab2JXA35 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Oct 2012 20:29:57 -0400
In-Reply-To: <CAKohpo=PF-MkG8KDRWSfoBXkK102r7WwToQ01UmfetvarRyK3w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Fengguang Wu <fengguang.wu@intel.com>, linux-pm@vger.kernel.org, Lists linaro-dev <linaro-dev@lists.linaro.org>

On Tuesday 23 of October 2012 10:55:51 Viresh Kumar wrote:
> Hi Fengguang,
> 
> Thanks for your mail. Few things i learnt from it:
> - Rafael has already applied my patches :)

Yes, I have.  I didn't have the time to let all the people whose patches
were applied know individually, however.

> - I haven't used sparse in my life till this point. Now i know how to use it.
> 
> On 23 October 2012 10:21, Fengguang Wu <fengguang.wu@intel.com> wrote:
> > Hi viresh,
> >
> > FYI, there are new sparse warnings show up in
> 
> Actually these aren't new warnings, but old. Because some part is moved from
> one file to another, that's why your script shows them as new warnings.
> 
> Anyway, i don't hesitate in fixing them.
> @Rafael: Most of these are due to mixed use of u64 and cputime64_t. Both of
> which are u64 if i am not wrong. Any specific reason that we used cputime64_t
> instead of u64? Or can i make everything u64 instead in governors?

Well, there might be a reason in the past, but I'm not sure it's still there. :-)

I _think_ you can use u64 everywhere.  It would be more correct than the current
situation anyway.

Thanks,
Rafael


> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> > head:   13f5e2d9a915373dd1573d8fe0214738bc69004f
> > commit: 83a73f712f2275033b2dc7f5c664988a1823ebc7 cpufreq: Move common part from governors to separate file, v2
> > date:   5 hours ago
> >
> > + drivers/cpufreq/cpufreq_governor.c:46:53: sparse: incorrect type in argument 2 (different modifiers)
> > drivers/cpufreq/cpufreq_governor.c:46:53:    expected unsigned long long [usertype] *wall
> > drivers/cpufreq/cpufreq_governor.c:46:53:    got unsigned long long [nocast] [usertype] *wall
> > + drivers/cpufreq/cpufreq_governor.c:46:53: sparse: implicit cast from nocast type
> > drivers/cpufreq/cpufreq_governor.c:48:58: sparse: incorrect type in argument 2 (different modifiers)
> > drivers/cpufreq/cpufreq_governor.c:48:58:    expected unsigned long long [usertype] *last_update_time
> > drivers/cpufreq/cpufreq_governor.c:48:58:    got unsigned long long [nocast] [usertype] *wall
> > drivers/cpufreq/cpufreq_governor.c:48:58: sparse: implicit cast from nocast type
> >
> > vim +46 drivers/cpufreq/cpufreq_governor.c
> >
> > 83a73f71 viresh kumar 2012-10-23  30    busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_SOFTIRQ];
> > 83a73f71 viresh kumar 2012-10-23  31    busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_STEAL];
> > 83a73f71 viresh kumar 2012-10-23  32    busy_time += kcpustat_cpu(cpu).cpustat[CPUTIME_NICE];
> > 83a73f71 viresh kumar 2012-10-23  33
> > 83a73f71 viresh kumar 2012-10-23  34    idle_time = cur_wall_time - busy_time;
> > 83a73f71 viresh kumar 2012-10-23  35    if (wall)
> > 83a73f71 viresh kumar 2012-10-23  36            *wall = jiffies_to_usecs(cur_wall_time);
> > 83a73f71 viresh kumar 2012-10-23  37
> > 83a73f71 viresh kumar 2012-10-23  38    return jiffies_to_usecs(idle_time);
> > 83a73f71 viresh kumar 2012-10-23  39  }
> > 83a73f71 viresh kumar 2012-10-23  40
> > 83a73f71 viresh kumar 2012-10-23  41  cputime64_t get_cpu_idle_time(unsigned int cpu, cputime64_t *wall)
> > 83a73f71 viresh kumar 2012-10-23  42  {
> > 83a73f71 viresh kumar 2012-10-23  43    u64 idle_time = get_cpu_idle_time_us(cpu, NULL);
> > 83a73f71 viresh kumar 2012-10-23  44
> > 83a73f71 viresh kumar 2012-10-23  45    if (idle_time == -1ULL)
> > 83a73f71 viresh kumar 2012-10-23 @46            return get_cpu_idle_time_jiffy(cpu, wall);
> > 83a73f71 viresh kumar 2012-10-23  47    else
> > 83a73f71 viresh kumar 2012-10-23  48            idle_time += get_cpu_iowait_time_us(cpu, wall);
> > 83a73f71 viresh kumar 2012-10-23  49
> > 83a73f71 viresh kumar 2012-10-23  50    return idle_time;
> > 83a73f71 viresh kumar 2012-10-23  51  }
> > 83a73f71 viresh kumar 2012-10-23  52  EXPORT_SYMBOL_GPL(get_cpu_idle_time);
> >
> > ---
> > 0-DAY kernel build testing backend         Open Source Technology Center
> > Fengguang Wu, Yuanhan Liu                              Intel Corporation
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
