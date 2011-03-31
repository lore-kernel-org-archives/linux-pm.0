From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/9] x86 idle: remove NOP
	cpuinfo_x86.hlt_works_ok flag
Date: Thu, 31 Mar 2011 03:02:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103310252160.8569__40465.2209872895$1301555051$gmane$org@x980>
References: <67e90d97e0a77df4acd0c75e1bacc7714e011f3e.1301550524.git.len.brown@intel.com>
	<b048802b0285a5ff28e74a4309d833116174904a.1301550524.git.len.brown@intel.com>
	<20110331061247.GA24786@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20110331061247.GA24786@elte.hu>
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
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> > hlt_works_ok was X86_32 only, initialized to 1, and never cleared.
> > 
> > On 32-bit kernels, this deletes a line from /proc/cpuinfo: "hlt_bug : no"
> 
> I think you missed the valid usecase where an old CPU with broken halt is 
> booted with the no-hlt boot parameter and does not want to crash in the HLT 
> instruction.
> 
> That "no-hlt" boot parameter does:
> 
>   arch/x86/kernel/cpu/bugs.c:     boot_cpu_data.hlt_works_ok = 0;
> 
> We can restrict compatibility, but *please* lets do it *explicitly*, not under 
> some 'remove unused code' pretense ...
> 
> Could you please list all CPU models that are affected?

"no-hlt" existed only for 32-bit, and there were exactly zero
automatic invocations of it.

"idle=poll" does the same thing -- sans change a line
in /proc/cpuinfo.

Do we really need both?

thanks,
-Len
