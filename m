From: Andrey Utkin <andrey.krieger.utkin@gmail.com>
Subject: [PATCH 1/5] tools/power/cpupower/utils/helpers/sysfs.c: drop negativity check on unsigned value
Date: Sat, 19 Jul 2014 22:14:04 +0300
Message-ID: <1405797244-5182-1-git-send-email-andrey.krieger.utkin@gmail.com>
References: <1405697445-23620-1-git-send-email-andrey.krieger.utkin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405697445-23620-1-git-send-email-andrey.krieger.utkin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, dcb314@hotmail.com, rafael.j.wysocki@intel.com, trenn@suse.de, linux@dominikbrodowski.net, linux-pm@vger.kernel.org, Andrey Utkin <andrey.krieger.utkin@gmail.com>
List-Id: linux-pm@vger.kernel.org

Resubmitting to send also to linux-pm@vger.kernel.org as requested by
Rafael J. Wysocki <rafael.j.wysocki@intel.com>

---8<---

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=80621
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Andrey Utkin <andrey.krieger.utkin@gmail.com>
---
 tools/power/cpupower/utils/helpers/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/helpers/sysfs.c b/tools/power/cpupower/utils/helpers/sysfs.c
index 851c7a1..09afe5d 100644
--- a/tools/power/cpupower/utils/helpers/sysfs.c
+++ b/tools/power/cpupower/utils/helpers/sysfs.c
@@ -81,7 +81,7 @@ int sysfs_is_cpu_online(unsigned int cpu)
 	close(fd);
 
 	value = strtoull(linebuf, &endp, 0);
-	if (value > 1 || value < 0)
+	if (value > 1)
 		return -EINVAL;
 
 	return value;
-- 
1.8.5.5
