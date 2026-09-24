Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C5246AED1;
	Thu, 24 Sep 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265662; cv=none; b=ilh81zp5KjlvJoqvcxeknu/ek6JxsPyNGOS0BMw2DgcYVRiFZgshcioLUQrOGbNZDlYNr+nOAHtTSkjI5aBWB5UYhSWJhSPJrDpE3eCegXnLAtqQjyWHZ8Pmkh/W+DtJCuSy1WN2GDHBF5YqF1xhMQQLDUqSiKokAi0NP57x/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265662; c=relaxed/simple;
	bh=4qPzDh1F2Va15e9/M6Je9n9C3eTGe9bPm/R2Bvn0C78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1mwLvDjlqAWPZoi3TLTdeYzdzpWlpUt//u4qt/3XeuS66McxxyI9hRjoopzHP0Ibu/gYgAKhMzyJPcRzYa8hVHZmrj/8a9SuW3+jRRP+SeKATC1YiOrFmvkpDKCGveFVPL9z5F719gyoZKOwIdDVVVeQIt5Zdb13r8Q9UOIOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReTJ91yC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReTJ91yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB441F00893;
	Thu, 24 Sep 2026 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265661;
	bh=dMci1PF1yjz/GaalbGrWU9zgaGHlbXIv13aWUyGv7CI=;
	h=From:To:Cc:Subject:Date;
	b=ReTJ91yCvaPlKkfwm0cFZXqDi4a5rPuJBuG4Mk2ZtHtehaQLkyWQdnV30IfMpzLzp
	 eh1BE5eJOKMRv0PyP6cCF8cyeh+hrq0UFMiYPdSy2F51EN1YrlaIZnyfWHgwQ/xflC
	 80N+gmFKWhouFRhYvVc6dBMDjhJLipgI1K83OAERHqvfsQ7MHRr7FBtsG3ve4wm0If
	 wa1ZO0EIl9Nx3IWGj90GpnJoW5a5emICALQfWfDjsKzp+ybBpOkRf131p72kwQhVrG
	 1dt8/rhCqCl6+JhEzYD7kuWGZeB4J9OzG1MeFihEXnzZ1eWu9ohV5EyrxoWnWI20O9
	 cqVZO0/GoAeQQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: =?UTF-8?q?Rafael=20J=20=2E=20Wysocki=20=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	x86@kernel.org,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 0/3] Zen6 client CPPC
Date: Thu, 24 Sep 2026 11:00:49 -0500
Message-ID: <20260924160052.2858456-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <superm1@kernel.org>

Zen6 client platforms use CPPC differently than previous platforms
and knowing maximum frequency for a core type is needed for capacity
calculations.

Newer versions of the ACPI will introduce a proper interface
for getting this information, but for now hardcode values so that
these systems perform as intended and to unblock future scheduler
work while we continue to wait.

v3:
 * rebase on linux-pm/bleeding-edge to pick up
   "ACPI: CPPC: Fix register access and lifetime bugs"
v2:
 Link: https://lore.kernel.org/linux-pm/20260901215913.3042182-1-mario.limonciello@amd.com/

Mario Limonciello (3):
  ACPI: CPPC: Refactor boost ratio handling
  cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
  cpufreq/amd-pstate: Get Highest Freq for a CPU

 arch/x86/kernel/acpi/cppc.c    | 166 ++++++++++++++++++++++-----------
 drivers/cpufreq/acpi-cpufreq.c |  17 ++--
 drivers/cpufreq/amd-pstate.c   |  20 ++--
 include/acpi/cppc_acpi.h       |  14 ++-
 4 files changed, 143 insertions(+), 74 deletions(-)

-- 
2.53.0

