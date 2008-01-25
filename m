From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 3/5] HWRNG: Add possibility to remove hwrng
	devices during suspend/resume
Date: Fri, 25 Jan 2008 01:35:24 +0100
Message-ID: <200801250135.26009.rjw__38362.7449548387$1201222271$gmane$org@sisk.pl>
References: <200801250127.21966.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801250127.21966.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Buesch <mb@bu3sch.de>, LKML <linux-kernel@vger.kernel.org>, Alessandro Rubini <rubini@vision.unipv.it>, pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Make it possible to unregister a Hardware Random Number Generator
device object in a safe way during a suspend/resume cycle.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Michael Buesch <mb@bu3sch.de>
---
 drivers/char/hw_random/core.c |   10 +++++-----
 include/linux/hw_random.h     |   10 +++++++++-
 2 files changed, 14 insertions(+), 6 deletions(-)

Index: linux-2.6.24-rc8-mm1/drivers/char/hw_random/core.c
===================================================================
--- linux-2.6.24-rc8-mm1.orig/drivers/char/hw_random/core.c
+++ linux-2.6.24-rc8-mm1/drivers/char/hw_random/core.c
@@ -234,11 +234,11 @@ static DEVICE_ATTR(rng_available, S_IRUG
 		   NULL);
 
 
-static void unregister_miscdev(void)
+static void unregister_miscdev(bool suspended)
 {
 	device_remove_file(rng_miscdev.this_device, &dev_attr_rng_available);
 	device_remove_file(rng_miscdev.this_device, &dev_attr_rng_current);
-	misc_deregister(&rng_miscdev);
+	__misc_deregister(&rng_miscdev, suspended);
 }
 
 static int register_miscdev(void)
@@ -313,7 +313,7 @@ out:
 }
 EXPORT_SYMBOL_GPL(hwrng_register);
 
-void hwrng_unregister(struct hwrng *rng)
+void __hwrng_unregister(struct hwrng *rng, bool suspended)
 {
 	int err;
 
@@ -332,11 +332,11 @@ void hwrng_unregister(struct hwrng *rng)
 		}
 	}
 	if (list_empty(&rng_list))
-		unregister_miscdev();
+		unregister_miscdev(suspended);
 
 	mutex_unlock(&rng_mutex);
 }
-EXPORT_SYMBOL_GPL(hwrng_unregister);
+EXPORT_SYMBOL_GPL(__hwrng_unregister);
 
 
 MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver");
Index: linux-2.6.24-rc8-mm1/include/linux/hw_random.h
===================================================================
--- linux-2.6.24-rc8-mm1.orig/include/linux/hw_random.h
+++ linux-2.6.24-rc8-mm1/include/linux/hw_random.h
@@ -44,7 +44,15 @@ struct hwrng {
 /** Register a new Hardware Random Number Generator driver. */
 extern int hwrng_register(struct hwrng *rng);
 /** Unregister a Hardware Random Number Generator driver. */
-extern void hwrng_unregister(struct hwrng *rng);
+extern void __hwrng_unregister(struct hwrng *rng, bool suspended);
+static inline void hwrng_unregister(struct hwrng *rng)
+{
+	__hwrng_unregister(rng, false);
+}
+static inline void hwrng_unregister_suspended(struct hwrng *rng)
+{
+	__hwrng_unregister(rng, true);
+}
 
 #endif /* __KERNEL__ */
 #endif /* LINUX_HWRANDOM_H_ */
