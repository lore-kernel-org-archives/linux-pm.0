Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC434CB5B;
	Mon,  8 Jun 2026 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884962; cv=none; b=ZXlQkEPJQiW1s6NRTnspqCz0vMiXLVcgza2zdrhzua35IslgHTVq70QJKgsNq5memPe1/yCs3wLxQF4cCBD8wKF0d2jfrw27VyD8/27DjsYxL8zfqud4vlL0gYLWYF/VTYrmhxZUgml0+KiwlXdKD8r5RCgKqqfpF25zm8gAIcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884962; c=relaxed/simple;
	bh=as1cn8I3sAvGEeC+Ccs5oMsBbu5PT+oFi1OPh3uD+8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjIKQQy1kRK4rT2ZvNUuY2Y93LcSf3dtvKzQwNPVkGWpxmUkWY9rZ/CzIHTG4Kz0i58+pCtd11k67AYeounZ9zRfqst/e7zyzRMXKF3/cJi9OiFA2Z15P1QJOMA+nozj5STTIIh+NvaLFCtiObZTCGVs8MCtcVFH9a1tGpZg5AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCWDI/bY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCWDI/bY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45651F00893;
	Mon,  8 Jun 2026 02:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780884961;
	bh=TdKMJPGr34VAMb6PbEzE4fJdx7m/8TjEUcQyEL/oeJ4=;
	h=From:To:Cc:Subject:Date;
	b=dCWDI/bYKJ2I0hjp/fmSUDPN+b7dbVqLQPrUhzqB0zZPywlc2OEDhhOnaQNILWtZQ
	 QUbIKD+17fSqtYLz71FgGb0FmSRj4GF2i2IyreQrx6xj4FDgNBz490SAGlezkXllMu
	 WtMXx+i3U8mNq8LAeqAAwUntCIxt+nKSk86HRbY69aHZNMJQG+o14rChKdi96y0ugL
	 re257J5SAB6dfU4m89MIHhmywCg2LvYwNaDvGKHKRgWEjKHAzUTJi0EmfzZi4P1BaO
	 BhnxFIs5k/mQ/BSjO5eWgaAhnvsvc30LZvB6Z/MfDZ+zWRNg7tT1oMEO5JVN+JsYpF
	 sI2/j6cXC41cQ==
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
Subject: [PATCH v3 0/3] PM: dpm_watchdog: Improve DPM watchdog configurability
Date: Mon,  8 Jun 2026 02:15:23 +0000
Message-ID: <20260608021526.1023248-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
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
v3:
- Address review comments on patch 2.

v2: https://lore.kernel.org/all/20260604090756.2884671-1-tzungbi@kernel.org
- Form a new series.

v1: Doesn't exist.

Tzung-Bi Shih (3):
  PM: core: Rename module parameters prefix to "power"
  PM: dpm_watchdog: Allow disabling DPM watchdog by default
  PM: dpm_watchdog: Add sysctl interface for DPM watchdog timeouts

 .../admin-guide/kernel-parameters.txt         |  8 ++
 drivers/base/power/main.c                     | 75 ++++++++++++++++++-
 kernel/power/Kconfig                          | 10 +++
 3 files changed, 89 insertions(+), 4 deletions(-)

-- 
2.54.0.1099.g489fc7bff1-goog

