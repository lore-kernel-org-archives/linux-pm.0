From: Ingo Molnar <mingo@elte.hu>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 01:46:34 +0200
Message-ID: <20100603234634.GA21831__37215.2867996649$1275608933$gmane$org@elte.hu>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<alpine.LFD.2.00.1006031630300.8175@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1006031630300.8175@i5.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 4 Jun 2010, Ingo Molnar wrote:
> > 
> >    This allows a task to 'exclude' other tasks that dont have low-latency 
> >    requirements. Crappy apps would have a large latency value, so they'd
> >    be idled out when a privileged task sets the exclusion level low enough.
> 
> Quite frankly, this sounds fundamentally broken.
>
> Think deadlock. The high-latency task got a lock, and now you're excluding 
> it because it scheduled away.

Mail was a bit too long already so i trimmed it at the wrong place :-/

What you say is absolutely true, hence this would be driven via sched_tick() + 
TIF notifiers - i.e. only ever treat user-mode tasks as 'idle-able'. This can 
be done with no overhead to the regular fastpaths.

The TIF notifier would be the one scheduling to idle - and would thus do it 
only to user-mode tasks.

Thanks,

	Ingo
