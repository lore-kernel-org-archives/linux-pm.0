From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86 intel power: Initialize
	MSR_IA32_ENERGY_PERF_BIAS
Date: Wed, 13 Jul 2011 16:44:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1107131640280.9546@x980>
References: <alpine.LFD.2.02.1103301819250.31342@x980>
	<20110414090854.GB9248@elte.hu>
	<alpine.LFD.2.02.1104150202310.29365@x980>
	<20110415101712.GB28007@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110415101712.GB28007@elte.hu>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


> So how about informing users, how about making it non-silent? An informative 
> printk that also mentions the power configuration tool, etc. This solves the 
> concerns i mentioned.

Something like this?

                rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
                if ((epb & 0xF) == 0) {
                        printk_once(KERN_WARN, "x86: updated energy_perf_bias"
                                " to 'normal' from 'performance'\n"
                                "You can view and update epb via utility,"
                                " such as x86_energy_perf_policy(8)\n");
                        epb = (epb & ~0xF) | ENERGY_PERF_BIAS_NORMAL;
                        wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
                }
