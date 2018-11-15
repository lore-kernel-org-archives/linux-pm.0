From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor for tickless systems
Date: Thu, 15 Nov 2018 03:57:05 +0100
Message-ID: <13917501.YLdTytznDL@aspire.rjw.lan>
References: <102783770.7hZjAahU8c@aspire.rjw.lan> <20181111152034.GC3021@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181111152034.GC3021@worktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, November 11, 2018 4:20:34 PM CET Peter Zijlstra wrote:
> On Thu, Nov 08, 2018 at 06:25:07PM +0100, Rafael J. Wysocki wrote:
> > +/*
> > + * The SPIKE value is added to metrics when they grow and the DECAY_SHIFT value
> > + * is used for decreasing metrics on a regular basis.
> > + */
> > +#define SPIKE		1024
> > +#define DECAY_SHIFT	3
> 
> > +	if (idx_timer >= 0) {
> > +		unsigned int hits = cpu_data->states[idx_timer].hits;
> > +		unsigned int misses = cpu_data->states[idx_timer].misses;
> > +
> > +		hits -= hits >> DECAY_SHIFT;
> > +		misses -= misses >> DECAY_SHIFT;
> > +
> > +		if (idx_timer > idx_hit) {
> > +			misses += SPIKE;
> > +			if (idx_hit >= 0)
> > +				cpu_data->states[idx_hit].early_hits += SPIKE;
> > +		} else {
> > +			hits += SPIKE;
> > +		}
> > +
> > +		cpu_data->states[idx_timer].misses = misses;
> > +		cpu_data->states[idx_timer].hits = hits;
> > +	}
> 
> That's a pulse-density-modulator, with a signal bound of:
> 
>   1024 == x/8 -> x := 8192
> 
> Anyway; I would suggest s/SPIKE/PULSE/ because of that.

OK
