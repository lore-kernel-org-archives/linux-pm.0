From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Eas-dev] [PATCH V4 1/3] sched: cpufreq: Allow remote cpufreq
 callbacks
Date: Thu, 27 Jul 2017 12:44:41 +0530
Message-ID: <20170727071441.GL352@vireshk-i7>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
 <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
 <CAEi0qN=ipk9SR+3DYcLk-5SoKnsfK=PQV62VH9KAoXz2PDRkjQ@mail.gmail.com>
 <20170727055026.GK352@vireshk-i7>
 <CAEi0qNnYANJ9qNAnh3H4F5igXvHhT8ujoVH3JjMgr_1aBvvcRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:37010 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdG0HOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 03:14:45 -0400
Received: by mail-pg0-f48.google.com with SMTP id y129so94278114pgy.4
        for <linux-pm@vger.kernel.org>; Thu, 27 Jul 2017 00:14:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEi0qNnYANJ9qNAnh3H4F5igXvHhT8ujoVH3JjMgr_1aBvvcRg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, smuckle.linux@gmail.com, eas-dev@lists.linaro.org, Joel Fernandes <joelaf@google.com>

On 26-07-17, 23:13, Joel Fernandes (Google) wrote:
> On Wed, Jul 26, 2017 at 10:50 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 26-07-17, 22:34, Joel Fernandes (Google) wrote:
> >> On Wed, Jul 26, 2017 at 2:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> > @@ -221,7 +226,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >> >         sugov_set_iowait_boost(sg_cpu, time, flags);
> >> >         sg_cpu->last_update = time;
> >> >
> >> > -       if (!sugov_should_update_freq(sg_policy, time))
> >> > +       if (!sugov_should_update_freq(sg_policy, time, hook->cpu))
> >> >                 return;
> >>
> >> Since with the remote callbacks now possible, isn't it unsafe to
> >> modify sg_cpu and sg_policy structures without a lock in
> >> sugov_update_single?
> >>
> >> Unlike sugov_update_shared, we don't acquire any lock in
> >> sugov_update_single before updating these structures. Did I miss
> >> something?
> >
> > As Peter already mentioned it earlier, the callbacks are called with
> > rq locks held and so sugov_update_single() wouldn't get called in
> > parallel for a target CPU.
> 
> Ah ok, I have to catch up with that discussion since I missed the
> whole thing. Now that you will have me on CC, that shouldn't happen,
> thanks and sorry about the noise.
> 
> > That's the only race you were worried about ?
> 
> Yes. So then in that case, makes sense to move raw_spin_lock in
> sugov_update_shared further down? (Just discussing, this point is
> independent of your patch), Something like:

Even that was discussed tomorrow with Peter :)

No it wouldn't work because sg_cpu->util we are updating here may be
getting read from some other cpu that shares policy with sg_cpu.

-- 
viresh
