Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC03389455;
	Mon, 20 Jul 2026 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516921; cv=none; b=n6tykRnFWGMwERUtbwtyiLIw5opMa9vZP+TbGrfQ8hb7nexNnrYQgnz4Tz0josip72MKXhxKIIzl7Kej/Ub49I7f1/7s2FwfoG0LlevFNGExccPFqDU4/ldXIOcbhNIG1AeSb14jc0p+2/SC8HFyzqtRdYv7E3v6HNaadLWmke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516921; c=relaxed/simple;
	bh=3Qf77x5UNso8Szde6l9Wn6t4nKVUvU94zkIFBCO0Y2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pW1XYTTuVLj/D6HktHgHJqSzB8pSJxWXOsE5yopfavEWXnauVET9Ba79qNUbVpFwm5AXNECZL+bHxlBLxUQX2/i9vFDbfjWd6wrD2LjLP9Kw0LlPBUCa794TDNh1FfJTomuMWM34LZkJB7rp2QHqcytHYt5O/SHBe0RTNLh5spM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsZ3S6YU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsZ3S6YU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938881F000E9;
	Mon, 20 Jul 2026 03:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784516920;
	bh=iUtm5SAe2SeQY6Iq7y1PN0eZx12oV8hhEPW1fl/WPVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XsZ3S6YU+B14tc4aZdBvsW3nhh5TtapgdDzjS6TZAZIbo9HKy9mF7o7j2BhNmTCWm
	 5CVzW1szxdbu39ged0IQzS7iSSDe7L/VKS42tvZ8ahQK9sB05eGOMfEwz5GTEfnH99
	 x5zzOUrGWBnE5i26RiV7GNhSKNtsUn+phP+KLB0VfbMz90C46uyUlTWHAHoMMQiNWL
	 Mxc15ncNTmTtIapdOLyzQl0pgriQwDQum5zG/3HSzB90cQxRWQkEgczIxRh6cZ33TP
	 VPDJkPa7EPLFxm3kPCM1n6TzcCaSeEmf/KUs13LSX7k64np8IZRoHjqxufLFKFWOTP
	 OlYAkDPghZgow==
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
Subject: [PATCH RESEND v6 2/2] PM: dpm_watchdog: Allow disabling DPM watchdog by default
Date: Mon, 20 Jul 2026 03:08:21 +0000
Message-ID: <20260720030821.2780257-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260720030821.2780257-1-tzungbi@kernel.org>
References: <20260720030821.2780257-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the "dpm_watchdog_enabled" module parameter to allow the DPM
watchdog to be enabled or disabled at boot time and runtime.

Additionally, introduce the CONFIG_DPM_WATCHDOG_ENABLED Kconfig option
to set the default value of the module parameter at compile time.

The primary motivation for this configurability resolves around Android
GKI (Generic Kernel Image).  We want to enable CONFIG_DPM_WATCHDOG in
the GKI so the feature is available.  However, because the GKI is shared
across many different devices, we don't want to inadvertently affect
devices that are unaware of this feature.  This provides a way to
compile it in, but keep it disabled by default for those devices via the
kernel command line or module parameters.

To maintain backward compatibility, CONFIG_DPM_WATCHDOG_ENABLED relies
on `default y`.  Previously, the DPM watchdog was always active if
CONFIG_DPM_WATCHDOG was set.  Defaulting this new option to 'y' ensures
that the behavior remains unchanged for existing users and defconfigs
when they upgrade.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v6:
- Change the prefix "pm_sleep" -> "pm".

v5: https://lore.kernel.org/all/20260701045640.3130090-3-tzungbi@kernel.org
- No changes.

v4: https://lore.kernel.org/all/20260611021219.2093476-3-tzungbi@kernel.org
- Rewrite the commit message to indicate the module parameter is the
  main change in the patch.
- DPM_WATCHDOG_DEFAULT_ENABLED -> DPM_WATCHDOG_ENABLED.

