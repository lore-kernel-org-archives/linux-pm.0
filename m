Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891732AAB3;
	Sat, 30 May 2026 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780155686; cv=none; b=nWzIsPoFLs3tfkdGfYrYn/5VO8VsGJCnEt4n5Fm59kg77UGQLyuMTUzJDFaIF89GdLMrK7L6lSdF07I7GJPZy/WrLujF3U8VXHZecniX7fzO8oJxZR3WUqgOokVIyShE3bd2yQ1WZp1eYvujHqab37JnUB6QXBLMt3WQTAR1wYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780155686; c=relaxed/simple;
	bh=CFBMXeJ+eqc8Y9m0iCF05uRh92N1m9XYM+b86d/csrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E655DrYrxrErTzknH3FMkOT3zzzzTEkGqThnb2dFlKowZNOfWPW02szBN3/FQN7lE691zeb2mSD4qxNMBFRIXPHOB5LGon3hQWSWj8JqtPtq6nTmzXyWRL/OiWwcrlIEB7IINp8zRdufiiptiVBATjtO/zQqKLKW598XtRwuu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYkWuGEY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYkWuGEY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC2C1F0089B;
	Sat, 30 May 2026 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780155685;
	bh=SeBGooNNKknCeZPxL/0T/srgpxh0fHVQiNrzdYDCXV4=;
	h=From:To:Cc:Subject:Date;
	b=dYkWuGEYGYEvFBDOF7WjGYiB4UtD4Ji6Sz6N/f4I0eUpP/vAAa53kD6PN7bMv0+kt
	 +Nua4/DR/TVLfLpcbvJx0sUwBnZBaMDlu66+nzpDqYIYgdQ/7/36/YefBHHPfmIj/M
	 BliCeLDMK4FghD1sN8tFxvTNdl0UK0+xrKGaLdr2Mkgie9hq+SJX/lEb7E5BEYDm8D
	 c6bvYsQdfNBE/MiVOHflE1w14DkH34Xlej4Lu8ZU4iB5u+tCZ6+J9t1Ke1JZwVLMBZ
	 JCVa6bqPNWjovqdYEo5KQ08J/tol3AcLXGZd/2sPxq5a7q6lnIE3EV4XTpehD0Wzgl
	 Tsdu/qYhIBnvg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Stuart Meckle <stuartmeckle@gmail.com>
Subject: [PATCH] cpufreq/amd-pstate: Fix setting EPP in performance mode
Date: Sat, 30 May 2026 10:41:21 -0500
Message-ID: <20260530154121.1670781-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EPP 0 is the only supported value in the performance policy.
commit 798c47593cca ("cpufreq/amd-pstate: Add support for platform profile
class") changed this while adding platform profile support to the
dynamic EPP feature, but this actually wasn't necessary since platform
profile writes disable manual EPP writes.

Restore allowing writing EPP of 0 when in performance mode.

Reported-by: Stuart Meckle <stuartmeckle@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221473
Closes: https://gitlab.freedesktop.org/upower/power-profiles-daemon/-/work_items/190
Fixes: 798c47593cca ("cpufreq/amd-pstate: Add support for platform profile class")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 62b5d995281d..72df461e7b39 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1428,7 +1428,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 			epp = cpudata->epp_default_dc;
 	}
 
-	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		pr_debug("EPP cannot be set under performance policy\n");
 		return -EBUSY;
 	}
-- 
2.54.0

