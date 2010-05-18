From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Wed, 19 May 2010 00:34:26 +0200
Message-ID: <201005190034.26085.rjw__16573.7267154784$1274222042$gmane$org@sisk.pl>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005182348.16026.rjw@sisk.pl>
	<AANLkTin-A5eXvxDEo-vi2x2jjXtZbAl2526w62noNMIK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTin-A5eXvxDEo-vi2x2jjXtZbAl2526w62noNMIK@mail.gmail.com>
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
> > On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> 2010/5/17 Rafael J. Wysocki <rjw@sisk.pl>:
> >> >> > On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> >> 2010/5/14 Rafael J. Wysocki <rjw@sisk.pl>:
> >> >> >> > On Friday 14 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> >> >> This patch series adds a suspend-block api that provides the =
same
> >> >> >> >> functionality as the android wakelock api. This version has s=
ome
> >> >> >> >> changes from, or requested by, Rafael. The most notable chang=
es are:
> >> >> >> >> - DEFINE_SUSPEND_BLOCKER and suspend_blocker_register have be=
en added
> >> >> >> >>   for statically allocated suspend blockers.
> >> >> >> >> - suspend_blocker_destroy is now called suspend_blocker_unreg=
ister
> >> >> >> >> - The user space mandatory _INIT ioctl has been replaced with=
 an
> >> >> >> >>   optional _SET_NAME ioctl.
> >> >> >> >>
> >> >> >> >> I kept the ack and reviewed by tags on two of the patches eve=
n though
> >> >> >> >> there were a few cosmetic changes.
> >> >> >> >
> >> >> >> > Thanks for the patches, I think they are in a pretty good shap=
e now.
> >> >> >> >
> >> >> >> > That said, I'd like the changelogs to be a bit more descriptiv=
e, at least for
> >> >> >> > patch [1/8].  I think it should explain (in a few words) what =
the purpose of
> >> >> >> > the feature is and what problems it solves that generally a co=
mbination of
> >> >> >> > runtime PM and cpuidle is not suitable for in your opinion.  I=
OW, why you
> >> >> >> > think we need that feature.
> >> >> >> >
> >> >> >>
> >> >> >> How about:
> >> >> >>
> >> >> >> PM: Add opportunistic suspend support.
> >> >> >
> >> >> > "PM: Opportunistic suspend support" would be sufficient IMO.
> >> >> >
> >> >> > Now, I'd start with the motivation.  Like "Power management featu=
res present
> >> >> > in the current mainline kernel are insufficient to get maximum po=
ssible energy
> >> >> > savings on some platforms, such as Android, because ..." (here go=
 explanations
> >> >> > why this is the case in your opinion).
> >> >> >
> >> >> > Next, "To allow Android and similar platforms to save more energy=
 than they
> >> >> > currently can save using the mainline kernel, introduce a mechani=
sm by which
> >> >> > the system is automatically suspended (i.e. put into a system-wid=
e sleep state)
> >> >> > whenever it's not doing useful work, called opportunistic suspend=
".
> >> >> >
> >> >> > "For this purpose introduce the suspend blockers framework allowi=
ng the
> >> >> > kernel's power management subsystem to decide when it is desirabl=
e to suspend
> >> >> > the system (i.e. when useful work is not being done).  Add an API=
 that ..."
> >> >> >
> >> >>
> >> >> PM: Opportunistic suspend support.
> >> >>
> >> >> Power management features present in the current mainline kernel are
> >> >> insufficient to get maximum possible energy savings on some platfor=
ms,
> >> >> such as Android, because low power states can only safely be entered
> >> >> from idle.
> >> >
> >> > Do you mean CPU low-power states or system low-power states here?
> >> >
> >> I think either.
> >
> > The statement is not true for system low-power states (or sleep states),
> > because generally (ie. on many platforms) they aren't entered from idle.
> > Suspend is for entering them.
> >
> I don't think that makes my statement false. If you can only safely
> enter low power states from idle, but some low power states cannot be
> entered from idle, then it follows that you cannot safely enter those
> low power states.

Define "safely", then.

> > So, there is a difference and the explanation can go like this: "... to=
 achieve
> > maximum energy savings one has to put all I/O devices and the CPU into
> > low-power states, but the CPU can only be put into a low-power state fr=
om
> > idle.  This, in turn, means that the CPU leaves the low-power state on
> > interrupts triggered by periodic timers and user space processes that u=
se
> > polling.  It turns out, however, that many of these events causing the =
CPU to
> > leave the low-power state aren't essential for the desired system funct=
ionality
> > and from the power management point of view it would be better if they =
didn't
> > occur".
> =

> This only explain why we still want to use suspend on systems that can
> enter the same power states from idle and suspend.

Sorry, I'm confused now.  Isn't that why you do that on Android?

AFACS, your hardware is capable of doing that, isn't it?

Rafael
