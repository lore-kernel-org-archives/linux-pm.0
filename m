Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55247390CBF;
	Mon,  8 Jun 2026 07:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780904202; cv=none; b=ITA4d8i8O2XyfRfFCpWSbTN7QuAuHJJ5Zu3GStNkDfclc63Ytctpw1Q2WSqmt2geYRkyFz+Zfr1YHggk1vNwHohzAPwBJnHqzU5lfGBlgS8Seh82A6Ni4KJkVbCH1gdU32x7UmcnS4JJSAXkHDcDNrJ03eSxPBTBn076oMLI9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780904202; c=relaxed/simple;
	bh=wv5BCToSISG6yggP25rP+NA7FDd5RuN5lOZqbt43AuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muXYh2vehYIeDdJ70vJhbiN9/q2PoysYSnJCIAQdiZ/3kpK8nBi87MXUeIIHF3jCZe+7CFXuRFW4ig+pvKBgOc48glhdQlf+DIM+T9ikeZrkO8XXItto/Z/pRrsg7236wyP7uRCC07V5dovvyPfqhiJTGxkbp8KQ9e7yq4AyvGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=DFW7QWNs; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="DFW7QWNs"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B4FCE27622;
	Mon,  8 Jun 2026 09:36:38 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GB53__dkvk7r; Mon,  8 Jun 2026 09:36:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780904198; bh=wv5BCToSISG6yggP25rP+NA7FDd5RuN5lOZqbt43AuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DFW7QWNs2ck6i72uALirbQncRN45NrADhipFtZU10SdjI6KCOtU/jstTAapiwOLZc
	 5CcoFQMdXGtwF429BX2FBiL/GMRaEXSLbmwjqLq6j7lTEisONAEAubk7SKkXfi/bpP
	 v3FzoSRfvDUvkuwADWoOgZP9zIyg8JgRt5V9sRG3mE5vE89yLelvjekqCIwEIkOX8W
	 uJXhwBylvjVZoTNbkHjocximkZY0bDJonhBIw2mtnGLmQfWrnXOfT/NPljYZBGABRC
	 NtT64ExRDPc4kiqAgEU0nat/x4ThfnCRUiyY9PeqzSyeS+iyNE3YwXgIZXVWwBd7zF
	 z6odg53VbACMw==
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
	viresh.kumar@linaro.org
Subject: [PATCH v5 0/3] cpufreq/amd-pstate: Fix EPP and auto_sel initialization
Date: Mon,  8 Jun 2026 09:31:00 +0200
Message-ID: <20260608073614.5738-1-scardracs@disroot.org>
In-Reply-To: <c97c81f1-1254-44fe-80b2-89f82fec73f6@amd.com>
References: <c97c81f1-1254-44fe-80b2-89f82fec73f6@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mario, Prateek,

I don't mind splitting in more patches as far as it works and make things
easier for you on backporting and verification.

Changes in v5:
- Split the unified patch into a 3-patch series:
  - Patch 1: Change EPP helper return types to signed int and add error handling
    in amd_pstate_epp_cpu_init().
  - Patch 2: Remove the active-mode early return check in shmem_init_perf() to
    ensure auto_sel is properly toggled on shared memory systems.
  - Patch 3: Cache the initial firmware programmed EPP value in cppc_req_cached.

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

Marco Scardovi (3):
  cpufreq/amd-pstate: Fix EPP return type and handle errors during
    initialization
  cpufreq/amd-pstate: Toggle auto_sel in active mode on shared memory
    systems
  cpufreq/amd-pstate: Cache the firmware programmed EPP value

 drivers/cpufreq/amd-pstate.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

-- 
2.54.0

