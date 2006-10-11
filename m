From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [RFC/PATCH 1/3] Use kobject_name() to access kobject
	names
Date: Wed, 11 Oct 2006 02:01:39 -0400
Message-ID: <20061011061030.151797574.dtor@insightbb.com>
References: <20061011060138.920913139.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=dpm-use-kobject-name.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

PM: use kobject_name() to access kobject names

Noone should use kobj.name directly since it may contain garbage.
Objects with longer names have them stored in memory pointed by
kobj->k_name.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/power/main.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

Index: work/drivers/base/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work.orig/drivers/base/power/main.c
+++ work/drivers/base/power/main.c
@@ -54,7 +54,8 @@ int device_pm_add(struct device * dev)
 	int error;
 =

 	pr_debug("PM: Adding info for %s:%s\n",
-		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
+		 dev->bus ? dev->bus->name : "No Bus",
+		 kobject_name(&dev->kobj));
 	down(&dpm_list_sem);
 	list_add_tail(&dev->power.entry, &dpm_active);
 	device_pm_set_parent(dev, dev->parent);
@@ -67,7 +68,8 @@ int device_pm_add(struct device * dev)
 void device_pm_remove(struct device * dev)
 {
 	pr_debug("PM: Removing info for %s:%s\n",
-		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
+		 dev->bus ? dev->bus->name : "No Bus",
+		 kobject_name(&dev->kobj));
 	down(&dpm_list_sem);
 	dpm_sysfs_remove(dev);
 	put_device(dev->power.pm_parent);
