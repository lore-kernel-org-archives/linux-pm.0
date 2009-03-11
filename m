From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/10] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Wed, 11 Mar 2009 23:45:48 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0903112342440.29264__34895.0517284267$1236812713$gmane$org@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl> <200903111036.02482.rjw@sisk.pl>
	<alpine.LFD.2.00.0903111106450.29264@localhost.localdomain>
	<200903112159.21166.rjw@sisk.pl>
	<alpine.LFD.2.00.0903112238280.29264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0903112238280.29264@localhost.localdomain>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 11 Mar 2009, Thomas Gleixner wrote:
> On Wed, 11 Mar 2009, Rafael J. Wysocki wrote:
> > On Wednesday 11 March 2009, Thomas Gleixner wrote:
> > > > +EXPORT_SYMBOL_GPL(suspend_device_irqs);
> > > 
> > >   I'm not too enthusiastic about this open coded implementation of
> > >   disable_irq() with slightly different semantics.
> > 
> > The difference in semantics is important IMO, otherwise I woulndn't have
> > done that.  In particular, IMO, the condition should be under the spinlock IMO
> > and I'd rather not synchronize all interrupts we don't really disable here.
> 
> I don't say that the difference is not relevant. But the code is
> almost the same and disable_irq() could have the sync_irq optimization
> as well.

Thought more about that. Avoiding the sync_irq() for irqs which have
no action associated is fine, but you need to catch the following case
as well:

   driver code calls disable_irq_nosyc() from the handler (which is
   still running)

   suspend code skips the sync due to depth > 0

The sync operation is not that expensive.

Thanks,

	tglx
