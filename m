From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Tue, 18 May 2010 15:52:12 -0700
Message-ID: <AANLkTime0yZ_t32m8WjqJEtSeNlBJYZy15X8HwKzMqOl__17310.067106928$1274223296$gmane$org@mail.gmail.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005182348.16026.rjw@sisk.pl>
	<AANLkTin-A5eXvxDEo-vi2x2jjXtZbAl2526w62noNMIK@mail.gmail.com>
	<201005190034.26085.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005190034.26085.rjw@sisk.pl>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> On Wednesday 19 May 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> > On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> >> 2010/5/17 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> >> > On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> >> >> 2010/5/14 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> >> >> > On Friday 14 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> >> >> >> This patch series adds a suspend-block api that provides the=
 same
>> >> >> >> >> functionality as the android wakelock api. This version has =
some
>> >> >> >> >> changes from, or requested by, Rafael. The most notable chan=
ges are:
>> >> >> >> >> - DEFINE_SUSPEND_BLOCKER and suspend_blocker_register have b=
een added
>> >> >> >> >> =A0 for statically allocated suspend blockers.
>> >> >> >> >> - suspend_blocker_destroy is now called suspend_blocker_unre=
gister
>> >> >> >> >> - The user space mandatory _INIT ioctl has been replaced wit=
h an
>> >> >> >> >> =A0 optional _SET_NAME ioctl.
>> >> >> >> >>
>> >> >> >> >> I kept the ack and reviewed by tags on two of the patches ev=
en though
>> >> >> >> >> there were a few cosmetic changes.
>> >> >> >> >
>> >> >> >> > Thanks for the patches, I think they are in a pretty good sha=
pe now.
>> >> >> >> >
>> >> >> >> > That said, I'd like the changelogs to be a bit more descripti=
ve, at least for
>> >> >> >> > patch [1/8]. =A0I think it should explain (in a few words) wh=
at the purpose of
>> >> >> >> > the feature is and what problems it solves that generally a c=
ombination of
>> >> >> >> > runtime PM and cpuidle is not suitable for in your opinion. =
=A0IOW, why you
>> >> >> >> > think we need that feature.
>> >> >> >> >
>> >> >> >>
>> >> >> >> How about:
>> >> >> >>
>> >> >> >> PM: Add opportunistic suspend support.
>> >> >> >
>> >> >> > "PM: Opportunistic suspend support" would be sufficient IMO.
>> >> >> >
>> >> >> > Now, I'd start with the motivation. =A0Like "Power management fe=
atures present
>> >> >> > in the current mainline kernel are insufficient to get maximum p=
ossible energy
>> >> >> > savings on some platforms, such as Android, because ..." (here g=
o explanations
>> >> >> > why this is the case in your opinion).
>> >> >> >
>> >> >> > Next, "To allow Android and similar platforms to save more energ=
y than they
>> >> >> > currently can save using the mainline kernel, introduce a mechan=
ism by which
>> >> >> > the system is automatically suspended (i.e. put into a system-wi=
de sleep state)
>> >> >> > whenever it's not doing useful work, called opportunistic suspen=
d".
>> >> >> >
>> >> >> > "For this purpose introduce the suspend blockers framework allow=
ing the
>> >> >> > kernel's power management subsystem to decide when it is desirab=
le to suspend
>> >> >> > the system (i.e. when useful work is not being done). =A0Add an =
API that ..."
>> >> >> >
>> >> >>
>> >> >> PM: Opportunistic suspend support.
>> >> >>
>> >> >> Power management features present in the current mainline kernel a=
re
>> >> >> insufficient to get maximum possible energy savings on some platfo=
rms,
>> >> >> such as Android, because low power states can only safely be enter=
ed
>> >> >> from idle.
>> >> >
>> >> > Do you mean CPU low-power states or system low-power states here?
>> >> >
>> >> I think either.
>> >
>> > The statement is not true for system low-power states (or sleep states=
),
>> > because generally (ie. on many platforms) they aren't entered from idl=
e.
>> > Suspend is for entering them.
>> >
>> I don't think that makes my statement false. If you can only safely
>> enter low power states from idle, but some low power states cannot be
>> entered from idle, then it follows that you cannot safely enter those
>> low power states.
>
> Define "safely", then.
>
OK. Is this clearer:

Power management features present in the current mainline kernel are
insufficient to get maximum possible energy savings on some platforms,
such as Android, because some wakeup events must work at all times
which means that low power states can only safely be entered from idle.
Suspend, in its current form, cannot be used, since wakeup events that
occur right after initiating suspend will not be processed until another
possibly unrelated event wake up the system again.


>> > So, there is a difference and the explanation can go like this: "... t=
o achieve
>> > maximum energy savings one has to put all I/O devices and the CPU into
>> > low-power states, but the CPU can only be put into a low-power state f=
rom
>> > idle. =A0This, in turn, means that the CPU leaves the low-power state =
on
>> > interrupts triggered by periodic timers and user space processes that =
use
>> > polling. =A0It turns out, however, that many of these events causing t=
he CPU to
>> > leave the low-power state aren't essential for the desired system func=
tionality
>> > and from the power management point of view it would be better if they=
 didn't
>> > occur".
>>
>> This only explain why we still want to use suspend on systems that can
>> enter the same power states from idle and suspend.
>
> Sorry, I'm confused now. =A0Isn't that why you do that on Android?
>

Yes, but it is not the only reason to use opportunistic support. It is
way more important to have opportunistic suspend support if the
hardware can enter lower power states from suspend than idle.

> AFACS, your hardware is capable of doing that, isn't it?
>

The current hardware, yes, the hardware we started with, no.

-- =

Arve Hj=F8nnev=E5g
