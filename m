From: Zhang Rui <rui.zhang@intel.com>
Subject: [linux-next] [PATCH V2 1/4] swsusp: call plaform_begin
	before	swsusp_shrinnk_memory
Date: Fri, 11 Jul 2008 13:29:06 +0800
Message-ID: <1215754146.1617.58.camel__1978.74257942221$1215754855$gmane$org@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, Ingo Molnar <mingo@elte.hu>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
List-Id: linux-pm@vger.kernel.org


call platform_begin before swsusp shrink memory so that
we can allocate enough pages for ACPI NVS memory region
in platform_begin.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 kernel/power/disk.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/kernel/power/disk.c
===================================================================
--- linux-2.6.orig/kernel/power/disk.c	2008-07-01 09:32:36.000000000 +0800
+++ linux-2.6/kernel/power/disk.c	2008-07-03 09:08:20.000000000 +0800
@@ -243,12 +243,12 @@
 {
 	int error;
 
-	/* Free memory before shutting down devices. */
-	error = swsusp_shrink_memory();
+	error = platform_begin(platform_mode);
 	if (error)
 		return error;
 
-	error = platform_begin(platform_mode);
+	/* Free memory before shutting down devices. */
+	error = swsusp_shrink_memory();
 	if (error)
 		goto Close;
 
