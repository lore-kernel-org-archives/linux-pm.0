From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 7/7] xen/acpi/sleep: Register to the
	acpi_suspend_lowlevel a callback.
Date: Wed, 31 Aug 2011 14:31:24 -0400
Message-ID: <1314815484-4668-8-git-send-email-konrad.wilk__36768.6424790465$1314918100$gmane$org@oracle.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org, tglx@linutronix.de, tboot-devel@lists.sourceforge.net, shane.wang@intel.com, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, len.brown@in
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-pm@vger.kernel.org

We piggyback on "x86/acpi: Provide registration for acpi_suspend_lowlevel."
to register a Xen version of the callback. The callback does not
do anything special - except it omits the x86_acpi_suspend_lowlevel.
It does that b/c during suspend it tries to save cr8 values (which
the hypervisor does not support), and then on resume path the
cr3, cr8, idt, and gdt are all resumed which clashes with what
the hypervisor has set up for the guest.

Signed-off-by: Liang Tang <liang.tang@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 include/xen/acpi.h |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/include/xen/acpi.h b/include/xen/acpi.h
index e414f14..0409919 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -12,10 +12,22 @@ int xen_acpi_notify_hypervisor_state(u8 sleep_state,
 				     u32 pm1a_cnt, u32 pm1b_cnd,
 				     bool *skip_rest);
 
+static inline int xen_acpi_suspend_lowlevel(void)
+{
+	/*
+	 * Xen will save and restore CPU context, so
+	 * we can skip that and just go straight to
+	 * the suspend.
+	 */
+	acpi_enter_sleep_state(ACPI_STATE_S3);
+	return 0;
+}
 static inline void xen_acpi_sleep_register(void)
 {
-	if (xen_initial_domain())
+	if (xen_initial_domain()) {
+		acpi_suspend_lowlevel = xen_acpi_suspend_lowlevel;
 		__acpi_override_sleep = xen_acpi_notify_hypervisor_state;
+	}
 }
 #else
 static inline void xen_acpi_sleep_register(void)
-- 
1.7.4.1
