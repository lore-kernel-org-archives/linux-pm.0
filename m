Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48492F0C74;
	Tue, 28 Jul 2026 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785206779; cv=none; b=qMM+mU2inoypJCzecPduLkeS/YRmitqj4rx1lF2V4hpp+d68ghVOpYZIVms24cSKk/cU5IhTp8SeTAmrwVHMTAZzJn+seop7JNJyu8ojMlc2CcTrbmN6plBfFwRVof+AlxZ9MqSsqvDN+a1DMt+MAcTk/crQxWjxW6zmSDadruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785206779; c=relaxed/simple;
	bh=sQS7ZTkY4dxB0pC6pIdKzefeFjIeEaPOYfJ+JTOyRuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kaq/1e13g4dnWZhYUOcA2BEr+bvoAy5Q73pS3O5uq4rBaGy/5SGcZw+1eq0Gzu3E1+jtHxzDhkdkOojiu1j7wd0kEgonhw8qbuTRvV58QSv6B6XQAB+6uEqpY/cmUHekS263C4lTvNaGJ8BtjkyM7j57d/lMn5dfdmPaYEJ1hhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 797360ca8a2e11f1aa26b74ffac11d73-20260728
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c9bdf885-3a19-4c52-ba3d-affaccf033d3,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:7a9bac681e78bd8ae28bec3fb0d807a4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 797360ca8a2e11f1aa26b74ffac11d73-20260728
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1019582191; Tue, 28 Jul 2026 10:46:03 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Sebastian Reichel <sre@kernel.org>
Cc: Waqar Hameed <waqar.hameed@axis.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v2 0/2] power: supply: bq25630: Improve hardware setup
Date: Tue, 28 Jul 2026 10:45:56 +0800
Message-Id: <20260728024558.3611522-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision addresses the review comments from Waqar Hameed and
Sebastian Reichel on v1.

Patch 1 scopes the battery information to bq25630_setup(), its only
user. Patch 2 uses the new power_supply_desc::init callback, so that the
charger registers are programmed before the device is exposed to the
system.

Patch 2 depends on commit c1eb5905fdce ("power: supply: Add registration
init callback"), which is in the power-supply tree but not in linux-next
yet. The series is therefore based on power-supply/for-next.

Changes in v2:
- Move the battery information get/put pair into bq25630_setup().
- Remove the now-unused batinfo member from the driver data.
- Use power_supply_desc::init to complete the hardware setup before the
  power supply is exposed.
- Split the changes into two patches.

Link to v1:
https://lore.kernel.org/linux-pm/20260727093738.2611185-1-lilinmao@kylinos.cn/

Linmao Li (2):
  power: supply: bq25630: Scope battery information to bq25630_setup()
  power: supply: bq25630: Initialize hardware before exposing the power
    supply

 drivers/power/supply/bq25630_charger.c | 55 +++++++++++++-------------
 1 file changed, 28 insertions(+), 27 deletions(-)


base-commit: c84ccde22d9d3070a9ee144e825270a7a784c570
-- 
2.25.1

