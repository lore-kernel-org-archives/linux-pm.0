From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: resume crashes in intel_init_thermal [was: mmotm
 2009-11-13-19-59 uploaded]
Date: Sat, 14 Nov 2009 08:15:49 -0800
Message-ID: <20091114081549.1477fabc.akpm@linux-foundation.org>
References: <200911140403.nAE43CN1016851@imap1.linux-foundation.org>
	<4AFEB060.80007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4AFEB060.80007@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, Linux-pm@smtp1.linux-foundation.org, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Yong Wang <yong.y.wang@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 14 Nov 2009 14:28:00 +0100 Jiri Slaby <jirislaby@gmail.com> wrote:

> On 11/14/2009 05:03 AM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2009-11-13-19-59 has been uploaded to
> 
> Hi, resume from ram dies in intel_init_thermal in that kernel:
> http://www.fi.muni.cz/~xslaby/sklad/mce_oops.png

lol.

> The code is cc cc cc cc ... KGDB and KPROBES are off, I don't know where
> the pattern may come from.
> 
> Does it ring a bell? Any ideas? mmotm 2009-11-01-10-01 was OK.

From: Andrew Morton <akpm@linux-foundation.org>

Revert

: commit ce6b5d768c79b9d5dd6345c033bae781d5ca9b8e
: Author:     Yong Wang <yong.y.wang@linux.intel.com>
: AuthorDate: Wed Nov 11 15:51:25 2009 +0800
: Commit:     Ingo Molnar <mingo@elte.hu>
: CommitDate: Wed Nov 11 12:33:32 2009 +0100
: 
:     x86: Mark the thermal init functions __init

because intel_init_thermal() is called from mce_intel_feature_init() at
resume time, and we'd like its text to still be in memory when that
happens.

Reported-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Yong Wang <yong.y.wang@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/kernel/cpu/mcheck/therm_throt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/x86/kernel/cpu/mcheck/therm_throt.c~revert-1 arch/x86/kernel/cpu/mcheck/therm_throt.c
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c~revert-1
+++ a/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -256,7 +256,7 @@ asmlinkage void smp_thermal_interrupt(st
 	ack_APIC_irq();
 }
 
-void __init mcheck_intel_therm_init(void)
+void mcheck_intel_therm_init(void)
 {
 	/*
 	 * This function is only called on boot CPU. Save the init thermal
@@ -268,7 +268,7 @@ void __init mcheck_intel_therm_init(void
 		lvtthmr_init = apic_read(APIC_LVTTHMR);
 }
 
-void __init intel_init_thermal(struct cpuinfo_x86 *c)
+void intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	unsigned int cpu = smp_processor_id();
 	int tm2 = 0;
_
