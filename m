From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 4/4] thermal sys: check for invalid trip setup
	when registering thermal device
Date: Tue, 12 Jun 2012 16:25:19 +0300
Message-ID: <1339507519-14434-5-git-send-email-eduardo.valentin@ti.com>
References: <1339507519-14434-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1339507519-14434-1-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rui.zhang@intel.com, durgadoss.r@intel.com
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This patch adds an extra check in the data structure while registering
a thermal device. The check is to avoid registering zones with a number
of trips greater than zero, but with no .get_trip_temp nor .get_trip_type
callbacks. Receiving such data structure may end in wrong data access.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/thermal_sys.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 61d0003..50830f2 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -1129,6 +1129,9 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 	if (!ops || !ops->get_temp)
 		return ERR_PTR(-EINVAL);
 
+	if (trips > 0 && !ops->get_trip_type)
+		return ERR_PTR(-EINVAL);
+
 	tz = kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
-- 
1.7.7.1.488.ge8e1c
