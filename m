Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381F3D6472;
	Mon,  7 Sep 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791529; cv=none; b=tteYFW31pQsh/RrtGMIB6e9yJmJQ51Wax9ADhJBWfWq92qtD+D3ahINknounWohxGELKDK0Wj/wEpOLdLL7EgZC2UMFoySD4pl4d/mRhCZ8x1ULCLjFet14HzjOiGjrh9BriXZ7RJLEtMV7dtMxUx3AsP9mrWn6SSTLjJZj9Y6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791529; c=relaxed/simple;
	bh=th29Cl4EYmv+R1Ps6iEbTtpNHUVM0tUQoLbxVVRf2GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAvKX6wuhSYGN0ZqJs6EWE27LaV6TE3UGOgIL+ZWZ7v1YZzMNmc9JYiWifXBZ3Q3G2PSa/SYoScwHxqWDUmAEGci2YIQtSdjb4lEsNIbdv82vWUeAF3DBmhPstcH459E7o+8WoMPQbN/zibHoyobZGHKLaveEsfsYgkizxuTXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4120E1F00A3A;
	Mon,  7 Sep 2026 14:32:06 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pmdomain: renesas: r8a78000: Fix lockdep false positive
Date: Mon,  7 Sep 2026 16:32:01 +0200
Message-ID: <86da16a61c58eb08419f7528237c124e519f0a72.1788791506.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdep reports a possible circular locking dependency when attaching
devices to an MDLC PM domain:

  - During creation of the singleton PM domain:
      A. r8a78000_genpd_always_on_singleton() takes r8a78000_mdlc_lock,
      B. pm_genpd_init() takes gpd_list_lock.

  - During attachment of devices to PM domains:
      A. pm_genpd_add_device() takes gpd_list_lock,
      B. r8a78000_mdlc_attach_dev() takes r8a78000_mdlc_lock.

As the former is done only once, before any devices are attached, such a
AB-BA deadlock cannot really happen.  Fix this false positive by
introducing a separate lock to protect the creation of the singleton
domain.

Fixes: 89e6a71b35703f10 ("pmdomain: renesas: Add R-Car X5H MDLC driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 2668fc2ac9cbd388..1fd71bb3da776eb1 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -45,8 +45,9 @@ struct r8a78000_mdlc_priv {
 };
 
 static struct generic_pm_domain *r8a78000_genpd_always_on;
+
 static HLIST_HEAD(r8a78000_mdlc_list);
-static DEFINE_MUTEX(r8a78000_mdlc_lock);	/* protects the two above */
+static DEFINE_MUTEX(r8a78000_mdlc_lock);	/* protects the list above */
 
 static struct generic_pm_domain *r8a78000_genpd_xlate(
 			const struct of_phandle_args *spec, void *data)
@@ -191,10 +192,11 @@ static void r8a78000_genpd_del_provider(void *data)
 
 static int r8a78000_genpd_always_on_singleton(struct device *dev)
 {
+	static DEFINE_MUTEX(singleton_lock);
 	struct generic_pm_domain *genpd;
 	int ret;
 
-	guard(mutex)(&r8a78000_mdlc_lock);
+	guard(mutex)(&singleton_lock);
 
 	if (r8a78000_genpd_always_on)
 		return 0;
-- 
2.43.0

