From: Colin King <colin.king@canonical.com>
Subject: [PATCH] cpufreq: st: add missing \n to end of dev_err message
Date: Sun, 25 Sep 2016 14:40:13 -0700
Message-ID: <20160925214013.12430-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, Patrice Chotard <patrice.chotard@st.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix, dev_err message is missing a \n, so add it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cpufreq/sti-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index 0404203..b366e6d 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -163,7 +163,7 @@ static int sti_cpufreq_set_opp_info(void)
 
 	reg_fields = sti_cpufreq_match();
 	if (!reg_fields) {
-		dev_err(dev, "This SoC doesn't support voltage scaling");
+		dev_err(dev, "This SoC doesn't support voltage scaling\n");
 		return -ENODEV;
 	}
 
-- 
2.9.3
