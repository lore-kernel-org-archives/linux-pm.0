From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] cpuidle / sleep: Use broadcast timer for states that stop local timer
Date: Mon, 02 Mar 2015 23:28:50 +0100
Message-ID: <6302236.aVZ7nQWQdn@vostro.rjw.lan>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com> <89103967.z1sWWFaE6y@vostro.rjw.lan> <20150302162706.GB5515@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150302162706.GB5515@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Monday, March 02, 2015 04:27:06 PM Lorenzo Pieralisi wrote:
> On Mon, Mar 02, 2015 at 02:53:28PM +0000, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Commit 381063133246 (PM / sleep: Re-implement suspend-to-idle handling)
> > overlooked the fact that entering some sufficiently deep idle states
> > by CPUs may cause their local timers to stop and in those cases it
> > is necessary to switch over to a broadcase timer prior to entering
> 
> s/broadcase/broadcast

Yup, thanks!

> > the idle state.  If the cpuidle driver in use does not provide
> > the new ->enter_freeze callback for any of the idle states, that
> > problem affects suspend-to-idle too, but it is not taken into account
> > after the changes made by commit 381063133246.
> > 
> > Fix that by changing the definition of cpuidle_enter_freeze() and
> > re-arranging of the code in cpuidle_idle_call(), so the former does
> > not call cpuidle_enter() any more and the fallback case is handled
> > by cpuidle_idle_call() directly.
> > 
> > Fixes: 381063133246 (PM / sleep: Re-implement suspend-to-idle handling)
> > Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Minor comment below, otherwise on the 4-patch series:
> 
> Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> [...]
> 
> >  /**
> >   * cpuidle_enter_freeze - Enter an idle state suitable for suspend-to-idle.
> > + * @drv: cpuidle driver for the given CPU.
> > + * @dev: cpuidle device for the given CPU.
> >   *
> >   * If there are states with the ->enter_freeze callback, find the deepest of
> >   * them and enter it with frozen tick.  Otherwise, find the deepest state
> >   * available and enter it normally.
> 
> Comment above becomes stale so you should update it, other than that it
> seems fine.

Sure, I forgot to update it, thanks for pointing this out.

I'll queue up the two (with the above fixed) in my tree then.

Peter, any objections to this one and the [1/2]?

Rafael
