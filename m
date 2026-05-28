Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF191C860A;
	Thu, 28 May 2026 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950767; cv=none; b=bSfD32tHw3onBNzMxvsGbQzBfXTSvDVurckYYjf9E6Fp5hBmgUFtrtpewDanUKjrXwMPuW3jNTAuLwVeAujhc4CPRAxeT4Hdcpz7NELh0vJchUJOuSNoMie/hawWlI+AqdrvDzpkqUWxHtwmuX4jX0IXfHZs7aV+cIzdlVnfgAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950767; c=relaxed/simple;
	bh=prdtrxY4K6tpuyuEGT/BUZzB6ZtzGfmw31jIxmiUMc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=n0fEkT+yL9b5K+Hgz/nNV2EBsnw/TC6tBesc1yteifcNIMV3sAkmroY0WigD2apNg0E81R7kSoMBmf+QJ1tlRRGJbq5WsOl7LAeyFN6dqGSu2g1ox9Q6qPof+B7Vj+Bdl2w428JTi0eqp7ZfJKr0GGnHa+7ZfYv7Pz3KmHgmt9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=s//di6AP; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="s//di6AP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1779950765; x=1811486765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=prdtrxY4K6tpuyuEGT/BUZzB6ZtzGfmw31jIxmiUMc0=;
  b=s//di6AP3OLufjvl8tPGcxecZHsceNI7v25DfgS5YEiqocVzdElMiA2m
   iihVkGjmgJZGqeDU6cdiGFi1OLOBcA/R/IcPR4QqMZj5s+6dSH4kAI2ZC
   AMIAL0CysJaMKDrxqUaGWV4rFGzCEkQ9Df2Lb57SMrWtMuDe3WCddvfbP
   IbDUazEdEVs32Ry4FJLM1bu/Uu+gqpbtQwUJz1c/0xnjG5JXbkyVV2MLJ
   dz/UD+pXHPWin1l5ULuNSFgCbsmHp2RBGse2xu3rHfhV2tFHZyBYySvtZ
   xV+ZOimJNMQ2ciKErgaV1V30tgL67B21+JLyOHKeRGmYb46UTvq14PCVG
   g==;
X-CSE-ConnectionGUID: HmsPKrqXReWV1SCu0QBOwA==
X-CSE-MsgGUID: ouc9kzsrSsiRSHRaInRdvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="221043445"
X-IronPort-AV: E=Sophos;i="6.24,173,1774278000"; 
   d="scan'208";a="221043445"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 15:46:03 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 3E34C100034E;
	Thu, 28 May 2026 06:46:03 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id DD28EC013E4;
	Thu, 28 May 2026 06:46:02 +0000 (UTC)
Received: from dhcp-portal (unknown [10.172.107.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by az2uksmom2.o.css.fujitsu.com (Postfix) with ESMTPS id E6B7A1400132;
	Thu, 28 May 2026 06:46:01 +0000 (UTC)
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by dhcp-portal (Postfix) with ESMTP id 3E41260A0E;
	Thu, 28 May 2026 08:46:01 +0200 (CEST)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: smita.koralahallichannabasappa@amd.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com
Cc: icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	nvdimm@lists.linux.dev,
	ardb@kernel.org,
	benjamin.cheatham@amd.com,
	dave.jiang@intel.com,
	jonathan.cameron@huawei.com,
	Tomasz Wolski <tomasz.wolski@fujitsu.com>
Subject: [PATCH v3] dax/bus: Upgrade resource conflict message to dev_err() in alloc_dax_region()
Date: Thu, 28 May 2026 08:45:46 +0200
Message-Id: <20260528064546.23362-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

