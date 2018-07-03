From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle:powernv: Add the CPUIDLE_FLAG_POLLING for snooze
Date: Tue, 3 Jul 2018 20:33:48 +0530
Message-ID: <20180703150348.GA13348@in.ibm.com>
References: <1530595456-32352-1-git-send-email-ego@linux.vnet.ibm.com>
 <20180703140616.GA13660@drishya.in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180703140616.GA13660@drishya.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, akshay.adiga@linux.vnet.ibm.com, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 03, 2018 at 07:36:16PM +0530, Vaidyanathan Srinivasan wrote:
> * Gautham R Shenoy <ego@linux.vnet.ibm.com> [2018-07-03 10:54:16]:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > In the situations where snooze is the only cpuidle state due to
> > firmware not exposing any platform idle states, the idle CPUs will
> > remain in snooze for a long time with interrupts disabled causing the
> > Hard-lockup detector to complain.
> 
> snooze_loop() will spin in SMT low priority with interrupt enabled. We
> have local_irq_enable() before we get into the snooze loop.
> Since this is a polling state, we should wakeup without an interrupt
> and hence we set TIF_POLLING_NRFLAG as well.
>

You are right. We have a local_irq_enable() inside the snooze_loop.


> 
> > watchdog: CPU 51 detected hard LOCKUP on other CPUs 59
> > watchdog: CPU 51 TB:535296107736, last SMP heartbeat TB:527472229239 (15281ms ago)
> > watchdog: CPU 59 Hard LOCKUP
> > watchdog: CPU 59 TB:535296252849, last heartbeat TB:526554725466 (17073ms ago)
> 
> hmm.. not sure why watchdog will complain, maybe something more is
> going on.

Will look into this Vaidy.

> 
> > Fix this by adding CPUIDLE_FLAG_POLLING flag to the state, so that the
> > cpuidle governor will do the right thing, such as not stopping the
> > tick if it is going to put the idle cpu to snooze.
> > 
> > Reported-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  drivers/cpuidle/cpuidle-powernv.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> > index d29e4f0..b73041b 100644
> > --- a/drivers/cpuidle/cpuidle-powernv.c
> > +++ b/drivers/cpuidle/cpuidle-powernv.c
> > @@ -156,6 +156,7 @@ static int stop_loop(struct cpuidle_device *dev,
> >  	{ /* Snooze */
> >  		.name = "snooze",
> >  		.desc = "snooze",
> > +		.flags = CPUIDLE_FLAG_POLLING,
> >  		.exit_latency = 0,
> >  		.target_residency = 0,
> >  		.enter = snooze_loop },
> 
> Adding the CPUIDLE_FLAG_POLLING is good and enables more optimization.
> But the reason that we spin with interrupt disabled does not seem
> right.


Fair point. 
> 
> --Vaidy
> 
