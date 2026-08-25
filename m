Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36142E413
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662379; cv=pass; b=K04Zxm2JXu8+QNNFzrXv5WXfbbl9r9QcNf3Zfw5aiPcfhd6yglhgSEoXB5iM2u1mxZwLUokNiG/A1Abjo0NUWjAfmdqCxLAuc8zynJmFfp8NNjYRsLhUQFQXac3512+ts4cQIGpkDD1q/FSrLNEHjrB2gEsZ1GhMZo27O04pplw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662379; c=relaxed/simple;
	bh=7/IxilMeunFA6sngwrJxfMRXjUd+i3uvC+cAd8NvABM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EojcQijd3qaiZb1feuSWEOqs9Lyj2Or4UGexM45OswmXYI98c9zLegMYMWjOsvb98NHR8dBmnI7/UQhICyohaCuGWWXNbPoCA7TpT82/dwAluOFtZdBHCoQVyXg36cWdWP9Ww2kfPzYTTAGALbtEkcn4It43JcTFRlWyTcz2AWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l3zsXkmE; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3zsXkmE"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso7675102a12.3
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 05:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787662373; cv=none;
        d=google.com; s=arc-20260327;
        b=IjT0vPwBO9pIaWvfaDgcxUFQedFvQK5RNIXEfPXDWVtuIZUqEvct6in3d8t6chSAO+
         BVUFVnJkvWMSjayg9pNK0NpBQq5Z67/4FHbO+4MDwv2HByExGcCnqA9/wbs8uaOM7IWZ
         KspOoEM6VUGkv0DbNZz7KpJoHCJcQLNbqKVovMvyhM2VRlbXhsXlm/y88gG4beH2vuPZ
         B4E78bxx4cavJAHfHPTd+engxqYcplN6jsJrU5Jg17lu9j/FF66ot8F38rHh8AHCtYcr
         q832xvMWIHjW4/LRf6HsMGEEY4ztN6I03vqHHP6/LeZVYtMiaZ/ouFyz0wNT9uW078He
         HRCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QeOm3RUm9VaHXJKfmD63R5uYHw6WUmpYszXMJKE/uSo=;
        fh=76gmqN5pEZb1+CQwxoXYFwr16zAuV37yIMhuEUAE1Ck=;
        b=XaR1TstKun0UdhG//ByFbkta6EkpsTWYE+hgEpMcLxf/R3Ntd4E8dyM8+9fZOM3Vi2
         p++qi0ichgR7cuc4fAciXi8Yp7pv/sp+2Q/LrvXruYgNtikY0Dnd/juzyIEb/UMmIYu5
         MLtrBnsfc7OG6XE/CZlXCWRKjApXdinrijScf4q9Y05rkw24fHPhfkR2juskMLOXZaDG
         EYYD70KJ7N5nOe4VFejfqzpahZpu4LGw4kDkloP1dCiXiHTgyEqNXjddwccftJV1qTrp
         daVWU5XXv9K6LgDglkZ23r5eRnMEW2tn1ScEb82+gXUVHE3o3W9gc0WF6u8J2zsVZ1vb
         KaKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787662373; x=1788267173; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QeOm3RUm9VaHXJKfmD63R5uYHw6WUmpYszXMJKE/uSo=;
        b=l3zsXkmEJ4EMY6oKTOJnym9xtyFqONz1YhRjGvkhuEqU/R0GdnBXMOXrSDraNzMxLD
         Bej6cgRd9OX86mzCHYzUeDgyWwa8d3dpWBRmSciBSeOmuHkDR8F8MzD2MT6G2bdYbCT3
         g0k+nsOc8H17MELn/rVSj1Bhlg0dty+hykxUlLqFiYhoYPNeISDW4264r18/E7W200K2
         PQ7N3QymNnyip1V4XVxb698OcLYR6uwsKpIFLr6+Eli0YRwSz0p0Yj94ZWs06k23ce5X
         f/oceyblaFPUZC69GB99LB4hWj1fUxLL3ESjsS9vlkqM/1/1BFn1+pd0V4phzrHcYNe0
         4fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787662373; x=1788267173;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QeOm3RUm9VaHXJKfmD63R5uYHw6WUmpYszXMJKE/uSo=;
        b=qgjEmwuZrpyadFihFDWahFMjYn+3ToZYxHKg+LwFzqTdNBRLVH1BlLXI2OdUTY34fk
         Fc3v7d5X+GKOnXnpQeAKonmbPHK1LS8ECbjDVAni14b5h1jh/mlYkhXTJpzXfHj+pqsX
         ogI41bSr8YvriZClXZwNZMfQWTtEPDQHJwbTW6sghViGBPPDkk5px9ggvGKBtXAMjIHQ
         HjvdVvfudi1XQcbKZPrqDMt39MI1yu4GpmabNuBnteanUkjSGYjzy+UiG/mSF8xieV4+
         kFFmHt9PqPy5K+u4wqP97As/BnuqEXMvXE/HvpD8DOjlr7SsHtVyKqM/momUYEYzukJ/
         2sKw==
