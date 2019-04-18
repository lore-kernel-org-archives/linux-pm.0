From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] PM / Domains: Don't kfree() the virtual device in the error path
Date: Thu, 18 Apr 2019 12:27:55 +0200
Message-ID: <20190418102757.1246-2-ulf.hansson@linaro.org>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190418102757.1246-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

It's not correct to call kfree(dev) when device_register(dev) has failed.
Fix this by calling put_device(dev) instead.

Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ecac03dcc9b2..7fec69aebf46 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2528,7 +2528,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 
 	ret = device_register(virt_dev);
 	if (ret) {
-		kfree(virt_dev);
+		put_device(virt_dev);
 		return ERR_PTR(ret);
 	}
 
-- 
2.17.1
