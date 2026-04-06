Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAC38A720;
	Mon,  6 Apr 2026 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492225; cv=none; b=hMpkQ6QSzZx/HULbYey9LLocxBM2mCJRculCmHZt9awXX66ssz1CHMFNBc75cqjsQ6uf3U3Te/KjF7uyNl1P+Jhd7w/3XMzwANNrUu9lAV0k3wxuKGKR0FAvOdKblRMQLWcH1vAXwyPcqO5FiKUyysBbhopqHVyZy2WDRBUlrl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492225; c=relaxed/simple;
	bh=oWpdjxHx5e5y+8c4jVqstzKl3mkteNQdDKC2FWJ9tpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qvMmY3pDNzAl8dh+UNyMBp5v/sAFskserSLvtqs1MchZjjD5LMRGc9avxIf9iC5gNAw+0HSSiJFvHRY/0WK9a11yNoSD1hIqH6EhQgz+U93OesP++yibrL9JWwWqyFeF6Cw37mV30fD20Ve0uOETGM8veqK47+Ai5+8rGXPtM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLv0Pr4h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLv0Pr4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A863BC4CEF7;
	Mon,  6 Apr 2026 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775492225;
	bh=oWpdjxHx5e5y+8c4jVqstzKl3mkteNQdDKC2FWJ9tpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLv0Pr4h4qAeXyLtQmw3h+nRtNrMn0/rGeUg5wDwB8ttHHQPssKAtYMxU9sW+DNrc
	 des/HHOMOpHebPhWlW6gwZxamOvs98ljTi+nKuj5R8+ETq0jfyaXo/1bAJAG1DJoOd
	 8rS3/C1OCFugIMYwdt05l2FeUWyiHnuiwqvMSOSn9HYAJXKmCb04fR26DeY+mDbBP/
	 XGBXAiZmlUm0NkV6V+snDaECmvCWO5v3cTDitK5sxE0ATSntr29AVyPpie0SIWIKeR
	 DBGWoWYROd/1UulB1JgFJV8QEWmqSgYnlvD9IqZTGizvV9NvemO79XCreIsHMuul/v
	 S8NyzKqlE4wLQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v3 4/6] thermal: core: Change thermal_wq to be unbound and not
 freezable
Date: Mon, 06 Apr 2026 18:11:08 +0200
Message-ID: <10858491.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5119690.31r3eYUQgx@rafael.j.wysocki>
References: <5119690.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The thermal workqueue doesn't need to be freezable or per-CPU, so drop
WQ_FREEZABLE and WQ_PERCPU from the flags when allocating it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v3: No changes

---
 drivers/thermal/thermal_core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1919,8 +1919,7 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
-	thermal_wq = alloc_workqueue("thermal_events",
-				      WQ_FREEZABLE | WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
+	thermal_wq = alloc_workqueue("thermal_events", WQ_POWER_EFFICIENT, 0);
 	if (!thermal_wq) {
 		result = -ENOMEM;
 		goto unregister_netlink;



