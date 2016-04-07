From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Skip all governor-related actions for
 cpufreq_suspended set
Date: Thu, 7 Apr 2016 13:22:39 +0200
Message-ID: <CAJZ5v0gfadfuSdkoitFJAZfYXLJhed+1w2wiq1O3VnVK+fGYzA@mail.gmail.com>
References: <2044559.GVlD7a2JcO@vostro.rjw.lan>
	<20160407042820.GA14903@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36112 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425AbcDGLWm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 07:22:42 -0400
In-Reply-To: <20160407042820.GA14903@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Thu, Apr 7, 2016 at 6:28 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 07-04-16, 03:29, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Since governor operations are generally skipped if cpufreq_suspended
>> is set, do nothing at all in cpufreq_start_governor() and
>> cpufreq_exit_governor() in that case.
>>
>> In particular, this prevents fast frequency switching from being
>> disabled after a suspend-to-RAM cycle on all CPUs except for the
>> boot one.
>
> static int cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
> {
>         int ret;
>
>         /* Don't start any governor operations if we are entering suspend */
>         if (cpufreq_suspended)
>                 return 0;
>
>         ...
>
> }
>
> Above already guarantees that we would start/stop governors. Why do we
> need this change then ?

Because we do extra stuff in cpufreq_start_governor() and
cpufreq_exit_governor() that *also* shouldn't be done if
cpufreq_suspended is set.
