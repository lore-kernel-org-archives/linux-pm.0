From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/8] PM / domains: Protect reading loop over list of domains
Date: Fri,  9 Jun 2017 18:08:47 +0200
Message-ID: <20170609160853.31789-3-krzk@kernel.org>
References: <20170609160853.31789-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609160853.31789-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pm@vger.kernel.org

The pm_genpd_present() iterates over list of domains so grabbing a
gpd_list_lock mutex is necessary before calling it.  Otherwise we could
end up in iterating over and modifying the list at the same time.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/base/power/domain.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 2e8d0f423507..2a6935dc0164 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1099,8 +1099,13 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
 	struct generic_pm_domain *genpd;
 
 	genpd = dev_to_genpd(dev);
-	if (!pm_genpd_present(genpd))
+
+	mutex_lock(&gpd_list_lock);
+	if (!pm_genpd_present(genpd)) {
+		mutex_unlock(&gpd_list_lock);
 		return;
+	}
+	mutex_unlock(&gpd_list_lock);
 
 	if (suspend) {
 		genpd->suspended_count++;
-- 
2.9.3
