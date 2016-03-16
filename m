From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 6/8] cpufreq/schedutil: sum per-sched class utilization
Date: Wed, 16 Mar 2016 11:20:45 -0700
Message-ID: <56E9A3FD.9050309@linaro.org>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-7-git-send-email-mturquette+renesas@baylibre.com>
 <20160315212926.GG6344@twins.programming.kicks-ass.net>
 <20160315220951.30639.12872@quark.deferred.io>
 <20160316073850.GO6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36822 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934953AbcCPSUq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 14:20:46 -0400
Received: by mail-pf0-f174.google.com with SMTP id u190so84510600pfb.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 11:20:46 -0700 (PDT)
In-Reply-To: <20160316073850.GO6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On 03/16/2016 12:38 AM, Peter Zijlstra wrote:
> Somewhere in the giant discussions I mentioned that we should be looking
> at a CPPC like interface and pass {min,max} tuples to the cpufreq
> selection thingy.
> 
> In that same discussion I also mentioned that we must compute min as the
> hard dl reservation, but that for max we can actually use the avg dl +
> avg rt + avg cfs.
> 
> That way there is far more room for selecting a sensible frequency.

Doesn't the above min/max policy mean that the platform will likely
underserve the task load? If avg dl+rt+cfs represents our best estimate
of the work to be done, I would think that should be the min.

