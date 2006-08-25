From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Re : Re : Re : [HELP] Power management for embedded
	system
Date: Fri, 25 Aug 2006 14:46:26 +0100
Message-ID: <20060825134625.GD2287@flint.arm.linux.org.uk>
References: <20060824215650.GB21439@flint.arm.linux.org.uk>
	<20060825133925.47842.qmail@web25810.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060825133925.47842.qmail@web25810.mail.ukl.yahoo.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 25, 2006 at 01:39:25PM +0000, moreau francis wrote:
> Russell King wrote:
> > We have some folk who want a method to trigger emergency suspends when
> > batteries got low, or if you move the battery cover, etc.  These are
> > events which require fast reactions from the system, and coding up some
> > additional interface to pass such events to userland, have some daemon
> > running to monitor for those events, and issue a PM event is completely
> > overkill and, actually, unreliable.
> > =

> =

> I'm not sure to understand why a daemon is needed. Could you explain ?

Consider how you would make a connection between an interrupt being
triggered and a suspend occuring, bearing in mind that you require
a process context to perform a suspend.

You essentially have three options:

1. a kernel thread, to which you pass an event or trigger condition.
2. a userland daemon which waits for the interrupt via some special
   kernel interface and triggers a suspend via normal userspace
   channels.
3. some hotplug-triggered userspace method.

Note that both 2 and 3 have the same limitation - since they use normal
userspace channels which have no concept of "emergency suspend", it's
quite possible for (eg) a busy X server to inappropriately delay such a
suspend.

Therefore, I chose (1) as being the most appropriate solution.

-- =

Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
