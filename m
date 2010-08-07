From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sat, 7 Aug 2010 11:11:05 +0200
Message-ID: <201008071111.05585.rjw__46292.5053936944$1281183256$gmane$org@sisk.pl>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100807061558.GA28087@thunk.org>
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
Cc: david@lang.hm, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Saturday, August 07, 2010, Ted Ts'o wrote:
> On Fri, Aug 06, 2010 at 08:14:09PM -0700, david@lang.hm wrote:
> > 
> > that description sounds far more like normal sleep power management
> > that suspending. especially since they want to set timers to wake
> > the system up and the defining characteristic of suspend (according
> > to this thread) is that timers don't fire while suspended.
> > 
> > as I am seeing it, there are two reasons why this don't "just work"
> > 
> > 1. sleeping can't currently save as much power as suspending
> 
> No, I don't think that's the case at all.  The key thing here is that
> *most* applications don't need to be modified to use suspend locks,
> because even though they might be in an event loop, when the user user
> turns off the display, the user generally doesn't want it doing things
> on their behalf.
> 
> Again, take for example the Mac Book, since Apple has gotten this
> right for most users' use cases.  When you close the lid, you even if
> the application is under the misguided belief that it should be
> checking every five seconds to see whether or not the web page has
> reloaded --- actually, that's not what you want.  You probably want
> the application to be forcibly put to sleep.  So the whole point of
> the suspend blocker design is that you don't have to modify most
> applications; they just simply get put to sleep when you close the
> MacBook lid, or, in the case of the Android device, you push the
> button that turns off the screen.

But in principle that need not mean suspending the entire system.
To get applications out of the way, you need to freeze user space.
However, that's not sufficient, because in addition to that you need to
prevent deactivate the majority of interrupt sources to avoid waking up the
CPU (from C-states) too often.

Thanks,
Rafael
