From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 17:39:17 -0700
Message-ID: <AANLkTikGDSzaENwg_0BAtsYf3ulGd_6sGPR30WsvUxMi__16975.954504642$1275698505$gmane$org@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu> <20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<201006050138.30859.rjw@sisk.pl>
	<alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006050148080.2933@localhost.localdomain>
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
Cc: tytso@mit.edu, Florian Mickler <florian@mickler.org>, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Neil Brown <neilb@suse.de>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 4, 2010 at 5:05 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Sat, 5 Jun 2010, Rafael J. Wysocki wrote:
>> I kind of agree here, so I'd like to focus a bit on that.
>>
>> Here's my idea in the very general terms:
>>
>> (1) Use the cgroup freezer to "suspend" the "untrusted" apps (ie. the on=
es
>> =A0 =A0 that don't use suspend blockers aka wakelocks in the Android wor=
ld) at the
>> =A0 =A0 point Android would normally start opportunistic suspend.
>
> There is an additional benefit to this approach:
>
> =A0 =A0 In the current android world a background task (e.g. download
> =A0 =A0 initiated before the screensaver kicked in) prevents the suspend,
> =A0 =A0 but that also means that the crapplications can still suck power
> =A0 =A0 completely unconfined.
>

Yes this can happen. It is usually only a big problem when you combine
an (trusted) application that has a bug that blocks suspend forever
with an application that wakes up too often for us to enter low power
idle modes.

> =A0 =A0 With the cgroup freezer you can "suspend" them right away and
> =A0 =A0 just keep the trusted background task(s) alive which allows us to
> =A0 =A0 go into deeper idle states instead of letting the crapplications
> =A0 =A0 run unconfined until the download finished and the suspend
> =A0 =A0 blocker goes away.
>

Yes this would be better, but I want it in addition to suspend, not
instead of it. It is also unclear if our user-space code could easily
make use of it since our trusted code calls into untrusted code.

>> (2) Allow the cpuidle framework to put CPUs into low-power states after =
the
>> =A0 =A0 "trusted" apps (ie. the ones that use suspend blockers in the An=
droid
>> =A0 =A0 world) have gone idle.
>>

As far as I know this is what we already have on hardware that supports it.

>> (3) Teach the cpuidle framework to schedule runtime suspend of I/O devic=
es
>> =A0 =A0 before idling the last CPU (*).
>>

I don't think we need this for android phones. We already put I/O
devices in low power modes when they are not in use.

>> (4) Design a mechanism to resume the I/O devices suspended in (3) so that
>> =A0 =A0 they are not powered up unnecessarily (that's going to be diffic=
ult as far
>> =A0 =A0 as I can see).
>>
>> This way, in principle, we should be able to save (at least almost) as m=
uch
>> energy as the opportunistic suspend currently used by Android, provided =
that
>> things will be capable of staying idle for extended periods of time.

The main reason we use suspend is that the system does not stay idle
for extened periods of time. If this gets fixed, and our if user-space
framework can deal with a subset of processes being frozen (this is a
big if) this solution may work, but it does not help us today.

>>
>> (*) That may require per-device PM QoS requirements to be used, in which=
 case
>> =A0 =A0 devices may even be suspended earlier if the PM QoS requirements=
 of all
>> =A0 =A0 of their users are met.
>>
>> I wonder what people think. =A0Is this realistic and if so, would it be =
difficult
>> to implement?
>
> I think it's realistic and not overly complicated to implement.
>

The kernel support can be easily implemented on most arm hardware, I
don't know if it can work on most existing x86 hardware. It does not
give us the same power savings as suspend with existing software, but
it can handle bad apps better (assuming you don't combine
opportunistic suspend and cgroup freezing). The biggest hurdle is how
to handle dependencies between processes that gets frozen and
processes that don't get frozen.

-- =

Arve Hj=F8nnev=E5g
