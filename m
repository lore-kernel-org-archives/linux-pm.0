From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v2] drivers/cpufreq: Convert non-modular s5pv210-cpufreq.c to use builtin_platform_driver
Date: Wed, 3 Jun 2015 17:12:46 -0400
Message-ID: <1433365966-29850-1-git-send-email-paul.gortmaker@windriver.com>
References: <20150512070444.GE32300@linux>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:35722 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879AbbFCVOE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 17:14:04 -0400
In-Reply-To: <20150512070444.GE32300@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org

This file depends on a Kconfig option which is a bool, so
we use the appropriate registration function, which avoids us
relying on an implicit inclusion of <module.h> which we are
doing currently.

While this currently works, we really don't want to be including
the module.h header in non-modular code, which we'd be forced
to do, pending some upcoming code relocation from init.h into
module.h.  So we fix it now by using the non-modular equivalent.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[v2: drop exnyos part from patch, since it really was modular and
 instead needs its implicit include fixed.]

 drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index b0dac7d6ba31..9e231f52150c 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -659,4 +659,4 @@ static struct platform_driver s5pv210_cpufreq_platdrv = {
 	},
 	.probe = s5pv210_cpufreq_probe,
 };
-module_platform_driver(s5pv210_cpufreq_platdrv);
+builtin_platform_driver(s5pv210_cpufreq_platdrv);
-- 
2.2.1