X-Forwarded-Encrypted: i=1; AHgh+RrH+pBo/ePytNGVy3PH91S3PnVNjeRZ1Nkh/MqjWd2AJeItP7pxo7yU8Ulb7MqRtQ4edWLYJQ6D+Q==@vger.kernel.org
X-Gm-Message-State: AFuF++l9MYEMGMect52OeVV50ENAuGiy14eDLlKWvTWTccjbJLxULlhC
	EZNVF/zKzUjL2f6tKK4ziwDZ2u/QB+SxTVqBIven8k7pl3lFzKRi+tnsTTTzUei0v6IDIpbandZ
	ZQGNbXLktx4QmPUJqzRjIIYXHQhAp68BCpSWVCbqpgw==
X-Gm-Gg: AR+sD10XcusftkDDJJ1S/DmZkusuZK95M9CZYE7e4j24kM5YqKy5OoCga6ov5WiVmWD
	GZKP0vYa8XuxqPmGgmc+DoKWQFrvDwrkbdf1LFMlhWGr668uiNBfW4frpbRn8wQSVDPcrSq5AZI
	8VblZcnZxexGPozwv9+miZzobnpV+F8/rh2O7eTE4warzZS88M2djSWvh1+0Fgj0s/xD7hk9mtf
	nnKDD75j5q4ZiOnk+sdL7KoP75MGn5YGw+EQD5GDKKGOjC/L486MEpFNPnYGeLwgaArFh9AfvA9
	1t50SST2i4VN7kH8JA1jO01L7bAWBcChJyrEIkghzwT8OOWYeEaFL4X6vLYfRZSrqvFOM/807Td
	/2Q==
X-Received: by 2002:a05:6402:434a:b0:6a3:691a:9d82 with SMTP id
 4fb4d7f45d1cf-6a582af951cmr31710850a12.3.1787662372907; Tue, 25 Aug 2026
 05:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824131842.2443385-1-christian.loehle@arm.com>
 <14b8edb7-3515-42dd-86bc-c61872921b5d@transsion.com> <31716152-14b6-46bc-88f6-b7fccc1e9377@arm.com>
In-Reply-To: <31716152-14b6-46bc-88f6-b7fccc1e9377@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 25 Aug 2026 14:52:41 +0200
X-Gm-Features: AcwNN1VveyATUIHNpZtjzi13d9waImJh_RMwx9TYlWnCyUSk4E4Ei5zBJQ9DMzY
Message-ID: <CAKfTPtDj7fxV9w+q10aXaHAFuBEgzBfiWx3yiBt_eS_qV1ATjg@mail.gmail.com>
Subject: Re: [PATCH] sched/cpufreq: Reevaluate frequency before tickless idle
To: Christian Loehle <christian.loehle@arm.com>
Cc: Hongyan Xia <hongyan.xia@transsion.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rafael@kernel.org" <rafael@kernel.org>, 
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, 
	"daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>, 
	"anna-maria@linutronix.de" <anna-maria@linutronix.de>, "frederic@kernel.org" <frederic@kernel.org>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, 
	"jstultz@google.com" <jstultz@google.com>, "qyousef@layalina.io" <qyousef@layalina.io>, 
	"sibi.sankar@oss.qualcomm.com" <sibi.sankar@oss.qualcomm.com>, "lukasz.luba@arm.com" <lukasz.luba@arm.com>, 
	"morten.rasmussen@arm.com" <morten.rasmussen@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Aug 2026 at 11:00, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 8/25/26 03:51, Hongyan Xia wrote:
