From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Wed, 19 May 2010 01:19:07 +0200
Message-ID: <201005190119.07710.rjw__12727.1967045546$1274224834$gmane$org@sisk.pl>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005190034.26085.rjw@sisk.pl>
	<AANLkTime0yZ_t32m8WjqJEtSeNlBJYZy15X8HwKzMqOl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTime0yZ_t32m8WjqJEtSeNlBJYZy15X8HwKzMqOl@mail.gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 19 May 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday 19 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> >> >> > On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> >> 2010/5/17 Rafael J. Wysocki <rjw@sisk.pl>:
> >> >> >> > On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> >> >> 2010/5/14 Rafael J. Wysocki <rjw@sisk.pl>:
> >> >> >> >> > On Friday 14 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> >> >> >> This patch series adds a suspend-block api that provides t=
he same
> >> >> >> >> >> functionality as the android wakelock api. This version ha=
s some
> >> >> >> >> >> changes from, or requested by, Rafael. The most notable ch=
anges are:
> >> >> >> >> >> - DEFINE_SUSPEND_BLOCKER and suspend_blocker_register have=
 been added
> >> >> >> >> >>   for statically allocated suspend blockers.
> >> >> >> >> >> - suspend_blocker_destroy is now called suspend_blocker_un=
register
> >> >> >> >> >> - The user space mandatory _INIT ioctl has been replaced w=
ith an
> >> >> >> >> >>   optional _SET_NAME ioctl.
> >> >> >> >> >>
> >> >> >> >> >> I kept the ack and reviewed by tags on two of the patches =
even though
> >> >> >> >> >> there were a few cosmetic changes.
> >> >> >> >> >
> >> >> >> >> > Thanks for the patches, I think they are in a pretty good s=
hape now.
> >> >> >> >> >
> >> >> >> >> > That said, I'd like the changelogs to be a bit more descrip=
tive, at least for
> >> >> >> >> > patch [1/8].  I think it should explain (in a few words) wh=
at the purpose of
> >> >> >> >> > the feature is and what problems it solves that generally a=
 combination of
> >> >> >> >> > runtime PM and cpuidle is not suitable for in your opinion.=
  IOW, why you
> >> >> >> >> > think we need that feature.
> >> >> >> >> >
> >> >> >> >>
> >> >> >> >> How about:
> >> >> >> >>
> >> >> >> >> PM: Add opportunistic suspend support.
> >> >> >> >
> >> >> >> > "PM: Opportunistic suspend support" would be sufficient IMO.
> >> >> >> >
> >> >> >> > Now, I'd start with the motivation.  Like "Power management fe=
atures present
> >> >> >> > in the current mainline kernel are insufficient to get maximum=
 possible energy
> >> >> >> > savings on some platforms, such as Android, because ..." (here=
 go explanations
> >> >> >> > why this is the case in your opinion).
> >> >> >> >
> >> >> >> > Next, "To allow Android and similar platforms to save more ene=
rgy than they
> >> >> >> > currently can save using the mainline kernel, introduce a mech=
anism by which
> >> >> >> > the system is automatically suspended (i.e. put into a system-=
wide sleep state)
> >> >> >> > whenever it's not doing useful work, called opportunistic susp=
end".
> >> >> >> >
> >> >> >> > "For this purpose introduce the suspend blockers framework all=
owing the
> >> >> >> > kernel's power management subsystem to decide when it is desir=
able to suspend
> >> >> >> > the system (i.e. when useful work is not being done).  Add an =
API that ..."
> >> >> >> >
> >> >> >>
> >> >> >> PM: Opportunistic suspend support.
> >> >> >>
> >> >> >> Power management features present in the current mainline kernel=
 are
> >> >> >> insufficient to get maximum possible energy savings on some plat=
forms,
> >> >> >> such as Android, because low power states can only safely be ent=
ered
> >> >> >> from idle.
> >> >> >
> >> >> > Do you mean CPU low-power states or system low-power states here?
> >> >> >
> >> >> I think either.
> >> >
> >> > The statement is not true for system low-power states (or sleep stat=
es),
> >> > because generally (ie. on many platforms) they aren't entered from i=
dle.
> >> > Suspend is for entering them.
> >> >
> >> I don't think that makes my statement false. If you can only safely
> >> enter low power states from idle, but some low power states cannot be
> >> entered from idle, then it follows that you cannot safely enter those
> >> low power states.
> >
> > Define "safely", then.
> >
> OK. Is this clearer:

Not really.

> Power management features present in the current mainline kernel are
> insufficient to get maximum possible energy savings on some platforms,
> such as Android, because some wakeup events must work at all times
> which means that low power states can only safely be entered from idle.

It's not clear what you mean by "some wakeup events must work at all times"
and what "safely" means.

> Suspend, in its current form, cannot be used, since wakeup events that
> occur right after initiating suspend will not be processed until another
> possibly unrelated event wake up the system again.

Well, I _guess_ I know what you're trying to say, but I'm not sure if that's
the core of the problem the patchset is supposed to address.

The problem, as I see it, is really two-fold.

First, to save as much energy as reasonably possible you need to put everyt=
hing
except for memory (ie. I/O devices and CPUs) into low-power states and let =
that
stay in these low-power states for as long as reasonably possible, right?

Second, you need the system to _always_ respond to some _specific_ events
regardless of its current state, correct?

Now, at present, we can put I/O devices and the CPU into low-power states
at the same time in two ways: (1) by using runtime PM and cpuidle and (2) by
suspending the system.  Unfortunately, none of these approaches is ideal,
because (1) is vulnerable to periodic timers and polling apps (and CPU-bound
apps) and (2) doesn't guarantee that all events you care about will be
responded to.

The proposed solution is to use suspend with an additional mechanism that
will prevent the events that have to be responded to from being lost.  This
additional mechanism is suspend blockers.

Is this correct?

> >> > So, there is a difference and the explanation can go like this: "...=
 to achieve
> >> > maximum energy savings one has to put all I/O devices and the CPU in=
to
> >> > low-power states, but the CPU can only be put into a low-power state=
 from
> >> > idle.  This, in turn, means that the CPU leaves the low-power state =
on
> >> > interrupts triggered by periodic timers and user space processes tha=
t use
> >> > polling.  It turns out, however, that many of these events causing t=
he CPU to
> >> > leave the low-power state aren't essential for the desired system fu=
nctionality
> >> > and from the power management point of view it would be better if th=
ey didn't
> >> > occur".
> >>
> >> This only explain why we still want to use suspend on systems that can
> >> enter the same power states from idle and suspend.
> >
> > Sorry, I'm confused now.  Isn't that why you do that on Android?
> >
> =

> Yes, but it is not the only reason to use opportunistic support. It is
> way more important to have opportunistic suspend support if the
> hardware can enter lower power states from suspend than idle.

Sure, but you can add something like "There also are systems where some
devices cannot be put into low-power states without suspending the entire
system (or the low-power states available to them without suspending the
entire system are substantially shallower than the low-power states they are
put into when the entire system is suspended), so the system have to be
suspended as a whole to achieve the maximum energy savings".

Rafael
