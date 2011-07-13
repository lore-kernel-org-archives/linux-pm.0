From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86 intel power: Initialize
	MSR_IA32_ENERGY_PERF_BIAS
Date: Wed, 13 Jul 2011 16:51:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1107131647140.9546__38904.9012250782$1310590465$gmane$org@x980>
References: <alpine.LFD.2.02.1103301819250.31342@x980>
	<20110414090854.GB9248@elte.hu>
	<alpine.LFD.2.02.1104150202310.29365@x980>
	<20110420131442.GA29418@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110420131442.GA29418@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, stable@kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

> Ok. So... what "serious bug" does this fix? You really need to use cc:
> stable less. Tweaking performance/power ratio is _not_ serious bug.

While the performance difference may not be significant,
the energy difference may be.

Some people think it is serious when Linux has worse out-of-box
energy efficiency than Windows on the same hardware.

Some people think that it is serious when their Linux distribution
has worse energy efficiency than competing Linux distributions.

Greg has given me a hard time for not cc'ing stable _enough_.
I guess the folks that answer the stable mail get to decide...

cheers,
-Len
