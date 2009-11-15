From: Ingo Molnar <mingo@elte.hu>
Subject: Re: resume crashes in intel_init_thermal [was: mmotm
 2009-11-13-19-59 uploaded]
Date: Sun, 15 Nov 2009 09:07:18 +0100
Message-ID: <20091115080718.GB15432__36608.631295576$1258272640$gmane$org@elte.hu>
References: <200911140403.nAE43CN1016851@imap1.linux-foundation.org>
	<4AFEB060.80007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: "Brown, Len" <len.brown@intel.com>, mm-commits@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Jiri Slaby <jirislaby@gmail.com> wrote:

> On 11/14/2009 05:03 AM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2009-11-13-19-59 has been uploaded to
> 
> Hi, resume from ram dies in intel_init_thermal in that kernel:
> http://www.fi.muni.cz/~xslaby/sklad/mce_oops.png
> 
> The code is cc cc cc cc ... KGDB and KPROBES are off, I don't know where
> the pattern may come from.
> 
> Does it ring a bell? Any ideas? mmotm 2009-11-01-10-01 was OK.

This is a known bug - see the fix below.

	Ingo

-------------->
>From cffd377e5879ea58522224a785a083f201afd80e Mon Sep 17 00:00:00 2001
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Date: Thu, 12 Nov 2009 15:52:40 +0900
Subject: [PATCH] x86, mce: Fix __init annotations

The intel_init_thermal() is called from resume path, so it
cannot be marked as __init.

OTOH mce_banks_init() is only called from
__mcheck_cpu_cap_init() which is marked as __cpuinit, so it can
be also marked as __cpuinit.

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Acked-by: Yong Wang <yong.y.wang@linux.intel.com>
LKML-Reference: <4AFBB0B8.2070501@jp.fujitsu.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/kernel/cpu/mcheck/mce.c         |    4 ++--
 arch/x86/kernel/cpu/mcheck/therm_throt.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 0d41020..5f277ca 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1201,7 +1201,7 @@ int mce_notify_irq(void)
 }
 EXPORT_SYMBOL_GPL(mce_notify_irq);
 
-static int mce_banks_init(void)
+static int __cpuinit __mcheck_cpu_mce_banks_init(void)
 {
 	int i;
 
@@ -1242,7 +1242,7 @@ static int __cpuinit __mcheck_cpu_cap_init(void)
 	WARN_ON(banks != 0 && b != banks);
 	banks = b;
 	if (!mce_banks) {
-		int err = mce_banks_init();
+		int err = __mcheck_cpu_mce_banks_init();
 
 		if (err)
 			return err;
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 8a73d5c..4fef985 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -268,7 +268,7 @@ void __init mcheck_intel_therm_init(void)
 		lvtthmr_init = apic_read(APIC_LVTTHMR);
 }
 
-void __init intel_init_thermal(struct cpuinfo_x86 *c)
+void intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	unsigned int cpu = smp_processor_id();
 	int tm2 = 0;
