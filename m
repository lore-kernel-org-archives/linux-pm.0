From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [RFC PATCH 1/5] cpufreq: stats: Allow small rounding errors
Date: Wed, 14 May 2014 15:30:51 -0700
Message-ID: <1400106655-22465-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

When matching a frequency against the freq_table, allow small deviances to
allow rounding errors. Rounding errors are likely to occur due to the
differenct frequency resolutions used in the common clock vs cpufreq
frameworks.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

 drivers/cpufreq/cpufreq_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index ecaaebf969fc..37a34178ab3a 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -146,7 +146,7 @@ static int freq_table_get_index(struct cpufreq_stats *stat, unsigned int freq)
 {
 	int index;
 	for (index = 0; index < stat->max_state; index++)
-		if (stat->freq_table[index] == freq)
+		if (abs(stat->freq_table[index] - freq) < 2)
 			return index;
 	return -1;
 }
-- 
1.9.3.1.ga73a6ad
