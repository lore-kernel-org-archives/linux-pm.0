From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC][Patch 2/3] bluetooth: Fix device_move() vs.
	dpm_list.
Date: Tue, 3 Mar 2009 11:21:03 +0100
Message-ID: <20090303112103.22f30b5c@gondolin>
References: <20090224165311.5d103b67@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090224165311.5d103b67@gondolin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "Rafael J.
	Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Marcel Holtmann <marcel@>
List-Id: linux-pm@vger.kernel.org

Make use of the new device_pm_move_*() functions when moving
bluetooth ttys. They either get a new parent or are moved to
head. (Note: I didn't bother to implement proper handling of
device_move() failures...)

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 net/bluetooth/hci_sysfs.c  |    5 ++++-
 net/bluetooth/rfcomm/tty.c |   21 ++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

--- linux-2.6.orig/net/bluetooth/rfcomm/tty.c
+++ linux-2.6/net/bluetooth/rfcomm/tty.c
@@ -730,8 +730,15 @@ static int rfcomm_tty_open(struct tty_st
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dev->wait, &wait);
 
-	if (err == 0)
-		device_move(dev->tty_dev, rfcomm_get_device(dev));
+	if (err == 0) {
+		struct device *target = rfcomm_get_device(dev);
+
+		device_pm_lock();
+		/* FIXME: handle device_move() errors */
+		if (!device_move(dev->tty_dev, target))
+			device_pm_move_before(dev->tty_dev, target);
+		device_pm_unlock();
+	}
 
 	rfcomm_tty_copy_pending(dev);
 
@@ -750,9 +757,13 @@ static void rfcomm_tty_close(struct tty_
 						atomic_read(&dev->opened));
 
 	if (atomic_dec_and_test(&dev->opened)) {
-		if (dev->tty_dev->parent)
-			device_move(dev->tty_dev, NULL);
-
+		if (dev->tty_dev->parent) {
+			device_pm_lock();
+			/* FIXME: handle device_move errors */
+			if (!device_move(dev->tty_dev, NULL))
+				device_pm_move_last(dev->tty_dev);
+			device_pm_unlock();
+		}
 		/* Close DLC and dettach TTY */
 		rfcomm_dlc_close(dev->dlc, 0);
 
--- linux-2.6.orig/net/bluetooth/hci_sysfs.c
+++ linux-2.6/net/bluetooth/hci_sysfs.c
@@ -140,7 +140,10 @@ static void del_conn(struct work_struct 
 		dev = device_find_child(&conn->dev, NULL, __match_tty);
 		if (!dev)
 			break;
-		device_move(dev, NULL);
+		device_pm_lock();
+		if (!device_move(dev, NULL))
+			device_pm_move_last(dev);
+		device_pm_unlock();
 		put_device(dev);
 	}
 
