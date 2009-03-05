From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Update,
	rev. 5] Re: [RFC][PATCH 1/4] PM: Rework handling of	interrupts
	during suspend-resume (rev. 4)
Date: Thu, 5 Mar 2009 11:35:24 +0100
Message-ID: <20090305103524.GC32407__46744.314072612$1236249672$gmane$org@elte.hu>
References: <200902221837.49396.rjw@sisk.pl> <200903030027.13884.rjw@sisk.pl>
	<d6200be20903031456r7caa3c42qa7c31dc74768449c@mail.gmail.com>
	<200903042303.30357.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200903042303.30357.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> On Tuesday 03 March 2009, Arve Hj=F8nnev=E5g wrote:
> > On Mon, Mar 2, 2009 at 3:27 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > On Tuesday 03 March 2009, Arve Hj=F8nnev=E5g wrote:
> > >> On Mon, Mar 2, 2009 at 3:13 PM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
> > >> > On Tuesday 03 March 2009, Arve Hj=F8nnev=E5g wrote:
> > >> >> On Sun, Mar 1, 2009 at 2:24 PM, Rafael J. Wysocki <rjw@sisk.pl> w=
rote:
> [--snip--]
> > > Can you show me a _single_ _driver_ currently in the tree doing somet=
hing
> > > like you describe in suspend_late and resume_early?  If you can't, th=
en please
> > > give up.
> > =

> > I don't know if any drivers call disable_irq or enable_irq in their
> > suspend hooks, but your change also allow timers, and I assume kernel
> > threads, to run during this phase.
> > =

> > There are several drivers (keypad drivers in particular), in tree and
> > out of tree, that call enable_irq from timers, and disable_irq from
> > their interrupt handler. If you also apply your later change to
> > disable non boot cpus after suspend_device_irqs, then on smp systems
> > the interrupt handler may run at the same time as suspend_device_irqs.
> > If suspend_device_irqs gets the spinlock first, then IRQ_SUSPENDED
> > gets set. If another suspend/resume cycle happens before the timer
> > runs, you will incorrectly enable the interrupt.
> =

> Well, unfortunately this is a valid point IMO.  I've been thinking for qu=
ite a
> while how to fix it nicely, but I'm not sure if there is a nice fix.
> =

> Below is an updated patch, hopefully everyone will be fine with it.
> =

> Ingo, is making __enable_irq() an extern function acceptable?

Sure, that's fine - it's a genirq internal function still =

between kernel/irq/manage.c and kernel/irq/pm.c.

	Ingo
