From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 10:18:59 -0700
Message-ID: <200606231018.59772.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
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

On Wednesday 21 June 2006 10:04 am, Linus Torvalds wrote:

> documentation. Much more important than documentation is just clear and =

> unambiguous interfaces. Right now, "suspend()" is _not_ that. It's not =

> clear and unambiguous at all, it's a muddy pit-hole of mixing different =

> things - you're supposed to do all of "freeze", "save state" and =

> "suspend")

It's messy -- I don't like pm_message_t much at all -- but it's not
as bad as you paint it.  It's _always_ correct to do everything needed
to enter STR ... fewer than 5% of today's drivers want to do anything
fancier, like avoiding disk spindown, enabling wakeup events, etc.

In fact that was true back in 2.4 kernels too.  Hardly any drivers
needed to do anything more than preparing for STR.  The extra parameter
to suspend() is only to support "advanced" PM mechanisms.

Of course that means under-featured system PM -- we still suck at
handling wakeup events -- but I figure the first milestone is getting
systems to handle STR (and STD) at all, and doing anything advanced
is a "phase 2" that not all drivers will ever reach.

- Dave
