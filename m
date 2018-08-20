From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5] cpuidle: menu: Handle stopped tick more aggressively
Date: Mon, 20 Aug 2018 13:04:10 +0200
Message-ID: <20180820110410.GY2494@hirez.programming.kicks-ass.net>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <1754612.IcCR94pSYR@aspire.rjw.lan>
 <1582055.9b67urWYFa@aspire.rjw.lan>
 <1572343.jWaXB8XNF1@aspire.rjw.lan>
 <20180814154441.GA13920@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180814154441.GA13920@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: leo.yan@linaro.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 14, 2018 at 11:44:41PM +0800, leo.yan@linaro.org wrote:
> I agree this patch can resolve the issue you mentioned in the commit
> log, but this patch will be fragile for below case, so it will select
> state1 but not state2, how about you think for this case?
> 
> Idle_state0::
> target_residency   TICK_USEC   Prediction
>     |                 |       /
>     V                 V      /
> -----------------------------------------------------> Time length
>                                 ^                 ^
>                                 |                 |
>                             Idle_state1:       Idle_state2:
>                             target_residency   target_residency

If someone can demonstate this is an actual problem; then we need to fix
it I suppose. But it would be very good to have a real world
need/reproducer for it first.
