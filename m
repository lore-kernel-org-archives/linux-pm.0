From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 1/9] PM / core: add helper to return suspend status of a
 device
Date: Sat, 22 Dec 2018 21:26:15 +0100
Message-ID: <20181222202623.4521-2-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

I2C core would like this to reject transfers on an already suspended
adapter.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1b25c7a43f4c..e63d3e06989f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1138,6 +1138,11 @@ static inline int device_is_registered(struct device *dev)
 	return dev->kobj.state_in_sysfs;
 }
 
+static inline bool device_is_suspended(struct device *dev)
+{
+	return dev->power.is_suspended;
+}
+
 static inline void device_enable_async_suspend(struct device *dev)
 {
 	if (!dev->power.is_prepared)
-- 
2.19.1
