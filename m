From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Tue, 18 May 2010 21:38:04 +0200
Message-ID: <201005182138.04610.rjw__33010.8703965836$1274211567$gmane$org@sisk.pl>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005172344.46222.rjw@sisk.pl>
	<AANLkTikENyp0UOKP2NzwjKye1EiZitdE0o4k1Z4ygCsT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikENyp0UOKP2NzwjKye1EiZitdE0o4k1Z4ygCsT@mail.gmail.com>
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

On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
> On Mon, May 17, 2010 at 2:44 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday 17 May 2010, Brian Swetland wrote:
> >> On Mon, May 17, 2010 at 1:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >>
> >> >> It should get out of that loop as soon as someone blocks suspend. If
> >> >> someone is constantly aborting suspend without using a suspend bloc=
ker
> >> >> it will be very inefficient, but it should still work.
> >> >
> >> > Well, the scenario I have in mind is the following.  Someone wants t=
o check
> >> > the feature and simply writes "opportunistic" to /sys/power/policy a=
nd "mem" to
> >> > /sys/power/state without any drivers or apps that use suspend blocke=
rs.
> >> >
> >> > How in that case is the system supposed to break out of the suspend-=
resume loop
> >> > resulting from this?  I don't see right now, because the main blocke=
r is
> >> > inactive, there are no other blockers that can be activated and it i=
s next to
> >> > impossible to write to /sys/power/state again.
> >>
> >> I guess we could set a flag when a suspend blocker is registered and
> >> refuse to enter opportunistic mode if no blockers have ever been
> >> registered.
> >>
> >> It does seem like extra effort to go through to handle a "don't do
> >> that" type scenario (entering into opportunistic suspend without
> >> anything that will prevent it).
> >
> > I agree, but I think it's necessary.  We shouldn't add interfaces that =
hurt
> > users if not used with care.
> >
> =

> I'm not sure this can be "fixed".

Yes, it can, but perhaps a workaround would be sufficient (see below).

> The user asked that the system to suspend whenever possible, which is wha=
t it
> is doing. I don't think disabling opportunistic suspend if no suspend
> blockers have been registered will work. As soon as we register a suspend
> blocker we are back in the same situation.

Not really, because the new suspend blocker is not added by the _framework_=
 _itself_.

Now, to make it more "user-friendly", we can simply use
queue_delayed_work() with a reasonable delay instead of queue_work() to que=
ue
the suspend work (the delay may be configurable via sysfs).

Thanks,
Rafael
