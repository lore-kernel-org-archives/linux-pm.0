Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E9252CCF6;
	Thu,  1 Oct 2026 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886186; cv=none; b=PhFIy1YcjBs0slQR5VX/rJe1CzdarJcHbr+ttvt86Upqfx5RPvAIoY9YXmhG1oazealZTlpxVC29f9hExZmAt4ek7r5oxBHkGJGHt17RiHQ/CtXfY3QwdsOYRbzTPElTVCz8tE6oNzbPf0fSy8/DOsU/4OIgZBk2EYPV4DQsPhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886186; c=relaxed/simple;
	bh=hr/2b7myJXr012oTzrImDdTw/Mb8Bg3gfPuyPMaow00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE+gl5eK5A6RtawXdQqT+T+T1Uhn5t/UQYCXAeWk+wceTMTOrCvoe3Tq1totdErZ17faBdOs8g9Pp9OcFIJs/MghniS1rxkTRJF0j4c9Kc8ahn2ZU4eAjEghTKXt2lWgYZY3j9GVLj6GMgDmwsRyfvegWC41a/DE09WtOJV8lrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg9t9q/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg9t9q/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8C41F00893;
	Thu,  1 Oct 2026 20:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790886180;
	bh=jqZ50XSjTWUK89UaZiWAw+nT5M4EKEPI0sEx5clcGrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hg9t9q/EHm5If0ZiHEDUbjzpdneFAA8AHVGTpC+YTD4Dk5cUFIcqHnMLPQFBoSufi
	 3ZsRtw80HZZpdbCWTqhtBP2NqFIl4Nk+nx8Lfvh4xnxLTYNHxvcKnTjYHLq29wwBC+
	 IG3ZcjIjDAmQrtqmn4zihQ9dpZ0LEfRgFxgeHEAxm72IyigMEe0H+Mc1O9AGs1jwEe
	 bem1V4O0Jf1IWLPGhLA5bSYG2hL8rv6TRLeG3hrljMl1Jf2b4hxaebf2XU77zUascI
	 8b6nsjPD+BteKiGfKp2xhE+gZ+20fGvFni1heeBrVMsKznvyw8umzK2fIbqEv5fkfu
	 V4gykvwJPGHhA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v2 2/3] cpufreq: amd-pstate: Propagate cppc_set_auto_sel() errors on mode change
Date: Thu,  1 Oct 2026 15:22:53 -0500
Message-ID: <20261001202254.1679976-2-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001202254.1679976-1-superm1@kernel.org>
References: <20261001202254.1679976-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

amd_pstate_change_mode_without_dvr_change() iterates over the online CPUs
and calls cppc_set_auto_sel() to enable or disable hardware autonomous
selection, but discards its return value and unconditionally returns 0.

If the firmware rejects the request, the failure is hidden: the cpufreq
core records the mode transition as successful while the hardware stays in
its previous autonomous-selection state.  The software mode and the actual
hardware behaviour then disagree, breaking the expected frequency scaling.

Check the return value of cppc_set_auto_sel() and propagate the first
error to the caller so the sysfs write reports the failure.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-d114a94a-655b-43a6-91b1-9484889726c9
Fixes: 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control support via sysfs")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20260921190235.3651688-2-mario.limonciello@amd.com
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a1d58d1f5f3aa..d8e2eec6e7250 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1822,6 +1822,7 @@ static int amd_pstate_unregister_driver(int dummy)
 static int amd_pstate_change_mode_without_dvr_change(int mode)
 {
 	int cpu = 0;
+	int ret;
 
 	cppc_state = mode;
 
@@ -1829,7 +1830,9 @@ static int amd_pstate_change_mode_without_dvr_change(int mode)
 		return 0;
 
 	for_each_online_cpu(cpu) {
-		cppc_set_auto_sel(cpu, (cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
+		ret = cppc_set_auto_sel(cpu, (cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.53.0

