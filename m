From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 10/16] cpuidle: pseries: Convert to hotplug state machine
Date: Mon, 22 Aug 2016 21:04:04 +0200
Message-ID: <20160822190404.i56qlimrqkhozacn@linutronix.de>
References: <20160818125731.27256-1-bigeasy@linutronix.de>
 <20160818125731.27256-11-bigeasy@linutronix.de>
 <57BB23CB.2080908@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54420 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754650AbcHVTEO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2016 15:04:14 -0400
Content-Disposition: inline
In-Reply-To: <57BB23CB.2080908@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 2016-08-22 18:09:47 [+0200], Daniel Lezcano wrote:
> On 08/18/2016 02:57 PM, Sebastian Andrzej Siewior wrote:
> > Install the callbacks via the state machine.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 5811954809af..baecc4faf028 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -19,6 +19,7 @@ enum cpuhp_state {
> >  	CPUHP_MM_WRITEBACK_DEAD,
> >  	CPUHP_SOFTIRQ_DEAD,
> >  	CPUHP_NET_MVNETA_DEAD,
> > +	CPUHP_CPUIDLE_PSERIES_DEAD,
> 
> Can't we directly merge these into CPUHP_CPUIDLE_DEAD instead ? Or is it
> planned to be done separately ?

You mean CPUHP_CPUIDLE_DEAD instead of _PSERIES_DEAD and _POWERNV_DEAD?
We could do that but you would have to ensure that only one CPUIDLE
driver registers itself at a time and for those powerpc drivers it looks
like you could have two registered (not sure about ARM's little/big (if
you could have two of those later at run-time)).
For the ONLINE state we have dynamic allocation of IDs. If it is
possible to rework the code to use only ONLINE & PRE_DOWN instead of
DEAD then we wouldn't have this. I can't say at this point if we do
dynamic allocation of the DEAD IDs.

Sebastian
