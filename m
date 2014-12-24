From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/3] PM / OPP: export dev_pm_opp_get_notifier
Date: Wed, 24 Dec 2014 11:22:55 -0600
Message-ID: <1419441777-25651-2-git-send-email-nm@ti.com>
References: <1419441777-25651-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419441777-25651-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

Allows user drivers such as devfreq to be modules.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/base/power/opp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index d24dd614a..1b385e4 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -725,6 +725,7 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(struct device *dev)
 
 	return &dev_opp->srcu_head;
 }
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_notifier);
 
 #ifdef CONFIG_OF
 /**
-- 
1.7.9.5
