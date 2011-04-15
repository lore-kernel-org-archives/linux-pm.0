From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2 2.6.37.stable] intel_idle: disable
 NHM/WSM HW C-state auto-demotion
Date: Fri, 15 Apr 2011 18:25:42 +0200
Message-ID: <20110415162542.GB22806@elf.ucw.cz>
References: <alpine.LFD.2.02.1103222222490.10489@x980>
	<20110408131630.GA18525@atrey.karlin.mff.cuni.cz>
	<alpine.LFD.2.02.1104081215120.27120@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1104081215120.27120@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > @@ -85,6 +86,12 @@ static int intel_idle(struct cpuidle_dev
> > >  static struct cpuidle_state *cpuidle_state_table;
> > >  
> > >  /*
> > > + * Hardware C-state auto-demotion may not always be optimal.
> > > + * Indicate which enable bits to clear here.
> > > + */
> > > +static unsigned long long auto_demotion_disable_flags;
> > 
> > Why long long here, but long above?
> 
> long long here because MSR accesses are 64-bits, even on
> 32-bit builds.
> 
> UL above because it matches the style of the neighboring code.
> The "UL" is purely cosmetic, of course.  Same code is generated
> if it were "ULL" or left off entirely; as the LHS is 64-bit.

Normally, if register is always 64bit, it should be u64.

And consistency should not be a reason to add misleading postfixes...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
