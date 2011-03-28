From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Mon, 28 Mar 2011 07:18:41 +0200
Message-ID: <20110328051841.GA1342__44356.6823298626$1301289656$gmane$org@elte.hu>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110324154505.934a56a0.sfr@canb.auug.org.au>
	<alpine.LFD.2.02.1103240336590.4529@x980>
	<alpine.LFD.2.02.1103240414450.4529@x980>
	<20110324083959.GE30812@elte.hu>
	<alpine.LFD.2.02.1103241929450.16085@x980>
	<20110325113048.GC29521@elte.hu>
	<alpine.LFD.2.02.1103260036300.28928@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1103260036300.28928@x980>
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

> > .42 removal might be too fast, considering the typical release schedule of 
> > Linux distributions. And i'm still doubting the removal itself: we are 
> > adding lots of special-purpose subarch drivers to arch/x86/ as we speak 
> > (the embedded mess coming to x86) - which drivers will be tomorrow's APM 
> > code. On what grounds do we treat APM support differently?
> >
> > Our general compatibility with old hardware is an *asset* that we should value.
> 
> My guess is that the customers have died off,

How do we know that? Users are on a bell curve, with a fat tail. If stuff just 
works - and that's not unexpected from relatively simple (and most likely to be 
used) APM functionality like APM-poweroff, why should they ever report 
problems?

Removing a driver based on lack of visible feedback is like removing 190,000 
apps from a 200,000 apps app store, on the (valid) observation that the top 
1000 apps receive 99% of the traffic and use so the remaining 1% are just a 
maintenance burden.

There's value in the concept of knowing that we do not do forced obscolescence 
in Linux and there's a value in a very broad "there's a driver for that" 
concept, just like there's value in a very broad "there's an app for that" 
concept.

> and so the code is no longer an asset, but a maintenance liability.
> 
> If there is a buzzing community of people running 2011
> linux kernels on their ancient laptops in APM mode,
> then the APM maintainer would probably know about them.

Not if most of them use APM-poweroff. I think i even had a desktop box (not a 
laptop) that supported APM suspend (or am i mistaken there, was APM suspend 
support only limited to laptops?).

Thanks,

	Ingo
