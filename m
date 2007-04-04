From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Wed, 4 Apr 2007 08:06:05 -0700
Message-ID: <200704040806.06367.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0704021557270.29713-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704021557270.29713-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 02 April 2007 1:04 pm, Alan Stern wrote:
> On Mon, 2 Apr 2007, David Brownell wrote:

> > This is the kind of thing that the pm_parent relationship was (AFAICT)
> > originally supposed to handle.  Of course, it doesn't/can't, given the
> > current implementation ... that relationship is never used.
> =

> Just so.  In fact, there almost certainly are other dependencies that =

> nobody is aware of, simply because they have never had a chance to bite.

In any given system, yes there are bugs lurking.  But I was more concerned
with a provably wrong assumption made by the current framework.  Such things
cause cascading fragility.

As Thomas mentioned, HPET isn't the only place where a "linear" model fails.


> Such things can be rather difficult to pin down when they occur.  I would
> be happy enough to leave matters as they are, with a strict LIFO approach.

I wouldn't.  Much better to have a solid handle on the interdependencies
than to need to cope, long term, with a framework that doesn't allow that.

Remember also that a LIFO model assumes that there's only one sequence by
which the hardware powers up/down ... i.e. that there's no runtime PM going
on, whereby large chunks are regularly powered down/up based on usage.
Better runtime PM becomes more important as system complexity rises.

- Dave
