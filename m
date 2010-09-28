From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PM / Hibernate / x86: Change RESTORE_MAGIC
	on x86_64
Date: Wed, 29 Sep 2010 01:12:11 +0200
Message-ID: <201009290112.11363.rjw__20867.3588269905$1285715722$gmane$org@sisk.pl>
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
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

On x86_64 the configuration and version of the kernel that
hibernates and creates a system image may be different from the
configuration and version of the boot kernel that loads the image.
So long as both these kernels are built with the same value of
RESTORE_MAGIC, the image created by one of them should be
successfully loaded and restored by the other one.

It wasn't necessary to modify RESTORE_MAGIC in the past, but now
that we are adding compression to the in-kernel hibernate code,
change the value of RESTORE_MAGIC so that earlier kernels don't
try to load compressed images they can't handle.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/power/hibernate_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/x86/power/hibernate_64.c
===================================================================
--- linux-2.6.orig/arch/x86/power/hibernate_64.c
+++ linux-2.6/arch/x86/power/hibernate_64.c
@@ -137,7 +137,7 @@ struct restore_data_record {
 	unsigned long magic;
 };
 
-#define RESTORE_MAGIC	0x0123456789ABCDEFUL
+#define RESTORE_MAGIC	0x0123456789ABCDF0UL
 
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
