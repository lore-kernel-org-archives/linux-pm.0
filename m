From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Fri, 13 Aug 2010 05:28:21 +0200
Message-ID: <201008130528.21887.rjw__11510.2606163875$1281670271$gmane$org@sisk.pl>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<AANLkTimjfU2zu4reEVdOwWwtFHPQ33_Gna6xS2XHRG-h@mail.gmail.com>
	<20100812125712.48b7fc26@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100812125712.48b7fc26@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thursday, August 12, 2010, Jesse Barnes wrote:
> On Thu, 12 Aug 2010 12:19:34 -0700
> Brian Swetland <swetland@google.com> wrote:
> > Question though -- has every feature ever added to the kernel been a
> > feature that there's pre-existing usage of?  Seems like a chicken and
> > egg problem.  Also, some people seem to think there's value in being
> > able to build kernels "out of the box" that work with the Android
> > userspace -- given that there are a few devices out there that have
> > that userspace on 'em.
> 
> We generally try to merge new features like this along with code that
> uses said feature, but there are always exceptions.  We've merged code
> one release or more before the new code gets used for example, which is
> fine IMO.  What we don't want to see is some new drop of code added and
> abandoned, but you already knew that.
> 
> At any rate, if Felipe is the only one arguing against including
> suspend blockers in the kernel, you're probably in good shape.  Based
> on my (rather cursory I admit) evaluation of this thread, it seems like
> reasonable people agree that there's a place for a suspend blocker like
> API in the kernel, and that dynamic power management is also highly
> desirable.  So where's the git pull request already? :)

In fact my patch going in that direction has been merged already and that
code will likely be extended to cover some needs and cases I didn't have in
mind when I was preparing it.

However, having discussed the whole issue for many times and reconsidered it
thoroughly, I think that it's inappropriate to identify the suspend blockers
(or wakelocks) framework with the opportunistic suspend feature as proposed in
the original submission of the "suspend blockers" patchset.  IMO they really
are not the same thing and while the suspend blockers framework is used by
Android to implement opportunistic suspend, I don't really believe this is the
right approach.

We really need something similar to suspend blockers to avoid races between
a suspend process and wakeup events, but it isn't necessary to provide user
space with an interface allowing it to use these things directly.  Such an
interface is only necessary in the specific implementation in which the system
is suspended as soon as the number of "active" suspend blockers goes down to
zero.  Arguably, though, this isn't the only possible way to implement a
mechanism allowing the system to be suspended automatically when it appears
to be inactive.

Namely, one can use a user space power manager for this purpose and actually
the OLPC project has been doing that successfully for some time, which clearly
demonstrates that the Android approach to this problem is not the only one
possible.  Moreover, the kernel's system suspend (or hibernate for that matter)
code has not been designed to be started from within the kernel.  It's been
designed to allow a privileged user space process to request the kernel to
put the system into a sleep state at any given time regardless of what the
other user space processes are doing.  While it can be started from within the
kernel, this isn't particularly nice and, in the Android case, starting it from
within the kernel requires permission from multiple user space processes
(given by not taking suspend blockers these processes are allowed to use).

Since, quite clearly, user space input is necessary to make the decision
whether or not to suspend the system, I think it is more appropriate to allow
user space to start the entire operation and provide the kernel with a means
to abort it in the case of a wakeup event.  Then, user space will be able to
use arbitrary heuristics in deciding whether or not to suspend the system,
possibly taking some kernel's input into account.

I'm not against the very idea of automatic system suspend, which IMO is a
legitimate and reasonable thing to do in many usage scenarios, but I don't
think that the kernel is the right place to start a suspend process.  For this
reason I'm not going to take any code trying to start a suspend process from
within the kernel, regardless of that code's purpose, unless somebody makes a
really convincing case for that to me (basically proving the need for such a
solution).  That said I'm willing to accept patches adding or improving code
that will help us to avoid races between system suspend, initiated by user
space, and wakeup events detected by the kernel.

I hope that makes things clear.

Thanks,
Rafael
