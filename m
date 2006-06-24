From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 20:28:03 -0700
Message-ID: <200606232028.04491.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Friday 23 June 2006 12:23 pm, Linus Torvalds wrote:
> =

> So I think we should attack the problems that we _can_ attack.

Sure ... much better than attacking the problems we _can't_ solve!  ;)
Gotta start somewhere; maybe with simple stuff.

Though it's also good to prioritize.  And for large changes like those
needed in the PM-related frameworks, have plans to minimize overall
disruption, regressions, etc.


> Btw, I disagree violently with the standpoint that you and Pavel have had =

> that we currently just do enough in "suspend()" to make STR work, and tha=
t =

> gets STD working automatically.

That's not been my standpoint with respect to STD at all.


> Several suspend() functions I've seen (networking in particular) do a =

> _hell_ of a lot more than they need for STR, exactly because they try to =

> protect against problems that happen with STD, but _not_ STR.
> =

> Network devices tend to do things like "unregister from the network stack=
" =

> etc, all of which should be totally unnecessary for STR. It's all there =

> really for _disk_ suspend, to make things quiet.

No; as Ben pointed out, there's no "unregister", netif_device_detach() is
just the "stop the I/O queues" operation.  Which _is_ needed for STR; we
went over that earlier.  Retransmits, accepting new connections, and all
that kind of stuff must be stopped cleanly before STR wraps up.

That has to be done in the network controller driver, because the network
stack doesn't participate in suspend operations otherwise.  If for example
there were a real "eth0" device node provided by the network stack, it
would be natural for the networking layer to provide a suspend() method
which calls that, rather than have every controller driver do so...


> So the whole argument that "suspend()" is the minimal functionality is =

> just totally bogus. Its' simply not _true_.

Who made that argument? =A0I've said that it's _correct_ to do all that
PM_EVENT_SUSPEND stuff for all suspend() calls, albeit overkill in
various scenarios. =A0Not that it's minimal. =A0And that's orthogonal to
most of the refactoring points you're making.


> The current suspend()  =

> functions do lots of things that have nothing to do with actual device =

> suspend, exactly because the current setup forces them to do so, not =

> because they would actually _need_ to do so for STR.

Where "current setup" IMO stretches into the layers above the drivers.
See the above for networking; and pretty much every stack has similar
issues.

- Dave
