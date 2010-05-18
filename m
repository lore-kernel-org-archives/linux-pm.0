From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Mon, 17 May 2010 17:52:46 -0700
Message-ID: <AANLkTilQ5wZ_7fMyDMpUBCtu9oD1Wh22JGllyS1EPlxB@mail.gmail.com>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005142308.48386.rjw@sisk.pl>
	<AANLkTilX0uhqrJtUSOC4smdH1M8V-h14J7YtRG4PPxOQ@mail.gmail.com>
	<201005172342.52660.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005172342.52660.rjw@sisk.pl>
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

2010/5/17 Rafael J. Wysocki <rjw@sisk.pl>:
> On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/5/14 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Friday 14 May 2010, Arve Hj=F8nnev=E5g wrote:
>> >> This patch series adds a suspend-block api that provides the same
>> >> functionality as the android wakelock api. This version has some
>> >> changes from, or requested by, Rafael. The most notable changes are:
>> >> - DEFINE_SUSPEND_BLOCKER and suspend_blocker_register have been added
>> >> =A0 for statically allocated suspend blockers.
>> >> - suspend_blocker_destroy is now called suspend_blocker_unregister
>> >> - The user space mandatory _INIT ioctl has been replaced with an
>> >> =A0 optional _SET_NAME ioctl.
>> >>
>> >> I kept the ack and reviewed by tags on two of the patches even though
>> >> there were a few cosmetic changes.
>> >
>> > Thanks for the patches, I think they are in a pretty good shape now.
>> >
>> > That said, I'd like the changelogs to be a bit more descriptive, at le=
ast for
>> > patch [1/8]. =A0I think it should explain (in a few words) what the pu=
rpose of
>> > the feature is and what problems it solves that generally a combinatio=
n of
>> > runtime PM and cpuidle is not suitable for in your opinion. =A0IOW, wh=
y you
>> > think we need that feature.
>> >
>>
>> How about:
>>
>> PM: Add opportunistic suspend support.
>
> "PM: Opportunistic suspend support" would be sufficient IMO.
>
> Now, I'd start with the motivation. =A0Like "Power management features pr=
esent
> in the current mainline kernel are insufficient to get maximum possible e=
nergy
> savings on some platforms, such as Android, because ..." (here go explana=
tions
> why this is the case in your opinion).
>
> Next, "To allow Android and similar platforms to save more energy than th=
ey
> currently can save using the mainline kernel, introduce a mechanism by wh=
ich
> the system is automatically suspended (i.e. put into a system-wide sleep =
state)
> whenever it's not doing useful work, called opportunistic suspend".
>
> "For this purpose introduce the suspend blockers framework allowing the
> kernel's power management subsystem to decide when it is desirable to sus=
pend
> the system (i.e. when useful work is not being done). =A0Add an API that =
..."
>

PM: Opportunistic suspend support.

Power management features present in the current mainline kernel are
insufficient to get maximum possible energy savings on some platforms,
such as Android, because low power states can only safely be entered
from idle. Suspend, in its current form, cannot be used, since wakeup
events that occur right after initiating suspend will not be processed
until another possibly unrelated event wake up the system again.

On some systems idle combined with runtime PM can enter the same power
state as suspend, but periodic wakeups increase the average power
consumption. Suspending the system also reduces the harm caused by
apps that never go idle. On other systems suspend can enter a much
lower power state than idle.

To allow Android and similar platforms to save more energy than they
currently can save using the mainline kernel, we introduce a mechanism
by which the system is automatically suspended (i.e. put into a
system-wide sleep state) whenever it's not doing useful work, called
opportunistic suspend.

For this purpose introduce the suspend blockers framework allowing the
kernel's power management subsystem to decide when it is desirable to
suspend the system (i.e. when useful work is not being done). Add an
API that that drivers can use to block opportunistic suspend. This is
needed to avoid losing wakeup events that occur right after suspend is
initiated.

Adds /sys/power/policy that selects the behavior of /sys/power/state.
After setting the policy to opportunistic, writes to /sys/power/state
become non-blocking requests that specify which suspend state to enter
when no suspend blockers are active. A special state, "on", stops the
process by activating the "main" suspend blocker.


>> Adds a suspend block api that drivers can use to block opportunistic
>> suspend. This is needed to avoid losing wakeup events that occur
>> right after suspend is initiated.
>>
>> Adds /sys/power/policy that selects the behaviour of /sys/power/state.
>> After setting the policy to opportunistic, writes to /sys/power/state
>> become non-blocking requests that specify which suspend state to enter
>> when no suspend blockers are active. A special state, "on", stops the
>> process by activating the "main" suspend blocker.
>>
>> Opportunistic suspend is most useful on systems that cannot enter their
>> lowest power state from idle, but it is also useful on systems that enter
>> the same power state from idle and suspend. Periodic timers can cause
>> a significant power drain on these systems, and suspend will stop most
>> of this. Opportunistic suspend can also reduce the harm caused by apps
>> that never go idle.
>>
>> > The changelog of patch [2/8] appears to be outdated, that needs to be =
fixed.
>> > Also, it would be nice to explain in the changelog what the interface =
is needed
>> > for (in terms of the problems that it helps to handle).
>> >
>>
>> How about:
>>
>> PM: suspend_block: Add driver to access suspend blockers from user-space
>>
>> Add a misc device, "suspend_blocker", that allows user-space processes
>> to block auto suspend.
>
> "automatic suspend" would be better IMO.
>
>> Opening this device creates a suspend_blocker.
>
> "suspend blocker that can be used by the opener to prevent automatic susp=
end
> from occuring. =A0There are ioctls provided for blocking and unblocking s=
uspend
> and for giving the suspend blocker a meaningful name. =A0Closing the devi=
ce
> special file causes the suspend blocker to be destroyed."
>
>> ioctls are provided to name this suspend_blocker, and to block and unblo=
ck
>> suspend. To delete the suspend_blocker, close the device.
>>
>> For example, when select or poll indicates that input event are availabl=
e, this
>> interface can be used to block suspend before reading those event. This =
allows
>> the input driver to release its suspend blocker as soon as the event que=
ue is
>> empty.
>
> I think you should explain in more detail how suspend blockers used by us=
er
> space make that possible.
>


PM: suspend_block: Add driver to access suspend blockers from user-space

Add a misc device, "suspend_blocker", that allows user-space processes
to block automatic suspend.

Opening this device creates a suspend blocker that can be used by the
opener to prevent automatic suspend from occurring.  There are ioctls
provided for blocking and unblocking suspend and for giving the
suspend blocker a meaningful name.  Closing the device special file
causes the suspend blocker to be destroyed.

For example, when select or poll indicates that input event are
available, this interface can be used by user space to block suspend
before it reads those events. This allows the input driver to release
its suspend blocker as soon as the event queue is empty. If user space
could not use a suspend blocker here the input driver would need to
delay the release of its suspend blocker until it knows (or assumes)
that user space has finished processing the events.

By careful use of suspend blockers in drivers and user space system
code, one can arrange for the system to stay awake for extremely short
periods of time in reaction to events, rapidly returning to a fully
suspended state.

-- =

Arve Hj=F8nnev=E5g
