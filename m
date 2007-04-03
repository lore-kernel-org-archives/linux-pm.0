From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Tue, 03 Apr 2007 07:54:45 +0200
Message-ID: <1175579686.28263.204.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.0704021557270.29713-100000@netrider.rowland.org>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704021557270.29713-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-04-02 at 16:04 -0400, Alan Stern wrote:
> > It's not that simple though, especially with HPET.  The BIOS may expect
> > the PIT to work, but Linux currently (and problematically!) uses HPET in
> > "legacy replacement mode".  And ISTR the problems are coming up when the
> > system is already in a low-functionality state:  IRQs off everywhere,
> > even timer ticks have stopped.
> =

> I know nothing about the workings of the HPET and other clock code.  My =

> point was this: Suspend passes through various intermediate stages in =

> which some devices are available and others aren't.  So long as those =

> stages are exact duplicates (in reverse order) of the stages that occurre=
d =

> during startup, it should be possible to make them all work.

Unfortunately it is not a fully linear problem. Devices are initialized
late and put the system into a more complex state (i.e. dynticks,
highres) which needs to be suspended and resumed. If we want to do this
completely linear we need to do a full reverse rollback of the system
states, which moves even more complexity into such systems.

Also the linear approach is not working with other devices, as one can
see with the still unresolved "IRQ#X nobody cared" issues at resume,
which break my laptop. It works nice on startup of the system, but
breaks on resume.

	tglx
