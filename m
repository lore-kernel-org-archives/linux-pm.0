Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CA319617
	for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774181143; cv=none; b=BjIkNoI90wppE2a1K+ol+RUhpQq91vbtDUE/313XlgLP8PZE6KiIDU360HCbJkrs+zKYc6vBquax2VTUrIakr2y2rxk79OL7h1+awUY7KKE+nQNi5xheEb8mw+C82kFyDdWCbvBQlRAruN+qWhAgkA0jcTzW5pstn7scUJ738jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774181143; c=relaxed/simple;
	bh=oshQ5qS4f+NZE6ebvXHFPclLDp2BdWi8rYO4kmK0ubo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5M34ssMpAf47IuR/PEb5CLSZaJQtvh+rkhCXDD8v1NokfxbsKzJtGAcPRzIRboGH7V7UQ+i9bCVRER0kkUvK2AasyfKJEORC2M/Jt/7xz7qcxK/odtHpwDWrW/lIpVfmVYjtCDweNmLvPaSjus87oNpc0YimuEP/3BaNh4/eXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 22 Mar 2026 21:05:30 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Youngjun Park <youngjun.park@lge.com>
Subject: [PATCH] PM: sleep: Drop spurious WARN_ON from pm_restore_gfp_mask()
Date: Sun, 22 Mar 2026 21:05:28 +0900
Message-Id: <20260322120528.750178-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask()
stacking") introduced refcount-based GFP mask management that warns
when pm_restore_gfp_mask() is called with saved_gfp_count == 0.

Some hibernation paths call pm_restore_gfp_mask() defensively where
the GFP mask may or may not be restricted depending on the execution
path. For example, the uswsusp interface invokes it in
SNAPSHOT_CREATE_IMAGE, SNAPSHOT_UNFREEZE, and snapshot_release().
Before the stacking change this was a silent no-op; it now triggers
a spurious WARNING.

Remove the WARN_ON() wrapper from the !saved_gfp_count check while
retaining the check itself, so that defensive calls remain harmless
without producing false warnings.

Fixes: 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask() stacking")
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
---
Split from the earlier pm_restore_gfp_mask_nowarn() series and
agreed upon with Rafael to take this simpler approach instead:
https://lore.kernel.org/linux-mm/CAJZ5v0gBHLz7T2qRJRjBfOWY6UXM6L6+Kw8UcsY4+OaB7+qQcg@mail.gmail.com/T/#m10ee3346cd8dcd052749105d9a8e2052dbf3bc80

 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 5f8c9e12eaec..5429e9f19b65 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -40,7 +40,7 @@ void pm_restore_gfp_mask(void)
 {
 	WARN_ON(!mutex_is_locked(&system_transition_mutex));
 
-	if (WARN_ON(!saved_gfp_count) || --saved_gfp_count)
+	if (!saved_gfp_count || --saved_gfp_count)
 		return;
 
 	gfp_allowed_mask = saved_gfp_mask;

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.34.1

