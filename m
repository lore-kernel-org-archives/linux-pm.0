From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 02 Aug 2010 11:51:20 -0500
Message-ID: <1280767880.2843.237.camel__45588.2545248189$1280768141$gmane$org@mulgrave.site>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801204026.GH31324@thunk.org>
	<1280705444.25620.62.camel@mulgrave.site>
	<20100802121241.GE27573@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100802121241.GE27573@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ted Ts'o <tytso@mit.edu>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-08-02 at 08:12 -0400, Ted Ts'o wrote:
> On Sun, Aug 01, 2010 at 06:30:44PM -0500, James Bottomley wrote:
> > That's why you present the user with choices and report on the outcomes.
> > At the end of the day the choice becomes binary: if the mobile optimised
> > browser burns you battery on the power meter, users will either
> > uninstall and move on to the next browser or deny the current browser
> > the ability to block suspend.
> 
> Or they may decide to drop the device which has much worse battery
> lifetime in favor of the hardware that seems to do a much better job
> of controlling power overall... which is why if the Nokia folks want
> to claim that suspend blockers are no good, it's probably not going to
> change what ships with Android, and may be better power management
> strategy win.  :-)
> 
> > Right, but this comes back to the axes of control.  They have to be
> > presented to the user in a simple but meaningful manner.
> 
> In the general case, at least for today, I think it's useful if
> applications are told, "you are on AC mains", "you are on cell phone
> battery", "you are on a laptop battery".  And from a user's
> perspective, I suspect if you are wanting something simple but
> meaningful, it's probably a single linear scale ranging between
> "performance optimized" and "power optimized", with maybe 1-3
> points in between.

Actually, I don't necessarily agree with this.  In fact, I think it's a
dangerous proposition.  The reason is that the only class of
applications I've seen usefully made power aware are some of the system
housekeeping ones (as in don't index my man pages, prelink my binaries
etc. when I'm on battery power).  Perhaps I could see things that have
to poll (like imap without push support on the server) do a "poll when
woken else every X minutes", but the potential for annoying the user by
doing the wrong thing on power environment change is huge.

> Advanced users will want a much finer level of control, though --- I
> can imagine having a number of different sliders that control the
> tradeoff between power vs. performance on a number of different
> scales: networking, GPS performance, scheduler control, schreen
> brightness, etc.
> 
> Android phones have a very simplified version of this widget, which
> allows you to toggle GPS on/off, bluetooth on/off, etc.  And the GPS
> toggle is a good example of what I'm talking about.  If you disable
> the GPS, then even if the application wants to use GPS, tough luck; it
> will have to settle for the less precise cell tower triangulation
> method.  Again, it's the _user_ who gets the final say, not the
> application --- and that's as it should be.

Yes and no; agree about the user not the application but ... I actually
find the current five android "power" toggles to be largely useless.  If
I don't want GPS killing my battery, I don't start GPS using
applications, for instance rather than disabling GPS.  I think this
represents the "axis" problem again ... I like to manage my power in a
particular way, and others want to manage it in different ways.

James
