From: "hongbo.zhang" <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V3 2/5] Thermal: fix bug of counting cpu frequencies.
Date: Tue, 30 Oct 2012 17:48:58 +0100
Message-ID: <1351615741-24134-3-git-send-email-hongbo.zhang@linaro.com>
References: <1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
	<1351615741-24134-1-git-send-email-hongbo.zhang@linaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1351615741-24134-1-git-send-email-hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, amit.kachhap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, kernel-vMlcbD5RyM6HZuj8yyL1ah2eb7JE58TQ@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>

In the while loop for counting cpu frequencies, if table[i].frequency equals
CPUFREQ_ENTRY_INVALID, index i won't be increased, so this leads to an endless
loop, what's more the index i cannot be referred as cpu frequencies number if
there is CPUFREQ_ENTRY_INVALID case.

Signed-off-by: hongbo.zhang <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
Reviewed-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Amit Daniel Kachhap <amit.kachhap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/thermal/cpu_cooling.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index b6b4c2a..bfd62b7 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -245,6 +245,7 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 	struct cpumask *maskPtr;
 	unsigned int cpu;
 	struct cpufreq_frequency_table *table;
+	unsigned long count = 0;
 
 	mutex_lock(&cooling_cpufreq_lock);
 	list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, node) {
@@ -263,13 +264,14 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 		goto return_get_max_state;
 	}
 
-	while (table[i].frequency != CPUFREQ_TABLE_END) {
+	for (i = 0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
 		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
 			continue;
-		i++;
+		count++;
 	}
-	if (i > 0) {
-		*state = --i;
+
+	if (count > 0) {
+		*state = --count;
 		ret = 0;
 	}
 
-- 
1.7.11.3
