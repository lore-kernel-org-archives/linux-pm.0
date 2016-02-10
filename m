From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: select IRQ_WORK in Kconfig
Date: Wed, 10 Feb 2016 16:14:21 +0100
Message-ID: <1455117265-3007562-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq core code has started using the irq_work infrastructure, but that
can be disabled in Kconfig, causing a link failure:

drivers/cpufreq/cpufreq_governor.c: In function 'gov_queue_irq_work':
drivers/cpufreq/cpufreq_governor.c:251:3: error: implicit declaration of function 'irq_work_queue_on' [-Werror=implicit-function-declaration]

This adds an explicit 'select' to ensure it's always enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0144fa03ef46 ("cpufreq: governor: Replace timers with utilization update callbacks")
---
 drivers/cpufreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 3050e8d48887..ca05037dd565 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -3,6 +3,7 @@ menu "CPU Frequency scaling"
 config CPU_FREQ
 	bool "CPU Frequency scaling"
 	select SRCU
+	select IRQ_WORK
 	help
 	  CPU Frequency scaling allows you to change the clock speed of 
 	  CPUs on the fly. This is a nice method to save power, because 
-- 
2.7.0
