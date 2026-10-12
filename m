Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D374B44C7
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830117; cv=none; b=VsVdckiauIh1F5wi533OCqQIuZgpIOqrevLrG4Fi+is60V2RbLZZwsUvzPZlqsl9NHK88I35iDGc+uqVFAbwRB7A9APT8YEkGXVNPfzvTl2LQsZUfPdtcx2biAqAHRvaUqRXxzabrxL1pL2Q0vMFCYmcEXG1kGvMqkvGJIlUEXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830117; c=relaxed/simple;
	bh=sbT5xAMKOPwDPzDJtgEJtJbmRSBjij4k8p3X+Jf4YQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuVYyaOww6LxqPnG+nXGEAEuAsf16u8sHhgxvqDiZ13zxIWAS/XjKEHaI0mRpbhD6hL7oNTqtHgwlqFo8O7tVY6y/grUevFHWnSGsWVN1IgiaLPSw82f1ogCtOGK0duqWddbnoqatqkBqFvhNMBuVmlQ3NvDN6LHBpdoCwzbqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LetF/EVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LetF/EVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2859C1F008A2;
	Mon, 12 Oct 2026 18:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830116;
	bh=PSqRCW8K8+mO/R4fc52AytEF8+z3gnbsGe2piB0FLZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=LetF/EVMLyOBc6xNiXDopwEyc9pkoGBmPP/66PnfL2VlgXDOsQPOP+rTpvaIYJUNF
	 1Ok7aGK/a+DqwF7NYAdExRjEy1DXMgunMcrDOmizuP2WrJA2E4zp0dlDOxIqucgF9G
	 lCnpXIA3r2+dZmOYpCpDGMiAcDgC63gzC+tSjbPPgiRVrAxM2e0j8N6++JYlhptY1e
	 ekG+s0FuMLyWcx9RiP9N1Xce9cAXV7Tc54sRtphaQqe52hpzV0NL3kIX2DoeFkBXs+
	 siY1NwN4G9J2M6HdFk8RUddP+OecqPuqdQtLmPSqMowaS4Hms7Q7st444jrHsdbVjt
	 Js0k6VerfocGw==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
Subject: [PATCH 6/9] tools/power turbostat: Fix CWF PMT off-by-one
Date: Mon, 12 Oct 2026 14:32:31 -0400
Message-ID: <5e940dd96bef6ca03b3b1b4740351237e5ec17e3.1791829903.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
References: <c24362650f7a8573dc9a9991a034b8500af8eb19.1791829903.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Len Brown <len.brown@intel.com>

Fix off-by-one error causing last CPU on CWF
to never get a pmt counter allocated.

Fixes: 5ce1e9bbb2a1 ("tools/power turbostat: Add CPU%c1e BIC for CWF")
Assisted-by: GitHub Copilot (claude-sonnet-4.6)
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8e017b4dbc6c..795946bcfd94 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -10453,7 +10453,7 @@ void pmt_init(void)
 		mod_num = 0;	/* Relative module number for current PMT file. */
 
 		/* Open the counter for each CPU. */
-		for (cpu_num = 0; cpu_num < topo.max_cpu_num;) {
+		for (cpu_num = 0; cpu_num <= topo.max_cpu_num;) {
 
 			if (cpu_is_not_allowed(cpu_num))
 				goto next_loop_iter;
-- 
2.45.2

