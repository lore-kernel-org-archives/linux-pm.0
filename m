From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/14] thermal: Prevent polling from happening
 during system suspend
Date: Sun, 06 Nov 2011 23:11:58 -0500
Message-ID: <51e20d0e3a60cf46b52ee1af598a35834919ed27.1320636776.git.len.brown@intel.com>
References: <1320639124-16178-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1320639124-16178-1-git-send-email-lenb@kernel.org>
In-reply-to: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
References: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@sisk.pl>

The thermal driver should use a freezable workqueue to schedule
polling to prevent thermal_zone_device_update() from being run
during system suspend, when the devices it relies on may be inactive.
Make it use the system freezable workqueue for this purpose.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 708f8e9..dd9a574 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -678,10 +678,10 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 		return;
 
 	if (delay > 1000)
-		schedule_delayed_work(&(tz->poll_queue),
+		queue_delayed_work(system_freezable_wq, &(tz->poll_queue),
 				      round_jiffies(msecs_to_jiffies(delay)));
 	else
-		schedule_delayed_work(&(tz->poll_queue),
+		queue_delayed_work(system_freezable_wq, &(tz->poll_queue),
 				      msecs_to_jiffies(delay));
 }
 
-- 
1.7.7.rc0.72.g4b5ea
