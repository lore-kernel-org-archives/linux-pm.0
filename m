Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7801DF74F;
	Mon,  8 Jun 2026 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884970; cv=none; b=CqJ8lgMV5etcdu1vjC2DsdcY2U/ruom/0Oql+cxJNrR0U+YfowS44YHzF4e4Uq9y80HcYz75ejzOsJ/eBn8GpOs8tiTALcLtR4wsNw+psW5yTysUtGpRkGbNvAGgURhIKuBI1qCro/2g/ch68NzPhoqzqWYn3+dayLZJdLQXgLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884970; c=relaxed/simple;
	bh=aJNNxC6IXDdS28KGccYnRiv3asfTGIEdXwVdfY80BEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2CM0mJcDerBgcPSgKSe3KYdz1qD9ioz/kiJR638aUuYmgpEWDMyUgzaShCDDMqkj7UdAXZZB5zSZEixP4QKrW/e1osQP974dchWSeGHL4fC9Uel/+KcfS9azEUHOQFVWct/Dk2BePS3d24W995/R4QREvEqap/n+Lsq6RCEALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7bdxwu8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7bdxwu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92A81F00893;
	Mon,  8 Jun 2026 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780884969;
	bh=QfKetB0CvB/6gCtppxMCr7hrqMdVrjFzeKGdJojD+XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7bdxwu89d7fRJA1DyAlghx8qzYCtnZqxJr2eHKQi3rKHaMRGhN7uJzqBOQJmUcJS
	 gMjvElCUaUWdeRhWWBXBdxzn6h/VmNs5n2CJBmU8NX8YK0H4iI9YT+yPJ0HfX/pk6K
	 GGdPFq66tG4Bkr5CfxnIl34jzZjTXLHF6AroeaTEeUNu0bzKMPpQt3PVBCAKBAIarx
	 UnnQKs3qXcHslcQjNLURI+ildPXYH1rD1GXldKQGa7zYFCtmPCMM2sYkfkPNqCc1K7
	 aWeYN8F4aTSfbiUXV0dHk+qX1yyJDB1kbqfRWnJ+jEEC99suZGbASym6sn0gs0oApL
	 zPIhdZNPXJMhA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	tzungbi@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	tfiga@chromium.org,
	senozhatsky@chromium.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 3/3] PM: dpm_watchdog: Add sysctl interface for DPM watchdog timeouts
Date: Mon,  8 Jun 2026 02:15:26 +0000
Message-ID: <20260608021526.1023248-4-tzungbi@kernel.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260608021526.1023248-1-tzungbi@kernel.org>
References: <20260608021526.1023248-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce sysctl knobs to allow configuring DPM watchdog timeouts at
runtime.

Currently, these timeouts are fixed at compile time via
CONFIG_DPM_WATCHDOG_TIMEOUT and CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT.
This limits flexibility if the timeouts need to be adjusted for
different testing scenarios or hardware behaviors without rebuilding
the kernel.

Add the following sysctl files under /proc/sys/kernel/:
- dpm_watchdog_timeout_secs: The total timeout before panic. The
  maximum value is capped at CONFIG_DPM_WATCHDOG_TIMEOUT to prevent
  unreasonably large timeouts.
- dpm_watchdog_warning_timeout_secs: The warning timeout. The maximum
  value is capped at the current dpm_watchdog_timeout_secs.
Both sysctls have a minimum value of 1.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v3:
- No changes.

v2: https://lore.kernel.org/all/20260604090756.2884671-4-tzungbi@kernel.org
- New to the series.

v1: Doesn't exist.

 drivers/base/power/main.c | 61 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 7822c29b7c8d..c1a4b30fafb2 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
+#include <linux/sysctl.h>
 #include <linux/async.h>
 #include <linux/suspend.h>
 #include <trace/events/power.h>
@@ -539,6 +540,58 @@ static bool __read_mostly dpm_watchdog_enabled =
 module_param(dpm_watchdog_enabled, bool, 0644);
 MODULE_PARM_DESC(dpm_watchdog_enabled, "Enable DPM watchdog");
 
+static unsigned int __read_mostly dpm_watchdog_timeout = CONFIG_DPM_WATCHDOG_TIMEOUT;
+static unsigned int __read_mostly dpm_watchdog_warning_timeout =
+						CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
+static const unsigned int dpm_watchdog_timeout_max = CONFIG_DPM_WATCHDOG_TIMEOUT;
+
+static int proc_dodpm_watchdog_timeout_secs(const struct ctl_table *table,
+					    int write, void *buffer,
+					    size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table ctl = *table;
+	unsigned int val = dpm_watchdog_timeout;
+	int ret;
+
+	ctl.data = &val;
+	ret = proc_douintvec_minmax(&ctl, write, buffer, lenp, ppos);
+	if (ret || !write)
+		return ret;
+
+	if (val < dpm_watchdog_warning_timeout)
+		dpm_watchdog_warning_timeout = val;
+	dpm_watchdog_timeout = val;
+
+	return 0;
+}
+
+static const struct ctl_table dpm_watchdog_sysctls[] = {
+	{
+		.procname	= "dpm_watchdog_timeout_secs",
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dodpm_watchdog_timeout_secs,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= (void *)&dpm_watchdog_timeout_max,
+	},
+	{
+		.procname	= "dpm_watchdog_warning_timeout_secs",
+		.data		= &dpm_watchdog_warning_timeout,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= (void *)&dpm_watchdog_timeout,
+	},
+};
+
+static int __init dpm_watchdog_sysctl_init(void)
+{
+	register_sysctl_init("kernel", dpm_watchdog_sysctls);
+	return 0;
+}
+subsys_initcall(dpm_watchdog_sysctl_init);
+
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
  * @t: The timer that PM watchdog depends on.
@@ -564,9 +617,9 @@ static void dpm_watchdog_handler(struct timer_list *t)
 			dev_driver_string(wd->dev), dev_name(wd->dev));
 	}
 
-	time_left = CONFIG_DPM_WATCHDOG_TIMEOUT - CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
+	time_left = dpm_watchdog_timeout - dpm_watchdog_warning_timeout;
 	dev_warn(wd->dev, "**** DPM device timeout after %u seconds; %u seconds until panic ****\n",
-		 CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT, time_left);
+		 dpm_watchdog_warning_timeout, time_left);
 	show_stack(wd->tsk, NULL, KERN_WARNING);
 
 	wd->fatal = true;
@@ -587,11 +640,11 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
 
 	wd->dev = dev;
 	wd->tsk = current;
-	wd->fatal = CONFIG_DPM_WATCHDOG_TIMEOUT == CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
+	wd->fatal = dpm_watchdog_timeout == dpm_watchdog_warning_timeout;
 
 	timer_setup_on_stack(timer, dpm_watchdog_handler, 0);
 	/* use same timeout value for both suspend and resume */
-	timer->expires = jiffies + HZ * CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
+	timer->expires = jiffies + HZ * dpm_watchdog_warning_timeout;
 	add_timer(timer);
 }
 
-- 
2.54.0.1099.g489fc7bff1-goog

