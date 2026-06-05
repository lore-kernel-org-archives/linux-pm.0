Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F536413638;
	Fri,  5 Jun 2026 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780655516; cv=none; b=WghZSRtM5iTvaWqJ0HEVTNJOwaYu6w4kPC6PzFzjIW5P7wgjHs0N2PkO4d5ep90F2CROpjmSe9cBvtE3oT5FWdvh0eC6knXRexSi2MX7tJzeGd3akqSAfhUeC53tKUgamWr7g6qWCnWBUh0p0gBjk3rdGehuz2QnI3cUDen3dic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780655516; c=relaxed/simple;
	bh=c7wpgVYXr5XWpv6ntqmCnzkBpgBRF5QBJ6bV8NtgmhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDufSItCNG7A3CiZFxT/jdfloIpkdMH349U4I0KkJIhAzbBwOSxnR/iuZNHUkDUk8FjzkVyKPdZtQ5PQBWaq0wl90JO9H7rOtjGImAZrDtq7rCFHdI3uaA9Dmv0Sn0TEMlP3bAp91mJMOlgYw2hjXT7pme2E+nfUfQMqfRlhlcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PERhIam/; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PERhIam/"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 67EBE27631;
	Fri,  5 Jun 2026 12:31:45 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id igWLsBAmTQbC; Fri,  5 Jun 2026 12:31:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780655504; bh=c7wpgVYXr5XWpv6ntqmCnzkBpgBRF5QBJ6bV8NtgmhU=;
	h=From:To:Cc:Subject:Date;
	b=PERhIam/DAjT5XiMVZYEKNyO9qyYw/OTa8spJOWU68uaAxOxc1C8d3MYOj5RNoz9y
	 pOFDxZcEL+mGBjmJiPmviWits3ZOTP9hlCAeFkrVOreJ4IZB3qdw+cju2fTcQKDI7R
	 CloZD2Sl7nTAXR3eZLP6cQm/eSrD1HhWE1ilUv0+SSJaYT84G5ADOK5PHcyea/cZUA
	 E2L9Y+jKcqPWZrRA3GeCQbRaESO3qmDHAEu12AH1i/b9NMKWGq+whVQISKjSOvCHk3
	 LP2VlVthHg9Ki+rdkBNfh1A3HQazD0o5PjN5e3RHBeQ8+KzEST31/mVVi+Y2uZ70nl
	 wKH6z6Ah5E+Tg==
From: Marco Scardovi <scardracs@disroot.org>
To: Mario Limonciello <mario.limonciello@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	perry.yuan@amd.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	stuartmeckle@gmail.com,
	viresh.kumar@linaro.org,
	wyes.karny@amd.com
Subject: [PATCH v3 0/1] cpufreq/amd-pstate: Fix EPP initialization for shared memory systems
Date: Fri,  5 Jun 2026 12:26:25 +0200
Message-ID: <20260605103131.88711-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Prateek, Mario,

Following discussion, I have dropped the previous second patch (EPP capability
checks) since EPP is supported on all Zen CPUs that support CPPC. The
frequency capping on Zen 2 systems was purely caused by a false cache hit
during driver initialization.

Thus, we consolidate the series to a single patch that fixes the false EPP
cache hit at boot and explicitly toggles AUTO_SEL_ENABLE on shared memory
systems.

If you have a znver2 or 1 under hand please test them as I don't own them.

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

 drivers/cpufreq/amd-pstate.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
2.54.0

