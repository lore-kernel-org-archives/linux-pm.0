From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 08:24:43 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.1008010812450.24755__21432.8714101159$1280643935$gmane$org@uplift.swm.pp.se>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100801054816.GI2470@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 31 Jul 2010, Paul E. McKenney wrote:

> available to do the programming and how valuable power-awareness is for 
> the application in question.  Given that people who program PC-class 
> applications are much more common than are people who program with 
> energy efficiency in mind, the power-naive choice will be attractive in 
> many cases.

I own a Nokia N900. Some applications are ported straight from regular 
Linux and they're definitely power-naive, as they have little or no 
optimization for mobile. I agree that this is not "sloppy" or "bad", it's 
just that mobile (low power) wasn't the intended target of the application 
when it was written, and this commonly shows.

Just like some people will burn CPU cycles by writing their application in 
a high-level language because it requires fewer man-hours and that you get 
thousands of cpu-hours for the cost of a man-hour programming the thing 
(often by externalising the true cost of power which makes power even less 
of a problem), not caring much about power is rational behaviour when 
creating an application for pc.

Just look at flash ads, they consume huge amounts of power and they 
commonly never stop. I imagine that the power used by PCs around the world 
displaying web pages with advertising with the monitor in power-save mode 
(powered down) can be counted in gigawatts. When I need my battery to last 
on my laptop I make sure I don't have any unneccessary tabs enabled 
because it seriously affects my battery time. I think laptop users would 
benefit from more power optimized applications as well, so if the OS could 
do the same for laptop/desktop use as well (spending less time on programs 
updating display when the display is off), I think there are real world 
benefits for every desktop/laptop/mobile user.

If nothing else, it's environmentally friendly.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
