From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Sun, 20 Jun 2010 21:04:22 -0700 (PDT)
Message-ID: <799617.66764.qm@web180304.mail.gq1.yahoo.com>
References: <Pine.LNX.4.44L0.1006202223440.29532-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006202223440.29532-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org, Alan Stern <stern@rowland.harvard.edu>
Cc: Neil Brown <neilb@suse.de>, linux-pm@lists.linux-foundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mark gross <640e9920@gmail.com>
List-Id: linux-pm@vger.kernel.org


> > > Indeed, the same problem arises if the event
> isn't delivered to
> > > userspace until after userspace is frozen.

Can we put this more directly:  the problem is
that the *SYSTEM ISN'T FULLY SUSPENDED* when the
hardware wake event triggers?  (Where "*SYSTEM*
includes userspace not just kernel.  In fact the
overall system is built from many subsystems,
some in the kernel and some in userspace.

At the risk of being prematurely general:  I'd
point out that these subsystems probably have
sequencing requirements.  kernel-then-user is
a degenerate case, and surely oversimplified.
There are other examples, e.g. between kernel
subsystems...  Like needing to suspend a PMIC
before the bus it uses, where that bus uses
a task to manage request/response protocols.
(Think I2C or SPI.)

This is like the __init/__exit sequencing mess...

In terms of userspace event delivery, I'd say
it's a bug in the event mechanism if taking the
next step in suspension drops any event.  It
should be queued, not lost...  As a rule the
hardware queuing works (transparently)...

> Of course, the underlying
> > > issue here is that the kernel has no direct way
> to know when userspace
> > > has finished processing an event.


Again said more directly:  there's no current
mechanism to coordinate subsystems.  Userspace
can't communicate "I'm ready" to kernel, and
vice versa.  (a few decades ago, APM could do
that ... we dropped such mechanisms though, and
I'm fairly sure APM's implementation was holey.)
