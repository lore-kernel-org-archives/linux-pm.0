From: tip-bot for Wanpeng Li <tipbot@zytor.com>
Subject: [tip:x86/timers] x86/tsc_msr: Fix rdmsr(MSR_PLATFORM_INFO) unsafe
 warning in KVM guest
Date: Mon, 11 Jul 2016 00:40:19 -0700
Message-ID: <tip-37c528ee1af7f24eb31f4195b8b7d4f23e6c716d@git.kernel.org>
References: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	  wanpeng.li@hotmail.com, rjw@rjwysocki.net, peterz@infradead.org,
	  pbonzini@redhat.com, rkrcmar@redhat.com, xiaolong.ye@intel.com,
	  mingo@kernel.org, hpa@zytor.com, rui.zhang@intel.com,
	  tglx@linutronix.de, y.c.chen@intel.com, linux-pm@vger.kernel.org,
	  len.brown@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38996 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbcGKHlJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jul 2016 03:41:09 -0400
In-Reply-To: <1466558908-3524-1-git-send-email-wanpeng.li@hotmail.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: len.brown@intel.com, linux-pm@vger.kernel.org, y.c.chen@intel.com, tglx@linutronix.de, rui.zhang@intel.com, hpa@zytor.com, mingo@kernel.org, xiaolong.ye@intel.com, rkrcmar@redhat.com, pbonzini@redhat.com, rjw@rjwysocki.net, peterz@infradead.org, wanpeng.li@hotmail.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

Commit-ID:  37c528ee1af7f24eb31f4195b8b7d4f23e6c716d
Gitweb:     http://git.kernel.org/tip/37c528ee1af7f24eb31f4195b8b7d4f23=
e6c716d
Author:     Wanpeng Li <wanpeng.li@hotmail.com>
AuthorDate: Wed, 22 Jun 2016 09:28:28 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Jul 2016 09:20:36 +0200

x86/tsc_msr: Fix rdmsr(MSR_PLATFORM_INFO) unsafe warning in KVM guest

After this commit:

  fc273eeef314 ("x86/tsc_msr: Extend to include Intel Core Architecture=
")

The following unsafe MSR reading warning triggers:

  WARNING: CPU: 0 PID: 0 at arch/x86/mm/extable.c:50 ex_handler_rdmsr_u=
nsafe+0x6a/0x70
  unchecked MSR access error: RDMSR from 0xce
    Call Trace:
   dump_stack+0x67/0x99
   __warn+0xd1/0xf0
   warn_slowpath_fmt+0x4f/0x60
   ex_handler_rdmsr_unsafe+0x6a/0x70
   fixup_exception+0x39/0x50
   do_general_protection+0x93/0x1b0
   general_protection+0x22/0x30
   ? cpu_khz_from_msr+0xd8/0x1c0
   native_calibrate_cpu+0x30/0x5b0
   tsc_init+0x2b/0x297
   x86_late_time_init+0xf/0x11
   start_kernel+0x398/0x451
   ? set_init_arg+0x55/0x55
   x86_64_start_reservations+0x2f/0x31
   x86_64_start_kernel+0xea/0xed

As Radim pointed out before:

| MSR_PLATFORM_INFO: Intel changes it from family to family and there i=
s
| no obvious overlap or default.  If we picked 0 (any other fixed value=
),
| then the guest would have to know that 0 doesn't mean that
| MSR_PLATFORM_INFO returned 0, but that KVM doesn't emulate this MSR a=
nd
| the value cannot be used.  This is very similar to handling a #GP in =
the
| guest, but also has a disadvantage, because KVM cannot say that
| MSR_PLATFORM_INFO is 0.  Simple emulation is not possible.

=46ix it by using rdmsr_safe(MSR_PLATFORM_INFO) in KVM guest to
not trigger a #GP, then tsc will be calibrated by a fallback
method: PIT, HPET etc.

Reported-by: kernel test robot <xiaolong.ye@intel.com>
Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Chen Yu <y.c.chen@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: jacob.jun.pan@intel.com
Cc: kvm@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: lkp@01.org
Link: http://lkml.kernel.org/r/1466558908-3524-1-git-send-email-wanpeng=
=2Eli@hotmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/tsc_msr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index e0c2b30..e6e465e 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -70,7 +70,7 @@ static int match_cpu(u8 family, u8 model)
  */
 unsigned long cpu_khz_from_msr(void)
 {
-	u32 lo, hi, ratio, freq_id, freq;
+	u32 lo, hi, freq_id, freq, ratio =3D 0;
 	unsigned long res;
 	int cpu_index;
=20
@@ -123,8 +123,8 @@ unsigned long cpu_khz_from_msr(void)
 	}
=20
 get_ratio:
-	rdmsr(MSR_PLATFORM_INFO, lo, hi);
-	ratio =3D (lo >> 8) & 0xff;
+	if (!rdmsr_safe(MSR_PLATFORM_INFO, &lo, &hi))
+		ratio =3D (lo >> 8) & 0xff;
=20
 done:
 	/* TSC frequency =3D maximum resolved freq * maximum resolved bus rat=
io */
