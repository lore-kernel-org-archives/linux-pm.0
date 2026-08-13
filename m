Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826236728F;
	Thu, 13 Aug 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607030; cv=none; b=J8ww+LzFBHQVZAtO54UfoyklkRLpgZxeS4S0kssRRTfByuyx5UyeG72btsGnXc8YiE9wqgHQzXi9mLmOnfm/73w5t01H/N8WnGslq/mg1oSPLtS6jiNXoAAfggLtLooCRGsENWXMwF8hsvMZI8A8mpLTzwxaYQbhW3T1YUmJdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607030; c=relaxed/simple;
	bh=wYYOcp+X7mzUdzTfl3hBNAyGN3nOGQ9ySfFeueDy/Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glIk4HG5eTtbOb29zaqotX96JqayUoaopyJnkTS14P3c/hZzLWBQVdKG9AxRWC3K4UvcOJM9HzWowFrcricTaZpL7jw9Qh6lWi26dHFOOBav4OdnUOeyfuEooFtt/o4Z4oOYUf7yDCz9wcvtogkvu8Zw9eULsreZo3jcuDp1kw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=VWNWGmia; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="VWNWGmia"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786607025;
	bh=9LifHOjCDZK6bCJxMXB8vcP5n7P8CcG/fRfKFgpm28c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWNWGmiaGkf0IB9Llfdj1Ze/66BLUQ6kfeRvV2G+4SXss+y8ff+hXo1awd4t8tXms
	 XUWzNrnvjPzMDenUIhjttGD6R/KV5FUClfUtjfIzVVARoGqPpUxSmNePTpBqV1nKkh
	 pTAG2IOjy4yhFkMkyFFd3gaaAdmVhKkKYIseDIgo=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with UTF8SMTP id 4hLHRP3zzLz10wR;
	Thu, 13 Aug 2026 07:43:45 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hLHRN6PZrz10w2;
	Thu, 13 Aug 2026 07:43:44 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>,
	Daniel Leznan <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clocksource/drivers/timer-ti-dm: Unregister CPU PM notifier outside of the timer lock
Date: Thu, 13 Aug 2026 07:43:42 +0000
Message-ID: <20260813074343.26460-2-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813074343.26460-1-include@grrlz.net>
References: <20260813074343.26460-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omap_dm_timer_remove() calls cpu_pm_unregister_notifier() with
dm_timer_lock held and interrupts disabled. Nothing sleeps in there
today, but it pins the helper into a context where it can never be
allowed to sleep, which is in the way of restoring the RCU grace
period on the cpu_pm notifier chain.

Do the list lookup under the lock and move the unregister after the
unlock. Nothing can race it at that point: remove() owns the device,
and once the timer is off the list nobody can reach it anymore.

Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 drivers/clocksource/timer-ti-dm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index bd06afb7d522..032e102bdd0a 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1530,7 +1530,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
  */
 static void omap_dm_timer_remove(struct platform_device *pdev)
 {
-	struct dmtimer *timer;
+	struct dmtimer *timer, *found = NULL;
 	unsigned long flags;
 	int ret = -EINVAL;
 
@@ -1538,14 +1538,17 @@ static void omap_dm_timer_remove(struct platform_device *pdev)
 	list_for_each_entry(timer, &omap_timer_list, node)
 		if (!strcmp(dev_name(&timer->pdev->dev),
 			    dev_name(&pdev->dev))) {
-			if (!(timer->capability & OMAP_TIMER_ALWON))
-				cpu_pm_unregister_notifier(&timer->nb);
 			list_del(&timer->node);
+			found = timer;
 			ret = 0;
 			break;
 		}
 	spin_unlock_irqrestore(&dm_timer_lock, flags);
 
+	/* Unregister outside the lock: cpu_pm_unregister_notifier() may sleep. */
+	if (found && !(found->capability & OMAP_TIMER_ALWON))
+		cpu_pm_unregister_notifier(&found->nb);
+
 	pm_runtime_disable(&pdev->dev);
 
 	if (ret)
-- 
2.47.3

