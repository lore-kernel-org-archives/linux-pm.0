From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Higer latency with dynamic tick (need for an
	io-ondemand govenor?)
Date: Sun, 20 Apr 2008 14:41:05 +0200
Message-ID: <87ej90aece.fsf__19189.5953998484$1208695523$gmane$org@basil.nowhere.org>
References: <3B6D69C3A9EBCA4BA5DA60D913027429010253CD@dlee13.ent.ti.com>
	<1179396659.3764.40.camel@chaos>
	<3B6D69C3A9EBCA4BA5DA60D913027429010258E8@dlee13.ent.ti.com>
	<1179434296.12981.14.camel@chaos>
	<3B6D69C3A9EBCA4BA5DA60D913027429010259ED@dlee13.ent.ti.com>
	<1179474567.12981.53.camel@chaos>
	<3B6D69C3A9EBCA4BA5DA60D91302742904131BED@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742904131BED@dlee13.ent.ti.com>
	(Richard Woodruff's message of "Fri, 18 Apr 2008 10:43:32 -0500")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Woodruff, Richard" <r-woodruff2@ti.com> writes:

> When capturing some traces with dynamic tick we were noticing the
> interrupt latency seems to go up a good amount. If you look at the trace
> the gpio IRQ is now offset a good amount.  Good news I guess is its
> pretty predictable.
>
> * If we couple this with progressively higher latency C-States we see
> that IO speed can fall by a good amount, especially for PIO mixes.  Now
> if QOS is maintained you may or may-not care.
>
> I was wondering what thoughts of optimizing this might be.
>
> One thought was if an io-ondemand of some sort was used.  It could track
> interrupt statistics and be feed back into cpu-idle.  When there is a
> high interrupt load period it could shrink the acceptable latency and
> thus help choose a good a C-State which favors throughput.  Some moving
> average window could be used to track it.
>
> Perhaps a new interrupt attribute could be attached at irq request time
> to allow the tracking of bandwidth important devices.
>
> The attached is captured on a .22 kernel.  The same should be available
> in a bit on a .24 kernel.

Are you talking about x86? 

On older x86 this effect should have been handled by the C state
algorithm taking the bus master activity register into account (which
should also trigger for interrupts)

But I think the register has been nop'ed on newer platforms 
so indeed we'll need some way to handle this.

-Andi
