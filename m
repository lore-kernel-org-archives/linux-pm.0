From: Raffaele Recalcati <lamiaposta71@gmail.com>
Subject: [PATCH 1/4] export bus_kset
Date: Thu, 12 May 2011 19:11:02 +0200
Message-ID: <1305220265-9020-2-git-send-email-lamiaposta71__10590.2190473445$1305238059$gmane$org@gmail.com>
References: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1305220265-9020-1-git-send-email-lamiaposta71@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-kernel@vger.kernel.org, Davide Ciminaghi <ciminaghi@gnudd.com>
List-Id: linux-pm@vger.kernel.org

From: Davide Ciminaghi <ciminaghi@gnudd.com>

Signed-off-by: Davide Ciminaghi <ciminaghi@gnudd.com>
---
 drivers/base/bus.c      |    3 ++-
 include/linux/kobject.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 000e7b2..2134248 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -158,7 +158,8 @@ static const struct kset_uevent_ops bus_uevent_ops = {
 	.filter = bus_uevent_filter,
 };
 
-static struct kset *bus_kset;
+struct kset *bus_kset;
+EXPORT_SYMBOL(bus_kset);
 
 
 #ifdef CONFIG_HOTPLUG
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 8f6d121..456b20d 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -205,6 +205,8 @@ extern struct kobject *power_kobj;
 /* The global /sys/firmware/ kobject for people to chain off of */
 extern struct kobject *firmware_kobj;
 
+extern struct kset *bus_kset ;
+
 #if defined(CONFIG_HOTPLUG)
 int kobject_uevent(struct kobject *kobj, enum kobject_action action);
 int kobject_uevent_env(struct kobject *kobj, enum kobject_action action,
-- 
1.7.0.4
