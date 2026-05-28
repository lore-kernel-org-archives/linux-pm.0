Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B8839A81E;
	Thu, 28 May 2026 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964363; cv=none; b=B+zixez3HYlxwQZp85inXTT/QjYwTzk1mPoE7o0tllB+IcS5zuo/r4t4JF2Rq3mIvshJnkbJaSbpQy2H9GlyTeH93ck0Bj0g5wZaXXq/GZXuksVOUZiYMAxVAyXdiQyrwx58XfNtjD0eG6l+SazFdbtRY2eZMQaqcnIidIXRjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964363; c=relaxed/simple;
	bh=aBMi0mrcf4vS1PF/4E16iOtxM6eVrsZSlKC1dqPmC6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kT2qdMG05UlublfXNbg6RGXTf/rxPskfjzT9gBvCx8GoUSXrkxTVNjCUTOjiJnKqeSNMjRX0jJqjeHv8+6lmM/V91xPK+8Sk/183hJ/I5OMopTlgce+wQPVXsfG04H27TtW/e4e2kvZzg42WD7Sht4g2+yCZXf28jzdcx/8AV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUx7mE+t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUx7mE+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055461F000E9;
	Thu, 28 May 2026 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779964362;
	bh=DkMr80QBD3s23T5qqCcla25byzvfr1d064BGe3h1zfg=;
	h=From:To:Cc:Subject:Date;
	b=RUx7mE+tbuhbUvUMifqnZtDE2uqWtP/EsTLR7SNlcYVu6TKNf8HEz7I4vtFl5eNxM
	 //Nmmo/xa7ULn0lhYGhKCKS7aiAj06oCs0Lf/o4lcuCMOzyJPGafUfRdBqWSXCfM7X
	 a061suEnOBT9U/gIDXs3gZK9RX103qCEqc/wp1LTDRpgplioPbaC7UBs4PX9UheeX5
	 oxpbRthP6Th7l8ghcaR9/9NUbBmNUn6rCRpmJ4VlDR74I1IbFmGALXJv/A2aOxnSka
	 gVHV8cutY7ABVd0EcUOhOsCM/oSDb7CSJVJ9HcmlJBBWkrNbU1xNrj+RYNtFFijSSY
	 XV0ZkzFiCprew==
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
	driver-core@lists.linux.dev
Subject: [PATCH] PM: sleep: Allow disabling DPM watchdog by default
Date: Thu, 28 May 2026 10:32:15 +0000
Message-ID: <20260528103215.505795-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED Kconfig option to
allow the device suspend/resume watchdog (DPM watchdog) to be disabled
by default at compile time.

Additionally, introduce the "dpm_watchdog_enabled" boot parameter to
enable or disable the watchdog at boot time.

This provides flexibility for systems that want the watchdog code
compiled in but inactive by default, allowing it to be enabled only when
needed.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++++++
 drivers/base/power/main.c                     | 20 +++++++++++++++++++
 kernel/power/Kconfig                          |  9 +++++++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 85936e48cf9a..3a919e660137 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1344,6 +1344,14 @@ Kernel parameters
 			it becomes active and is searched during signature
 			verification.
 
+	dpm_watchdog_enabled=
+			[KNL] Enable or disable the device suspend/resume
+			watchdog (DPM watchdog).
+			Format: {"0" | "1"}
+			0: disable
+			1: enable
+			Default value is set by CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED.
+
 	driver_async_probe=  [KNL]
 			List of driver names to be probed asynchronously. *
 			matches with all driver names. If * is specified, the
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e1b550664bab..4f92905f3edf 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -527,6 +527,20 @@ module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
 MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
 		 "Backtrace all CPUs on DPM watchdog timeout");
 
+#ifdef CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED
+static unsigned int __read_mostly dpm_watchdog_enabled = 1;
+#else
+static unsigned int __read_mostly dpm_watchdog_enabled;
+#endif
+
+static int __init dpm_watchdog_setup(char *str)
+{
+	if (kstrtouint(str, 0, &dpm_watchdog_enabled) == 0)
+		return 1;
+	return 0;
+}
+__setup("dpm_watchdog_enabled=", dpm_watchdog_setup);
+
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
  * @t: The timer that PM watchdog depends on.
@@ -570,6 +584,9 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
 {
 	struct timer_list *timer = &wd->timer;
 
+	if (!dpm_watchdog_enabled)
+		return;
+
 	wd->dev = dev;
 	wd->tsk = current;
 	wd->fatal = CONFIG_DPM_WATCHDOG_TIMEOUT == CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
@@ -588,6 +605,9 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
 {
 	struct timer_list *timer = &wd->timer;
 
+	if (!dpm_watchdog_enabled)
+		return;
+
 	timer_delete_sync(timer);
 	timer_destroy_on_stack(timer);
 }
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 05337f437cca..d4cecdb8575e 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -267,6 +267,15 @@ config DPM_WATCHDOG
 	  captured in pstore device for inspection in subsequent
 	  boot session.
 
+config DPM_WATCHDOG_DEFAULT_ENABLED
+	bool "Enable DPM watchdog by default"
+	depends on DPM_WATCHDOG
+	default y
+	help
+	  If you say Y here, the DPM watchdog will be enabled by default.
+	  If you say N, it will be compiled in but disabled, requiring a
+	  boot parameter to activate.
+
 config DPM_WATCHDOG_TIMEOUT
 	int "Watchdog timeout to panic in seconds"
 	range 1 120
-- 
2.54.0.929.g9b7fa37559-goog

