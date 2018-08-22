From: leo.yan@linaro.org
Subject: Re: [PATCH] cpuidle: menu: Retain tick when shallow state is selected
Date: Wed, 22 Aug 2018 20:03:30 +0800
Message-ID: <20180822120330.GB8949@leoy-ThinkPad-X240s>
References: <34910476.pgRhNDWo5t@aspire.rjw.lan>
 <20180822120200.GA8949@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180822120200.GA8949@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 22, 2018 at 08:02:00PM +0800, Leo Yan wrote:

[...]

> > +			if (!tick_nohz_tick_stopped()) {
> > +				/*
> > +				 * If the state selected so far is shallow,
> > +				 * waking up early won't hurt, so retain the
> > +				 * tick in that case and let the governor run
> > +				 * again in the next iteration of the loop.
> > +				 */
> > +				expected_interval = drv->states[idx].target_residency;
> > +				break;
> > +			}
> > +
> 
> This is reliable, how we can rely on a shallow idle state target
> residency to decide if need to stop a tick or not?

s/This is reliable/This isn't reliable

> 
> >  			/*
> >  			 * If the state selected so far is shallow and this
> >  			 * state's target residency matches the time till the
> > 
