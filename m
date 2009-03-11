From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/10] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Wed, 11 Mar 2009 22:53:04 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903112251150.29264__18189.8241783076$1236808760$gmane$org@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200903112215.02445.rjw@sisk.pl>
	<alpine.LFD.2.00.0903112234530.29264@localhost.localdomain>
	<200903112250.10572.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903112250.10572.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, 11 Mar 2009, Rafael J. Wysocki wrote:

> On Wednesday 11 March 2009, Thomas Gleixner wrote:
> > On Wed, 11 Mar 2009, Rafael J. Wysocki wrote:
> > > On Wednesday 11 March 2009, Thomas Gleixner wrote:
> > > > > +			desc->status |= IRQ_SUSPENDED;
> > > > 
> > > >   This flag needs to be checked in __enable_irq().
> > > 
> > > [I overlooked this comment, sorry.]
> > > 
> > > Why does it?
> > 
> > To catch abuse and callers of enable_irq() when this flag is set.
> 
> Hmm.  This means you'd like to make enable_irq() fail if called with
> IRQ_SUSPENDED set, correct?
> 
> What if someone calls irq_disable() and then irq_enable() between
> suspend_device_irqs() and resume_device_irqs()?  That would be pointless, but
> surely not a bug?  Should irq_disable() also fail if IRQ_SUSPENDED is set?

I'm not worried about nested ones.

> Or should __enable_irq() only fail with IRQ_SUSPENDED set for desc->depth == 1?

At least it needs a WARN_ON() in that case. A very prominent one.

Thanks,

	tglx
