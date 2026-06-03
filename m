Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00346AEF2;
	Wed,  3 Jun 2026 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488099; cv=none; b=q6DgjxErSMscUpffiaqADws46478b85V94Qoh7033UGQtNuE45LQtItzvgYNwS19fmX6Kb8lKCIqZQWt5JaeHEnV2NnVql33VXq87r0Iwi+fUl5GhzfjmWobfAqXcaXBqIZDDU6I+ndXbHscSU0QpdD/gd3hx5sRTX5Ch+B3u+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488099; c=relaxed/simple;
	bh=aIt7iflSFe/IeQyHr1BOSUPaXA/5ZY9y6pqWCjV/9XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSBChHNXRKwszrAqrHU/J9810EBZhLxQ08aj2HmUZNlEfKjuAVgzz/Dnsk4OWPp5Otpx3OrjfZPYoR1imbwGTJrBwygSY+ql6xY0f3HeID/6bPsUr4I+wxw0wUf/9sIMi0meXGZl6fDQc4er5oRJbRftaWKq6C27X1z2rySvKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=l2MSuGr2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="l2MSuGr2"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2FAE72721D;
	Wed,  3 Jun 2026 14:01:35 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pfVK6ROpOcCS; Wed,  3 Jun 2026 14:01:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780488094; bh=aIt7iflSFe/IeQyHr1BOSUPaXA/5ZY9y6pqWCjV/9XM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l2MSuGr2f3FE9lzcozknawdLFUKzyF7z71TPyVtiy/PfLHvzfe5FoPyRlVc01B9vE
	 tMHCuurSPDxAHtZVns7tYGGN/H5Rv770l/VIBRXuSFNAqhe6ykCLh3L4PJTISJ5dtP
	 Yn7f+iwJfH49mhwuZY0mpAgjdcqPUTF31VOFfsVYz/YmtLU31wrASFRRoxWV6iLbor
	 QEw/DzMgTxw0VOpLHs1bXXvcXuA6aPhxGeNViyAX40cYll1m8CTigkET3nJbyFE8ge
	 4mnmkugjx94rWd6taXxeF35yWUoEIzFf4sPgIT2MA45dwOKRQv6ItY5fweGcINXXa+
	 eC0Z7sUJEzkrw==
From: Marco Scardovi <scardracs@disroot.org>
To: kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	perry.yuan@amd.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	scardracs@disroot.org,
	stuartmeckle@gmail.com,
	viresh.kumar@linaro.org,
	wyes.karny@amd.com
Subject: [PATCH v2 0/2] cpufreq/amd-pstate: Fix EPP initialization and add capability check
Date: Wed,  3 Jun 2026 13:56:33 +0200
Message-ID: <20260603120121.25772-1-scardracs@disroot.org>
In-Reply-To: <4cb9459c-f471-478a-9670-58d898619f45@amd.com>
References: <4cb9459c-f471-478a-9670-58d898619f45@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Prateek and all,

before trying merging in @Mario's git il post the new patches with the
changes you suggested. If something doesn't feel right let me know.

This series addresses a boot-time performance regression on shared memory
systems where the CPU gets stuck at the lowest non-linear frequency
(1.7GHz), and adds proper EPP capability checks to prevent active mode from
being incorrectly enabled on systems without EPP support.

Patch 1 fixes the boot-time initialization regression by introducing an
`epp_hw_programmed` flag in struct amd_cpudata to track whether EPP has
been configured on the hardware. This bypasses a false cache hit on boot
due to zero-initialized caching registers, ensuring that EPP and auto_sel
are always written during CPU initialization, while still preserving the
cache guard optimization for all subsequent runtime transitions.

Patch 2 implements an EPP capability check at boot time using a new
amd_pstate_epp_supported() helper, which queries the EPP performance
capability on the first online CPU. If EPP is unsupported, the driver falls
back to passive mode at boot, and rejects any subsequent runtime
transitions to active mode.

Changes in v2:
- Patch 1: Rename `epp_initialized` to `epp_hw_programmed`, explicitly
  document the flag semantics, and add a comment documenting the EPP cache
  guard optimization behavior.
- Patch 2: Add comments explaining the uniform CPU capability check on x86,
  handle EPP capability check errors robustly using a tri-state model (only
  treat -EOPNOTSUPP as unsupported, warn and assume supported for other
  errors to avoid false negatives), and reject runtime active mode transitions
  at sysfs store time (preventing the driver from being left in an
  unregistered state).

Changes in v1:
- Fix the boot-time CPPC EPP/auto_sel initialization regression in
  shmem_set_epp() using a state tracking flag while preserving runtime
  cache optimization.
- Add an EPP capability check helper during initialization.
- Fall back to passive mode at boot if EPP is not supported, and reject
  transitions to active mode at runtime if EPP is not supported.

Marco Scardovi (2):
  cpufreq/amd-pstate: Fix EPP initialization for shared memory systems
  cpufreq/amd-pstate: Prevent active mode on systems without EPP support

 drivers/cpufreq/amd-pstate.c | 52 +++++++++++++++++++++++++++++++++++-
 drivers/cpufreq/amd-pstate.h |  2 ++
 2 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.54.0
