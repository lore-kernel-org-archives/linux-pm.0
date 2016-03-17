From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Thu, 17 Mar 2016 06:55:34 -0700
Message-ID: <56EAB756.1050805@linaro.org>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-5-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212047.GE6344@twins.programming.kicks-ass.net>
 <20160315214043.30639.75507@quark.deferred.io>
 <20160315214821.GM6344@twins.programming.kicks-ass.net>
 <20160315223701.30639.43127@quark.deferred.io> <56E8D4D9.1060202@linaro.org>
 <20160316080503.GS6344@twins.programming.kicks-ass.net>
 <20160316100257.GC18212@e106622-lin> <56E99E25.9070002@linaro.org>
 <20160317094046.GF18212@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34262 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030842AbcCQNzh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Mar 2016 09:55:37 -0400
Received: by mail-pf0-f170.google.com with SMTP id x3so122134014pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2016 06:55:37 -0700 (PDT)
In-Reply-To: <20160317094046.GF18212@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <Juri.Lelli@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>, Patrick Bellasi <patrick.bellasi@arm.com>

On 03/17/2016 02:40 AM, Juri Lelli wrote:
>> Could the default schedtune value not serve as the out of the box margin?
>>
> I'm not sure I understand you here. For me schedtune should be disabled
> by default, so I'd say that it doesn't introduce any additional margin
> by default. But we still need a margin to make the governor work without
> schedtune in the mix.

Why not have schedtune be enabled always, and use it to add the margin?
It seems like it'd simplify things.

I haven't looked at the schedtune code at all so I don't know whether
this makes sense given its current implementation. But conceptually I
don't know why we'd need or want one margin in schedutil which will be
tunable, and then another mechanism for tuning as well.
