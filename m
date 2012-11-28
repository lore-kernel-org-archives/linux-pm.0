From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 2/5] mfd: db8500: Update cpufreq device name
Date: Wed, 28 Nov 2012 11:27:41 +0100
Message-ID: <1354098464-6665-3-git-send-email-ulf.hansson@stericsson.com>
References: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Jonas Aberg <jonas.aberg@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Philippe Begnic <philippe.begnic@st.com>, Ulf Hansson <ulf.hansson@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>

Since the cpufreq driver for ux500 has been renamed from
cpufreq-db8500 to cpufreq-dbx500, we need to change the
device name here as well.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/db8500-prcmu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index a1b295f..2900132 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3072,8 +3072,8 @@ static struct mfd_cell db8500_prcmu_devs[] = {
 		.pdata_size = sizeof(db8500_regulators),
 	},
 	{
-		.name = "cpufreq-u8500",
-		.of_compatible = "stericsson,cpufreq-u8500",
+		.name = "cpufreq-ux500",
+		.of_compatible = "stericsson,cpufreq-ux500",
 		.platform_data = &db8500_cpufreq_table,
 		.pdata_size = sizeof(db8500_cpufreq_table),
 	},
-- 
1.7.10

