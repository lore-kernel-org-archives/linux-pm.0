From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Fri, 25 Mar 2011 12:30:48 +0100
Message-ID: <20110325113048.GC29521__46440.5081620955$1301052739$gmane$org@elte.hu>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110324154505.934a56a0.sfr@canb.auug.org.au>
	<alpine.LFD.2.02.1103240336590.4529@x980>
	<alpine.LFD.2.02.1103240414450.4529@x980>
	<20110324083959.GE30812@elte.hu>
	<alpine.LFD.2.02.1103241929450.16085@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1103241929450.16085@x980>
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


* Len Brown <lenb@kernel.org> wrote:

> > Thus from a maintenance POV APM has not been much of a drag on the x86 
> > maintainer side. Sure, we do not test it, but that's the case with most of 
> > the obsolete drivers in the kernel.
> > 
> > The principle is that as long as there's no ongoing drag, the cost of 
> > carrying obsolete drivers is minimal - and the unknown cost of screwing 
> > someone in a big way by removing hardware support is hard to measure 
> > reliably. So we are cautious and err on the side of supporting too much 
> > hardware.
> 
> I think this reasoning would apply in 2006, but that was 5 years ago.

I cited a few real examples:

 > > Beyond the lack of a upstream-visible feature-removal-schedule entry, we 
 > > still have an Arcnet driver which hardware was obsoleted by Ethernet in the 
 > > late 80s, and we still have i486 support and those are *much* older than 
 > > APM.

So how does your reasoning not apply to those drivers? There's several which 
are older than APM support.

We had this really big battle about x86/Voyager two years ago, which x86 
subarchitecture literally had just a single user left, and the code was more 
intrusive than APM. Even there after much flaming the eventual consensus was 
that we'd accept it back if it was done cleanly, as part of the new-style 
x86_platform code.

Given that APM fits into the current PM frameworks there's no such problem here 
that i can see.

> Okay, I can delay this way:
> 
> 2.6.39:
> 	feature-removal.txt targets 2.6.42 removal
> 	depend on CONFIG_EXPERT
> 
> 2.6.40, 2.6.41:
> 	WARN once on run-time access
> 
> 2.6.42:
> 	remove.

Regardless of removal, i'd suggest a "this code is not supported" kind of 
WARN() message to the APM code today, into .39 - to see whether it pops up 
anywhere - and mark it for -stable as well.

.42 removal might be too fast, considering the typical release schedule of 
Linux distributions. And i'm still doubting the removal itself: we are adding 
lots of special-purpose subarch drivers to arch/x86/ as we speak (the embedded 
mess coming to x86) - which drivers will be tomorrow's APM code. On what 
grounds do we treat APM support differently?

Our general compatibility with old hardware is an *asset* that we should value.

Thanks,

	Ingo
