Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5312D3ED1
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768731; cv=none; b=D+l6la9wmt+jbGSJQwLJ9jg9p75ulRuHP0P3S4etoA+UCrLRMUbglBBfjKgt1ddY8gzH0BPc+tRCguqxTYqR75J0yxZZZ62rhGLFYl0wJ57a9Jd4mYiTqSRJQM5N4xEwcRWK1P4mG2bNvky93aZpUV6BthUMc/Y72oFm0U0aHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768731; c=relaxed/simple;
	bh=2qiZ3D8/x30FAqHO4UFNETv/Yp7psnFt9mDHoq5Zo5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GnHKtggp0VP72OG6dRQ5O8QW4IAsGLnILx+y5ebhjT0EnbPvFkQzVlzZRuWk6BNXHeHTPtjrtxFKIger4D31pSYIruwYaJbVn5zY+pI9aEF6adXXo1qe629YmeTmi0aiRGivCe0B82dj2lSDSlrlal+7IIXoE3KdUPddcUFHa5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cFKgtoup; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cFKgtoup"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso67080335e9.2
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778768729; x=1779373529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0rdjMEa8HXb1DckTrt1qXkiZJtpPbgucbfsGntj68F4=;
        b=cFKgtoup213xzS2TQzDXhlcgIJa6+ke/7dwS8NYIFOdkUh7d/bhfrFtYhW7S8zMIpY
         3EsJgFD3kn+bQg/LQJRR7w4TwV12Tl8w8UtH4hAEafRs4xj+gHe/HenbTBPKqrHDb9WE
         +ROpRRSPVh63EA6H02e9XghYsaH3qwLEl/p7jTrvZ9RhEnItv2MbFLmkGY53rZOSf8zt
         1RGME5y71884xNIIG99VDf1OYOcAdD6SyX6s23UgzqpEhl/VwbYAv4TF7JLHeSMWoSJN
         17j6OuDGztGkkCNRgbkdlrn5cFmqiX9VV4MafOMgIvF0jShUlFg4PvSLi/ejFdBFrimY
         4Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778768729; x=1779373529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rdjMEa8HXb1DckTrt1qXkiZJtpPbgucbfsGntj68F4=;
        b=PnLXoQ1UAv/KOd8sdOWNdShJ5vB8eglMjc7ZYTPMdrvyyQ1XN8/PVrDlxA0GviqFKs
         T3MX3xpIBnM+0kIg1MY5fOUfWTVbRkEc/GH8frHczMdQyTS2Cv8BsGH3gl6TMjW4Pf9l
         x3j+FHlBP88v3HSVD9HNlxPbEhueKbmFB1Q21wsTk8tj1I641eYTdzln32WRLbC/jOeL
         g+WXvnD8WyVSx0awPqI6kAEjKxzIw9EwPTpFZVzyGg8pbXO5GLLiEEWraWM4KecUPu+p
         nebQWZvDTedqzZwtxnKo4qmp+I7tUC7PqeJLjr4/ZVHu5T+d6Xsl73NwgRqXVL9F7L/5
         q3yw==
X-Forwarded-Encrypted: i=1; AFNElJ8y2CM1Xz8LK+Bmc3VToNM1QDCOnK8GLlKqtEYEMKNASYCq8cYWk7hOMoB1MZkforbk+nqn3tnh/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YydevLf47XBwm6+PFSIq4BBJsPDBo/PUWgwRKviLrRx0aPmb7RZ
	CjGyWsReRgIPkM2HCbtWXgex/n1aK6NxzQojEhS5YOAdpMQ43+77jVh6q7HMVTbSFus=
X-Gm-Gg: Acq92OG5ly/JVv3vrdu8X3RMpHH+hbzo8TO5B1duJH+Bk6pzqaS2xAKILDFBLcrn5fj
	M0BeSKmY0D0XuSOP373PEEmzo4PIubFkaxjEGK12JJZyqpfnrssdFBKMwf+fUprhY9kjfHO8S0Z
	azj5oDsYMCx6x69m/y5QmMbPzMYOGc7vUymoKxSwj7WBEajsw1Anyc4iPBGTYtMDCWi/MQTQi24
	odOcaidxokLgCkHoYUJbVsE0s9wtWDACJwN4ADs2K24aeNJubrJrJqxIPmwO94p1fOHq0K01EMo
	cmQpff3jezio6mnzZGVryDrFGNSiUJBIMgg8kYtfiX9GXdQ1FhRAEAEoui5AvIgvlLvl/Qhigq9
	a5JYtVWDRWeCmIu99ZiQtABfJZ+twE0RcaCLuHLILb6UyWtCDAL4PsWvnlFZnwC7305FEWVJemB
	5hzbMfev5QUa9WrMGwM0IzOHwdtdFCxym5cW1tGSz9qtxdKzX6P5oqkyV58A==
X-Received: by 2002:a05:600c:4206:b0:48f:d1b8:9aa0 with SMTP id 5b1f17b1804b1-48fd1b89f71mr60671575e9.7.1778768728597;
        Thu, 14 May 2026 07:25:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd62e0da2sm21235005e9.7.2026.05.14.07.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:25:27 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2] thermal: core: Add WQ_UNBOUND to alloc_workqueue users
Date: Thu, 14 May 2026 16:25:11 +0200
Message-ID: <20260514142511.325446-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

This workqueue has no benefits being per-CPU, so make it unbound using
explicitly WQ_UNBOUND.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
Changes in v2:
- "thermal_events" workqueue has more benefits being unbound, so instead
  of WQ_PERCPU, use WQ_UNBOUND.

Link to v1: https://lore.kernel.org/all/20260514132901.275477-1-marco.crivellari@suse.com/

 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2f4e2dc46b8f..1ac4262dafbc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1889,7 +1889,8 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
-	thermal_wq = alloc_workqueue("thermal_events", WQ_POWER_EFFICIENT, 0);
+	thermal_wq = alloc_workqueue("thermal_events",
+				     WQ_POWER_EFFICIENT | WQ_UNBOUND, 0);
 	if (!thermal_wq) {
 		result = -ENOMEM;
 		goto unregister_netlink;
-- 
2.54.0

