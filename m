Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF43FA5C3;
	Thu,  4 Jun 2026 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564123; cv=none; b=h2LmEgSrDQ+nJWMm85cMOpqzY/87wiW8MIjUjXMdUUW6EYLB7yq7eAFEPDk96EFJG7+scsxyPFaUMpLWUXcobnahsgjNwpZLiKHc8q8rMTHws++SuOAZ/q10/efg9teX9jZjL7xzIeTfZtnVmeW/9WM8j5J4WRRCxMdJELDPF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564123; c=relaxed/simple;
	bh=1nUCbBcG/ceajNb/U0e4uaBC+wh2nb/tdEkyFINrWac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPa7sathG2GL/AhPQxxqWi8MzcEA4AbpdSLwmdJ2Y0GPZ7aSVB3E4LEVRXqGSqqgSfd/ia/BYyqE1FC7u4nuLWRbGZp38+6OJs0cuYe9XDqUuktLC1ODmfUKyRfYegNonPbUVZIsqwsKDz+YFfuzmGaE4qe8a5mI4cFe2auOlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLp2A4Hd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLp2A4Hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC0F1F00898;
	Thu,  4 Jun 2026 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564122;
	bh=qajQS6K4sEG7dCirtHqQn3VxJX58YgefzvtwF+eYZ04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KLp2A4HdXtS0+KB4ncOBHLw3JmZTTRBC8/a0d2meE0ApmGnGe94bwAXG7OaagAWyu
	 voMuPtgQSE8CpP1/uoig8niOc6KAYoYj8TVheR1CNcs1r8ky2p4peKr4pY59B0F2iH
	 oUJ9EimPn4cRb8TdiYA+jH4CII28H9rr+B78TSn9DphF2Rau3BD0AM0VAbZ1jyloAK
	 7HdDrmA9ztl4vWWcjhmLrcODKzGEoGk1sphZlDjaUKFN7RyvHmDUbuGbBfzMUBoKsw
	 m1oeFLB7SlC9Z/0DNFT/43TpBoJ9ZT+rad/qm1455Iqkbs1lijHCzz+zzJXbmv8Dh6
	 5ke7vdFhf++aQ==
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
	senozhatsky@chromium.org
Subject: [PATCH v2 2/3] PM: dpm_watchdog: Allow disabling DPM watchdog by default
Date: Thu,  4 Jun 2026 09:07:50 +0000
Message-ID: <20260604090756.2884671-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604090756.2884671-1-tzungbi@kernel.org>
References: <20260604090756.2884671-1-tzungbi@kernel.org>
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

Additionally, introduce the "dpm_watchdog_enabled" module parameter to
allow the watchdog to be enabled or disabled at boot time (via
"power.dpm_watchdog_enabled") and at runtime (via sysfs).

This provides flexibility for systems that want the watchdog code
compiled in but inactive by default, allowing it to be enabled only when
needed.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v2:
- Use module parameter and bool for dpm_watchdog_enabled.
- Use IS_ENABLED().

v1: https://lore.kernel.org/all/20260528103215.505795-1-tzungbi@kernel.org

 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 drivers/base/power/main.c                       | 11 +++++++++++
 kernel/power/Kconfig                            |  9 +++++++++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 00375193bd26..0a0d5340b0c7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5399,6 +5399,14 @@ Kernel parameters
 			function to NULL. On Idle the CPU just reduces
 			execution priority.
 
+	power.dpm_watchdog_enabled=
+			[KNL] Enable or disable the device suspend/resume
+			watchdog (DPM watchdog).
+			Format: {"0" | "1"}
+			0: disable
+			1: enable
+			Default value is set by CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED.
+
 	ppc_strict_facility_enable
 			[PPC,ENABLE] This option catches any kernel floating point,
 			Altivec, VSX and SPE outside of regions specifically
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index cd864f3a2799..7822c29b7c8d 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -534,6 +534,11 @@ module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
 MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
 		 "Backtrace all CPUs on DPM watchdog timeout");
 
+static bool __read_mostly dpm_watchdog_enabled =
+				IS_ENABLED(CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED);
+module_param(dpm_watchdog_enabled, bool, 0644);
+MODULE_PARM_DESC(dpm_watchdog_enabled, "Enable DPM watchdog");
+
 /**
  * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
  * @t: The timer that PM watchdog depends on.
@@ -577,6 +582,9 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
 {
 	struct timer_list *timer = &wd->timer;
 
+	if (!dpm_watchdog_enabled)
+		return;
+
 	wd->dev = dev;
 	wd->tsk = current;
 	wd->fatal = CONFIG_DPM_WATCHDOG_TIMEOUT == CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
@@ -595,6 +603,9 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
 {
 	struct timer_list *timer = &wd->timer;
 
+	if (!dpm_watchdog_enabled)
+		return;
+
 	timer_delete_sync(timer);
 	timer_destroy_on_stack(timer);
 }
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 530c897311d4..12a4a66d48d4 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -268,6 +268,15 @@ config DPM_WATCHDOG
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
2.54.0.1032.g2f8565e1d1-goog

