From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Thu, 17 Mar 2016 11:56:05 -0700
Message-ID: <20160317185605.11016.62512@quark.deferred.io>
References: <20160315214043.30639.75507@quark.deferred.io>
 <20160315223701.30639.43127@quark.deferred.io> <56E8D4D9.1060202@linaro.org>
 <20160316080503.GS6344@twins.programming.kicks-ass.net>
 <20160316100257.GC18212@e106622-lin> <56E99E25.9070002@linaro.org>
 <20160317094046.GF18212@e106622-lin> <56EAB756.1050805@linaro.org>
 <20160317155357.GA31104@derkdell> <20160317175407.GO18212@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33157 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948AbcCQS4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 14:56:12 -0400
Received: by mail-pf0-f170.google.com with SMTP id 4so1421218pfd.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2016 11:56:12 -0700 (PDT)
In-Reply-To: <20160317175407.GO18212@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

Quoting Juri Lelli (2016-03-17 10:54:07)
> Hi,
> 
> On 17/03/16 15:53, Patrick Bellasi wrote:
> > On 17-Mar 06:55, Steve Muckle wrote:
> > > On 03/17/2016 02:40 AM, Juri Lelli wrote:
> > > >> Could the default schedtune value not serve as the out of the box margin?
> > > >>
> > > > I'm not sure I understand you here. For me schedtune should be disabled
> > > > by default, so I'd say that it doesn't introduce any additional margin
> > > > by default. But we still need a margin to make the governor work without
> > > > schedtune in the mix.
> > > 
> > > Why not have schedtune be enabled always, and use it to add the margin?
> > > It seems like it'd simplify things.
> > 
> > Actually one of the effects we noticed when SchedTune and SchedFreq
> > are both in use is that we have a sort of "double boosting" effect.
> > 
> > SchedTune boosts the CPU utilization signal, thus already providing a
> > sort of margin for the selection of the OPP. This margin overlaps with
> > the SchedFreq margin, which in turns could results in the selection of
> > an OPP even more higher than required (with boost already accouned).
> >  
> > > I haven't looked at the schedtune code at all so I don't know whether
> > > this makes sense given its current implementation.
> > 
> > The current implementation requires review, of course ;-)
> > Last (and only) posting is based on top of SchedFreq code, as it was
> > at that time.
> > 
> > > But conceptually I don't know why we'd need or want one margin in
> > > schedutil which will be tunable, and then another mechanism for
> > > tuning as well.
> > 
> > I agree with Steve on the conceptual standpoint. The main goal of
> > SchedTune is actually to provide a "single tunable" to bias many
> > different subsystem in a "consistent" way. Thus, from a conceptual
> > standpoint, IMO it makes sens to investigate better how the boost value
> > can be linked with SchedFreq.
> > 
> > A possible option can be to:
> > 1. use an hardcoded margin (M) defined by SchedFreq
> >    this margin is used to trigger OPP jumps
> >    when SchedTune _is not_ in use
> > 2. "compose" the M margin with a boost value defined margin (B)
> >    when SchedTune _is_ in use
> > 
> > This means, e.g.
> >   schedfreq_margin = max(M, B)
> > Thus:
> > a) non boosted tasks (and in general when SchedTune is not in use)
> >    gets OPPs jumps based on the hardcoded M margin
> > b) boosted tasks can get more aggressive OPPs jumps based on the B
> >    margin
> > 
> > While the M margin is hardcoded, the B one is defined via CGroups
> > depending on the how much tasks needs to be boosted.
> > 
> 
> Makes sense to me. And I think M margin is the one we don't want to make
> part of the ABI and only play with it under DEBUG.

Correct.

Regarding "composing" the margin, schedtune could even overwrite the
margin entirely via cpufreq_set_cfs_capacity_margin (see patch #2 in
this series). This avoids complications around a "double boosting"
effect.

Either way, it sounds like the schedtune angle is something that we can
figure out in due time and change the code as needed later on. For
schedutil to make sense for frequency-invariant platforms we do need a
margin today, and there is desire to tune it easily, so I will move this
sysfs knob to a debug knob in v2.

Regards,
Mike

> 
> Best,
> 
> - Juri
