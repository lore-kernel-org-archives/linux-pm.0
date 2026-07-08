Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF642088E;
	Wed,  8 Jul 2026 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485254; cv=none; b=f39U7YTy9sTd8gEPLZqrztw/oTi421BmBFbicNg76gEjSOfSTtpKQpzUkww44gXwBshsY18hq3d2EYZtduwkcEFVkPhhX8dYDEiSeE3KMjt3KKNNMgQaCBXpFCUrjeaNcWLi29EPpIDwDH8peUD4ctdotuZKWp0LYd9/IpCCe34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485254; c=relaxed/simple;
	bh=js0llBOdkJNDIRk9T3auG88K93xaYSJmaQk2iydpp5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhqFZNJrmQo6APYdEh0t2YDHM0PDQx63NIpYiPUQ/b7SZYkIvr7MInQjy6YMixBGetXSk8WrzENlktxjgDkA4G0cRvvHLzUOBnNBN+bsZnxIv8Fz0UiaEsI9IPyOy1BDKhV7sec67dzCx2QV5aQi1o79211HcNy39Jz0eslYZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go9ex8q5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go9ex8q5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC31B1F000E9;
	Wed,  8 Jul 2026 04:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783485253;
	bh=e2ISK8b2fzjNMIJpxR6K8Mnj8XL4W13/HvIME0ErR+Q=;
	h=From:To:Cc:Subject:Date;
	b=Go9ex8q5UxgrpwTHFuXcI5YhEqr9bCEccsVQM+S4R74URoauHENCw/L7dSZvZszJU
	 624M2tTGJQ45iaEU7fsvoQVTAOhpIjrNKzDH2tKBS8KCx9aKwRnJxCd1m31jt3z9nm
	 dSE4UYVF9uMHshijC0kRaV2A+yufHYC7dnyikpGXfud65aTcLQI+KVQhngNGj0r1pK
	 FxQewuZcT6Oxhg4ck+L9wlNdXrI2ng+LeZYEaHOxfTOAhVR68QBbWAHg3dgGvM3DBa
	 4RmDtG+J+td0OAH660X4+312pBfZC7CfPngbHmTMVtTPl7ZMk53cQo6Pi56hE8NIFi
	 II/43KPNgjkbQ==
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
Subject: [PATCH v6 0/2] PM: dpm_watchdog: Improve DPM watchdog configurability
Date: Wed,  8 Jul 2026 04:33:15 +0000
Message-ID: <20260708043317.2980098-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves the configurability of the DPM watchdog.

Currently, the DPM watchdog is always enabled if compiled in.  Also, the
module parameters defined in drivers/base/power/main.c use the generic
and non-descriptive "main" prefix.

This series addresses these limitations.

Patch 1 renames the module parameter prefix for
drivers/base/power/main.c from "main" to "pm".

Patch 2 introduces the "dpm_watchdog_enabled" module parameter to allow
enabling/disabling the watchdog at boot time and runtime.  It also adds
CONFIG_DPM_WATCHDOG_ENABLED to set the default value of the module
parameter at compile time.

The primary motivation for this configurability revolves around Android
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
---
v6:
- Change the prefix "pm_sleep" -> "pm".

v5: https://lore.kernel.org/all/20260701045640.3130090-1-tzungbi@kernel.org
- Rebase to v7.2-rc1.
- Fix Signed-off-by lines.

v4: https://lore.kernel.org/all/20260611021219.2093476-1-tzungbi@kernel.org
- Address review comments.
- Patch 3 in v3 has applied separately.

v3: https://lore.kernel.org/all/20260608021526.1023248-1-tzungbi@kernel.org
- Address review comments on patch 2.

v2: https://lore.kernel.org/all/20260604090756.2884671-1-tzungbi@kernel.org
- Form a new series.

v1: Doesn't exist.

Tzung-Bi Shih (2):
  PM: sleep: Rename module parameters prefix to "pm"
  PM: dpm_watchdog: Allow disabling DPM watchdog by default

 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 drivers/base/power/main.c                       | 14 ++++++++++++++
 kernel/power/Kconfig                            | 10 ++++++++++
 3 files changed, 31 insertions(+)

-- 
2.55.0.795.g602f6c329a-goog

