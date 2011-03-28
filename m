From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Mon, 28 Mar 2011 06:51:08 +0200
Message-ID: <20110328045108.GA26322__28772.1670618796$1301287962$gmane$org@elte.hu>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110325113048.GC29521@elte.hu>
	<alpine.LFD.2.02.1103260036300.28928@x980>
	<201103272340.42748.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103272340.42748.linux@rainbow-software.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Ondrej Zary <linux@rainbow-software.org> wrote:

> > Is there somebody on LKML that has a older laptop than me
> > and is able to get it to boot in APM mode?  I'd be astonished
> > if there was not.  Are they willing to regularly test changes
> > to the upstream kernel to make sure that APM still works?
> > If yes, where have they been for the last 5 years?
> 
> I just tested 2.6.38-rc4 on a desktop board and it works (power off at least). 

Ok, thanks for testing. I too tried APM poweroff in the not too distant past 
and it worked - but not very recent kernels.

Thanks,

	Ingo
