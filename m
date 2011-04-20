From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86 intel power: Initialize
	MSR_IA32_ENERGY_PERF_BIAS
Date: Wed, 20 Apr 2011 15:14:42 +0200
Message-ID: <20110420131442.GA29418__3090.68756546385$1303305436$gmane$org@atrey.karlin.mff.cuni.cz>
References: <alpine.LFD.2.02.1103301819250.31342@x980>
	<20110414090854.GB9248@elte.hu>
	<alpine.LFD.2.02.1104150202310.29365@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1104150202310.29365@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>, stable@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


> > > However, the typical BIOS fails to initialize the MSR,
> > > and the typical Linux distro neglects to invoke x86_energy_perf_policy(8).
> > > 
> > > The result is that some modern hardware is running in hardware default,
> > > which is "performance" mode, rather than the intended design default
> > > of "normal" mode.
> > > 
> > > Initialize the MSR to the "normal" setting during kernel boot.
> > > 
> > > Of course, x86_energy_perf_policy(8) is available to change
> > > the default after boot, should the user have a policy preference.
> > > 
> > > cc: stable@kernel.org
...
> Will it be possible to measure a performance difference between
> "performance" and "normal"?  Yes, it will be possible.

Ok. So... what "serious bug" does this fix? You really need to use cc:
stable less. Tweaking performance/power ratio is _not_ serious bug.


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
