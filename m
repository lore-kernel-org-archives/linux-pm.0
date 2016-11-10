From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] PM / Domains: Fix a warning message
Date: Thu, 10 Nov 2016 15:52:15 +0300
Message-ID: <20161110125215.GA18664@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The first argument of WARN() is the condition, followed by the message.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 661737c..7b4d41f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1297,7 +1297,7 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	 * powered on/off in that context.
 	 */
 	if (!genpd_is_irq_safe(genpd) && genpd_is_irq_safe(subdomain)) {
-		WARN("Parent %s of subdomain %s must be IRQ safe\n",
+		WARN(1, "Parent %s of subdomain %s must be IRQ safe\n",
 				genpd->name, subdomain->name);
 		return -EINVAL;
 	}
