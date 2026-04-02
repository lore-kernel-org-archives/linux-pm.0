Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1C3612DB;
	Thu,  2 Apr 2026 05:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106151; cv=none; b=g1un1UKyF953B14i1bYJ/i425QkiA8GydDb49oivJ7QXS5l6QCjYhQf8M1I5ZgoanXbhCnKmgb1KkP50i8U0xpVvE96O17x/HTAjh8p8HNsT9dJ27lWWfbB6W4ohuTEX8AhpenWr1q1mPz98QtQlDKqu2AoELW0QGGUAQXJ/XFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106151; c=relaxed/simple;
	bh=+98rvey7Q4UswdDRV0rpkuA6V3qBxOg1e95MTNkKJnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9AaKPoFazWF3vPjSBB977YtGO3oImCgzqP2E/V/L9MKBAdx+KRU67sN+ep2GqxwjbyPeqJz/Q3TzGRTAEtnOaj3BN6VsRhld3z30KPRxLQQNBwGpbEqZ28uZSv/6bJkP95mOPTBpaGJBJRb411OIUEdCRTMkdHjEUQJoB1k5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW3jInMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW3jInMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797B6C19423;
	Thu,  2 Apr 2026 05:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775106151;
	bh=+98rvey7Q4UswdDRV0rpkuA6V3qBxOg1e95MTNkKJnw=;
	h=From:To:Cc:Subject:Date:From;
	b=ZW3jInMSUHR0c2qLHi8aV67DPaKCymgBfaPRBIoUNXaA/uEiqr7M7xY6Q1uP0/p47
	 1jAn8RKnJMQTsQYDgkMthcNU3LykShXSGKyZHDcXs1QC9/Vbgw05Icsz5ndeQbw8Tf
	 ImVUdb6l2/bYORA5xvWDKbmUy6qiYjUAO9s66dVaKrzVFdSpwxPI7X+Jeqj7Oi5JQQ
	 +pbw7WPt1Ul/YddqZRxCPUl9nNwHHf7PmEK33zTcdO6+q6Wm3HrVtE/nM584qO/skc
	 czNIHpuuISvWm8Onec+BVbctkgj3N0pGm5L4uiTgbTQoSqsP5vYq9PGK5psFKrdGoR
	 sDMq2LzV8YLyQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v8 0/5] amd-pstate Dynamic EPP and raw EPP
Date: Thu,  2 Apr 2026 00:02:09 -0500
Message-ID: <20260402050214.1238624-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic EPP allows the kernel to register amd-pstate as part of
a platform profile. It will change EPP modes matching the user's
preference to the platform profile sysfs files as well as power
adapter state.

Raw EPP allows userspace to write integers to
energy_performance_preference.

This is based off superm1/linux-next.

Mario Limonciello (AMD) (5):
  cpufreq/amd-pstate: Add dynamic energy performance preference
  cpufreq/amd-pstate: add kernel command line to override dynamic epp
  cpufreq/amd-pstate: Add support for platform profile class
  cpufreq/amd-pstate: Add support for raw EPP writes
  cpufreq/amd-pstate-ut: Add a unit test for raw EPP

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/admin-guide/pm/amd-pstate.rst   |  41 ++-
 drivers/cpufreq/Kconfig.x86                   |  13 +
 drivers/cpufreq/amd-pstate-ut.c               | 109 +++++++
 drivers/cpufreq/amd-pstate.c                  | 281 ++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                  |  21 +-
 6 files changed, 449 insertions(+), 23 deletions(-)

-- 
2.43.0

