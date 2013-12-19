From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 idle: repair large-server 50-watt idle-power regression
Date: Thu, 19 Dec 2013 08:13:21 -0800
Message-ID: <52B31B21.6010901@zytor.com>
References: <baff264285f6e585df757d58b17788feabc68918.1387403066.git.len.brown@intel.com> <20131219122257.GC11279@gmail.com> <52B316FF.50906@zytor.com> <20131219160210.GA28426@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000906000501000406070602"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131219160210.GA28426@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Len Brown <lenb@kernel.org>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Mike Galbraith <efault@gmx.de>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------000906000501000406070602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

How does this look?  Completely untested, of course.

I do wonder if we need more memory barriers, though.

An alternative would be to move everything into mwait_idle_with_hints().

	-hpa


--------------000906000501000406070602
Content-Type: text/plain; charset=UTF-8;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="diff"

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 7b034a4057f9..6dce588f94b4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -723,6 +723,23 @@ static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 		     :: "a" (eax), "c" (ecx));
 }
 
+/*
+ * Issue a clflush in preparation for a monitor instruction if the CPU
+ * needs it.  We force the address into the ax register to get a fixed
+ * length for the instruction, however, this is what the monitor instruction
+ * is going to need anyway, so it shouldn't add any additional code.
+ */
+static inline void clflush_monitor(const void *addr, unsigned long ecx,
+				   unsigned long edx)
+{
+	alternative_input(ASM_NOP3,
+			  "clflush (%0)",
+			  X86_FEATURE_CLFLUSH_MONITOR,
+			  "a" (addr));
+	__monitor(addr, eax, edx);
+	smp_mb();
+}
+
 extern void select_idle_routine(const struct cpuinfo_x86 *c);
 extern void init_amd_e400_c1e_mask(void);
 
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index d2b7f27781bc..b14d02354134 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -163,11 +163,7 @@ EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
 void mwait_idle_with_hints(unsigned long ax, unsigned long cx)
 {
 	if (!need_resched()) {
-		if (this_cpu_has(X86_FEATURE_CLFLUSH_MONITOR))
-			clflush((void *)&current_thread_info()->flags);
-
-		__monitor((void *)&current_thread_info()->flags, 0, 0);
-		smp_mb();
+		clflush_monitor(&current_thread_info()->flags, 0, 0);
 		if (!need_resched())
 			__mwait(ax, cx);
 	}

--------------000906000501000406070602--
