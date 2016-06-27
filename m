From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2 1/3] intel_pstate: Fix incorrect placement of __initdata
Date: Mon, 27 Jun 2016 18:07:16 +0800
Message-ID: <1467022038-924-2-git-send-email-jszhang@marvell.com>
References: <1467022038-924-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467022038-924-1-git-send-email-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-pm@vger.kernel.org

__initdata should be placed between the variable name and equal sign
(if there is) for the variable to be placed in the intended section.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index fe9dc17..44099e9 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1574,9 +1574,9 @@ static struct cpufreq_driver intel_pstate_driver = {
 	.name		= "intel_pstate",
 };
 
-static int __initdata no_load;
-static int __initdata no_hwp;
-static int __initdata hwp_only;
+static int no_load __initdata;
+static int no_hwp __initdata;
+static int hwp_only __initdata;
 static unsigned int force_load;
 
 static int intel_pstate_msrs_not_valid(void)
-- 
2.8.1
