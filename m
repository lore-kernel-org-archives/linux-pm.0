From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Sun, 27 Mar 2011 22:43:57 -0700
Message-ID: <4D90201D.1010308@zytor.com>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110325113048.GC29521@elte.hu>
	<alpine.LFD.2.02.1103260036300.28928@x980>
	<201103272340.42748.linux@rainbow-software.org>
	<20110328045108.GA26322@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110328045108.GA26322@elte.hu>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ondrej Zary <linux@rainbow-software.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 03/27/2011 09:51 PM, Ingo Molnar wrote:
> 
> * Ondrej Zary <linux@rainbow-software.org> wrote:
> 
>>> Is there somebody on LKML that has a older laptop than me
>>> and is able to get it to boot in APM mode?  I'd be astonished
>>> if there was not.  Are they willing to regularly test changes
>>> to the upstream kernel to make sure that APM still works?
>>> If yes, where have they been for the last 5 years?
>>
>> I just tested 2.6.38-rc4 on a desktop board and it works (power off at least). 
> 
> Ok, thanks for testing. I too tried APM poweroff in the not too distant past 
> and it worked - but not very recent kernels.
> 

Given that the current merge window rewrote this code, it would be good
to get it tested on 2.6.39-rc1 when it becomes available.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
