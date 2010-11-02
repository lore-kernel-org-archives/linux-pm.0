From: Hong Liu <hong.liu@intel.com>
Subject: [PATCH] drivers/misc/apds9802als.c: fix runtime PM errors
Date: Tue, 02 Nov 2010 14:38:55 +0800
Message-ID: <1288679935.2369.52.camel__7494.20007127828$1288679881$gmane$org@hongdev>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Putting the device into runtime suspend after resume()/probe() is handled
by the PM core and the device core code. No need to manually add them in
each single driver. And correct the runtime state in remove().

Signed-off-by: Hong Liu <hong.liu@intel.com>
---
 drivers/misc/apds9802als.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/apds9802als.c b/drivers/misc/apds9802als.c
index f9b91ba..19c5b97 100644
--- a/drivers/misc/apds9802als.c
+++ b/drivers/misc/apds9802als.c
@@ -245,9 +245,8 @@ static int apds9802als_probe(struct i2c_client *client,
 	als_set_default_config(client);
 	mutex_init(&data->mutex);
 
+	pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
-	pm_runtime_get(&client->dev);
-	pm_runtime_put(&client->dev);
 
 	return res;
 als_error1:
@@ -256,12 +255,19 @@ als_error1:
 	return res;
 }
 
-static int apds9802als_remove(struct i2c_client *client)
+static int __devexit apds9802als_remove(struct i2c_client *client)
 {
 	struct als_data *data = i2c_get_clientdata(client);
 
+	pm_runtime_get_sync(&client->dev);
+
 	als_set_power_state(client, false);
 	sysfs_remove_group(&client->dev.kobj, &m_als_gr);
+
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_put_noidle(&client->dev);
+
 	kfree(data);
 	return 0;
 }
@@ -276,9 +282,6 @@ static int apds9802als_suspend(struct i2c_client *client, pm_message_t mesg)
 static int apds9802als_resume(struct i2c_client *client)
 {
 	als_set_default_config(client);
-
-	pm_runtime_get(&client->dev);
-	pm_runtime_put(&client->dev);
 	return 0;
 }
 
@@ -324,7 +327,7 @@ static struct i2c_driver apds9802als_driver = {
 		.pm = APDS9802ALS_PM_OPS,
 	},
 	.probe = apds9802als_probe,
-	.remove = apds9802als_remove,
+	.remove = __devexit_p(apds9802als_remove),
 	.suspend = apds9802als_suspend,
 	.resume = apds9802als_resume,
 	.id_table = apds9802als_id,
-- 
1.7.2.3
