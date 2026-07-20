Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B812D94BA;
	Mon, 20 Jul 2026 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784516915; cv=none; b=cHUgvj30baTY3SYNbL7V5tfQZeErUCNcxohOl1VErlusX+lCuqn4mg6+IBQiy3esjp4GxXD1VxeFj3/aOTtDlQq2P4P2xW2Qs1OyTotWuZtlvML2nHjyL4p64/AnqaVN/xFtJCL+HgA61VS07dwHz75437mjQPsD0/8cxIJIkN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784516915; c=relaxed/simple;
	bh=ZHbYeQh8M/lo+c/Yp9za3JsjfdxW5rWgVBkcpS9k7lw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=moD8qdFnx/cnex9+NIgIN5egITdU8gjVrKvMc7P6z0nUwDJsN0YFkXuAu5jPLnpM059EHr9yn6qSEXexY0wPQFDeLF/ARb4vCkF6j0AuRahgd3eX+Or+Usz3iIf2epamQKC7ErzzpeF19a25YlHp2h42DPtaK21i0cR1jOQ3gA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgSTsChn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgSTsChn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAB91F000E9;
	Mon, 20 Jul 2026 03:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784516914;
	bh=xqkCUUSg3VKT7BIAgeA9qVYw7W4y8B+uGXFbFwcpUns=;
	h=From:To:Cc:Subject:Date;
	b=dgSTsChnJccxX2g7CRYTyqPAoj0AC4CcZVDdIjfRknfCBmOg0Cn6ECdIMfXFMjgFT
	 kou3HqjooY7YJFEWXeZv64E0+rlzklKl/5A6cm0hsI5jj4yh5xCn2z9RW77GJrCB6O
	 yNSapfonoWs1uX2BngT2rKgNj2C2GWPU8msGWu7behE1EqXMEJFzaw8lzhQT99y3Xt
	 Qk87hdzv0d3ZBlGSsNnt/N/lfA28FlQA7GazTrBd8e+eBfU2YAY2OAsKJMQX78RBhS
	 AOVsYlgWKzxOEa4Usm0hrd7i0GMrDrNmih9GyWgnXmnRa47TPlIPa4RoZXV0ROcx4s
	 56Yf5cJTDbp3A==
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
Subject: [PATCH RESEND v6 0/2] PM: dpm_watchdog: Improve DPM watchdog configurability
Date: Mon, 20 Jul 2026 03:08:19 +0000
Message-ID: <20260720030821.2780257-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
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
Since there was no further feedback on v5, I'm sending out v6.
Any feedback would be appreciated.
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

