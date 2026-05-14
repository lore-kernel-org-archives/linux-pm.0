Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF5CA5A
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765355; cv=none; b=LVBNTO3paPLBITL2MPZrh01AX1ZZRhQno1dny5G2XcMGCokglfRrejBv0iSDo2VBrf5N3tVeG8zTy9eUCMmTjT/gclEuCCNy8Q332nKPo+2j6JCyzFDSDZKQg7CaF39l4bHz8/K+dcSo79kF5oqaC9KcP11arrrcVtTBIYiAqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765355; c=relaxed/simple;
	bh=BbcfHwBHVv6WXsVeyFwtzErk2WsFg1SfD9AjoNqoV0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PTALVp1eCJAFT1hLOPI1kD3PrrnMJtFy1d8FCM2FW3e31IK8ur8rMB/eC2LpGsP1GeBDC0pf9hPkrwcIKtAMh+b+bUwf6ObVo0uJEkTEl75xiHKLJsoT+sTmwtaN8d36hehRUWF8/f5CiaGdNVCQlNhQ1VdVd1MfkGe/pk7kY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DcYD7K96; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DcYD7K96"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so5771101f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778765351; x=1779370151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MtBK/h89H6dfJ3EcXAN8IHTwccnlBxh7pW1GbdLixAU=;
        b=DcYD7K96qFUAP5KBa9XZ2DZX9I//7yQsujGMj+CA8vQZoyW5JUX8QdO4TKfgwKHfkv
         RBT9g6mJ2dCyxoPmpCM2K8ISWEf+6JpaCj5dm/LqTm+G/IH5aqMettRXCExMNN0oWNpe
         DFDjI3LcY/e7jmf25lCIZ4PoFqnQmYMDpArlh1h4snhac899hXaA8uiOjsxk/paL2iNS
         PjyDjWQ7D/PkorE0frduWC94hzUB2o1WOlXvPIoD1lc1wavNgD6drCRzU67+En1pJmTi
         UHylpBy2+XxPtByke6Of4uM7f3ZAx0OBFMgxg01+XYchvTESflOyVgtqSlw4zTA6rYQw
         Iwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778765351; x=1779370151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtBK/h89H6dfJ3EcXAN8IHTwccnlBxh7pW1GbdLixAU=;
        b=SWJhdIaffjstrU/zLWmIEljcF2qt5dnu0/G1YYIty/D6PtTOQRVeVbEiNHnERJQu3o
         xhWjz+cXRunlIhDMc4mN6CMQ4ErphTnrtsZFWkFQRRYB4OEawWuefSTCLDhyWKdHtLK+
         2h0R+OUg+5L5oKQZ1yx/QaJxF9D3zYondIQyt9Sd3keRtoWoIQaD9gupNJkl0jbjU0sA
         XIDSy+6YAVM/nnicJjZK0AxImZT3oJUD0SI0ITEx/+40ssd7J9sI2OtlsAugJx1o+hOJ
         TGN/mHqQcu9hIMfYXQe6ghqmNw2r1XWnjt4TOW2Oe3i2nduWjrHbi28/k0Zho++SjmLL
         C4SQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ER0EY/bSm6uzUTL5CG0g0hQLIPaDLNQtsklQG0ujUJ+UdSOqfLo79tkfn48ezdHr5TqrGOIxstw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXP/LlQouUPhlEDpTZun+4L50gixOHDk0eHRvotRMu3kOWyaAO
	LNq1I4h1h+jPk/4Pj3BDuv0ZlLXomOHm93bTVbEi7JPh4Uy2hCMQlpcXxtPedAWqP+o=
X-Gm-Gg: Acq92OHA9Um+Qe0CN/nut8tFT4PeR8C6LA+W03eytEDfwELZV85jPQplflz0g9WVsWw
	WVmDP+oBpbXXICL0NWL8055VYYm2cFoRs57vls4u9x4DgNT5EYx7g4C5vXv5NRvLHS78EFQ2PnZ
	h49oFItxHie/LNN6Vcn+HdvbzCLqIVgek8JLrOJycUeZw/UkoZe/8dZ9iBocUHZj+jfCwVIzFt5
	zv8lR8PoYVZyaKvnsDo1FW6AUzoZMpM2VdU+zvabgN364SphXaeXJgIoLWjp0g5sfNpy33S0XKm
	cGDIFVopmUTrjcz2FJCg/QktSNTl5y7+UNZtYlk8L8el1QZgEZwY2JFYThcyezxn0O4x7DaePRR
	Y4ibT5sH498i5TPqUQtc0FjE1fp159ZJhryG92sqTQ+oARewM/DtTwMzZLn3h65ZjSaJp/C2Psa
	/aTdsKkOrdJ5/FuPkw8MNI1VjTu3jlkgaoBkfwdbhejkHkMss=
X-Received: by 2002:a05:6000:4381:b0:43d:7874:5d3b with SMTP id ffacd0b85a97d-45d90a8eec8mr6634989f8f.9.1778765350776;
        Thu, 14 May 2026 06:29:10 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a666fsm6280725f8f.36.2026.05.14.06.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:29:10 -0700 (PDT)
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
Subject: [PATCH] thermal: core: Add WQ_PERCPU to alloc_workqueue users
Date: Thu, 14 May 2026 15:29:01 +0200
Message-ID: <20260514132901.275477-1-marco.crivellari@suse.com>
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

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/thermal/thermal_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2f4e2dc46b8f..691c5e749c3e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1889,7 +1889,8 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
-	thermal_wq = alloc_workqueue("thermal_events", WQ_POWER_EFFICIENT, 0);
+	thermal_wq = alloc_workqueue("thermal_events",
+				     WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
 	if (!thermal_wq) {
 		result = -ENOMEM;
 		goto unregister_netlink;
-- 
2.54.0

