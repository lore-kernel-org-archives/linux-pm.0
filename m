From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH v2 5/8] power: ab8500_charger: Remove deprecated
 create_singlethread_workqueue
Date: Tue, 16 Aug 2016 10:53:16 +0530
Message-ID: <1e5233916d018583925bd52354d50157165b3f8b.1471324750.git.bhaktipriya96@gmail.com>
References: <cover.1471324749.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1471324749.git.bhaktipriya96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

alloc_ordered_workqueue() with WQ_MEM_RECLAIM set replaces
deprecated create_singlethread_workqueue(). This is the identity
conversion.

The workqueue "charger_wq" is used for the IRQs and checking HW state of
the charger. It has been identity converted.

It has multiple work items viz usb_charger_attached_work, kick_wd_work,
check_vbat_work, check_hw_failure_work, usb_charger_attached_work,
ac_work, ac_charger_attached_work, attach_work and check_usbchgnotok_work,
which require execution ordering. Hence, a dedicated ordered workqueue
has been used here.

The WQ_MEM_RECLAIM flag has also been set to ensure
forward progress under memory pressure.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/power/ab8500_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/ab8500_charger.c b/drivers/power/ab8500_charger.c
index 30de5d4..5cee9aa 100644
--- a/drivers/power/ab8500_charger.c
+++ b/drivers/power/ab8500_charger.c
@@ -3540,8 +3540,8 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->usb_state.usb_current = -1;

 	/* Create a work queue for the charger */
-	di->charger_wq =
-		create_singlethread_workqueue("ab8500_charger_wq");
+	di->charger_wq = alloc_ordered_workqueue("ab8500_charger_wq",
+						 WQ_MEM_RECLAIM);
 	if (di->charger_wq == NULL) {
 		dev_err(di->dev, "failed to create work queue\n");
 		return -ENOMEM;
--
2.1.4
