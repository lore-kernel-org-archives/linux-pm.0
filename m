From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Mon, 28 Mar 2011 05:57:01 -0700
Message-ID: <4D90859D.70704__9373.18128203533$1301317114$gmane$org@zytor.com>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110325113048.GC29521@elte.hu>
	<alpine.LFD.2.02.1103260036300.28928@x980>
	<201103272340.42748.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 03/27/2011 02:40 PM, Ondrej Zary wrote:
> 
> I just tested 2.6.38-rc4 on a desktop board and it works (power off at least). 
> If using Grub2, linux16 command must be used instead of linux in grub.cfg 
> (otherwise loading apm module will fail with "apm: BIOS not found").
> 

This is just Yet Another Example of the Grub2 people doing things in the
absolutely most idiotic way possible by default, and then blaming the user.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