> > On 8/24/2026 9:18 PM, Christian Loehle wrote:
> >> sugov_hold_freq() can preserve a UCLAMP_MIN-driven high frequency when
> >> the runqueue goes idle. If cpuidle then stops the tick, no later
> >> utilization update is guaranteed and a CPU using WFI can remain at an
> >> unnecessarily high voltage for the entire idle period.
> >>
> >> Issue a final cpufreq update when the idle tick actually transitions to
> >> stopped and force single-policy schedutil past its rate limit. Keep the
> >> existing hold behavior when the tick is retained.
> >>
> >> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >> ---
> >>   include/linux/sched/cpufreq.h    |  1 +
> >>   kernel/sched/cpufreq_schedutil.c |  5 ++++-
> >>   kernel/sched/idle.c              | 29 +++++++++++++++++++++++++++--
> >>   3 files changed, 32 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> >> index bdd31ab93bc5..0814f6c79315 100644
> >> --- a/include/linux/sched/cpufreq.h
> >> +++ b/include/linux/sched/cpufreq.h
> >> @@ -9,6 +9,7 @@
> >>    */
> >>
> >>   #define SCHED_CPUFREQ_IOWAIT       (1U << 0)
> >> +#define SCHED_CPUFREQ_IDLE  (1U << 1)
> >>
> >>   #ifdef CONFIG_CPU_FREQ
> >>   struct cpufreq_policy;
> >> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >> index a1782755efcc..90bf8d8bffb7 100644
> >> --- a/kernel/sched/cpufreq_schedutil.c
> >> +++ b/kernel/sched/cpufreq_schedutil.c
> >> @@ -100,7 +100,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >>
> >>              return true;
> >>      } else if (sg_policy->need_freq_update) {
> >> -            /* ignore_dl_rate_limit() wants a new frequency to be found. */
> >> +            /* A forced update needs a new frequency to be found. */
> >>              return true;
> >>      }
> >>
> >> @@ -407,6 +407,9 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
> >>      sugov_iowait_boost(sg_cpu, time, flags);
> >>      sg_cpu->last_update = time;
> >>
> >> +    if (flags & SCHED_CPUFREQ_IDLE)
> >> +            sg_cpu->sg_policy->need_freq_update = true;
> >> +
> >>      ignore_dl_rate_limit(sg_cpu);
> >>
> >>      if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
> >> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> >> index eb73b65ce6c4..36f8840d0562 100644
> >> --- a/kernel/sched/idle.c
> >> +++ b/kernel/sched/idle.c
> >> @@ -161,10 +161,35 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >>      return cpuidle_enter(drv, dev, next_state);
> >>   }
> >>
> >> +static void idle_stop_tick(void)
> >> +{
> >> +#ifdef CONFIG_CPU_FREQ
> >> +    bool was_stopped = tick_nohz_tick_stopped();
> >> +#endif
> >> +
> >> +    tick_nohz_idle_stop_tick();
> >> +
> >> +#ifdef CONFIG_CPU_FREQ
> >> +    /*
> >> +     * Run one last cpufreq update before entering idle with the tick
> >> +     * stopped, because no later update is guaranteed.
> >> +     */
> >> +    if (!was_stopped && tick_nohz_tick_stopped()) {
> >> +            struct rq *rq = this_rq();
> >> +            struct rq_flags rf;
> >> +
> >> +            rq_lock(rq, &rf);
> >> +            update_rq_clock(rq);
> >> +            cpufreq_update_util(rq, SCHED_CPUFREQ_IDLE);
> >> +            rq_unlock(rq, &rf);
> >> +    }
> >> +#endif
> >> +}
> >> +
> >>   static void idle_call_stop_or_retain_tick(bool stop_tick)
> >>   {
> >>      if (stop_tick || tick_nohz_tick_stopped())
> >> -            tick_nohz_idle_stop_tick();
> >> +            idle_stop_tick();
> >>      else
> >>              tick_nohz_idle_retain_tick();
> >>   }
> >> @@ -225,7 +250,7 @@ static void cpuidle_idle_call(bool stop_tick)
> >>                      max_latency_ns = dev->forced_idle_latency_limit_ns;
> >>              }
> >>
> >> -            tick_nohz_idle_stop_tick();
> >> +            idle_stop_tick();
> >>
> >>              next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
> >>              call_cpuidle(drv, dev, next_state);
> >
> > LGTM, minus the Sashiko issue.
> >
> > One side note is that I briefly looked at similar things before, not
> > just for sugov_hold_freq() but for going idle in general. It might be
> > desirable to predict the util *after* wake-up and use it to drive
> > frequency one last time before going idle for any CPU. This avoids
> > holding high frequencies in update_single() and also avoids idling CPUs
> > holding high frequencies for the entire cluster in update_shared().
> >
> > But predictions are hard and the energy savings aren't much so I didn't
> > spend much time on it. Not sure if there are better ideas.
>
> Funnily enough the slow-switch case makes this a lot more complicated,
> in particular with PREEMPT_RT :/
> My current approach is to have an irq work for the next tick for
> the sugov_hold_freq() case, that checks if it hasn't seen another update
> for the tick duration and then drops the hold_freq.
> It's not ideal because of course it disabled the tick-stop by one tick,
> but it's the best approach I can come up with now.
> We could do something similar for decayed blocked utilization (i.e. have
> an irq work for when utilization would reach lowest OPP (or an intermediate
> step?) and decay that then).
>
> That being said I do think the hold_freq and the blocked utilization are
> separate issues, they just might have a similar-looking solution...
> I can post an RFC for the latter, that being said I'm not entirely convinced
> myself that it's worth it, while I think the hold_freq is just clearly wrong
> behavior.

IIRC some past discussions, keeping the frequency when going idle was
a desired behavior because switching back to a high frequency took
time and slow down the wakeup (in particular with the cpufreq slow
path), and the power cost was not huge because long idle times would
power off the power domain, and idle time in WFI would be corrected by
the next tick. Do I understand correctly that in your case you only
have WFI, so you never power down domain for long sleep ?

I'm not sure I get why you want to decrease frequency in WFI instead
of letting the tick update the utilization. Or Am I missing something
in your use case ?
