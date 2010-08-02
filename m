From: "Ted Ts'o" <tytso@mit.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 08:12:41 -0400
Message-ID: <20100802121241.GE27573__23735.3729237386$1280751300$gmane$org@thunk.org>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801204026.GH31324@thunk.org>
	<1280705444.25620.62.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1280705444.25620.62.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 01, 2010 at 06:30:44PM -0500, James Bottomley wrote:
> On Sun, 2010-08-01 at 16:40 -0400, Ted Ts'o wrote:
> > This brings me back to a major problem I have with the pm_qos approach
> > to power management.  It assumes that applications know best, and that
> > they should be free to tell pm_qos subsystem whether they need 0ms
> > latency for wireless.
> 
> Um, so this behaviour is isomorphic to the suspend block case for the
> applications.  I think everyone agrees that suspend block isn't optimal,
> but we were prepared to use it as a starting point given the lack of
> enthusiasm in android for the more innovative approaches that have been
> proposed.

Um, yes, that was deliberate.  For some people I think people have
gotten hypersensitive about suspend blockers, to the point that I
think sometimes minds get closed automatically to say that suspend
blockers or their requirements are evil/not really a requirement, so I
decided to use another example other than scheduler control in the
hopes of pointing out (a) there is a more general problem, and (b)
application knows best is not enough, and (c) Arjan's claim that we
don't need to do anything because all applications should be written
to be "power optimized" and it shouldn't matter whether they are
connected to the AC mains or not is a vast oversimplification.

> That's why you present the user with choices and report on the outcomes.
> At the end of the day the choice becomes binary: if the mobile optimised
> browser burns you battery on the power meter, users will either
> uninstall and move on to the next browser or deny the current browser
> the ability to block suspend.

Or they may decide to drop the device which has much worse battery
lifetime in favor of the hardware that seems to do a much better job
of controlling power overall... which is why if the Nokia folks want
to claim that suspend blockers are no good, it's probably not going to
change what ships with Android, and may be better power management
strategy win.  :-)

> Right, but this comes back to the axes of control.  They have to be
> presented to the user in a simple but meaningful manner.

In the general case, at least for today, I think it's useful if
applications are told, "you are on AC mains", "you are on cell phone
battery", "you are on a laptop battery".  And from a user's
perspective, I suspect if you are wanting something simple but
meaningful, it's probably a single linear scale ranging between
"performance optimized" and "power optimized", with maybe 1-3
points in between.

Advanced users will want a much finer level of control, though --- I
can imagine having a number of different sliders that control the
tradeoff between power vs. performance on a number of different
scales: networking, GPS performance, scheduler control, schreen
brightness, etc.

Android phones have a very simplified version of this widget, which
allows you to toggle GPS on/off, bluetooth on/off, etc.  And the GPS
toggle is a good example of what I'm talking about.  If you disable
the GPS, then even if the application wants to use GPS, tough luck; it
will have to settle for the less precise cell tower triangulation
method.  Again, it's the _user_ who gets the final say, not the
application --- and that's as it should be.

						- Ted
