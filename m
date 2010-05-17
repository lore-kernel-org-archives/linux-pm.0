From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Mon, 17 May 2010 22:40:35 +0200
Message-ID: <201005172240.35742.rjw__35531.5251196318$1274128918$gmane$org@sisk.pl>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005162142.39343.rjw@sisk.pl>
	<AANLkTinP68yHYfVCW-urCrRbeSb0Mlz8JsvAs-FKoUPZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinP68yHYfVCW-urCrRbeSb0Mlz8JsvAs-FKoUPZ@mail.gmail.com>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/5/16 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Friday 14 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> This patch series adds a suspend-block api that provides the same
> >> functionality as the android wakelock api. This version has some
> >> changes from, or requested by, Rafael. The most notable changes are:
> >> - DEFINE_SUSPEND_BLOCKER and suspend_blocker_register have been added
> >>   for statically allocated suspend blockers.
> >> - suspend_blocker_destroy is now called suspend_blocker_unregister
> >> - The user space mandatory _INIT ioctl has been replaced with an
> >>   optional _SET_NAME ioctl.
> >>
> >> I kept the ack and reviewed by tags on two of the patches even though
> >> there were a few cosmetic changes.
> >
> > I have one more comment, sorry for that.
> >
> > Namely, if /sys/power/policy is set to "opportunistic" and "mem" is wri=
tten
> > into /sys/power/state and there are no suspend blockers present except =
for
> > the main blocker (and the blockers used only for statistics), the syste=
m won't
> > be able to go out of an infinit suspend-resume loop (or at least it see=
ms
> > so from reading the code).
> >
> > I think we should prevent that from happening somehow.
> >
> =

> It should get out of that loop as soon as someone blocks suspend. If
> someone is constantly aborting suspend without using a suspend blocker
> it will be very inefficient, but it should still work.

Well, the scenario I have in mind is the following.  Someone wants to check
the feature and simply writes "opportunistic" to /sys/power/policy and "mem=
" to
/sys/power/state without any drivers or apps that use suspend blockers.

How in that case is the system supposed to break out of the suspend-resume =
loop
resulting from this?  I don't see right now, because the main blocker is
inactive, there are no other blockers that can be activated and it is next =
to
impossible to write to /sys/power/state again.

Rafael
