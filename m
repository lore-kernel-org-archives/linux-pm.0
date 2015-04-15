From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] cpuidle: Store the idle start time stamp
Date: Wed, 15 Apr 2015 15:11:57 +0200
Message-ID: <20150415131157.GO23123@twins.programming.kicks-ass.net>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
 <20150415102057.GR5029@twins.programming.kicks-ass.net>
 <552E5992.2050404@linaro.org>
 <20150415124246.GW5029@twins.programming.kicks-ass.net>
 <552E5E99.6060901@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <552E5E99.6060901@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 15, 2015 at 02:50:33PM +0200, Daniel Lezcano wrote:
> I was thinking about converting to nanosecond the cpuidle framework but it
> is not worth to do that as the resolution is too high for the idle states.

The question is if saving those 4 bytes (unsigned int vs u64) on
next_timer_us is worth having to do that /1000 all the time.

The one spot where its used:

        new_factor += RESOLUTION * measured_us / data->next_timer_us;

Could be fixed with a few shifts, all that matters is that measured_us
and next_timer_us are in the same metric, it doesn't need to be us, it
could be ns/1024 for instance.
