From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sat, 7 Aug 2010 13:36:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008071330500.30564@asgard.lang.hm>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org> <201008071111.05585.rjw@sisk.pl>
	<7F55B423-3F07-4DF7-B958-7380FDD53545@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <7F55B423-3F07-4DF7-B958-7380FDD53545@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Theodore Tso <tytso@mit.edu>
Cc: peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat, 7 Aug 2010, Theodore Tso wrote:

> On Aug 7, 2010, at 5:11 AM, Rafael J. Wysocki wrote:
>
>> But in principle that need not mean suspending the entire system.
>> To get applications out of the way, you need to freeze user space.
>> However, that's not sufficient, because in addition to that you need to
>> prevent deactivate the majority of interrupt sources to avoid waking up the
>> CPU (from C-states) too often.

> True, but again, consider the MacBook.  If you plug in an iPod, the 
> machine will wake up for *just* long enough to let the iTunes sync the 
> iPod, but once its done, the machine goes back to sleep again 
> immediately.  I doubt MacOS has something called a "suspend blocker" 
> which prevents the machine from sleeping until iTunes finished, which 
> when released, allows the machine to suspend again immediately.  But 
> neither did I see any evidence that it took 30 seconds for some kludgy 
> polling process to decide that iTunes was done, and to allow the MacBook 
> to go back to sleep.

nobody has proposed a polling process to decide the system can suspend, 
what I proposed was to have idle detection decide the system can suspend, 
which would mean that if you don't want the system to suspend you have to 
do something to keep it from being idle.

At the time I didn't know that Android always disabled suspend for the 
entire time the display was on, so I made the assumption that timouts had 
to be long enough for input events to keep the system awake, which would 
put them on the order of 30 seconds or longer.

If all that is wanted is to disable the suspend for the entire time the 
backlight is on you don't need wakelocks, and you don't need a privilaged 
thread waking up, all you need is to tell the power management system not 
to suspend through the existing mechanism. you could create a new 
mechanism (wakelock) to pass the same information, but what is the 
advantage of doing so?

David Lang
