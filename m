Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F63FFAA7;
	Thu,  4 Jun 2026 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780564128; cv=none; b=V+OQdgUdx1SaVSPJGNheec37+l3QAAeem0hkmsBBapIzc3mtznMrRUrVPS1sYrPScnucfWXPjgA6XnXChA83WNWHwtm2vQN8BQ1QFCpnKjhPrRbxnHls6RUFq9kvYwaxQJC7WneqDGjJwHu32+Dfz8I13+f2hOemLKLjSwHzTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780564128; c=relaxed/simple;
	bh=gR/tI7V1xtGpHTVg4yxmUFL8pTB/bPH3uiuf6LSiPWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3Jeiyy5PemjQ5CO3DfIdUdGhos0RLmG0HSbWN32gqoypoAKDH1Pmsxts7DHXM5Qz8IuhqkxXhF6GplDmfiQCvXithLWbpfmpMxZhs1OJNdSflHptN93nkBucOgPTxBOCoQPrqX+d0zY0y30Pfs3i7NMnO1ScZTBvxyd+RTgNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBcLHbq6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBcLHbq6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263401F00899;
	Thu,  4 Jun 2026 09:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780564127;
	bh=dkAMsc4FtFAFIxdfhhEA2HI+PsCBrhGiEI43ClSKD38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UBcLHbq69TBDnhWQhHbjlvB3u/Hx/2qTimnfWywIWcjzbMMsaVcFXgB9tMrx4bVj6
	 xL3a2vjCPhZ26TqVTt7hpfnfHVb7Uo4uIKtR5eCgMFTUSM3/+cGyDlpYlJGKj2BfCa
	 LQo6wNI3vwmU3PcKTdUm+ZSZBHvBVij8bol96vSSM7X4oA3K+aeyKko7uF/kxeLG4p
	 7fmhldUc5vrTzDXd6Zqx4dwyWQLwZL5ZdL4FfmOcpsSSLyld3nUl5l1tlZFDyJE8BB
	 V0pNW0jg8GQpfhU6MUn3ZqgVpe4PWaaffzCtBw2Kqb1LtDKMV2/6c0NtXp/rEn5ROR
	 bv05E+gFaZMwA==
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
Date: Thu,  4 Jun 2026 09:07:52 +0000
Message-ID: <20260604090756.2884671-5-tzungbi@kernel.org>
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

