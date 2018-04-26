From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 02/11] PM / Domains: Drop comment in genpd about legacy Samsung DT binding
Date: Thu, 26 Apr 2018 10:53:01 +0200
Message-ID: <1524732790-2234-3-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The parsing of the Samsung specific DT binding is gone, but the comment in
the function header remained. Let's drop the comment to avoid confusions.

Fixes: 001d50c9a14f ("PM / Domains: Remove obsolete "samsung,power-domain" check")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ef6cf3d5..d3703a1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2185,9 +2185,6 @@ static void genpd_dev_pm_sync(struct device *dev)
  * Parse device's OF node to find a PM domain specifier. If such is found,
  * attaches the device to retrieved pm_domain ops.
  *
- * Both generic and legacy Samsung-specific DT bindings are supported to keep
- * backwards compatibility with existing DTBs.
- *
  * Returns 0 on successfully attached PM domain or negative error code. Note
  * that if a power-domain exists for the device, but it cannot be found or
  * turned on, then return -EPROBE_DEFER to ensure that the device is not
-- 
2.7.4
