From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/9] x86 idle: remove NOP
	cpuinfo_x86.hlt_works_ok flag
Date: Thu, 31 Mar 2011 08:12:47 +0200
Message-ID: <20110331061247.GA24786__32479.1000494317$1301552309$gmane$org@elte.hu>
References: <67e90d97e0a77df4acd0c75e1bacc7714e011f3e.1301550524.git.len.brown@intel.com>
	<b048802b0285a5ff28e74a4309d833116174904a.1301550524.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <b048802b0285a5ff28e74a4309d833116174904a.1301550524.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> From: Len Brown <len.brown@intel.com>
> 
> hlt_works_ok was X86_32 only, initialized to 1, and never cleared.
> 
> On 32-bit kernels, this deletes a line from /proc/cpuinfo: "hlt_bug : no"

I think you missed the valid usecase where an old CPU with broken halt is 
booted with the no-hlt boot parameter and does not want to crash in the HLT 
instruction.

That "no-hlt" boot parameter does:

  arch/x86/kernel/cpu/bugs.c:     boot_cpu_data.hlt_works_ok = 0;

We can restrict compatibility, but *please* lets do it *explicitly*, not under 
some 'remove unused code' pretense ...

Could you please list all CPU models that are affected?

Thanks,

	Ingo
