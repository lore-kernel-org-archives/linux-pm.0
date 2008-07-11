From: "Stoyan Gaydarov" <stoyboyker@gmail.com>
Subject: [PATCH] ioctl conversion
Date: Thu, 10 Jul 2008 19:28:16 -0500
Message-ID: <6d291e080807101728j62be7c93qba11aa214a8dfe1__14842.9787638181$1215787135$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: rjw@sisk.pl, pavel@suse.cz
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This changes the ioctl usage of kernel/power/user.c to use the unlocked_ioctl

Signed-off-by: Stoyan Gaydarov <stoyboyker@gmail.com>

diff -uprN linux-2.6.26-rc9/kernel/power/user.c devel/kernel/power/user.c
--- linux-2.6.26-rc9/kernel/power/user.c        2008-07-05
17:53:22.000000000 -0500
+++ devel/kernel/power/user.c   2008-07-10 19:26:42.000000000 -0500
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/smp_lock.h>
 #include <linux/pm.h>
 #include <linux/fs.h>
 #include <linux/console.h>
@@ -164,20 +165,28 @@ static ssize_t snapshot_write(struct fil
        return res;
 }

-static int snapshot_ioctl(struct inode *inode, struct file *filp,
-                          unsigned int cmd, unsigned long arg)
+static long snapshot_ioctl(struct file *filp, unsigned int cmd,
+                          unsigned long arg)
 {
        int error = 0;
        struct snapshot_data *data;
        loff_t size;
        sector_t offset;

-       if (_IOC_TYPE(cmd) != SNAPSHOT_IOC_MAGIC)
+       lock_kernel();
+
+       if (_IOC_TYPE(cmd) != SNAPSHOT_IOC_MAGIC) {
+               unlock_kernel();
                return -ENOTTY;
-       if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR)
+       }
+       if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR) {
+               unlock_kernel();
                return -ENOTTY;
-       if (!capable(CAP_SYS_ADMIN))
+       }
+       if (!capable(CAP_SYS_ADMIN)) {
+               unlock_kernel();
                return -EPERM;
+       }

        data = filp->private_data;

@@ -390,6 +399,7 @@ static int snapshot_ioctl(struct inode *

        }

+       unlock_kernel();
        return error;
 }

@@ -399,7 +409,7 @@ static const struct file_operations snap
        .read = snapshot_read,
        .write = snapshot_write,
        .llseek = no_llseek,
-       .ioctl = snapshot_ioctl,
+       .unlocked_ioctl = snapshot_ioctl,
 };

 static struct miscdevice snapshot_device = {
