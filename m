From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v10 10/27] MAINTAINERS: Update files for PSCI
Date: Thu, 29 Nov 2018 18:46:43 +0100
Message-ID: <20181129174700.16585-11-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The files for the PSCI firmware driver were moved to a sub-directory, let's
update MAINTAINERS to reflect that.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- None.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f585d3..9805444711ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11919,7 +11919,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.17.1
