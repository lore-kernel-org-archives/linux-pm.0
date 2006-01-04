From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface
	(rev. 2)
Date: Wed, 4 Jan 2006 23:51:58 +0100
Message-ID: <200601042351.58667.rjw@sisk.pl>
References: <200601042340.42118.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============90812662449431558=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601042340.42118.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============90812662449431558==
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id k04N70DZ000753

This patch adds a user space interface for swsusp. =C2=A0The interface is=
 based
on the special character device allowing user space processes to perform
suspend and resume-related operations with the help of some ioctls and
the read()/write() functions. =C2=A0Additionally it allows these processe=
s to
allocate swap pages so that they know which sectors of the resume partiti=
on
are available to them (it is also possible to free the allocated swap pag=
es).

Currently the major number of the device is allocated dynamically,
so it is exported via sysfs for convenience, but I'd like the device to
have a well-defined major number in the future, if possible/acceptable.

The interface uses the same low-level snapshot-handling functions that
are used by the in-kernel swap-writing/reading code of swsusp.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 init/do_mounts_initrd.c |    1=20
 kernel/power/Makefile   |    2=20
 kernel/power/power.h    |   46 ++++++
 kernel/power/swsusp.c   |   69 ++++------
 kernel/power/user.c     |  325 +++++++++++++++++++++++++++++++++++++++++=
+++++++
 5 files changed, 402 insertions(+), 41 deletions(-)

