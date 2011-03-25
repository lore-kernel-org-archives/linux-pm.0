From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Fri, 25 Mar 2011 13:38:15 +0100
Message-ID: <20110325123815.GA29936__2694.87395785308$1301056863$gmane$org@elte.hu>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110324154505.934a56a0.sfr@canb.auug.org.au>
	<alpine.LFD.2.02.1103240336590.4529@x980>
	<alpine.LFD.2.02.1103240414450.4529@x980>
	<20110324083959.GE30812@elte.hu>
	<alpine.LFD.2.02.1103241929450.16085@x980>
	<20110325113048.GC29521@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110325113048.GC29521@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > Okay, I can delay this way:
> > 
> > 2.6.39:
> > 	feature-removal.txt targets 2.6.42 removal
> > 	depend on CONFIG_EXPERT
> > 
> > 2.6.40, 2.6.41:
> > 	WARN once on run-time access
> > 
> > 2.6.42:
> > 	remove.
> 
> Regardless of removal, i'd suggest a "this code is not supported" kind of 
> WARN() message to the APM code today, into .39 - to see whether it pops up 
> anywhere - and mark it for -stable as well.
> 
> .42 removal might be too fast, considering the typical release schedule of 
> Linux distributions. [...]

Anyway, i'd ack this schedule if you queued up the WARN() today with a -stable 
tag, on the condition that if we get complaints about that message, we keep APM 
support.

If there are people who are still using it then we should not remove it, 
agreed?

	Ingo
