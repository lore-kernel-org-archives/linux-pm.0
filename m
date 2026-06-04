Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3253F1664;
	Thu,  4 Jun 2026 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564118; cv=none; b=Dwg2PZgpKgjnj4GS+A6FaqTW8PQQboly+PmSdto+Ama2NiyQ4tBBvetb+lIgJuRxMjNIJfjc7MW1yNVLQxfetg9br07DCMLH63et4uc7wG+GowUV/L0mRDUUhUkah1mE1saqRVq7kZeGLqGHPHCTlSP6hBERl68mIPk6t869UnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564118; c=relaxed/simple;
	bh=gR/tI7V1xtGpHTVg4yxmUFL8pTB/bPH3uiuf6LSiPWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4WtBECZ2r0gckUcjqc6DiRNESm4WMqtSKW6h1RvWkXe4oiJsKy9RY6fHn1vxMZtRVVEdlBc0BwSLiblceCxBABrONoWtoZI857VFFQ/Nq6Hen2fXlkvmlbVZUI31WnMBPfBBfEPikFtztIWTlNfJ057gWiGTVoSpQBFHx0QfWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSrJple5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSrJple5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EF51F00893;
	Thu,  4 Jun 2026 09:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564117;
	bh=dkAMsc4FtFAFIxdfhhEA2HI+PsCBrhGiEI43ClSKD38=;
	h=From:To:Cc:Subject:Date;
	b=bSrJple5UEHRiYRMgaEedWY3bUB8hEriDHRSfO0TWUuj/MeLm8tifhnYuFYvVfXut
	 PF1NKEWRxW17QKnrYl1nVTHV4FgpZ17ny/t2afpK8J+LD4xfWI0TMLuBTY7N7OojtX
	 mHzms+UmaNkt9d9vnHLEJVQ6dpzFrzKYSbEu/kuP76NCYU000onpO1Q+OYnN/vJmvW
	 gp8mJpq/4pnq0Ci6S9cxDXEhjmCe5JUINcW+i9gMD2PuYUYSKDWKCIAAl6NI6QGXMH
	 XTkZR4D2KUPhTTWbhLuy1kOsM/Ul1jJkNoNPEBMg3e4DOuWA7j+9seVAloQHXm3qqb
	 Q7BUykLiZ00zQ==
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
Subject: [PATCH v2 0/3] PM: dpm_watchdog: Improve DPM watchdog configurability
Date: Thu,  4 Jun 2026 09:07:48 +0000
Message-ID: <20260604090756.2884671-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves the configurability of the DPM watchdog.

Currently, the DPM watchdog timeouts are fixed at compile time, and the
watchdog is always enabled if compiled in.  Also, the module parameters
defined in drivers/base/power/main.c use the generic and non-descriptive
"main" prefix.

This series addresses these limitations.

Patch 1 renames the module parameter prefix for drivers/base/power/main.c
from "main" to "power".

Patch 2 introduces the CONFIG_DPM_WATCHDOG_DEFAULT_ENABLED to allow the DPM
watchdog to be disabled by default at compile time.  It also exposes the
"power.dpm_watchdog_enabled" module parameter to allow enabling/disabling
the watchdog at boot time and runtime.

Patch 3 introduces sysctl knobs under /proc/sys/kernel/ to allow
configuring the DPM watchdog timeouts at runtime.

---
v2:
- Form a new series.

v1: Doesn't exist.

Tzung-Bi Shih (3):
  PM: core: Rename module parameters prefix to "power"
  PM: dpm_watchdog: Allow disabling DPM watchdog by default
  PM: dpm_watchdog: Add sysctl interface for DPM watchdog timeouts

 .../admin-guide/kernel-parameters.txt         |  8 ++
 drivers/base/power/main.c                     | 75 ++++++++++++++++++-
 kernel/power/Kconfig                          |  9 +++
 3 files changed, 88 insertions(+), 4 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog

