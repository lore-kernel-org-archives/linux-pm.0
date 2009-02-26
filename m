From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Fri, 27 Feb 2009 00:10:35 +0100
Message-ID: <200902270010.38291.rjw__38214.4753275954$1235690100$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0902261404580.3111@localhost.localdomain>
	<d6200be20902261430w19ea3e6fye014f8443d9ab5ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902261430w19ea3e6fye014f8443d9ab5ca@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 26 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Thu, Feb 26, 2009 at 2:10 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >
> > On Thu, 26 Feb 2009, Rafael J. Wysocki wrote:
> >>
> >> Well, how exactly the $subject patch does cause this problem to happen?
> >
> > Rafael, the problem is that if an interrupt happens while it's disabled=
 -
> > but before the CPU has actually turned all interrupts off - the CPU will
> > ACK the interrupt (but just set a flag for it being PENDING), so now the
> > chipset logic around it will not see it as pending any more, so now the
> > chipset won't auto-wake the CPU immediately (or more likely, it won't
> > even suspend it).
> >
> > It's trivial to fix multiple ways, so I wouldn't worry. The most trivial
> > way is to just have some sysdev drievr code simply do something like
> >
> >  static int sysdev_suspend()
> >  {
> >        for_each_irq(irq,desc) {
> >                if (!(desc->flags & IRQF_WAKE))
> >                        continue;
> >                if (desc->flags & IRQ_PENDING)
> >                        return -EBUSY;
> >        }
> >        return 0;
> >  }
> >
> > and that should automatically mean that if any irq is pending, the susp=
end
> > will fail and we'll immediately wake up again.
> >
> > It looks trivial, and I don't understand why Arve can't just do the sys=
dev
> > thing.
> =

> I can. My point is that the patch breaks our existing code.

Is that a mainline kernel code?

> If anyone else uses edge triggered wakeup interrupt it may break from the=
m as
> well. The main question if this should be fixed separately for every
> platform that needs it, or if pending wakeup interrupts should always
> abort sleep.

Well, I'm not really sure if this is the problem.  In fact the problem is t=
hat
you have a regular device the interrupt of which can be a wake-up one.  I t=
hink
the problem wouldn't have existed at all if it had been a sysdev.  Is that
correct?

Rafael
