From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Sat, 26 Mar 2011 10:31:31 +0100
Message-ID: <20110326093131.GA8706__6700.59436602077$1301131973$gmane$org@elte.hu>
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

> Personally, my oldest usable laptop is a T23 from March 2002.
> It supports APM and ACPI (it shipped with Win2K).
> Linux works well on it in ACPI mode, but doesn't even boot in APM mode.
> If anybody was really using the latest kernel in APM mode,
> I suspect this laptop would boot...

I boot non-ACPI kernels all the time:

  mercury:~> grep -E 'PM|ACPI' /proc/config.gz 
  mercury:~> 
  mercury:~> uname -a
  Linux mercury 2.6.38-tip+ #110579 SMP Sat Mar 26 11:47:58 CET 2011 x86_64 x86_64 x86_64 GNU/Linux

How does it fail for you?

Could you describe the steps you'd like to see from folks using APM to see it 
tested? What kernel configs, BIOS options, etc., what should they see in the 
syslog, etc. - to make sure APM mode is still working fine?

Thanks,

	Ingo
