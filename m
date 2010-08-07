From: Theodore Tso <tytso@mit.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sat, 7 Aug 2010 10:46:59 -0400
Message-ID: <7F55B423-3F07-4DF7-B958-7380FDD53545__17523.2933521785$1281192591$gmane$org@mit.edu>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org> <201008071111.05585.rjw@sisk.pl>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008071111.05585.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: david@lang.hm, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org


On Aug 7, 2010, at 5:11 AM, Rafael J. Wysocki wrote:

> But in principle that need not mean suspending the entire system.
> To get applications out of the way, you need to freeze user space.
> However, that's not sufficient, because in addition to that you need to
> prevent deactivate the majority of interrupt sources to avoid waking up the
> CPU (from C-states) too often.

True, but again, consider the MacBook.  If you plug in an iPod, the machine will wake up for *just* long enough to let the iTunes sync the iPod, but once its done, the machine goes back to sleep again immediately.   I doubt MacOS has something called a "suspend blocker" which prevents the machine from sleeping until iTunes finished, which when released, allows the machine to suspend again immediately.    But neither did I see any evidence that it took 30 seconds for some kludgy polling process to decide that iTunes was done, and to allow the MacBook to go back to sleep.    Clearly, the MacBook allows some interrupts through, and some USB insert events through, but clearly not all.  (Inserting a USB drive doesn't wake up the laptop; at least, not for long.)

Can we do something as smooth with a Linux desktop?  And if not, why not?   (Oh yeah, and wasn't this supposed to be the year of the Linux Desktop?  :-)

-- Ted