Index: linux-2.6.15-rc5-mm3/kernel/power/user.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm3/kernel/power/user.c	2006-01-04 20:27:47.00000000=
0 +0100
@@ -0,0 +1,325 @@
+/*
+ * linux/kernel/power/user.c
+ *
+ * This file provides the user space interface for software suspend/resu=
me.
+ *
+ * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * This file is released under the GPLv2.
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/syscalls.h>
+#include <linux/string.h>
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/pm.h>
+#include <linux/uaccess.h>
+#include <linux/fs.h>
+
+#include "power.h"
+
+struct snapshot_dev {
+	char *name;
+	dev_t devno;
+	struct cdev cdev;
+	struct snapshot_handle handle;
+	int swap;
+	struct bitmap_page *bitmap;
+	int mode;
+	char frozen;
+	char ready;
+};
+
+static atomic_t device_available =3D ATOMIC_INIT(1);
+
+int snapshot_open(struct inode *inode, struct file *filp)
+{
+	struct snapshot_dev *dev;
+
+	if (!atomic_dec_and_test(&device_available)) {
+		atomic_inc(&device_available);
+		return -EBUSY;
+	}
+
+	if ((filp->f_flags & O_ACCMODE) =3D=3D O_RDWR)
+		return -ENOSYS;
+
+	nonseekable_open(inode, filp);
+	dev =3D container_of(inode->i_cdev, struct snapshot_dev, cdev);
+	filp->private_data =3D dev;
+	memset(&dev->handle, 0, sizeof(struct snapshot_handle));
+	if ((filp->f_flags & O_ACCMODE) =3D=3D O_RDONLY) {
+		dev->swap =3D swsusp_get_swap_index();
+		dev->mode =3D O_RDONLY;
+	} else {
+		dev->swap =3D -1;
+		dev->mode =3D O_WRONLY;
+	}
+	dev->bitmap =3D NULL;
+	dev->frozen =3D 0;
+	dev->ready =3D 0;
+
+	return 0;
+}
+
+int snapshot_release(struct inode *inode, struct file *filp)
+{
+	struct snapshot_dev *dev;
+
+	swsusp_free();
+	dev =3D filp->private_data;
+	free_all_swap_pages(dev->swap, dev->bitmap);
+	free_bitmap(dev->bitmap);
+	if (dev->frozen) {
+		down(&pm_sem);
+		thaw_processes();
+		enable_nonboot_cpus();
+		up(&pm_sem);
+	}
+	atomic_inc(&device_available);
+	return 0;
+}
+
+static ssize_t snapshot_read(struct file *filp, char __user *buf,
+                             size_t count, loff_t *offp)
+{
+	struct snapshot_dev *dev;
+	ssize_t res;
+
+	dev =3D filp->private_data;
+	res =3D snapshot_read_next(&dev->handle, count);
+	if (res > 0) {
+		if (copy_to_user(buf, data_of(dev->handle), res))
+			res =3D -EFAULT;
+		else
+			*offp =3D dev->handle.offset;
+	}
+	return res;
+}
+
+static ssize_t snapshot_write(struct file *filp, const char __user *buf,
+                              size_t count, loff_t *offp)
+{
+	struct snapshot_dev *dev;
+	ssize_t res;
+
+	dev =3D filp->private_data;
+	res =3D snapshot_write_next(&dev->handle, count);
+	if (res > 0) {
+		if (copy_from_user(data_of(dev->handle), buf, res))
+			res =3D -EFAULT;
+		else
+			*offp =3D dev->handle.offset;
+	}
+	return res;
+}
+
+static int snapshot_ioctl(struct inode *inode, struct file *filp,
+                          unsigned int cmd, unsigned long arg)
+{
+	int error =3D 0;
+	struct snapshot_dev *dev;
+	unsigned long offset;
+	unsigned int n;
+
+	if (_IOC_TYPE(cmd) !=3D SNAPSHOT_IOC_MAGIC)
+		return -ENOTTY;
+	if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR)
+		return -ENOTTY;
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	dev =3D filp->private_data;
+
+	switch (cmd) {
+
+	case SNAPSHOT_IOCFREEZE:
+		if (dev->frozen)
+			break;
+		sys_sync();
+		down(&pm_sem);
+		disable_nonboot_cpus();
+		if (freeze_processes())
+			error =3D -EBUSY;
+		up(&pm_sem);
+		if (!error)
+			dev->frozen =3D 1;
+		break;
+
+	case SNAPSHOT_IOCUNFREEZE:
+		if (!dev->frozen)
+			break;
+		down(&pm_sem);
+		thaw_processes();
+		enable_nonboot_cpus();
+		up(&pm_sem);
+		dev->frozen =3D 0;
+		break;
+
+	case SNAPSHOT_IOCATOMIC_SNAPSHOT:
+		if (dev->mode !=3D O_RDONLY || !dev->frozen  || dev->ready) {
+			error =3D -EPERM;
+			break;
+		}
+		down(&pm_sem);
+		pm_prepare_console();
+		/* Free memory before shutting down devices. */
+		error =3D swsusp_shrink_memory();
+		if (!error) {
+			error =3D device_suspend(PMSG_FREEZE);
+			if (!error) {
+				in_suspend =3D 1;
+				error =3D swsusp_suspend();
+				device_resume();
+			}
+		}
+		pm_restore_console();
+		up(&pm_sem);
+		if (!error)
+			error =3D put_user(in_suspend, (unsigned int __user *)arg);
+		if (!error)
+			dev->ready =3D 1;
+		break;
+
+	case SNAPSHOT_IOCATOMIC_RESTORE:
+		if (dev->mode !=3D O_WRONLY || !dev->frozen ||
+		    !snapshot_image_loaded(&dev->handle)) {
+			error =3D -EPERM;
+			break;
+		}
+		down(&pm_sem);
+		pm_prepare_console();
+		error =3D device_suspend(PMSG_FREEZE);
+		if (!error) {
+			mb();
+			error =3D swsusp_resume();
+			device_resume();
+		}
+		pm_restore_console();
+		up(&pm_sem);
+		break;
+
+	case SNAPSHOT_IOCFREE:
+		swsusp_free();
+		memset(&dev->handle, 0, sizeof(struct snapshot_handle));
+		dev->ready =3D 0;
+		break;
+
+	case SNAPSHOT_IOCSET_IMAGE_SIZE:
+		image_size =3D arg;
+		break;
+
+	case SNAPSHOT_IOCAVAIL_SWAP:
+		n =3D swsusp_available_swap(dev->swap);
+		error =3D put_user(n, (unsigned int __user *)arg);
+		break;
+
+	case SNAPSHOT_IOCGET_SWAP_PAGE:
+		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cm=
d))) {
+			error =3D -EINVAL;
+			break;
+		}
+		if (dev->swap < 0 || dev->swap >=3D MAX_SWAPFILES) {
+			error =3D -ENODEV;
+			break;
+		}
+		if (!dev->bitmap) {
+			dev->bitmap =3D alloc_bitmap(swsusp_total_swap(dev->swap));
+			if (!dev->bitmap) {
+				error =3D -ENOMEM;
+				break;
+			}
+		}
+		offset =3D alloc_swap_page(dev->swap, dev->bitmap);
+		if (offset)
+			__put_user(offset, (unsigned long __user *)arg);
+		else
+			error =3D -ENOSPC;
+		break;
+
+	case SNAPSHOT_IOCFREE_SWAP_PAGES:
+		if (dev->swap >=3D 0 && dev->swap < MAX_SWAPFILES) {
+			error =3D -ENODEV;
+			break;
+		}
+		free_all_swap_pages(dev->swap, dev->bitmap);
+		free_bitmap(dev->bitmap);
+		dev->bitmap =3D NULL;
+		break;
+
+	case SNAPSHOT_IOCSET_SWAP_FILE:
+		if (!dev->bitmap) {
+			/*
+			 * User space encodes device types as two-byte values,
+			 * so we need to recode them
+			 */
+			dev->swap =3D swsusp_get_swap_index_of(old_decode_dev(arg));
+			if (dev->swap < 0)
+				error =3D -ENODEV;
+		} else {
+			error =3D -EPERM;
+		}
+		break;
+
+	default:
+		error =3D -ENOTTY;
+
+	}
+
+	return error;
+}
+
+static struct file_operations snapshot_fops =3D {
+	.open =3D snapshot_open,
+	.release =3D snapshot_release,
+	.read =3D snapshot_read,
+	.write =3D snapshot_write,
+	.llseek =3D no_llseek,
+	.ioctl =3D snapshot_ioctl,
+};
+
+static struct snapshot_dev interface =3D {
+	.name =3D "snapshot",
+};
+
+static ssize_t snapshot_show(struct subsystem * subsys, char *buf)
+{
+	return sprintf(buf, "%d:%d\n", MAJOR(interface.devno),
+		       MINOR(interface.devno));
+}
+
+static struct subsys_attribute snapshot_attr =3D {
+	.attr =3D {
+		.name =3D __stringify(snapshot),
+		.mode =3D S_IRUGO,
+	},
+	.show =3D snapshot_show,
+};
+
+static int __init snapshot_dev_init(void)
+{
+	int error;
+
+	error =3D  alloc_chrdev_region(&interface.devno, 0, 1, interface.name);
+	if (error)
+		return error;
+	cdev_init(&interface.cdev, &snapshot_fops);
+	interface.cdev.ops =3D &snapshot_fops;
+	error =3D cdev_add(&interface.cdev, interface.devno, 1);
+	if (error)
+		goto Unregister;
+	error =3D sysfs_create_file(&power_subsys.kset.kobj, &snapshot_attr.att=
r);
+	if (!error)
+		return 0;
+	cdev_del(&interface.cdev);
+Unregister:
+	unregister_chrdev_region(interface.devno, 1);
+	return error;
+};
+
+late_initcall(snapshot_dev_init);
Index: linux-2.6.15-rc5-mm3/kernel/power/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15-rc5-mm3.orig/kernel/power/Makefile	2005-12-31 15:54:11.0=
00000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/Makefile	2006-01-04 20:26:57.000000=
000 +0100
@@ -5,7 +5,7 @@ endif
=20
 obj-y				:=3D main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+=3D pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+=3D swsusp.o disk.o snapshot.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+=3D swsusp.o disk.o snapshot.o user.o
