From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 1/6] regulator: core: Don't spew backtraces on duplicate sysfs
Date: Mon,  1 Jun 2015 18:47:54 -0700
Message-ID: <1433209679-31389-2-git-send-email-sboyd@codeaurora.org>
References: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1433209679-31389-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Andy Gross <agross@codeaurora.org>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

We don't consider a failure to add the sysfs node as a problem,
so use sysfs_create_link_nowarn() so that we don't print a
backtrace when duplicated files exist. Also, downgrade the printk
message to a debug statement so that we're quiet here. This
allows multiple drivers to request a CPU's regulator so that
CPUfreq and AVSish drivers can coexist.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/regulator/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 443eaab933fc..f6989485c382 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1192,10 +1192,10 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 		if (regulator->supply_name == NULL)
 			goto overflow_err;
 
-		err = sysfs_create_link(&rdev->dev.kobj, &dev->kobj,
+		err = sysfs_create_link_nowarn(&rdev->dev.kobj, &dev->kobj,
 					buf);
 		if (err) {
-			rdev_warn(rdev, "could not add device link %s err %d\n",
+			rdev_dbg(rdev, "could not add device link %s err %d\n",
 				  dev->kobj.name, err);
 			/* non-fatal */
 		}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
