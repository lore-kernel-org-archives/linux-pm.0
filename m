From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Thu, 26 Feb 2009 22:58:54 +0100
Message-ID: <200902262258.55835.rjw__4581.84631211243$1235685769$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200902261050.50531.rjw@sisk.pl>
	<d6200be20902261234i5a3896fo78a7f56d16a247c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902261234i5a3896fo78a7f56d16a247c7@mail.gmail.com>
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
> On Thu, Feb 26, 2009 at 1:50 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday 26 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> On Tue, Feb 24, 2009 at 3:29 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > BTW, appended is the current (3rd) version of the $subject patch wit=
h some
> >> > of your comments taken into account.  In particular, I did the follo=
wing:
> >> > - moved [suspend|resume]_device_irqs() to a separate file (pm.c)
> >> > - fixed interrupt.h so that their headers are at a better place
> >> > - made enable_irq() clear IRQ_SUSPENDED
> >> > - made device_power_down() and device_power_up() call
> >> >  suspend_device_irqs() and resume_device_irqs(), respectively, which
> >> >  simplified the callers quite a bit (it changed the Xen code orderin=
g, though,
> >> >  but I _think_ it still should work).
> >>
> >> Do you plan to fix edge triggered wakeup interrupts? It still looks
> >> like edge triggered wakeup interrupts that occur between
> >> suspend_device_irqs and local_irq_disable will not cause a wakeup.
> >
> > In the current version of the patch the interrupts that have IRQ_WAKEUP=
 set
> > in status are not disabled.  Is this not enough?
> =

> That is enough for drivers that use wakelocks to abort suspend (if I
> fix the wakelock code to not use a platform device as its last abort
> point). It is not enough if you don't have wakelocks, since the
> interrupt can occur after suspend_late has been called and the driver
> has no way to abort suspend.

Well, how exactly the $subject patch does cause this problem to happen?

Rafael
