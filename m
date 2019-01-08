From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 2/4] cpufreq: s5pv210: Don't flood kernel log after cpufreq change
Date: Tue,  8 Jan 2019 21:05:07 +0100
Message-ID: <20190108200509.30494-3-pawel.mikolaj.chmiel@gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kgene@kernel.org
Cc: krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
List-Id: linux-pm@vger.kernel.org

This commit replaces printk with pr_debug, so we don't flood kernel log.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index dbecd7667db2..f51697f1e0b3 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -481,7 +481,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 				arm_volt, arm_volt_max);
 	}
 
-	printk(KERN_DEBUG "Perf changed[L%d]\n", index);
+	pr_debug("Perf changed[L%d]\n", index);
 
 exit:
 	mutex_unlock(&set_freq_lock);
-- 
2.17.1
