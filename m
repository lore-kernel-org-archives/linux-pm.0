From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/10] PM: Rework handling of interrupts
	during suspend-resume (rev. 5)
Date: Wed, 11 Mar 2009 23:01:50 +0100
Message-ID: <200903112301.51594.rjw@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903112159.21166.rjw@sisk.pl>
	<alpine.LFD.2.00.0903112238280.29264@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0903112238280.29264@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 11 March 2009, Thomas Gleixner wrote:
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

Agreed.

> > >   Can we please move the fiddling with desc->* into
> > >   kernel/irq/manage.c and share the code there ?
> > 
> > Can you please discuss that with Ingo?  I moved that from manage.c at his
> > request.
> 
> Hmrpf. Will do. I just want to avoid that we have scattered functions
> which deal with the guts of the irq code all over the place.

I understand your concern, I'd prefer to avoid that too.

> I'm fine with your loop in irq/pm.c, but the actual handling of the irq
> internals should remain in manage.c.

Well, perhaps we can add a parameter to disable_irq_nosync() telling it not
to disable the interrupt if it's a timer one?  Something like

void disable_irq_nosync(unsigned int irq, bool skip_timer) etc.?

Also, it could return a value meaning whether or not the interrupt has been
actually disabled.

> I'll have a closer look how to solve this.

Thanks!

Best,
Rafael
