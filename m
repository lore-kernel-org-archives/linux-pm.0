From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [Update][PATCH v7 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 30 Mar 2016 10:05:55 -0700
Message-ID: <56FC0773.6060605@linaro.org>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan> <145931680.Kk1xSBT0Ro@vostro.rjw.lan>
 <20160330053011.GF8773@vireshk-i7>
 <CAJZ5v0iB_7zZSu5-H-px7NYiaZ_P6DW3dqx-bKs7eohWudwxvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32848 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898AbcC3RF6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 13:05:58 -0400
Received: by mail-pf0-f178.google.com with SMTP id 4so47686888pfd.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 10:05:57 -0700 (PDT)
In-Reply-To: <CAJZ5v0iB_7zZSu5-H-px7NYiaZ_P6DW3dqx-bKs7eohWudwxvQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On 03/30/2016 04:31 AM, Rafael J. Wysocki wrote:
>>> >> +static int sugov_limits(struct cpufreq_policy *policy)
>>> >> +{
>>> >> +     struct sugov_policy *sg_policy = policy->governor_data;
>>> >> +
>>> >> +     if (!policy->fast_switch_enabled) {
>>> >> +             mutex_lock(&sg_policy->work_lock);
>>> >> +
>>> >> +             if (policy->max < policy->cur)
>>> >> +                     __cpufreq_driver_target(policy, policy->max,
>>> >> +                                             CPUFREQ_RELATION_H);
>>> >> +             else if (policy->min > policy->cur)
>>> >> +                     __cpufreq_driver_target(policy, policy->min,
>>> >> +                                             CPUFREQ_RELATION_L);
>>> >> +
>>> >> +             mutex_unlock(&sg_policy->work_lock);
>>> >> +     }
>>> >> +
>>> >> +     sg_policy->need_freq_update = true;
>> >
>> > I am wondering why we need to do this for !fast_switch_enabled case?
>
> That will cause the rate limit to be ignored in the utilization update
> handler which may be necessary if it is set to a relatively large
> value (like 1 s).

But why is that necessary for !fast_switch_enabled? In that case the
frequency has been adjusted to satisfy the new limits here, so ignoring
the rate limit shouldn't be necessary. In other words why not

} else {
	sg_policy->need_freq_update = true;
}
