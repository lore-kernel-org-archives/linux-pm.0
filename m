Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86CD39D6E7;
	Thu, 14 May 2026 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751259; cv=none; b=U8H2SDYZ60QWpyxWaFhJ1hjeDTofOJ9a8ebBY5DmER8Kn8AifBdhzKJ7pTty7b+E8o9yepFwpi0FYyTxQKvxD9nJ7t+i1ueVCahqk3vWFZQ8lvKMLj/F9xgfP5Qo1sDm8KuIXpYh7BtrpwKT6SQhKVnFEIeGeuEVTks3qjU3Pbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751259; c=relaxed/simple;
	bh=fDawJLoVbJW9DQMIgEDksrxqneT+9Loc/Ww6UOHOFV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Cfxjs/mzfkb7N51O0Ijn0SnDakedwNWEsutvoiyaq99U9E2/L7NweSIPEODVdxnrZcryNe6rSz3kIPaM5koaSEbWq9I4Cii/utucxiKAhk666iY2A8dvPlzymenPby1tEW+zkZyFwRjnM20bQUoO1PXp3iVRTIh2mvhwx3ia00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=rt8dhCB6; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="rt8dhCB6"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1778751258; x=1810287258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fDawJLoVbJW9DQMIgEDksrxqneT+9Loc/Ww6UOHOFV8=;
  b=rt8dhCB6YzvqDV29yqBTGnU2Ku1AsbVBk6aKhaoV63c27vVYBe0x+tKV
   fxPkyeXUfMJa0p+hjbLcG0i/UMX4gi9NicGwA9Etkq+6xPzzHNYueboMP
   cvrEubyu7feRtAaq8C3I0TDRLE6RRGlyoBVFYmI8x8OgtqEOeRPZ/PbI1
   kfCO32x6+/kPz/mLnEerArP4FC/H5CX3el6NZ4mYGAJ9tuhrUqp7IRbXw
   pBJi1UEVvKtL+8tk3DxoA0tC/F9VAnesXTqpHUKxPvQdM4m1WelTHrgt6
   Qcv0pB1RbnWbLyrPM8SITbLmz4qxKE2OGx5y/C6RKIvq2Zkvb0ne0+8jk
   A==;
X-CSE-ConnectionGUID: SZ38OUN5TYSm18ggFaoR4Q==
X-CSE-MsgGUID: HFhQfCOfRuaku5Ge1v7Tzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="228496063"
X-IronPort-AV: E=Sophos;i="6.23,234,1770562800"; 
   d="scan'208";a="228496063"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 18:33:06 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 1A1A61000349;
	Thu, 14 May 2026 09:33:06 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (az2uksmom4.o.css.fujitsu.com [10.151.22.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id BE31F1807162;
	Thu, 14 May 2026 09:33:05 +0000 (UTC)
Received: from dhcp-portal (unknown [10.172.107.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmom4.o.css.fujitsu.com (Postfix) with ESMTPS id 42F27406855;
	Thu, 14 May 2026 09:33:04 +0000 (UTC)
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by dhcp-portal (Postfix) with ESMTP id 50BD3608E9;
	Thu, 14 May 2026 11:33:03 +0200 (CEST)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: smita.koralahallichannabasappa@amd.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	nvdimm@lists.linux.dev,
	ardb@kernel.org,
	benjamin.cheatham@amd.com,
	dave.jiang@intel.com,
	jonathan.cameron@huawei.com,
	Tomasz Wolski <tomasz.wolski@fujitsu.com>
Subject: [PATCH] dax/bus: Upgrade resource conflict message to dev_err() in alloc_dax_region()
Date: Thu, 14 May 2026 11:32:08 +0200
Message-Id: <20260514093208.13110-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The dax_region resource conflict in alloc_dax_region() indicates a
serious configuration problem — two subsystems (e.g. dax_hmem and
dax_cxl) are attempting to register overlapping address ranges. This is
not a transient or debug-level condition; it represents a genuine
resource conflict that an administrator needs to be aware of.

Promote the log level from dev_dbg() to dev_err() so that the conflict
is visible by default without requiring dynamic debug to be enabled.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/linux-cxl/69c1a8d1c0fa9_7ee3100a1@dwillia2-mobl4.notmuch/
Fixes: 34f80bb969cc ("dax: Track all dax_region allocations under a global resource tree")
Signed-off-by: Tomasz Wolski <tomasz.wolski@fujitsu.com>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 68437c05e21d..cd963eeeef7b 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -672,7 +672,7 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 
 	rc = request_resource(&dax_regions, &dax_region->res);
 	if (rc) {
-		dev_dbg(parent, "dax_region resource conflict for %pR\n",
+		dev_err(parent, "dax_region resource conflict for %pR\n",
 			&dax_region->res);
 		goto err_res;
 	}
-- 
2.47.3

