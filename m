From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] PM / OPP: make _of_get_opp_desc_node a static function
Date: Thu, 20 Oct 2016 15:44:53 +0900
Message-ID: <1476945893-26998-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

Since commit f47b72a15a96 ("PM / OPP: Move CONFIG_OF dependent code
in a separate file"), this function is defined and called only in
drivers/base/power/opp/of.c .

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/base/power/opp/of.c  | 2 +-
 drivers/base/power/opp/opp.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
index 5552211..6480137 100644
--- a/drivers/base/power/opp/of.c
+++ b/drivers/base/power/opp/of.c
@@ -198,7 +198,7 @@ void dev_pm_opp_of_remove_table(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
 
 /* Returns opp descriptor node for a device, caller must do of_node_put() */
-struct device_node *_of_get_opp_desc_node(struct device *dev)
+static struct device_node *_of_get_opp_desc_node(struct device *dev)
 {
 	/*
 	 * TODO: Support for multiple OPP tables.
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index fabd5ca..96cd30a 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -190,7 +190,6 @@ struct opp_table {
 /* Routines internal to opp core */
 struct opp_table *_find_opp_table(struct device *dev);
 struct opp_device *_add_opp_dev(const struct device *dev, struct opp_table *opp_table);
-struct device_node *_of_get_opp_desc_node(struct device *dev);
 void _dev_pm_opp_remove_table(struct device *dev, bool remove_all);
 struct dev_pm_opp *_allocate_opp(struct device *dev, struct opp_table **opp_table);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
-- 
1.9.1
