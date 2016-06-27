From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] cpufreq: dt: call of_node_put() before error out
Date: Mon, 27 Jun 2016 14:50:13 +0900
Message-ID: <1467006613-24076-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If of_match_node() fails, this init function bails out without
calling of_node_put().

I also changed of_node_put(of_root) to of_node_put(np); both of them
hold the same pointer, but it seems better to call of_node_put()
against the node returned by of_find_node_by_path().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/cpufreq/cpufreq-dt-platdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 3646b14..0bb44d5 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -79,15 +79,16 @@ static const struct of_device_id machines[] __initconst = {
 static int __init cpufreq_dt_platdev_init(void)
 {
 	struct device_node *np = of_find_node_by_path("/");
+	const struct of_device_id *match;
 
 	if (!np)
 		return -ENODEV;
 
-	if (!of_match_node(machines, np))
+	match = of_match_node(machines, np);
+	of_node_put(np);
+	if (!match)
 		return -ENODEV;
 
-	of_node_put(of_root);
-
 	return PTR_ERR_OR_ZERO(platform_device_register_simple("cpufreq-dt", -1,
 							       NULL, 0));
 }
-- 
1.9.1
