Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD12642EEC7;
	Wed,  3 Jun 2026 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474921; cv=none; b=uv9uPX3Atm/bgGwrPty4b/an/qmOg1cCpgM1bgsAj/4ixCRdnLW1ASTV/PaUI14bMPvGTqVtofez3r+Iy4kx0PoturV4y29fyExQmYPgGoPcZCaFoT2SuS7gOVlP8W8S1WD+jmjpgpneAydnZVhn+mXgpbca5VofDiZFSsKqNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474921; c=relaxed/simple;
	bh=pGPJHAUkpxU/a6QKvNkEldgiYFgQZcpIZKxRyUehqDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPvzZivS5Lf0fCXLucXcGUqZn3XGTq1JzkvpW1kq9zG0Huv9t/lzwDzWG40mrrwH3azqeIZE32wKO9ZxDmfLxSvPRL6AUhGoqE88lFhunqg+IgmmAfKDmSMBqmP9D/9EX3X8qdPvICKNtb35nVS74Vdl53Y0vsFALCJVTvMVkSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=GGGB3kut; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="GGGB3kut"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5A4D127146;
	Wed,  3 Jun 2026 10:21:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mtesjDrtspcb; Wed,  3 Jun 2026 10:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780474917; bh=pGPJHAUkpxU/a6QKvNkEldgiYFgQZcpIZKxRyUehqDE=;
	h=From:To:Cc:Subject:Date;
	b=GGGB3kuttqpX9y3HiTwbcwv+uEBQGQdlMbcZOrU0lFnB6JKxZnLLZofacKvIH8e4Q
	 GKancnb3Abw86cZ4oq44VrVCeBBghfomfMof8qnrEmeps2zturl0EJz9YJZumYN6Cw
	 rAebbtoAyCRrNkV//tI9pDMQGVEjrDosPzrLochWw5cGCp7RVg5a/zQ/z6U0cxYk8L
	 oGnxl9Sq5GAg1f6st4wbUtvfvd7NH3qFOU8KVd+XUQnB6u3f+3W+knLaKHP/ehBBtb
	 7JKpizSdclWtI+4cEqP7c5ZnD+/P4m991fLgq7NofH6pAxXi37XYz08P64f7wNBM18
	 ZjEixykKdxyXg==
From: Marco Scardovi <scardracs@disroot.org>
To: viresh.kumar@linaro.org,
	rafael@kernel.org,
	ray.huang@amd.com,
	mario.limonciello@amd.com
Cc: perry.yuan@amd.com,
	kprateek.nayak@amd.com,
	wyes.karny@amd.com,
	stuartmeckle@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] cpufreq/amd-pstate: Prevent active mode on systems without EPP support
Date: Wed,  3 Jun 2026 10:19:56 +0200
Message-ID: <20260603082143.11215-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Mario, I've made the actual changes you have requested me on bugzilla for
https://bugzilla.kernel.org/show_bug.cgi?id=221473 . Let me know if it sits
right with you.

Prevent the amd-pstate driver from loading in EPP-reliant "active" mode on
systems without Collaborative Processor Performance Control (CPPC) Energy
Performance Preference (EPP) support (such as Zen 2 and older processors).

Zen 2 and older processors do not support EPP. Loading the driver in active
mode on these systems pins the CPU frequency to the lowest non-linear
frequency (1.7GHz).

To resolve this:
- Unconditionally probe EPP support during driver initialization via a new
  amd_pstate_epp_supported() helper, which queries cppc_get_epp_perf() on
  the first online CPU.
- Lack of ENERGY_PERF support or any error from cppc_get_epp_perf() causes
  EPP to be treated as unsupported.
- Cache EPP support to avoid repeated capability checks during mode switches.
- Fall back to passive mode at boot if EPP is unsupported.
- Reject runtime switches to active mode with -ENODEV.

Please review and provide feedback.

Thanks,
Marco


Marco Scardovi (1):
  cpufreq/amd-pstate: Prevent active mode on systems without EPP support

 drivers/cpufreq/amd-pstate.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
2.54.0

