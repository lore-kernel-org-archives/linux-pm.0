From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Mon, 23 Feb 2009 23:23:24 +0100
Message-ID: <200902232323.25583.rjw@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200902221839.50357.rjw@sisk.pl>
	<d6200be20902231411s654f8b3csf1388a97f3f94ac4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902231411s654f8b3csf1388a97f3f94ac4@mail.gmail.com>
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

On Monday 23 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Sun, Feb 22, 2009 at 9:39 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Introduce two helper functions allowing us to disable device
> > interrupts (at the IO-APIC level) during suspend or hibernation
> > and enable them during the subsequent resume, respectively, so that
> > the timer interrupts are enabled while "late" suspend callbacks and
> > "early" resume callbacks provided by device drivers are being
> > executed.
> >
> > Use these functions to rework the handling of interrupts during
> > suspend (hibernation) and resume.  Namely, interrupts will only be
> > disabled on the CPU right before suspending sysdevs, while device
> > interrupts will be disabled (at the IO-APIC level), with the help of
> > the new helper function, before calling "late" suspend callbacks
> > provided by device drivers and analogously during resume.
> >
> =

> What impact does this have on wakeup interrupts? Unless you add a
> check, after masking all interrupt at the CPU, to abort suspend if any
> wakeup interrupt has IRQ_PENDING set I think you will loose wakeup
> interrupts (at least for irqs that use default_disable).

I _think_ they would have to be reenabled after we've called
local_irq_disable().

Thanks,
Rafael