=20
 obj-$(CONFIG_SUSPEND_SMP)	+=3D smp.o
=20
Index: linux-2.6.15-rc5-mm3/init/do_mounts_initrd.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15-rc5-mm3.orig/init/do_mounts_initrd.c	2005-12-31 15:54:11=
.000000000 +0100
+++ linux-2.6.15-rc5-mm3/init/do_mounts_initrd.c	2005-12-31 17:29:04.0000=
00000 +0100
@@ -56,6 +56,7 @@ static void __init handle_initrd(void)
 	sys_chroot(".");
 	mount_devfs_fs ();
=20
+	current->flags |=3D PF_NOFREEZE;
 	pid =3D kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
 		while (pid !=3D sys_wait4(-1, NULL, 0, NULL))
Index: linux-2.6.15-rc5-mm3/kernel/power/power.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15-rc5-mm3.orig/kernel/power/power.h	2005-12-31 16:05:33.00=
0000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/power.h	2006-01-04 20:26:57.0000000=
00 +0100
@@ -77,3 +77,49 @@ struct snapshot_handle {
 extern int snapshot_read_next(struct snapshot_handle *handle, size_t cou=
nt);
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t co=
unt);
 int snapshot_image_loaded(struct snapshot_handle *handle);
+
+#define SNAPSHOT_IOC_MAGIC	'3'
+#define SNAPSHOT_IOCFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 1)
+#define SNAPSHOT_IOCUNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
+#define SNAPSHOT_IOCATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
+#define SNAPSHOT_IOCATOMIC_RESTORE	_IO(SNAPSHOT_IOC_MAGIC, 4)
+#define SNAPSHOT_IOCFREE		_IO(SNAPSHOT_IOC_MAGIC, 5)
+#define SNAPSHOT_IOCSET_IMAGE_SIZE	_IOW(SNAPSHOT_IOC_MAGIC, 6, unsigned =
long)
+#define SNAPSHOT_IOCAVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
+#define SNAPSHOT_IOCGET_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
+#define SNAPSHOT_IOCFREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
+#define SNAPSHOT_IOCSET_SWAP_FILE	_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned =
int)
+#define SNAPSHOT_IOC_MAXNR	10
+
+/**
+ *	The bitmap is used for tracing allocated swap pages
+ *
+ *	The entire bitmap consists of a number of bitmap_page
+ *	structures linked with the help of the .next member.
+ *	Thus each page can be allocated individually, so we only
+ *	need to make 0-order memory allocations to create
+ *	the bitmap.
+ */
+
+#define BITMAP_PAGE_SIZE	(PAGE_SIZE - sizeof(void *))
+#define BITMAP_PAGE_CHUNKS	(BITMAP_PAGE_SIZE / sizeof(long))
+#define BITS_PER_CHUNK		(sizeof(long) * 8)
+#define BITMAP_PAGE_BITS	(BITMAP_PAGE_CHUNKS * BITS_PER_CHUNK)
+
+struct bitmap_page {
+	unsigned long		chunks[BITMAP_PAGE_CHUNKS];
+	struct bitmap_page	*next;
+};
+
+extern void free_bitmap(struct bitmap_page *bitmap);
+extern struct bitmap_page *alloc_bitmap(unsigned int nr_bits);
+extern unsigned long alloc_swap_page(int swap, struct bitmap_page *bitma=
p);
+extern void free_all_swap_pages(int swap, struct bitmap_page *bitmap);
+
+extern int swsusp_get_swap_index_of(dev_t device);
+extern int swsusp_get_swap_index(void);
+extern unsigned int swsusp_total_swap(unsigned int swap);
+extern unsigned int swsusp_available_swap(unsigned int swap);
+extern int swsusp_shrink_memory(void);
+extern int swsusp_suspend(void);
+extern int swsusp_resume(void);
Index: linux-2.6.15-rc5-mm3/kernel/power/swsusp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.15-rc5-mm3.orig/kernel/power/swsusp.c	2005-12-31 16:51:57.0=
00000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/swsusp.c	2006-01-04 20:26:57.000000=
000 +0100
@@ -130,41 +130,41 @@ static int mark_swapfiles(swp_entry_t st
 }
