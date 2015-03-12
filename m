From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 1/9] pm: domains: quieten down generic pm domains
Date: Thu, 12 Mar 2015 18:30:55 +0000
Message-ID: <E1YW7sl-0003m2-4Z@rmk-PC.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:40977 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbbCLSbC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 14:31:02 -0400
In-Reply-To: <20150312183020.GU8656@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

PM domains are rather noisy; scheduling behaviour can cause callbacks
to take longer, which causes them to spit out a warning-level message
each time a callback takes a little longer than the previous time.
There really isn't a need for this, except when debugging.

Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/base/power/domain.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0d8780c04a5e..b3fbc21da2dc 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -173,8 +173,8 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 	genpd->power_on_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
 	genpd_recalc_cpu_exit_latency(genpd);
-	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
-		genpd->name, "on", elapsed_ns);
+	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
+		 genpd->name, "on", elapsed_ns);
 
 	return ret;
 }
@@ -199,8 +199,8 @@ static int genpd_power_off(struct generic_pm_domain *genpd)
 
 	genpd->power_off_latency_ns = elapsed_ns;
 	genpd->max_off_time_changed = true;
-	pr_warn("%s: Power-%s latency exceeded, new value %lld ns\n",
-		genpd->name, "off", elapsed_ns);
+	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
+		 genpd->name, "off", elapsed_ns);
 
 	return ret;
 }
-- 
1.8.3.1

