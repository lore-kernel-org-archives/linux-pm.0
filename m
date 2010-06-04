From: Ingo Molnar <mingo@elte.hu>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 10:15:38 +0200
Message-ID: <20100604081538.GC15181__17639.9783733816$1275639422$gmane$org@elte.hu>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<alpine.LFD.2.00.1006031630300.8175@i5.linux-foundation.org>
	<20100603234634.GA21831@elte.hu>
	<alpine.LFD.2.00.1006031856420.8175@i5.linux-foundation.org>
	<alpine.LFD.2.00.1006031917500.8175@i5.linux-foundation.org>
	<20100603204521.09808a7f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100603204521.09808a7f@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> On Thu, 3 Jun 2010 19:26:50 -0700 (PDT)
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > If the system is idle (or almost idle) for long times, I would heartily 
> > recommend actively shutting down unused cores. Some CPU's are hopefully 
> > smart enough to not even need that kind of software management, but I 
> > suspect even the really smart ones might be able to take advantage of the 
> > kernel saying: "I'm shutting you down, you don't have to worry about 
> > latency AT ALL, because I'm keeping another CPU active to do any real 
> > work".
> 
> sadly the reality is that "offline" is actually the same as "deepest C 
> state". At best.
> 
> As far as I can see, this is at least true for all Intel and AMD cpus.
> 
> And because there's then no power saving (but a performance cost), it's 
> actually a negative for battery life/total energy.
> 
> (lots of experiments inside Intel seem to confirm that, it's not just 
> theory)

Well, the scheme would only be useful if it's _NOT_ just a deep C4 state, but 
something that prevents tasks from being woken to that CPU for a good period 
of time. Hot-unplugging that CPU achieves that (the runqueues are pulled), so 
i think in Linus's idea makes sense in principle.

[ Or have you done deep-idle experiments to that effect as well? ]

I suspect it all depends on the cost: and our current hot-unplug and 
hot-replug code is all but cheap ...

	Ingo
