From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 11:53:51 -0700
Message-ID: <200703221153.52227.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0703221039001.3605-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0703221039001.3605-100000@iolanthe.rowland.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Thursday 22 March 2007 7:45 am, Alan Stern wrote:
> On Thu, 22 Mar 2007, Scott E. Preece wrote:
> =

> > I would normally call designs that expect important functions (like
> > power on/power off) to happen as side effects of other operations (like
> > opening and closing files) broken to begin with. It's still a bad idea
> > to hide policy inside the driver.
> =

> Even though other people have already answered this, I'd like to add my =

> own comments.
> =

> Firstly, doing power on/power off as side effects of other operations is =

> _not_ a policy choice.  It is a design principle:

Yes ... and one that's widely used in other contexts:  deallocate
resources when they're not in active use.


> 	When device D has been idle for more than N ms, it should be
> 	put in a low-power state (unless such state changes have been
> 	disabled for D by userspace).

THAT is however something I would call a heuristic.  It's a widely
used one -- disk spindown uses one value for N, displays enter their
lowpower states using other values for N, etc -- but it's still not
as definitive as for example "if the device isn't opened, it can't
possibly be in use".

Not that I see a way around having such a heuristic for things like mice,
or anything wrong with that one ... I just want to call a spade a spade
here, and not confuse (a) the design principle, with (b) a heuristic that's
used to implement that principle in certain cases.

 =

> Of course N will vary for different D's, and the exact choice of N _is_
> policy.  Thus N should be exposed and configurable by userspace.  So
> should the ability to disable the state changes.  But the principle
> above isn't a policy, it is part of the design.
> =

> Secondly, this principle _requires_ that power on/power off occur as side =

> effects of other operations, since those other operations affect whether =

> or not the device is idle.
> =

> If anybody wants to argue against the principle itself, then go ahead and
> say so.  I, for one, don't see anything objectionable about it.

Me either -- for either principle or, in general, that heuristic.

Of course, choosing to apply that heuristic to a given device is
a different kettle of fish.  That's why it's got an "off" switch.  :)

- Dave
