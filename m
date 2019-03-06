From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH 6/6] PM / domains: Remove one unnecessary blank line
Date: Wed, 6 Mar 2019 13:25:29 +0000
Message-ID: <1551878302-8146-7-git-send-email-aisheng.dong@nxp.com>
References: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551878302-8146-1-git-send-email-aisheng.dong@nxp.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Remove one unnecessary blank line

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/base/power/domain_governor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 99896fb..4d07e38 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -128,7 +128,6 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 	off_on_time_ns = genpd->states[state].power_off_latency_ns +
 		genpd->states[state].power_on_latency_ns;
 
-
 	min_off_time_ns = -1;
 	/*
 	 * Check if subdomains can be off for enough time.
-- 
2.7.4
