From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 7/8] firmware: arm_scmi: improve exit paths and code
 readability
Date: Wed,  9 May 2018 18:07:13 +0100
Message-ID: <1525885634-22348-8-git-send-email-sudeep.holla@arm.com>
References: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

The existing code intends the good path to reduce the code which is so
uncommon. It's obvious to have more readable code with a goto used for
the error path. This patch adds more appropriate error paths and makes
code more readable. It also moves a error logging outside the scope of
locking.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index f2760a596c28..472c88ae1c0f 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -125,13 +125,13 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 	int id, retval;
 	struct scmi_device *scmi_dev;
 
-	id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
-	if (id < 0)
-		return NULL;
-
 	scmi_dev = kzalloc(sizeof(*scmi_dev), GFP_KERNEL);
 	if (!scmi_dev)
-		goto no_mem;
+		return NULL;
+
+	id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
+	if (id < 0)
+		goto free_mem;
 
 	scmi_dev->id = id;
 	scmi_dev->protocol_id = protocol;
@@ -141,13 +141,15 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol)
 	dev_set_name(&scmi_dev->dev, "scmi_dev.%d", id);
 
 	retval = device_register(&scmi_dev->dev);
-	if (!retval)
-		return scmi_dev;
+	if (retval)
+		goto put_dev;
 
+	return scmi_dev;
+put_dev:
 	put_device(&scmi_dev->dev);
-	kfree(scmi_dev);
-no_mem:
 	ida_simple_remove(&scmi_bus_id, id);
+free_mem:
+	kfree(scmi_dev);
 	return NULL;
 }
 
@@ -171,9 +173,9 @@ int scmi_protocol_register(int protocol_id, scmi_prot_init_fn_t fn)
 	spin_lock(&protocol_lock);
 	ret = idr_alloc(&scmi_protocols, fn, protocol_id, protocol_id + 1,
 			GFP_ATOMIC);
+	spin_unlock(&protocol_lock);
 	if (ret != protocol_id)
 		pr_err("unable to allocate SCMI idr slot, err %d\n", ret);
-	spin_unlock(&protocol_lock);
 
 	return ret;
 }
-- 
2.7.4
