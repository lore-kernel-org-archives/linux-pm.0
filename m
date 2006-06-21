From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 14:13:49 -0700
Message-ID: <200606211413.50197.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211130350.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210844460.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606210844460.5498@g5.osdl.org>
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

On Wednesday 21 June 2006 9:03 am, Linus Torvalds wrote:
> =

>  - we should have _suspend_ support. This is the "real suspend" thing, ie =

>    support for putting the machine to sleep, and it is totally independen=
t =

>    of any snapshotting capability what-so-ever.

In the same vein, some system _run_ states will look to drivers just
like suspend states.  Example, maybe the 48 MHz clock is not available
(as needed by a few drivers) or particular voltage levels aren't.
Linux should be able to enter those system states too.  No snapshotting
involved!

One benefit of recognizing such run states is that they enable different
system sleep states ... maybe the idle loop can enter lower power
modes than just the "wait for interrrupt" CPU mode.  This can interact
with dynamic voltage and frequency scaling (DVFS) on some processors,
as well as the dynamic tick stuff.  (Because entering those lower power
states probably implies staying in them for long enough to amortize
enter/exit costs, and dynamic tick offers "how long till next IRQ"
predictions.  Sort of like C1/C2/C3 issues on x86.)

Yes, that's slightly afield from the STD-vs-real-suspend thread, but
it's worth keeping in mind that STR isn't the only "real suspend"
state to care about.  There can be a whole range of platform-specific
system states available ... leveraging them can stretch battery life,
and with less end-user-visible impact than needing to say "enter STR"
(or "enter standby") in the X11 user interface.  (Plus no need to
care about $SUBJECT!)

- Dave
