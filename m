From: Sonny Rao <sonnyrao@chromium.org>
Subject: [RFC][PATCH] Enable async suspend/resume of i2c devices
Date: Mon, 4 Apr 2011 20:47:01 -0700
Message-ID: <BANLkTik7i0VQpJb+enUd9c4-XvZQ1S57fQ__18483.871574472$1302114569$gmane$org@mail.gmail.com>
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
To: linux-i2c@vger.kernel.org
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, linux-pm@lists.linux-foundation.org, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>
List-Id: linux-pm@vger.kernel.org

This improves our resume time when we have devices on an i2c bus
that are slow to resume.  In particular we have a light sensor that
adds about 50ms of resume time on one device. We have to enable it
both on the i2c master and i2c client side and then we get fully async
suspend/resume.  I suspect we'll see nice gains on systems with more
i2c devices and will test that out soon.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
 drivers/i2c/i2c-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index e5f76a0..bbe7569 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -547,6 +547,7 @@ i2c_new_device(struct i2c_adapter *adap, struct
i2c_board_info const *info)

        dev_dbg(&adap->dev, "client [%s] registered with bus id %s\n",
                client->name, dev_name(&client->dev));
+       device_enable_async_suspend(&client->dev);

        return client;

@@ -857,6 +858,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
                dev_warn(&adap->dev,
                         "Failed to create compatibility class link\n");
 #endif
+       device_enable_async_suspend(&adap->dev);

        /* create pre-declared device nodes */
        if (adap->nr < __i2c_first_dynamic_bus_num)
-- 
1.7.3.1
