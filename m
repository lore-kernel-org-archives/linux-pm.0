From: "Ted Ts'o" <tytso@mit.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 14:47:13 -0400
Message-ID: <20100802184712.GA25653__32680.8675578379$1280775069$gmane$org@thunk.org>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801204026.GH31324@thunk.org>
	<1280705444.25620.62.camel@mulgrave.site>
	<20100802121241.GE27573@thunk.org>
	<1280767880.2843.237.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1280767880.2843.237.camel@mulgrave.site>
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

On Mon, Aug 02, 2010 at 11:51:20AM -0500, James Bottomley wrote:
> Actually, I don't necessarily agree with this.  In fact, I think it's a
> dangerous proposition.  The reason is that the only class of
> applications I've seen usefully made power aware are some of the system
> housekeeping ones (as in don't index my man pages, prelink my binaries
> etc. when I'm on battery power).  Perhaps I could see things that have
> to poll (like imap without push support on the server) do a "poll when
> woken else every X minutes", but the potential for annoying the user by
> doing the wrong thing on power environment change is huge.

Sure, but that's why you need to let the user choose.  They can decide
between, "behave as if you were on AC", and "try to save power as much
as possible", and maybe one or two points in between, and let them
choose how much performance/battery life they are willing to give up.
If they are on a long flight to Europe/Australia with no power, they
might choose a very different tradeoff point than if they know they
are only going to be in the meeting room for an hour before they can
recharge their battery.

The point is you can annoy users by burning power to improve their
"user experience" just as much as you can annoy users by trying to sip
power as delicately as possible.  It's true that many applications
don't do a lot in this space, but that's mainly becaue of application
laziness.  Which is why I really don't buy Arjan's whack-a-mole
approach to solving the problem.  I *know* I can save tons of power by
doing "killall -STOP firefox" when I don't need to use the browser.
I've don't the power management when I've been carefully nursing my
battery while at a conference.  So I have no problem if the system
does that automatically for me when I switch to a different virtual
console --- in fact, I'd prefer it!  Similarly, having tools which
forcibly choose different pm_qos settings, even if it's not what the
applications want, is things that *can* very much make a difference.

So yes, maybe applications won't do much with that.  But that just
reinforces the argument that it's the framework or the kernel that
needs to do these sorts of things, because the application programers
won't.

							- Ted
