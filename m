From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: suspend blockers & Android integration
Date: Thu, 3 Jun 2010 16:37:02 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1006031630300.8175__11776.3664843098$1275608654$gmane$org@i5.linux-foundation.org>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100603232302.GA16184@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org



On Fri, 4 Jun 2010, Ingo Molnar wrote:
> 
>    This allows a task to 'exclude' other tasks that dont have low-latency 
>    requirements. Crappy apps would have a large latency value, so they'd
>    be idled out when a privileged task sets the exclusion level low enough.

Quite frankly, this sounds fundamentally broken.

Think deadlock. The high-latency task got a lock, and now you're excluding 
it because it scheduled away.

So from my perspective, putting that kind of logic deep in the system 
sounds like the _last_ thing we want to do.

I think it's much saner to have a very targeted suspend blocker that only 
blocks the opportunistic suspends and has _zero_ interaction with the rest 
of the system (certainly none at all with core code like the scheduler).

And if somebody then suspends the traditional way (by an actual suspend 
event, not that opportunistic thing), then the suspend blocker does 
nothing at all - because it simply doesn't even _exist_ at that level. 
It's only about the opportunistic suspends.

(I'd further suggest that disk wait and running in kernel mode disable any 
opportunistic suspend anyway - but that's not about suspend blockers as 
much as it is about just the opportunistic suspend itself).

		Linus
