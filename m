From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PM / Hibernate: Modify signature used to
	mark swap
Date: Wed, 29 Sep 2010 23:13:23 +0200
Message-ID: <201009292313.23601.rjw__37533.0468909398$1285794956$gmane$org@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / Hibernate: Modify signature used to mark swap

Since we are adding compression to the kernel's hibernate code,
change signature used by it to mark swap spaces, so that earlier
kernels don't attempt to restore compressed images they cannot
handle.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/swap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/kernel/power/swap.c
===================================================================
--- linux-2.6.orig/kernel/power/swap.c
+++ linux-2.6/kernel/power/swap.c
@@ -29,7 +29,7 @@
 
 #include "power.h"
 
-#define SWSUSP_SIG	"S1SUSPEND"
+#define HIBERNATE_SIG	"LINHIB0001"
 
 /*
  *	The swap map is a data structure used for keeping track of each page
@@ -195,7 +195,7 @@ static int mark_swapfiles(struct swap_ma
 	if (!memcmp("SWAP-SPACE",swsusp_header->sig, 10) ||
 	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
 		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
-		memcpy(swsusp_header->sig,SWSUSP_SIG, 10);
+		memcpy(swsusp_header->sig, HIBERNATE_SIG, 10);
 		swsusp_header->image = handle->first_sector;
 		swsusp_header->flags = flags;
 		error = hib_bio_write_page(swsusp_resume_block,
@@ -916,7 +916,7 @@ int swsusp_check(void)
 		if (error)
 			goto put;
 
-		if (!memcmp(SWSUSP_SIG, swsusp_header->sig, 10)) {
+		if (!memcmp(HIBERNATE_SIG, swsusp_header->sig, 10)) {
 			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
 			/* Reset swap signature now */
 			error = hib_bio_write_page(swsusp_resume_block,
