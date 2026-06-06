Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55469305057;
	Sat,  6 Jun 2026 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780729095; cv=none; b=KrPe3G97CfgdEj2QwWsODzzGM9KptMpieqALTtdpaETNGQGYs4dsQlkdDiKBQ6vRA3Kb1b7WcAuy+/uJyIvE+cg7I8QRVMElK4IQjSD9K9zuoRHLN1c6NdQNiQhiDQOtI91Uh3Qdv1bhV3SORvI2kX8hQk+sVapTMlQCaATuK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780729095; c=relaxed/simple;
	bh=YNw3gSQM91tUtkEaBpqEUx3RsDfLPLtpHucGGKR9nZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5vhgDJnwSaq8M180Hk2dDYJEZbJ2eRSTmAiHBYShZSWHEgE4G1yxFAITNYQReQxUI6xL4OnogD/0IE8cue66IzXb1OwQBQZh3KTqaWE43JToCJRoJU9IlMl37IYSC6xl+O2tHDavM7db+bJe1bIAmoDqhsLbTMgIhVswGVTm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=jmhtbJXL; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="jmhtbJXL"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F201B276C9;
	Sat,  6 Jun 2026 08:58:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id otLBUkjYg2yQ; Sat,  6 Jun 2026 08:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780729089; bh=YNw3gSQM91tUtkEaBpqEUx3RsDfLPLtpHucGGKR9nZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jmhtbJXLsDm5NADGYx/+U1oUBjWK2OC1KUFZvwLbIiduuhlrKxxDtbtIW4hifn+wg
	 jyFWXLGmVHFdQ5efSDFgweNLvlIp30Ka5Ly4SpsMg2sbumm2deI+poj6E9ZveneLll
	 hbLBDnTxiVNUZIIMlWCX2rrtCxF2czFDYSw6/CURY3Sf9EnWaqPpNqENsvMdXW6hpo
	 Ji4Vy6bglFl1koT06UZV5GWXMdHs9P0Ss+qjE5YIYBdZEaEw/wc7kmh7GQ0CxYVIeZ
	 fEC4zWmUVcu3WWay3nyf19z2LMpfky2rQnRU7zyxzI+4651ljNCGWqojkg46FzSQ7U
	 vdXGnbIhHeE9A==
From: Marco Scardovi <scardracs@disroot.org>
To: scardracs@disroot.org
Cc: kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	perry.yuan@amd.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	stuartmeckle@gmail.com,
	viresh.kumar@linaro.org,
	wyes.karny@amd.com
Subject: [PATCH v4 0/1] cpufreq/amd-pstate: Fix EPP initialization for shared memory systems
Date: Sat,  6 Jun 2026 08:57:14 +0200
Message-ID: <20260606065756.4442-1-scardracs@disroot.org>
In-Reply-To: <20260605103131.88711-1-scardracs@disroot.org>
References: <20260605103131.88711-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mario, Prateek,

I have submitted v4 of this series to address your feedback:

Changes in v4:
- Refactor EPP getter helper functions (msr_get_epp, shmem_get_epp, and
  amd_pstate_get_epp) to return int, conforming to standard kernel practice
  for value-or-negative-errno helpers.
- Clean up commit message description to link error propagation directly to
  EPP caching.
- Execute the remaining shared-memory initialization path even when booting
  in active mode, rather than bypassing it through an early return.

Changes in v3:
- Patch 1: Cache the firmware-programmed default EPP value at CPU EPP
  initialization (resolving the boot-time false cache hit) and explicitly
  toggle the AUTO_SEL_ENABLE register to 1 on shared memory systems,
  rather than utilizing a state-tracking flag as proposed in v2.
- Patch 2: Dropped as CPPC systems universally support EPP.

Changes in v2:
- Patch 1: Rename `epp_initialized` to `epp_hw_programmed` and add a comment
  documenting the EPP cache guard optimization behavior.
- Patch 2: Add comments explaining the uniform CPU capability check on x86,
  handle EPP capability check errors robustly (only treat -EOPNOTSUPP as
  unsupported, warn and assume supported for other errors to avoid false
  negatives), and reject runtime active mode transitions at sysfs store time
  (preventing the driver from being left in an unregistered state).

Changes in v1:
- Fix the boot-time CPPC EPP/auto_sel initialization regression in
  shmem_set_epp() using a state tracking flag while preserving runtime
  cache optimization.
- Add an EPP capability check helper during initialization.
- Fall back to passive mode at boot if EPP is not supported, and reject
  transitions to active mode at runtime if EPP is not supported.


Marco Scardovi (1):
  cpufreq/amd-pstate: Fix EPP initialization for shared memory systems

 drivers/cpufreq/amd-pstate.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.54.0
