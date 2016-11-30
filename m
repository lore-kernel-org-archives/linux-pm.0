From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/3] dev_pm_qos: Export dev_pm_qos_update_user_latency_tolerance
Date: Tue, 29 Nov 2016 17:11:52 -0800
Message-ID: <9cee8760c35e7eae1d85de83c5217fd3eb0f18f0.1480468027.git.luto@kernel.org>
References: <cover.1480468027.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1480468027.git.luto@kernel.org>
In-Reply-To: <cover.1480468027.git.luto@kernel.org>
References: <cover.1480468027.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
List-Id: linux-pm@vger.kernel.org

nvme wants a module parameter that overrides the default latency
tolerance.  This makes it easy for nvme to reflect that default in
sysfs.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/base/power/qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 6a1f2c7e01ea..58fcc758334e 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -886,6 +886,7 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 	mutex_unlock(&dev_pm_qos_mtx);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dev_pm_qos_update_user_latency_tolerance);
 
 /**
  * dev_pm_qos_expose_latency_tolerance - Expose latency tolerance to userspace
-- 
2.9.3
