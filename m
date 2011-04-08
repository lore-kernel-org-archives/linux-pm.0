From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2 2.6.37.stable] intel_idle: disable
 NHM/WSM HW C-state auto-demotion
Date: Fri, 08 Apr 2011 18:31:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1104081215120.27120@x980>
References: <alpine.LFD.2.02.1103222222490.10489@x980>
	<20110408131630.GA18525@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110408131630.GA18525@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

> > Hardware C-state auto-demotion is a mechanism where the HW overrides
> > the OS C-state request, instead demoting to a shallower state,
> > which is less expensive, but saves less power.
> > 
> > Modern Linux should generally get exactly the states it requests.
> > In particular, when a CPU is taken off-line, it must not be demoted, else
> > it can prevent the entire package from reaching deep C-states.
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=25252
> > 
> >  
> > +#define MSR_NHM_SNB_PKG_CST_CFG_CTL	0x000000e2
> > +#define NHM_C3_AUTO_DEMOTE		(1UL << 25)
> > +#define NHM_C1_AUTO_DEMOTE		(1UL << 26)
> > +
> ....
> > @@ -85,6 +86,12 @@ static int intel_idle(struct cpuidle_dev
> >  static struct cpuidle_state *cpuidle_state_table;
> >  
> >  /*
> > + * Hardware C-state auto-demotion may not always be optimal.
> > + * Indicate which enable bits to clear here.
> > + */
> > +static unsigned long long auto_demotion_disable_flags;
> 
> Why long long here, but long above?

long long here because MSR accesses are 64-bits, even on
32-bit builds.

UL above because it matches the style of the neighboring code.
The "UL" is purely cosmetic, of course.  Same code is generated
if it were "ULL" or left off entirely; as the LHS is 64-bit.

cheers,
Len Brown, Intel Open Source Technology Center
