From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Tue, 18 May 2010 15:03:57 -0700
Message-ID: <AANLkTin-A5eXvxDEo-vi2x2jjXtZbAl2526w62noNMIK__16400.2087935389$1274220369$gmane$org@mail.gmail.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005182113.10448.rjw@sisk.pl>
	<AANLkTinPC94F1wj-CEb3vvSo7__u625DsZxErlmTymEw@mail.gmail.com>
	<201005182348.16026.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005182348.16026.rjw@sisk.pl>
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
> On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> 2010/5/17 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> > On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> >> 2010/5/14 Rafael J. Wysocki <rjw@sisk.pl>:
>> >> >> > On Friday 14 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> >> >> This patch series adds a suspend-block api that provides the sa=
me
>> >> >> >> functionality as the android wakelock api. This version has some
>> >> >> >> changes from, or requested by, Rafael. The most notable changes=
 are:
>> >> >> >> - DEFINE_SUSPEND_BLOCKER and suspend_blocker_register have been=
 added
>> >> >> >> =A0 for statically allocated suspend blockers.
>> >> >> >> - suspend_blocker_destroy is now called suspend_blocker_unregis=
ter
>> >> >> >> - The user space mandatory _INIT ioctl has been replaced with an
>> >> >> >> =A0 optional _SET_NAME ioctl.
>> >> >> >>
>> >> >> >> I kept the ack and reviewed by tags on two of the patches even =
though
>> >> >> >> there were a few cosmetic changes.
>> >> >> >
>> >> >> > Thanks for the patches, I think they are in a pretty good shape =
now.
>> >> >> >
>> >> >> > That said, I'd like the changelogs to be a bit more descriptive,=
 at least for
>> >> >> > patch [1/8]. =A0I think it should explain (in a few words) what =
the purpose of
>> >> >> > the feature is and what problems it solves that generally a comb=
ination of
>> >> >> > runtime PM and cpuidle is not suitable for in your opinion. =A0I=
OW, why you
>> >> >> > think we need that feature.
>> >> >> >
>> >> >>
>> >> >> How about:
>> >> >>
>> >> >> PM: Add opportunistic suspend support.
>> >> >
>> >> > "PM: Opportunistic suspend support" would be sufficient IMO.
>> >> >
>> >> > Now, I'd start with the motivation. =A0Like "Power management featu=
res present
>> >> > in the current mainline kernel are insufficient to get maximum poss=
ible energy
>> >> > savings on some platforms, such as Android, because ..." (here go e=
xplanations
>> >> > why this is the case in your opinion).
>> >> >
>> >> > Next, "To allow Android and similar platforms to save more energy t=
han they
>> >> > currently can save using the mainline kernel, introduce a mechanism=
 by which
>> >> > the system is automatically suspended (i.e. put into a system-wide =
sleep state)
>> >> > whenever it's not doing useful work, called opportunistic suspend".
>> >> >
>> >> > "For this purpose introduce the suspend blockers framework allowing=
 the
>> >> > kernel's power management subsystem to decide when it is desirable =
to suspend
>> >> > the system (i.e. when useful work is not being done). =A0Add an API=
 that ..."
>> >> >
>> >>
>> >> PM: Opportunistic suspend support.
>> >>
>> >> Power management features present in the current mainline kernel are
>> >> insufficient to get maximum possible energy savings on some platforms,
>> >> such as Android, because low power states can only safely be entered
>> >> from idle.
>> >
>> > Do you mean CPU low-power states or system low-power states here?
>> >
>> I think either.
>
> The statement is not true for system low-power states (or sleep states),
> because generally (ie. on many platforms) they aren't entered from idle.
> Suspend is for entering them.
>
I don't think that makes my statement false. If you can only safely
enter low power states from idle, but some low power states cannot be
entered from idle, then it follows that you cannot safely enter those
low power states.

> So, there is a difference and the explanation can go like this: "... to a=
chieve
> maximum energy savings one has to put all I/O devices and the CPU into
> low-power states, but the CPU can only be put into a low-power state from
> idle. =A0This, in turn, means that the CPU leaves the low-power state on
> interrupts triggered by periodic timers and user space processes that use
> polling. =A0It turns out, however, that many of these events causing the =
CPU to
> leave the low-power state aren't essential for the desired system functio=
nality
> and from the power management point of view it would be better if they di=
dn't
> occur".

This only explain why we still want to use suspend on systems that can
enter the same power states from idle and suspend.

>
>> > I'd add more details here, because it may not be completely clear to t=
he
>> > (interested) reader why entering these states only from idle affects t=
he
>> > possibility to achieve maximum energy savings. =A0I _guess_ you mean t=
hat
>> > using idle is not sufficient, because there are so many wakeups on the
>> > systems in question that more savings are still possible. =A0Is that c=
orrect?
>> >
>> Yes, is this not what the next paragraph explains?
>
> Well, it doesn't explain that. =A0It explains why idle + runtime PM is ge=
nerally
> insufficient and is using that as an argument (at least in my view).
>
>> >> Suspend, in its current form, cannot be used, since wakeup
>> >> events that occur right after initiating suspend will not be processed
>> >> until another possibly unrelated event wake up the system again.
>> >
>> > I think the word "cannot" is too strong here. =A0I'd say "not suitable=
" instead
>>
>> I don't think it is too strong, but I can change it.
>>
>> > and I'd say what kind of wakeup events I meant more precisely (there a=
re
>> > events that wake up a CPU from idle and events that wake up the system=
 from
>> > suspend).
>>
>> When I say wakeup events I mean events that do both. Is there another
>> term for this, or should I just add: "since wakeup events (events that
>> wake the CPU from idle and the system from suspend)..."
>
> Yes, that would clarify things IMO.
>
> Thanks,
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



-- =

Arve Hj=F8nnev=E5g
