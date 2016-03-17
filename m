From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Thu, 17 Mar 2016 15:53:57 +0000
Message-ID: <20160317155357.GA31104@derkdell>
References: <20160315212047.GE6344@twins.programming.kicks-ass.net>
 <20160315214043.30639.75507@quark.deferred.io>
 <20160315214821.GM6344@twins.programming.kicks-ass.net>
 <20160315223701.30639.43127@quark.deferred.io>
 <56E8D4D9.1060202@linaro.org>
 <20160316080503.GS6344@twins.programming.kicks-ass.net>
 <20160316100257.GC18212@e106622-lin>
 <56E99E25.9070002@linaro.org>
 <20160317094046.GF18212@e106622-lin>
 <56EAB756.1050805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EAB756.1050805@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Juri Lelli <Juri.Lelli@arm.com>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 17-Mar 06:55, Steve Muckle wrote:
> On 03/17/2016 02:40 AM, Juri Lelli wrote:
> >> Could the default schedtune value not serve as the out of the box margin?
> >>
> > I'm not sure I understand you here. For me schedtune should be disabled
> > by default, so I'd say that it doesn't introduce any additional margin
> > by default. But we still need a margin to make the governor work without
> > schedtune in the mix.
> 
> Why not have schedtune be enabled always, and use it to add the margin?
> It seems like it'd simplify things.

Actually one of the effects we noticed when SchedTune and SchedFreq
are both in use is that we have a sort of "double boosting" effect.

SchedTune boosts the CPU utilization signal, thus already providing a
sort of margin for the selection of the OPP. This margin overlaps with
the SchedFreq margin, which in turns could results in the selection of
an OPP even more higher than required (with boost already accouned).
 
> I haven't looked at the schedtune code at all so I don't know whether
> this makes sense given its current implementation.

The current implementation requires review, of course ;-)
Last (and only) posting is based on top of SchedFreq code, as it was
at that time.

> But conceptually I don't know why we'd need or want one margin in
> schedutil which will be tunable, and then another mechanism for
> tuning as well.

I agree with Steve on the conceptual standpoint. The main goal of
SchedTune is actually to provide a "single tunable" to bias many
different subsystem in a "consistent" way. Thus, from a conceptual
standpoint, IMO it makes sens to investigate better how the boost value
can be linked with SchedFreq.

A possible option can be to:
1. use an hardcoded margin (M) defined by SchedFreq
   this margin is used to trigger OPP jumps
   when SchedTune _is not_ in use
2. "compose" the M margin with a boost value defined margin (B)
   when SchedTune _is_ in use

This means, e.g.
  schedfreq_margin = max(M, B)
Thus:
a) non boosted tasks (and in general when SchedTune is not in use)
   gets OPPs jumps based on the hardcoded M margin
b) boosted tasks can get more aggressive OPPs jumps based on the B
   margin

While the M margin is hardcoded, the B one is defined via CGroups
depending on the how much tasks needs to be boosted.

-- 
#include <best/regards.h>

Patrick Bellasi
