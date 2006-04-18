From: Adrian Bunk <bunk@stusta.de>
Subject: [-mm patch] kernel/power/snapshot.c: cleanups
Date: Wed, 19 Apr 2006 00:17:41 +0200
Message-ID: <20060418221741.GY11582@stusta.de>
References: <20060418031423.3cbef2f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48216240601013083=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060418031423.3cbef2f7.akpm@osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, linux-pm@osdl.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============48216240601013083==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch contains the following cleanups:
- make needlessly global functions static
- make dummy functions static inline

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/power/snapshot.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- linux-2.6.17-rc1-mm3-full/kernel/power/snapshot.c.old	2006-04-18 22:29:56.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/kernel/power/snapshot.c	2006-04-18 22:37:56.000000000 +0200
@@ -112,7 +112,7 @@
 }
 
 #ifdef CONFIG_HIGHMEM
-unsigned int count_highmem_pages(void)
+static unsigned int count_highmem_pages(void)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
@@ -189,7 +189,7 @@
 	return 0;
 }
 
-int save_highmem(void)
+static int save_highmem(void)
 {
 	struct zone *zone;
 	int res = 0;
@@ -206,7 +206,7 @@
 	return 0;
 }
 
-int restore_highmem(void)
+static int restore_highmem(void)
 {
 	printk("swsusp: Restoring Highmem\n");
 	while (highmem_copy) {
@@ -223,9 +223,9 @@
 	return 0;
 }
 #else
-static unsigned int count_highmem_pages(void) {return 0;}
-static int save_highmem(void) {return 0;}
-static int restore_highmem(void) {return 0;}
+static inline unsigned int count_highmem_pages(void) {return 0;}
+static inline int save_highmem(void) {return 0;}
+static inline int restore_highmem(void) {return 0;}
 #endif
 
 unsigned int count_special_pages(void)
@@ -472,7 +472,8 @@
  *	On each page we set up a list of struct_pbe elements.
  */
 
-struct pbe *alloc_pagedir(unsigned int nr_pages, gfp_t gfp_mask, int safe_needed)
+static struct pbe *alloc_pagedir(unsigned int nr_pages, gfp_t gfp_mask,
+				 int safe_needed)
 {
 	unsigned int num;
 	struct pbe *pblist, *pbe;


--===============48216240601013083==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48216240601013083==--