v3: https://lore.kernel.org/all/20260608021526.1023248-3-tzungbi@kernel.org
- Add "PM" tag (was missing).
- Update the format and specify dependencies in kernel-parameters.txt.
- Update the help message in Kconfig to reflect that dpm_watchdog_enabled
  can be set at runtime as well.

v2: https://lore.kernel.org/all/20260604090756.2884671-3-tzungbi@kernel.org
- Use module parameter and bool for dpm_watchdog_enabled.
- Use IS_ENABLED().

v1: https://lore.kernel.org/all/20260528103215.505795-1-tzungbi@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 drivers/base/power/main.c                       | 11 +++++++++++
 kernel/power/Kconfig                            | 10 ++++++++++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..ea0b70f87472 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -47,6 +47,7 @@
 	PCI	PCI bus support is enabled.
 	PCIE	PCI Express support is enabled.
 	PCMCIA	The PCMCIA subsystem is enabled.
+	PM	Power Management support is enabled.
 	PNP	Plug & Play support is enabled.
 	PPC	PowerPC architecture is enabled.
 	PPT	Parallel port support is enabled.
@@ -5354,6 +5355,12 @@ Kernel parameters
 	pm_debug_messages	[SUSPEND,KNL]
 			Enable suspend/resume debug messages during boot up.
 
+	pm.dpm_watchdog_enabled=
+			[PM] Enable or disable the DPM watchdog.  Requires
+			CONFIG_PM_SLEEP and CONFIG_DPM_WATCHDOG enabled.
+			Format: <bool>
+			Default value is set by CONFIG_DPM_WATCHDOG_ENABLED.
+
 	pnp.debug=1	[PNP]
 			Enable PNP debug messages (depends on the
 			CONFIG_PNP_DEBUG_MESSAGES option).  Change at run-time
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 49ea6e2cd735..184dc4b3b938 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -535,6 +535,11 @@ module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
 MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
 		 "Backtrace all CPUs on DPM watchdog timeout");
 
+static bool __read_mostly dpm_watchdog_enabled =
+				IS_ENABLED(CONFIG_DPM_WATCHDOG_ENABLED);
+module_param(dpm_watchdog_enabled, bool, 0644);
+MODULE_PARM_DESC(dpm_watchdog_enabled, "Enable DPM watchdog");
+
 static unsigned int __read_mostly dpm_watchdog_timeout = CONFIG_DPM_WATCHDOG_TIMEOUT;
 static unsigned int __read_mostly dpm_watchdog_warning_timeout =
 						CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
@@ -630,6 +635,9 @@ static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
 {
 	struct timer_list *timer = &wd->timer;
 
+	if (!dpm_watchdog_enabled)
+		return;
+
 	wd->dev = dev;
 	wd->tsk = current;
 	wd->fatal = dpm_watchdog_timeout == dpm_watchdog_warning_timeout;
@@ -648,6 +656,9 @@ static void dpm_watchdog_clear(struct dpm_watchdog *wd)
 {
 	struct timer_list *timer = &wd->timer;
 
+	if (!dpm_watchdog_enabled)
+		return;
+
 	timer_delete_sync(timer);
 	timer_destroy_on_stack(timer);
 }
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 530c897311d4..71165e7f04f4 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -268,6 +268,16 @@ config DPM_WATCHDOG
 	  captured in pstore device for inspection in subsequent
 	  boot session.
 
+config DPM_WATCHDOG_ENABLED
+	bool "Enable DPM watchdog by default"
+	depends on DPM_WATCHDOG
+	default y
+	help
+	  If you say Y here, the DPM watchdog will be enabled by default.
+	  If you say N, it will be compiled in but disabled.  It can be
+	  enabled at boot time via the "pm.dpm_watchdog_enabled" kernel
+	  parameter or at runtime via sysfs.
+
 config DPM_WATCHDOG_TIMEOUT
 	int "Watchdog timeout to panic in seconds"
 	range 1 120
-- 
2.55.0.795.g602f6c329a-goog

