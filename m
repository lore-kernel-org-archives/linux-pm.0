Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F56E3DCD86;
	Tue,  9 Jun 2026 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990260; cv=none; b=DVezlPdHE3m5CVaf0HMIuuAY1P29zVLH0/roYy9DwSFYChNOUAwUwagX45e4fPeGxUFJoemO0cEuYqn+Syu5FMMn7YqGVsttj8DbU6SlkgLgRT2/uXdkYwK4zW7LjkMlXw2OfBEv1+fsw/HJwPF1biyu8PcC1zopzXAqw/IxD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990260; c=relaxed/simple;
	bh=D3u1xQvTsi6bgU2LSDJugZI8pEuRGxHOMiyy6eRF0fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFJdcZPJ4GWIHZXxEeIco7gM4X0AgPgISLCBQ8LQuoLEMWAL/6+BOwrq7WGc+NSYJrjK8ofF84Y7z+cXYQA/RD5+g/m4Udy1EIqB/TApUr+LG3c7wGWrty5YggRdIBWOBRQ497gjrB6FKCS+mRNSd4RoRrthw8j/9W1vgAesAbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=AJ/Rmlww; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="AJ/Rmlww"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E1FFE27229;
	Tue,  9 Jun 2026 09:30:56 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id frK_ykhhAr_a; Tue,  9 Jun 2026 09:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780990256; bh=D3u1xQvTsi6bgU2LSDJugZI8pEuRGxHOMiyy6eRF0fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AJ/RmlwwuTQjFcAE8NRVbI+MHenEcweXbgsNVOcS9HsKEUrF52bS94GnPU1k0XnGx
	 11933H/8+gQ7XeKTx2JZe6JK2wOCYGEUaP6DGivo0InFAHaSg47hAI+Y/BjbNXwvBW
	 yaD1V7oBZJGD/daX1X2KfGtHEHQDukXxhY632hIbxHXziKDmT+K10oBUOzAunHzgFC
	 DNHd4S9L5CYNNmHybGg+GSF5ZJW2XDCjuX0cZMlgd3BAzuKvoVZtx8t1wM+SkLyXoz
	 xtqy6N3+Mv4ljjR2WjJu2lE1OJj06gdzqi5JwvW44CjGmcanKh3KZogIRYdJnAacU+
	 4PfgPuV/GFaXg==
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
Subject: [PATCH v6 0/3] cpufreq/amd-pstate: Fix EPP and auto_sel initialization
Date: Tue,  9 Jun 2026 09:29:02 +0200
Message-ID: <20260609073042.81275-1-scardracs@disroot.org>
In-Reply-To: <d8bc45af-d8bb-48fb-9f3e-5188c8d79c8e@amd.com>
References: <d8bc45af-d8bb-48fb-9f3e-5188c8d79c8e@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mario, Prateek,

no big deal making a v6 with your suggestions. I'm glad this series come to an end
and everything works as expected.

Here is v6 of the series addressing the feedback on EPP and auto_sel initialization.
This version updates the metadata with Reviewed-by and Tested-by tags and applies
a small commit message cleanup.

Changes in v6:
- Add K Prateek Nayak's Reviewed-by and Tested-by tags to all patches.
- Drop the redundant paragraph from the commit message of Patch 3.

Changes in v5:
- Split the single unified patch into a 3-patch series:
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

