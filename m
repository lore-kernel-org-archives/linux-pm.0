From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 21:09:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006072030420.26784-100000__23197.3035647117$1275959538$gmane$org@netrider.rowland.org>
References: <AANLkTiny-hiPoKKKolNAhpvFUS-GaArBO8bwYBUg5glx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTiny-hiPoKKKolNAhpvFUS-GaArBO8bwYBUg5glx@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Jun 2010, Arve Hj=F8nnev=E5g wrote:

> > In fact it's possible to do this with only minimal changes to the
> > userspace, providing you can specify all your possible hardware wakeup
> > sources. =A0(On the Android this list probably isn't very large -- I
> > imagine it includes the keypad, the radio link(s), the RTC, and maybe
> > a few switches, buttons, or other things.)
> >
> > Here's how you can do it. =A0Extend the userspace suspend-blocker API, =
so
> > that each suspend blocker can optionally have an associated wakeup
> > source.
> >
> > The power-manager process should keep a list of "active" wakeup
> > sources. =A0A source gets removed from the list when an associated
> > suspend blocker is activated.
> >
> =

> How do you do this safely? If you remove the active wakeup only when

"remove the active wakeup" isn't a good way of expressing this.  You =

remove the wakeup source from the power manager's list of active =

sources.  This is just manipulation of a data structure internal to the =

power manager; it doesn't affect the actual source.

> activating the suspend blocker, you will never unblock suspend if
> another wakeup event happens after user-space blocked suspend but
> before user-space read the events.

I'm not sure what you mean.  In this scheme userspace doesn't ever =

block suspends.  Instead the power manager freezes and unfreezes all =

the other processes.  And the system never suspends, it simply goes =

idle for prolonged periods of time... with all processes frozen except =

the power manager, and it sitting inside a poll() system call.

It's true that under some exceptional circumstances the system would =

never remove a wakeup source from the "active" list and then would =

never go idle.  But exactly the same problem exists with wakelocks, if =

the kernel activates a wakelock and there's no user process reading the =

corresponding event queue.

> Also, I'm not sure we can easily associate a wakeup event with a user
> space suspend blocker. For instance when an alarm triggers it is
> sometimes because of a user-space alarm and sometimes because an
> in-kernel alarm.

That's okay.  The association is optional, and not all suspend blockers
will have an associated wakeup source.  (However, each wakeup source
that needs to percolate up into userspace -- i.e., that isn't handled
internally by the kernel -- should have at least one associated suspend
blocker.)  The purpose of these associations is to make explicit the
"handoff" in your original scheme, whereby a source would cause the
kernel to activate a wakelock until some user process activated its own
and then cleared the kernel's wakelock.  In your scheme, the connection
between the userspace wakelock and the wakeup source is implicit; in
my scheme it is explicit.

For example, a process that uses a suspend blocker in order to read
keystrokes would obviously associate its suspend blocker with the
keypad-matrix wakeup source.

Or take your example of an alarm.  To make it work in my scheme, each
user alarm would have to be implemented as a poll-able file descriptor.  =

Processes reading the descriptor would block until the alarm expires.  =

(I don't know of any driver that provides this sort of timer interface,
but it would be easy to write one.  You could think of it as applying
Unix's "Everything is a file" philosophy to alarms.)  Each of these
descriptors would then be a wakeup source, included among the sources
that the power manager polls for, and a suspend blocker could be
associated with it.

Alan Stern
