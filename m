Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F8534473;
	Thu,  1 Oct 2026 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886186; cv=none; b=fD2Nzh7wXkXmOuPtCMaRvJaT5mUOvzdrVhyJ2wSrz8xdFk17WofO4vvfDOXTwEXXq+VpYkhOak7crMCBtuBwarWufa5kSdMzCjPNLVMyVwui5MM2W0NUqZZfGrkJSru3o8tbqGQZqUh0JPjqP6CGrjBvX5pEWk38VMISgH9TKPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886186; c=relaxed/simple;
	bh=QwpCCepGhj9lgRWd0EkYNhJZKP0rOe4Mfz1MYctjnDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oz69Zw/gtleWIhz9EeKTRDAL+iVe5JcJA6tnVOLOV7YcZgwKFePRXnoxXEnzu0ibAXPpkFXnStqC/i2cghUlw3tOIpl9Afw3g+BIzFEdITi3zvSlAZZRxWYr/XpDRR42JEugs6zUqJxVh8ACtmfqzk6x/dVfCrcjvFgVfwinskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMwmUxuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMwmUxuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD491F000FF;
	Thu,  1 Oct 2026 20:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790886179;
	bh=wguAyofh+2kg9EHi04fUcFmtJNnKWrwa9V7NNaUAkzE=;
	h=From:To:Cc:Subject:Date;
	b=GMwmUxuucPMJh0mHQZYU2Wj7gm6mHYoXdYus2G57eImhVzImQmNjPdIY4h+JT2xf8
	 XukOyt0YdlMcYTf+1im8gRZoXOjDT+ttqGbOfzPsriQtxX3hqUfT+smcXtleSnwi1k
	 nEuYQ0LRFNwh4lXTTC0bE+egrFIdVeGtsK4eQU2z/8N3yPXoOzG2cnBz8b3gFO/Cid
	 2M67CDylknLYx/VSODMcdXekFzr1HRQEwa2DuS5NEJ/pNuA9r/jjx/t7/N1VxuhS5c
	 xEbflaz2ovSJG93UJpdf/aV91tA8BJ0ZnleAt9OWIMOHleJJClmyHm1w/biDZDtl6E
	 6WOXNnvHhOgkg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v2 1/3] cpufreq: amd-pstate: Restore previous mode when changing driver mode fails
Date: Thu,  1 Oct 2026 15:22:52 -0500
Message-ID: <20261001202254.1679976-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

amd_pstate_change_driver_mode() unregisters the currently active driver
before registering the requested mode.  If amd_pstate_register_driver()
fails for the new mode, the function returns the error without restoring
anything, leaving the system with no cpufreq scaling driver at all until
a valid mode is manually re-selected.

Remember the mode that was active before the transition and, if
registering the requested mode fails, register the previous mode again so
the system keeps a working scaling driver.  The original error is still
returned to the caller so the sysfs write reports the failure.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-5b138ddb-c88b-4f82-8a2d-f39446b625d4
Fixes: 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control support via sysfs")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20260921190235.3651688-1-mario.limonciello@amd.com
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 743d90ed6af46..a1d58d1f5f3aa 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1837,6 +1837,7 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 
 static int amd_pstate_change_driver_mode(int mode)
 {
+	int old_mode = cppc_state;
 	int ret;
 
 	lockdep_assert_held(&amd_pstate_driver_lock);
@@ -1846,10 +1847,16 @@ static int amd_pstate_change_driver_mode(int mode)
 		return ret;
 
 	ret = amd_pstate_register_driver(mode);
-	if (ret)
-		return ret;
+	if (ret) {
+		pr_err("Failed to register %s mode, restoring %s mode\n",
+		       amd_pstate_get_mode_string(mode),
+		       amd_pstate_get_mode_string(old_mode));
+		if (amd_pstate_register_driver(old_mode))
+			pr_err("Failed to restore %s mode\n",
+			       amd_pstate_get_mode_string(old_mode));
+	}
 
-	return 0;
+	return ret;
 }
 
 static cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
-- 
2.53.0

