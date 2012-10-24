From: "hongbo.zhang" <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V2 2/6] Thermal: make sure cpufreq cooling register after
	cpufreq driver
Date: Wed, 24 Oct 2012 19:58:16 +0800
Message-ID: <1351079900-32236-3-git-send-email-hongbo.zhang@linaro.com>
References: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1351079900-32236-1-git-send-email-hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, kernel-vMlcbD5RyM6HZuj8yyL1ah2eb7JE58TQ@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>

The cpufreq works as a cooling device, so the cooling layer should check if the
cpufreq driver is initialized or not.

Signed-off-by: hongbo.zhang <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
---
 drivers/thermal/cpu_cooling.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index b6b4c2a..7519a0b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -354,6 +354,10 @@ struct thermal_cooling_device *cpufreq_cooling_register(
 	int ret = 0, i;
 	struct cpufreq_policy policy;
 
+	/* make sure cpufreq driver has been initialized */
+	if (!cpufreq_frequency_get_table(cpumask_any(clip_cpus)))
+		return ERR_PTR(-EPROBE_DEFER);
+
 	list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, node)
 		cpufreq_dev_count++;
 
-- 
1.7.11.3
