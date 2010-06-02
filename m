From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Tue, 1 Jun 2010 18:10:42 -0700
Message-ID: <AANLkTikObnAZbyOxeYAhXcEbimO3XTTO-HlC9CD_HH6t__17617.4743021422$1275441155$gmane$org@mail.gmail.com>
References: <20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<20100601135102.GA8098@srcf.ucam.org>
	<1275426085.21962.967.camel@mulgrave.site>
	<201006020024.14220.rjw@sisk.pl>
	<1275431816.21962.1108.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275431816.21962.1108.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, mark.gross@intel.com, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 1, 2010 at 3:36 PM, James Bottomley <James.Bottomley@suse.de> w=
rote:
> On Wed, 2010-06-02 at 00:24 +0200, Rafael J. Wysocki wrote:
>> On Tuesday 01 June 2010, James Bottomley wrote:
>> > On Tue, 2010-06-01 at 14:51 +0100, Matthew Garrett wrote:
>> > > On Mon, May 31, 2010 at 04:21:09PM -0500, James Bottomley wrote:
>> > >
>> > > > You're the one mentioning x86, not me. =A0I already explained that=
 some
>> > > > MSM hardware (the G1 for example) has lower power consumption in S3
>> > > > (which I'm using as an ACPI shorthand for suspend to ram) than any
>> > > > suspend from idle C state. =A0The fact that current x86 hardware h=
as the
>> > > > same problem may be true, but it's not entirely relevant.
>> > >
>> > > As long as you can set a wakeup timer, an S state is just a C state =
with
>> > > side effects. The significant one is that entering an S state stops =
the
>> > > process scheduler and any in-kernel timers. I don't think Google car=
e at
>> > > all about whether suspend is entered through an explicit transition =
or
>> > > something hooked into cpuidle - the relevant issue is that they want=
 to
>> > > be able to express a set of constraints that lets them control wheth=
er
>> > > or not the scheduler keeps on scheduling, and which doesn't let them
>> > > lose wakeup events in the process.
>> >
>> > Exactly, so my understanding of where we currently are is:
>>
>> Thanks for the recap.
>>
>> > =A0 =A0 =A01. pm_qos will be updated to be able to express the android=
 suspend
>> > =A0 =A0 =A0 =A0 blockers as interactivity constraints (exact name TBD,=
 but
>> > =A0 =A0 =A0 =A0 probably /dev/cpu_interactivity)
>>
>> I think that's not been decided yet precisely enough. =A0I saw a few ide=
as
>> here and there in the thread, but which of them are we going to follow?
>
> Well, android only needs two states (block and don't block), so that
> gets translated as 2 s32 values (say 0 and INT_MAX). =A0I've seen defines
> like QOS_INTERACTIVE and QOS_NONE (or QOS_DRECKLY or QOS_MANANA) to
> describe these, but if all we're arguing over is the define name, that's
> progress.

I think we need separate state constraints for suspend and idle low
power modes. On the msm platform only a subset of the interrupts can
wake up from the low power mode, so we block the use if the low power
mode from idle while other interrupts are enabled. We do not block
suspend however if those interrupts are not marked as wakeup
interrupts. Most constraints that prevent suspend are not hardware
specific and should not prevent entering low power modes from idle. In
other words we may need to prevent low power idle modes while allowing
suspend, and we may need to prevent suspend while allowing low power
idle modes.

It would also be good to not have an implementation that gets slower
and slower the more clients you have. With binary constraints this is
trivial.

>
> The other piece they need is the suspend block name, which comes with
> the stats API, and finally we need to decide what the actual constraint
> is called (which is how the dev node gets its name) ...
>
>> > =A0 =A0 =A02. pm_qos will be updated to be callable from atomic context
>> > =A0 =A0 =A03. pm_qos will be updated to export statistics initially cl=
osely
>> > =A0 =A0 =A0 =A0 matching what suspend blockers provides (simple update=
 of the rw
>> > =A0 =A0 =A0 =A0 interface?)

4. It would be useful to change pm_qos_add_request to not allocate
anything so can add constraints from init functions that currently
cannot fail.

>> >
>> > After this is done, the current android suspend block patch becomes a
>> > re-expression in kernel space in terms of pm_qos, with the current
>> > userspace wakelocks being adapted by the android framework into pm_qos
>> > requirements expressed to /dev/cpu_interactivity (or whatever name is
>> > chosen). =A0Then opportunistic suspend is either a small add-on kernel
>> > patch they have in their tree to suspend when the interactivity
>> > constraint goes to NONE, or it could be done entirely by a userspace
>> > process. =A0Long term this could migrate to the freezer and suspend fr=
om
>> > idle approach as the various problem timers get fixed.
>> >
>> > I think the big unresolved issue is the stats extension. =A0For androi=
d,
>> > we need just a name written along with the value, so we have something
>> > to hang the stats off ... current pm_qos userspace users just write a
>> > value, so the name would be optional. =A0From the kernel, we probably =
just
>> > need an additional API that takes a stats name or NULL if none
>> > (pm_qos_add_request_named()?). =A0Then reading the stats could be done=
 by
>> > implementing a fops read routine on the misc device.
>>
>> Is the original idea of having that information in debugfs objectionable?
>
> Well ... debugfs is usually used to get around the sysfs rules. =A0In this
> case, pm_qos has a dev interface ... I don't specifically object to
> using debugfs, but I don't see any reason to forbid it from being a
> simple dev read interface either.
>

We don't currently have a dev interface for stats so this is not an
immediate requirement. The suspend blocker debugfs interface is just
as good as the proc interface we have for wakelocks.

-- =

Arve Hj=F8nnev=E5g
