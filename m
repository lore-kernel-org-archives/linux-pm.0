From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [Eas-dev] [PATCH V4 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Wed, 26 Jul 2017 23:13:11 -0700
Message-ID: <CAEi0qNnYANJ9qNAnh3H4F5igXvHhT8ujoVH3JjMgr_1aBvvcRg@mail.gmail.com>
References: <cover.1501060871.git.viresh.kumar@linaro.org> <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
 <CAEi0qN=ipk9SR+3DYcLk-5SoKnsfK=PQV62VH9KAoXz2PDRkjQ@mail.gmail.com> <20170727055026.GK352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33210 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbdG0GNN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 02:13:13 -0400
In-Reply-To: <20170727055026.GK352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, smuckle.linux@gmail.com, eas-dev@lists.linaro.org, Joel Fernandes <joelaf@google.com>

On Wed, Jul 26, 2017 at 10:50 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-07-17, 22:34, Joel Fernandes (Google) wrote:
>> On Wed, Jul 26, 2017 at 2:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > @@ -221,7 +226,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>> >         sugov_set_iowait_boost(sg_cpu, time, flags);
>> >         sg_cpu->last_update = time;
>> >
>> > -       if (!sugov_should_update_freq(sg_policy, time))
>> > +       if (!sugov_should_update_freq(sg_policy, time, hook->cpu))
>> >                 return;
>>
>> Since with the remote callbacks now possible, isn't it unsafe to
>> modify sg_cpu and sg_policy structures without a lock in
>> sugov_update_single?
>>
>> Unlike sugov_update_shared, we don't acquire any lock in
>> sugov_update_single before updating these structures. Did I miss
>> something?
>
> As Peter already mentioned it earlier, the callbacks are called with
> rq locks held and so sugov_update_single() wouldn't get called in
> parallel for a target CPU.

Ah ok, I have to catch up with that discussion since I missed the
whole thing. Now that you will have me on CC, that shouldn't happen,
thanks and sorry about the noise.

> That's the only race you were worried about ?

Yes. So then in that case, makes sense to move raw_spin_lock in
sugov_update_shared further down? (Just discussing, this point is
independent of your patch), Something like:

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 622eed1b7658..9a6c12fb2c16 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -295,8 +295,6 @@ static void sugov_update_shared(struct
update_util_data *hook, u64 time,

        sugov_get_util(&util, &max);

-       raw_spin_lock(&sg_policy->update_lock);
-
        sg_cpu->util = util;
        sg_cpu->max = max;
        sg_cpu->flags = flags;
@@ -304,6 +302,8 @@ static void sugov_update_shared(struct
update_util_data *hook, u64 time,
        sugov_set_iowait_boost(sg_cpu, time, flags);
        sg_cpu->last_update = time;

+       raw_spin_lock(&sg_policy->update_lock);
+
        if (sugov_should_update_freq(sg_policy, time)) {
                if (flags & SCHED_CPUFREQ_RT_DL)
                        next_f = sg_policy->policy->cpuinfo.max_freq;



thanks,

-Joel
