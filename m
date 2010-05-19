From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Wed, 19 May 2010 22:40:39 +0200
Message-ID: <201005192240.39803.rjw__26489.5629058175$1274301821$gmane$org@sisk.pl>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005190056.36804.rjw@sisk.pl>
	<AANLkTikc9MmR_r1NkdCwDaPD4kJa9l9KUwcWAxilcs3l@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikc9MmR_r1NkdCwDaPD4kJa9l9KUwcWAxilcs3l@mail.gmail.com>
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

On Wednesday 19 May 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday 19 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> >> >> > On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> >> On Mon, May 17, 2010 at 2:44 PM, Rafael J. Wysocki <rjw@sisk.pl>=
 wrote:
> >> >> >> > On Monday 17 May 2010, Brian Swetland wrote:
> >> >> >> >> On Mon, May 17, 2010 at 1:40 PM, Rafael J. Wysocki <rjw@sisk.=
pl> wrote:
> >> >> >> >> > On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> >> >> >>
> >> > ...
> >> >>
> >> >> > Now, to make it more "user-friendly", we can simply use
> >> >> > queue_delayed_work() with a reasonable delay instead of queue_wor=
k() to queue
> >> >> > the suspend work (the delay may be configurable via sysfs).
> >> >> >
> >> >>
> >> >> I can add a delay (and the timeout support code does add a delay as=
 an
> >> >> optimization) to the unknown wakeup case, but this does not fix the
> >> >> problem of a user turning on opportunistic suspend with a user space
> >> >> framework that does not use suspend blockers. If the kernel uses
> >> >> suspend blockers to make sure the wakeup event makes it to user spa=
ce,
> >> >> but user space does not block suspend, then the system will suspend
> >> >> before the event is processed.
> >> >
> >> > But the user can still manually write to /sys/power/state. :-)
> >> >
> >>
> >> Does adding or removing a delay change this? It seems in only changes
> >> how quickly the user can finish that write.
> >
> > Yes, but that should allow the user to avoid rebooting the system if he=
 does
> > the "wrong thing".
> >
> >> I'm not convinced adding a configurable delay here is necessary.
> >
> > No, it's not, but it would be useful in some cases IMO.  Pretty much th=
e same
> > way your debug features are useful.
> >
> >> Once the driver that enabled the wakeup event has been updated to block
> >> suspend until this event gets to user space, then this delay will
> >> never be triggered. The kernel cannot tell the difference between a
> >> user enabling opportunistic suspend but not wanting it and
> >> opportunistic suspend aware user space code deciding that this wakeup
> >> event should be ignored.
> >
> > The point is, if there's a delay, it may be too aggressive for some use=
rs and
> > too conservative for some other users, so it makes sense to provide a m=
eans
> > to adjust it to the user's needs.
> >
> =

> My point is that the delay will not be used at all if the driver uses
> a suspend blocker (like it should). Why add a configuration option for
> opportunistic suspend that only works when the driver does not support
> opportunistic suspend.

Because on many systems there are no such drivers (yet, at least).

Rafael