=20
 /**
- * Check whether the swap device is the specified resume
- * device, irrespective of whether they are specified by
- * identical names.
+ *	is_device - check whether the specified device is a swap device,
+ *	irrespective of whether they are specified by identical names.
  *
- * (Thus, device inode aliasing is allowed.  You can say /dev/hda4
- * instead of /dev/ide/host0/bus0/target0/lun0/part4 [eg. for devfs]
- * and they'll be considered the same device.  This was *necessary* for
- * devfs, since the resume code could only recognize the form /dev/hda4,
- * but the suspend code would see the long name.)
+ *	(Thus, device inode aliasing is allowed.  You can say /dev/hda4
+ *	instead of /dev/ide/host0/bus0/target0/lun0/part4 [eg. for devfs]
+ *	and they'll be considered the same device.  This was *necessary* for
+ *	devfs, since the resume code could only recognize the form /dev/hda4,
+ *	but the suspend code would see the long name.)
  */
=20
-static inline int is_resume_device(const struct swap_info_struct *swap_i=
nfo)
+static inline int is_device(const struct swap_info_struct *swap_info,
+                            dev_t device)
 {
 	struct file *file =3D swap_info->swap_file;
 	struct inode *inode =3D file->f_dentry->d_inode;
=20
 	return S_ISBLK(inode->i_mode) &&
-		swsusp_resume_device =3D=3D MKDEV(imajor(inode), iminor(inode));
+		device =3D=3D MKDEV(imajor(inode), iminor(inode));
 }
