From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: resume latency QoS support,
	unify suspend/resume into idle states
Date: Fri, 28 May 2010 02:59:02 -0700
Message-ID: <AANLkTilUULhXJ4LhOfb6FSdH9DsIdu3m2rCjiXwjsbET__32462.3416680426$1275040855$gmane$org@mail.gmail.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<AANLkTil6Bo7qZltbLzHJjIDyruKHFQEURpe5LPJEpTws@mail.gmail.com>
	<20100528092137.GD24058@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100528092137.GD24058@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, May 28, 2010 at 2:21 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Arve Hj?nnev?g <arve@android.com> wrote:
>
>> On Thu, May 27, 2010 at 3:23 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wro=
te:
>> > On Thu, 27 May 2010 23:09:49 +0100
>> > Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>> >
>> >> On Thu, May 27, 2010 at 11:08:06PM +0100, Alan Cox wrote:
>> >>
>> >> > This is I believe robust (and has been implemented on some non x86
>> >> > boxes). It depends on not forcing running tasks into suspend. That =
is the
>> >> > key.
>> >>
>> >> We've already established that ACPI systems require us to force runni=
ng
>> >> tasks into suspend. How do we avoid the race in that situation?
>> >
>> > Android phones do not have ACPI. Embedded platforms do not have ACPI. =
MID
>> > x86 devices do not have ACPI.
>>
>> Android does not only run on phones. It is possible that no android devi=
ces
>> have ACPI, but I don't know that for a fact. What I do know is that peop=
le
>> want to run Android on x86 hardware and supporting suspend could be very
>> benficial.
>
> (If there's a sane framework then we'll fix x86 to fit into it and will d=
eal
> with quirks.)
>
>> > I would imagine the existing laptops will handle power management limi=
ted
>> > by the functionality they have available. Just like any other piece of
>> > hardware.
>>
>> I think existing laptops (and desktops) can benefit from opportunistic
>> suspend support. If opportunistic suspend is used for auto-sleep after
>> inactivity instead of forced suspend, the user space suspend blocker api
>> will allow an application to delay this auto sleep until for instance a
>> download completes. This part could also be done with a user-space IPC c=
all,
>> but having a standard kernel interface for it may make it more common. A
>> less common case, but more critical, is RTC alarms. I know my desktops c=
an
>> wakeup at a specific time by programming an RTC alarm, but without suspe=
nd
>> blockers how do you ensure that the system does not suspend right after =
the
>> alarm triggered? I have a system that wakes up at specific times request=
ed
>> by my DVR application, but I cannot use this system for anything else un=
less
>> I manually turn off the DVR application's auto-sleep feature. With suspe=
nd
>> blockers and something like the android alarm driver, I could use this
>> system for more than one application that have scheduled tasks and it wo=
uld
>> be more usable for interactive applications.
>
> I really like the level of detail and care that went into suspend-blocker=
s,
> and i think the Android solution is very mature in terms of functionality
> offered to users.
>
> In terms of bringing this depth of functionality and control to the upstr=
eam
> kernel, what do you think about Alan's QoS scheme, described in:
>
> =A0 <20100528001514.28e593ef@lxorguk.ukuu.org.uk>
>
> ?
>
> It's in essence suspend-blockers on steroids. It consists of two main
> components:
>
> =A0- Unify the 'suspended' state into the regular chain of idle states, a=
nd
> =A0 create a single, coherent and transparent way we handle system idlene=
ss.
>
> =A0- Give apps a QoS attribute that allows them to express how long they =
can
> =A0 afford to wait for a wakeup. (A downloading app would set it to say 5=
0msecs,
> =A0 and thus the kernel would know it automatically which method of idlen=
ess is
> =A0 still achievable. If all currently running apps have a max(QoS) attri=
bute
> =A0 of infinite, then the kernel can suspend for an unlimited amount of t=
ime.)
>
> AFAICS, and i have read through your suspend-blocker usecases, this should
> handle all the usecases you listed - and some more. (please yell if that'=
s not
> so)
>
> Suspend-blockers are equivalent to: 'app sets idle QoS latency to 0 msecs=
'.
>
> (And on x86, for BIOS/CPU combos that allow it we can implement this sche=
me
> too.)
>
> Thoughts?

Tying the QoS attribute to apps does not work (all proposals I have
seen have race conditions), but replacing every suspend blocker with
unique QoS object will work, since is the same thing as what suspend
blockers provide. I think replacing suspend blockers with artificial
latency requirements is a bad idea though, since we use them to ensure
a specific level of functionality (tasks, timers and interrupts
operate normally). If we get a more generic constraint framework,
suspend blockers may possibly be absorbed by this, but I think the
current implementation is useful as is (it could even be useful to
someone working on a generic constraints framework).

-- =

Arve Hj=F8nnev=E5g
