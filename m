From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Wed, 19 May 2010 00:29:04 +0200
Message-ID: <201005190029.05056.rjw__14186.8842569695$1274221745$gmane$org@sisk.pl>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005182052.28778.rjw@sisk.pl>
	<87y6fgn9y1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87y6fgn9y1.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 19 May 2010, Kevin Hilman wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> =

> > On Tuesday 18 May 2010, Kevin Hilman wrote:
> >> Arve Hj=F8nnev=E5g <arve@android.com> writes:
> >> =

> >> >
> >> > PM: Opportunistic suspend support.
> >> >
> >> > Power management features present in the current mainline kernel are
> >> > insufficient to get maximum possible energy savings on some platform=
s,
> >> > such as Android, because low power states can only safely be entered
> >> > from idle.  Suspend, in its current form, cannot be used, since wake=
up
> >> > events that occur right after initiating suspend will not be process=
ed
> >> > until another possibly unrelated event wake up the system again.
> >> =

> >> I think the problems with wakeups in the current suspend path need to
> >> be described in more detail.  In particular, why check_wakeup_irqs()
> >> is not enough etc.
> >
> > That one is really easy.: because some (the majority of?) architectures
> > don't even implement it.
> =

> OK, then this problem will still in traditional suspend even after
> this series, so calling it out as a the problem to be solved but not
> fixing it doesn't seem right.
> =

> This problem needs an independent fix, namely implementing
> check_wakeup_irqs().

No, it is not.  There's nothing like wake-up interrupts on (ACPI-based) x86=
 PCs.
 =

> That being said, what exactly is there for architectures to implement
> for check_wakeup_irqs()?  IIUC, this all handled by genirq as long as
> deferred disable (now the default) is used?

No.  Wakeup IRQs cause the system to wake up from sleep states.  On a PC
the only interrupts that can do that are PCIe root port PME interrupts, but
they are not really "device" interrupts (ie. they come from a source that is
different from a device signaling wakeup).

> I suspect the platforms that Android currently cares about already
> have this functionality.  At least OMAP does already.

ISTR there is an x86 Android port, so not all of them.  Although that really
doesn't matter.

> >> > On some systems idle combined with runtime PM can enter the same pow=
er
> >> > state as suspend, but periodic wakeups increase the average power
> >> > consumption. Suspending the system also reduces the harm caused by
> >> > apps that never go idle. On other systems suspend can enter a much
> >> > lower power state than idle.
> >> >
> >> > To allow Android and similar platforms to save more energy than they
> >> > currently can save using the mainline kernel, we introduce a mechani=
sm
> >> > by which the system is automatically suspended (i.e. put into a
> >> > system-wide sleep state) whenever it's not doing useful work, called
> >> > opportunistic suspend.
> >> =

> >> A definition of "useful work" here would provide clarity and would
> >> also help clarify by what criteria other on-going work is determined
> >> to be not useful.
> >
> > Probably "useful" is not the right word here.  I guess it's more like
> > "work that can be deferred without visible impact on functionality".
> =

> OK, then a definition of "visible impact on functionality" should be
> provided and the critera for determining that.
> =

> I know this sounds like splitting hairs,

Yes, it does.

> but what I'm getting at is that this series implements a brand new method
> for making decisions about when the system is idle.

Since we are splitting hairs, I'd be rather cautious about the word "idle".
It would be safer to say "when the system is not doing anything the user
really cares about at the moment and therefore it may be suspended".

That actually is the whole point of the patch series.

> That fact should be clearly stated and the criteria for making this decis=
ion
> should be clearly described.

Well, suspend blockers are the tool to define the criteria.

Thanks,
Rafael
