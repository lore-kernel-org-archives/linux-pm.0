From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Sun, 27 Mar 2011 23:40:31 +0200
Message-ID: <201103272340.42748.linux__2841.46821727536$1301262196$gmane$org@rainbow-software.org>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<20110325113048.GC29521@elte.hu>
	<alpine.LFD.2.02.1103260036300.28928@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1103260036300.28928@x980>
Content-Disposition: inline
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 26 March 2011 06:01:38 Len Brown wrote:
> > Regardless of removal, i'd suggest a "this code is not supported" kind of
> > WARN() message to the APM code today, into .39 - to see whether it pops
> > up anywhere - and mark it for -stable as well.
>
> Okay, can do.
>
> > .42 removal might be too fast, considering the typical release schedule
> > of Linux distributions. And i'm still doubting the removal itself: we are
> > adding lots of special-purpose subarch drivers to arch/x86/ as we speak
> > (the embedded mess coming to x86) - which drivers will be tomorrow's APM
> > code. On what grounds do we treat APM support differently?
> >
> > Our general compatibility with old hardware is an *asset* that we should
> > value.
>
> My guess is that the customers have died off,
> and so the code is no longer an asset, but a maintenance liability.
>
> If there is a buzzing community of people running 2011
> linux kernels on their ancient laptops in APM mode,
> then the APM maintainer would probably know about them.
>
> Personally, my oldest usable laptop is a T23 from March 2002.
> It supports APM and ACPI (it shipped with Win2K).
> Linux works well on it in ACPI mode, but doesn't even boot in APM mode.
> If anybody was really using the latest kernel in APM mode,
> I suspect this laptop would boot...
>
> Is there somebody on LKML that has a older laptop than me
> and is able to get it to boot in APM mode?  I'd be astonished
> if there was not.  Are they willing to regularly test changes
> to the upstream kernel to make sure that APM still works?
> If yes, where have they been for the last 5 years?

I just tested 2.6.38-rc4 on a desktop board and it works (power off at least). 
If using Grub2, linux16 command must be used instead of linux in grub.cfg 
(otherwise loading apm module will fail with "apm: BIOS not found").

I also have some working laptops with APM but haven't tried recent kernels 
yet.

> I suspect when there is nobody using the latest kernel on mrst,
> then the latest kernel can delete support for mrst, and nobody will care.
> Like APM, it will probably undergo "maintenance without testing",
> aka bit rot, for a period before that happens.

-- 
Ondrej Zary
