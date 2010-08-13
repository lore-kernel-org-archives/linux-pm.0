From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Fri, 13 Aug 2010 17:07:02 +0200
Message-ID: <201008131707.03484.rjw__7904.6847102747$1281712321$gmane$org@sisk.pl>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<201008130528.21887.rjw@sisk.pl>
	<AANLkTinMmVdAVaCFXyDZpVRmZ9FCWYhtdeM=o4hdoZnT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinMmVdAVaCFXyDZpVRmZ9FCWYhtdeM=o4hdoZnT@mail.gmail.com>
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
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Friday, August 13, 2010, Arve Hj=F8nnev=E5g wrote:
> On Thu, Aug 12, 2010 at 8:28 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday, August 12, 2010, Jesse Barnes wrote:
> >> On Thu, 12 Aug 2010 12:19:34 -0700
> >> Brian Swetland <swetland@google.com> wrote:
> >> > Question though -- has every feature ever added to the kernel been a
> >> > feature that there's pre-existing usage of?  Seems like a chicken and
> >> > egg problem.  Also, some people seem to think there's value in being
> >> > able to build kernels "out of the box" that work with the Android
> >> > userspace -- given that there are a few devices out there that have
> >> > that userspace on 'em.
> >>
> >> We generally try to merge new features like this along with code that
> >> uses said feature, but there are always exceptions.  We've merged code
> >> one release or more before the new code gets used for example, which is
> >> fine IMO.  What we don't want to see is some new drop of code added and
> >> abandoned, but you already knew that.
> >>
> >> At any rate, if Felipe is the only one arguing against including
> >> suspend blockers in the kernel, you're probably in good shape.  Based
> >> on my (rather cursory I admit) evaluation of this thread, it seems like
> >> reasonable people agree that there's a place for a suspend blocker like
> >> API in the kernel, and that dynamic power management is also highly
> >> desirable.  So where's the git pull request already? :)
> >
> > In fact my patch going in that direction has been merged already and th=
at
> > code will likely be extended to cover some needs and cases I didn't hav=
e in
> > mind when I was preparing it.
> >
> > However, having discussed the whole issue for many times and reconsider=
ed it
> > thoroughly, I think that it's inappropriate to identify the suspend blo=
ckers
> > (or wakelocks) framework with the opportunistic suspend feature as prop=
osed in
> > the original submission of the "suspend blockers" patchset.  IMO they r=
eally
> > are not the same thing and while the suspend blockers framework is used=
 by
> > Android to implement opportunistic suspend, I don't really believe this=
 is the
> > right approach.
> >
> =

> Can you clarify this? Do you not believe using opportunistic suspend
> is the right approach, or do you not believe linking suspend blockers
> with opportunistic suspend is the right approach?

The latter.  That should be clear from the remaining part of my message.

> > We really need something similar to suspend blockers to avoid races bet=
ween
> > a suspend process and wakeup events, but it isn't necessary to provide =
user
> > space with an interface allowing it to use these things directly.  Such=
 an
> > interface is only necessary in the specific implementation in which the=
 system
> > is suspended as soon as the number of "active" suspend blockers goes do=
wn to
> > zero.
> =

> I don't think what you are saying here is correct. When you decide to
> suspend has no impact on whether a user space interface to block
> suspend is needed. The last suspend blocker patchset had this
> interface as a separate patch and the reasons for providing it have
> not changed with your interface. Android need the user space interface
> because low level services that handle wakeup events are started
> before the user space power manager. The other reason to have this
> interface in the mainline kernel is to provide a safe way to handle
> wakeup events on linux regardless of which user space power manager is
> used on the system. For instance some devices have a user space
> battery monitor, and there would be no need for this code to be
> android specific if the kernel provided all the functionality it
> needs.

Well, the problem is, with your /dev/suspend_blocker interface, multiple
user space processes are supposed to decide whether or not system suspend
should be started and in general there don't seem to be any particularly go=
od
criteria for choosing these applications, in general.  So, application writ=
ers
may be tempted to use this interface in all programs and then the decision
whether or not to allow these programs to affect system power management wi=
ll
be delegated to users.  In turn, the users may not be technically qualified=
 to
make such a decision.

Also the fact that the same mechanism is used for handling wakeup events
detected by the kernel and allowing user space programs to grant permission=
 to
suspend the system is somewhat confusing.

> >  Arguably, though, this isn't the only possible way to implement a
> > mechanism allowing the system to be suspended automatically when it app=
ears
> > to be inactive.
> >
> > Namely, one can use a user space power manager for this purpose and act=
ually
> > the OLPC project has been doing that successfully for some time, which =
clearly
> > demonstrates that the Android approach to this problem is not the only =
one
> > possible.  Moreover, the kernel's system suspend (or hibernate for that=
 matter)
> > code has not been designed to be started from within the kernel.  It's =
been
> > designed to allow a privileged user space process to request the kernel=
 to
> > put the system into a sleep state at any given time regardless of what =
the
> > other user space processes are doing.  While it can be started from wit=
hin the
> > kernel, this isn't particularly nice and, in the Android case, starting=
 it from
> > within the kernel requires permission from multiple user space processes
> > (given by not taking suspend blockers these processes are allowed to us=
e).
> >
> =

> Why is starting suspend from within the kernel not nice? Personally I
> think reentering suspend from within the kernel is nicer than being
> forced to wake up a user space thread for events that are fully
> handled within the kernel (for instance the battery monitor on the
> Nexus One).

For basically the same reason why the kernel generally doesn't use sys_open=
()
for opening files.  It is an interface provided for user space.

> > Since, quite clearly, user space input is necessary to make the decision
> > whether or not to suspend the system, I think it is more appropriate to=
 allow
> > user space to start the entire operation and provide the kernel with a =
means
> > to abort it in the case of a wakeup event.  Then, user space will be ab=
le to
> > use arbitrary heuristics in deciding whether or not to suspend the syst=
em,
> > possibly taking some kernel's input into account.
> >
> When we don't need these heuristics, this is just a burden.

The word 'arbitrary' means in particular that you can implement a mechanism
equivalent to the /dev/suspend_blocker entirely in user space.  Someone els=
e,
though, can use a different approach.

By adding the /dev/suspend_blocker interface to the mainline kernel we would
mandate that Linux applications use it on all platforms.  Consequently,
application writers would have the right to expect that all platforms would=
 be
using Android-alike opportunistic suspend, which may or may not be the case.

> > I'm not against the very idea of automatic system suspend, which IMO is=
 a
> > legitimate and reasonable thing to do in many usage scenarios, but I do=
n't
> > think that the kernel is the right place to start a suspend process.  F=
or this
> > reason I'm not going to take any code trying to start a suspend process=
 from
> > within the kernel, regardless of that code's purpose, unless somebody m=
akes a
> > really convincing case for that to me (basically proving the need for s=
uch a
> > solution).
> =

> There is no absolute need to start the suspend process from within the
> kernel, but it makes the user space code much simpler for what we
> need.

I'm entirely aware of that.  Still, I think user space is the right place to
initiate system suspend.

Thanks,
Rafael
