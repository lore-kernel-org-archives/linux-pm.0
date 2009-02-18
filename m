From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 22:17:46 +0100
Message-ID: <200902182217.48321.rjw__34464.2268064947$1234992122$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0902162156380.24097-100000@netrider.rowland.org>
	<200902180022.00239.rjw@sisk.pl>
	<d6200be20902172046sf00599ckc6710c6132d6b92f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902172046sf00599ckc6710c6132d6b92f@mail.gmail.com>
Content-Disposition: inline
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 18 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Tue, Feb 17, 2009 at 3:21 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday 17 February 2009, Alan Stern wrote:
> >> On Tue, 17 Feb 2009, Rafael J. Wysocki wrote:
> >>
> >> > Phase 1: I agree that system-auto-suspend-on, system-auto-suspend-of=
f would be
> >> > useful, but I don't like the wakelocks interface.  Do you think ther=
e is an
> >> > alternative way/mechanism of doing this?
> >>
> >> I rather like the suggestions Matthew Garrett has been making.  They
> >> show how to improve the wakelock interface without losing any function.
> >>
> >> Really, the idea behind wakelocks comes down to the question of how to
> >> determine when the system is sufficiently idle to go into auto-suspend.
> >> There may be occasions when no task is runnable but userspace knows
> >> that the system should not go to sleep because some work will be done
> >> in the near future.  (Arve's example of a non-empty input buffer is
> >> such a case.)  How should userspace let the kernel know whether it's
> >> okay to suspend at these times?  That is the problem userspace
> >> wakelocks are meant to solve.
> >
> > Still, do we really need multiple user space wakelocks (I'd prefer to c=
all them
> > sleeplocks)?  It seems that one such lock and a user space manager cont=
rolling
> > it should be sufficient.
> =

> Yes, we could have a user space manager that all userspace wakelocks
> go through, but it would have to start before any other processes that
> need wakelocks and it would need a blocking ipc mechanism. The
> wakelock api that is provided to android applications does all this,
> but it is only available to java code. Supporting multiple userspace
> wakelocks in the kernel is simpler than adding another userspace
> wakelock layer.
> =

> >> Kernel wakelocks are a separate matter.  They are more like a form of
> >> optimization, preventing the kernel from starting an auto-suspend when
> >> some driver knows beforehand that it will return -EBUSY.
> >
> > I think kernel-side autosuspend (or rather autosleep) should only happen
> > after certain subset of devices have been suspended using a per-device
> > run-time autosuspend mechanism.
> =

> When the last wakelock is released the task that we woke up to perform
> has finished. Why wait to re-enter suspend.

I don't really understand this comment.  Could you please explain a bit?

> >> > Phase 3: Probably explicit control left to open/close.
> >>
> >> While that's generally a good idea, it's important to recognize that
> >> some devices should be runtime-suspended even while they are open.
> >
> > From the kernel side, yes (and that should be transparent to the user s=
pace
> > having them open).  By the user space, no.
> =

> Allowing user space to suspend input devices while they are still open
> is useful. The user-space code that reads from the input devices does
> not need to know if the device is suspended or not, and the kernel
> cannot auto suspend input devices based on inactivity.

Hmm.  Why can't it?

Rafael
