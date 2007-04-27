From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 17:20:06 +0200
Message-ID: <200704271720.08150.rjw__29045.2660796747$1177687096$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0704271008540.3430-100000@iolanthe.rowland.org>
	<1177684764.3565.20.camel@johannes.berg>
	<1177685391.3565.22.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177685391.3565.22.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Piggin <npiggin@suse.de>, Pavel Machek <pavel@ucw.cz>, Mike Galbraith <efault@gmx.de>, Kernel development list <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 27 April 2007 16:49, Johannes Berg wrote:
> On Fri, 2007-04-27 at 16:39 +0200, Johannes Berg wrote:
> 
> > Good point. Though if we go for passing the interrupt-enable setting as
> > an argument then many drivers will have the same
> > "if (irqs_disabled()) return" code. Hm. I guess passing it isn't even
> > strictly necessary.
> 
> Eh, the point I actually wanted to make is that many drivers don't care
> for the irqs disabled case and would have to add code to exclude it.

I think we can use 'stages' and pass them as arguments to the functions.

In that case we can have two callbacks for the hibernation (I'd prefer to say
'hibernation' instead of 'suspend to disk' from now on), one 'quiesce' callback
and one 'activate' callback that can be called many times in one
snapshot/restore cycle with different arguments, for example:

quiesce(PREPARE) -- that may be needed for drivers that allocate much memory
before quiescing devices (if any)
...
quiesce(PRE_SNAPSHOT)
...
quiesce(PRE_SNAPSHOT_IRQ_OFF)
...
activate(POST_SNAPSHOT_IRQ_OFF)
...
activate(POST_SNAPSHOT)
...
activate(FINISH)

etc.

Greetings,
Rafael
