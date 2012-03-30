From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/76] thermal_sys: remove obfuscating used-once
	macros
Date: Fri, 30 Mar 2012 06:13:18 -0400
Message-ID: <ec797685609da142588012d734e85d14cff9c7d2.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Joe Perches <joe@perches.com>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Jesper Juhl <jj@chaosbits.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Joe Perches <joe@perches.com>

These don't add any value as they are used only once and the surrounding
code uses similar variable.

Signed-off-by: Joe Perches <joe@perches.com>
Cc: Jesper Juhl <jj@chaosbits.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |   32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 71802ca..11237bc 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -310,22 +310,6 @@ static struct device_attribute trip_point_attrs[] = {
 	__ATTR(trip_point_11_temp, 0444, trip_point_temp_show, NULL),
 };
 
-#define TRIP_POINT_ATTR_ADD(_dev, _index, result)     \
-do {    \
-	result = device_create_file(_dev,	\
-				&trip_point_attrs[_index * 2]);	\
-	if (result)	\
-		break;	\
-	result = device_create_file(_dev,	\
-			&trip_point_attrs[_index * 2 + 1]);	\
-} while (0)
-
-#define TRIP_POINT_ATTR_REMOVE(_dev, _index)	\
-do {	\
-	device_remove_file(_dev, &trip_point_attrs[_index * 2]);	\
-	device_remove_file(_dev, &trip_point_attrs[_index * 2 + 1]);	\
-} while (0)
-
 /* sys I/F for cooling device */
 #define to_cooling_device(_dev)	\
 	container_of(_dev, struct thermal_cooling_device, device)
@@ -1196,7 +1180,12 @@ struct thermal_zone_device *thermal_zone_device_register(char *type,
 	}
 
 	for (count = 0; count < trips; count++) {
-		TRIP_POINT_ATTR_ADD(&tz->device, count, result);
+		result = device_create_file(&tz->device,
+					    &trip_point_attrs[count * 2]);
+		if (result)
+			break;
+		result = device_create_file(&tz->device,
+					    &trip_point_attrs[count * 2 + 1]);
 		if (result)
 			goto unregister;
 		tz->ops->get_trip_type(tz, count, &trip_type);
@@ -1276,9 +1265,12 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	if (tz->ops->get_mode)
 		device_remove_file(&tz->device, &dev_attr_mode);
 
-	for (count = 0; count < tz->trips; count++)
-		TRIP_POINT_ATTR_REMOVE(&tz->device, count);
-
+	for (count = 0; count < tz->trips; count++) {
+		device_remove_file(&tz->device,
+				   &trip_point_attrs[count * 2]);
+		device_remove_file(&tz->device,
+				   &trip_point_attrs[count * 2 + 1]);
+	}
 	thermal_remove_hwmon_sysfs(tz);
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 	idr_destroy(&tz->idr);
-- 
1.7.10.rc2.19.gfae9d
