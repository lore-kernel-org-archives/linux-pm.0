From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/5] MAINTAINERS: Update files for PSCI
Date: Wed, 13 Mar 2019 09:36:56 +0100
Message-ID: <20190313083659.7100-3-ulf.hansson@linaro.org>
References: <20190313083659.7100-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313083659.7100-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The files for the PSCI firmware driver were moved to a sub-directory, let's
update MAINTAINERS to reflect that.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a419acaa01c5..97dcec6fc877 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12257,7 +12257,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.17.1
