From: David Brownell <david-b@pacbell.net>
Subject: Re: Higer latency with dynamic tick (need for an
	io-ondemand govenor?)
Date: Fri, 18 Apr 2008 20:45:56 -0700
Message-ID: <200804182045.56893.david-b__10740.5429742814$1208618110$gmane$org@pacbell.net>
References: <3B6D69C3A9EBCA4BA5DA60D913027429010253CD@dlee13.ent.ti.com>
	<1179474567.12981.53.camel@chaos>
	<3B6D69C3A9EBCA4BA5DA60D91302742904131BED@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742904131BED@dlee13.ent.ti.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 18 April 2008, Woodruff, Richard wrote:
> When capturing some traces with dynamic tick we were noticing the
> interrupt latency seems to go up a good amount. If you look at the trace
> the gpio IRQ is now offset a good amount. =A0Good news I guess is its
> pretty predictable.

That is, about 24 usec on this CPU ... an ARM v7, which I'm guessing
is an OMAP34xx running fairly fast (order of 4x faster than most ARMs).

Similar issues were noted, also using ETM trace, on an ARM920 core [1]
from Atmel.  There, the overhead of NO_HZ was observed to be more like
150 usec of per-IRQ overhead, which is enough to make NO_HZ non-viable
in some configurations.


> I was wondering what thoughts of optimizing this might be.

Cutting down the math implied by jiffies updates might help.
The 64 bit math for ktime structs isn't cheap; purely by eyeball,
that was almost 1/3 the cost of that 24 usec (mostly __do_div64).

- Dave

[1] http://marc.info/?l=3Dlinux-kernel&m=3D120471594714499&w=3D2
