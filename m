From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RFCv5 PATCH 41/46] sched/fair: add triggers for OPP change requests
Date: Sat, 15 Aug 2015 20:50:56 -0700
Message-ID: <20150816035056.31346.59624@quantum>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-42-git-send-email-morten.rasmussen@arm.com>
 <20150815124817.GH10304@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150815124817.GH10304@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Peter Zijlstra (2015-08-15 05:48:17)
> 
> 
> So this OPP thing, I think that got mentioned once earlier in this patch
> set, wth is that?

OPP == OPerating Point == P-state

In System-on-chip Land OPP is a very common term, roughly defined as a
frequency & voltage pair that makes up a performance state.

In other words, OPP is the P-state of the non-ACPI world.

Similarly DVFS is sometimes confused as a brand new file system, but it
is also a very standardized acronym amongst SoC vendors meaning
frequency and voltage scaling.

Regards,
Mike

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