=20
 /**
- *	swsusp_get_swap_index - find the index of the resume device
+ *	swsusp_get_swap_index_of - find the index of the given device
  */
=20
-int swsusp_get_swap_index(void)
+int swsusp_get_swap_index_of(dev_t device)
 {
 	int i;
=20
-	if (!swsusp_resume_device)
-		return -ENODEV;
+	if (!device)
+		return -EINVAL;
 	spin_lock(&swap_lock);
 	for (i =3D 0; i < MAX_SWAPFILES; i++) {
 		if (!(swap_info[i].flags & SWP_WRITEOK))
 			continue;
-		if (is_resume_device(swap_info + i)) {
+		if (is_device(swap_info + i, device)) {
 			spin_unlock(&swap_lock);
 			return i;
 		}
@@ -173,6 +173,15 @@ int swsusp_get_swap_index(void)
 	return -ENODEV;
 }
=20
+/**
+ *	swsusp_get_swap_index - find the index of the resume device
+ */
+
+int swsusp_get_swap_index(void)
+{
+	return swsusp_get_swap_index_of(swsusp_resume_device);
+}
+
 static int swsusp_swap_check(void) /* This is called before saving image=
 */
 {
 	int res =3D swsusp_get_swap_index();
@@ -185,34 +194,14 @@ static int swsusp_swap_check(void) /* Th
 }
=20
 /**
- *	The bitmap is used for tracing allocated swap pages
- *
- *	The entire bitmap consists of a number of bitmap_page
- *	structures linked with the help of the .next member.
- *	Thus each page can be allocated individually, so we only
- *	need to make 0-order memory allocations to create
- *	the bitmap.
- */
-
-#define BITMAP_PAGE_SIZE	(PAGE_SIZE - sizeof(void *))
-#define BITMAP_PAGE_CHUNKS	(BITMAP_PAGE_SIZE / sizeof(long))
-#define BITS_PER_CHUNK		(sizeof(long) * 8)
-#define BITMAP_PAGE_BITS	(BITMAP_PAGE_CHUNKS * BITS_PER_CHUNK)
-
-struct bitmap_page {
-	unsigned long		chunks[BITMAP_PAGE_CHUNKS];
-	struct bitmap_page	*next;
-};
-
-/**
  *	The following functions are used for tracing the allocated
  *	swap pages, so that they can be freed in case of an error.
  *
  *	The functions operate on a linked bitmap structure defined
- *	above
+ *	in power.h
  */
=20
-static void free_bitmap(struct bitmap_page *bitmap)
+void free_bitmap(struct bitmap_page *bitmap)
 {
 	struct bitmap_page *bp;
=20
@@ -223,7 +212,7 @@ static void free_bitmap(struct bitmap_pa
 	}
 }
=20
-static struct bitmap_page *alloc_bitmap(unsigned int nr_bits)
+struct bitmap_page *alloc_bitmap(unsigned int nr_bits)
 {
 	struct bitmap_page *bitmap, *bp;
 	unsigned int n;
@@ -266,7 +255,7 @@ static inline int bitmap_set(struct bitm
 	return 0;
 }
=20
-static unsigned long alloc_swap_page(int swap, struct bitmap_page *bitma=
p)
+unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap)
 {
 	unsigned long offset;
=20
@@ -280,7 +269,7 @@ static unsigned long alloc_swap_page(int
 	return offset;
 }
=20
-static void free_all_swap_pages(int swap, struct bitmap_page *bitmap)
+void free_all_swap_pages(int swap, struct bitmap_page *bitmap)
 {
 	unsigned int bit, n;
 	unsigned long test;


--===============90812662449431558==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--===============90812662449431558==--
