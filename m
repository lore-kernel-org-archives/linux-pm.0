Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC4337F300;
	Fri, 21 Aug 2026 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299065; cv=none; b=ECIvRNBlunnlgFXduIh9C9E0jGqEJJEENHNuA5n5j6PQJtbBPGoe9bUlTyPr2vfC5GpMELJOjjEwP1aQaBQKMmGMVUvXRD8E4ronyr8rV8epz/DcqVSeCjUqB6FUVZPK1ied6nedHa3sUCPYDo8+x8t/+zSFL1STLk0mSlLLBZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299065; c=relaxed/simple;
	bh=RWCOIty24a4otBeBhf6s61m4xgOyJsdxf9/TP/GKwuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YA+9jnPdiWHipmJso/f7l8vEyOqca5e6BMZyBLa57TjhpOzBxNXSdA8ndMEPjMymGCBmDuEgdLrMj9JC9iQuypYYlNh+4MjJkrtRSqphJkJkmut3YheqEEcwP4bq+Jm1aJGAn4C/qRIjkotu2EBCbGph8nN5f3vOki4/hlXUSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f7dc77d49d3511f19a56ed5b684f684d-20260821
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a2422e41-86e0-41f2-9d97-1e5602fbe2d0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:bde5205a522d2a8e048691a6a377c7f3,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:n
	il,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f7dc77d49d3511f19a56ed5b684f684d-20260821
X-User: gonglinkai@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <gonglinkai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1879735826; Fri, 21 Aug 2026 15:57:34 +0800
From: Linkai Gong <gonglinkai@kylinos.cn>
To: Ulf Hansson <ulfh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Anup Patel <anup@brainfault.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gonglinkai@kylinos.cn
Subject: [PATCH] cpuidle: dt_idle_genpd: kfree() the original name allocation
Date: Fri, 21 Aug 2026 15:57:28 +0800
Message-Id: <20260821075728.273004-1-gonglinkai@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dt_idle_pd_alloc() kasprintf()s the full node path, then points
pd->name at kbasename() of that string. dt_idle_pd_free() kfree()s
pd->name, which is no longer the start of the allocation.

Copy the basename instead.

Fixes: 9d976d6721df ("cpuidle: Factor-out power domain related code from PSCI domain driver")
Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
---
 drivers/cpuidle/dt_idle_genpd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_genpd.c b/drivers/cpuidle/dt_idle_genpd.c
index d292975cc468..ed41a90eeeb7 100644
--- a/drivers/cpuidle/dt_idle_genpd.c
+++ b/drivers/cpuidle/dt_idle_genpd.c
@@ -99,7 +99,7 @@ struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
 	if (!pd)
 		goto out;
 
-	pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
+	pd->name = kstrdup(kbasename(of_node_full_name(np)), GFP_KERNEL);
 	if (!pd->name)
 		goto free_pd;
 
@@ -112,7 +112,6 @@ struct generic_pm_domain *dt_idle_pd_alloc(struct device_node *np,
 		goto free_name;
 
 	pd->free_states = pd_free_states;
-	pd->name = kbasename(pd->name);
 	pd->states = states;
 	pd->state_count = state_count;
 
-- 
2.25.1

