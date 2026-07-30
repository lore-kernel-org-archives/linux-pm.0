Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F313A244;
	Thu, 30 Jul 2026 01:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374249; cv=none; b=NUOnpKNWAfA3v1KVHxfmsHuzEFyUjD51/YPuIOuMBFWpZcr3+woFx4bTkLCQP6h79yg3ofet3vR9lPZ4otHiQp96rk0uAVd71qEnEGiTQx/t+4XWuSAj09/+7Z4K509szEJQcojQl0nxYRBMEIALTMOX4edAKhXK9lr+X/v4aJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374249; c=relaxed/simple;
	bh=z9rCIFseRBPNZbXwzIhVuCjRr8a5jA9U6WRPS5YWoqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AWQ29airdHccVM40rDiYnuKJSnvAo3DvnsJdcLpBBDvYSZykAqAaLS3bn1z4djbJzvr2uid01Gir95U1n+c2Wv3x1xKZRRFoKmoGpe8Rxz7BNNSvyIpMuHWjL8SbzfatFSj7PqO9caQidh8dKiGkwyl8zmI/IMop7mAwdAWrwM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 68ca32588bb411f1aa26b74ffac11d73-20260730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:40e7f201-4b4f-4034-b3b0-3790b9d7512a,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:bd5a205922a9d0fcd6e8de74054d1177,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 68ca32588bb411f1aa26b74ffac11d73-20260730
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1898333408; Thu, 30 Jul 2026 09:17:19 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Sebastian Reichel <sre@kernel.org>
Cc: Waqar Hameed <waqar.hameed@axis.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH v3 0/2] power: supply: bq25630: scope the battery information
Date: Thu, 30 Jul 2026 09:17:11 +0800
Message-Id: <20260730011713.3332913-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

data->batinfo is only read by bq25630_setup(), but it is fetched in
bq25630_probe() and kept in the driver data for the lifetime of the
device.

Patch 1 moves the get/put pair into bq25630_setup() and drops the member.
Patch 2 then uses the new power_supply_desc::init callback so the charger
registers are programmed before the device is exposed to the system.

Patch 2 depends on commit c1eb5905fdce ("power: supply: Add registration
init callback"), which is in the power-supply tree but not in linux-next
yet. The series is therefore based on power-supply/for-next.

Changes in v3:
- Use dev_err() instead of dev_err_probe() for the battery info failure in
  bq25630_setup(). The function is currently only reached from probe(), but
  that should not be baked in as a policy, and the rest of the function
  already uses dev_err() (Waqar Hameed).
- Rebased onto current power-supply/for-next.

Note that v2 went out with a broken charset in the Content-Type header,
which made git am fail. That was a send-email misconfiguration on my side,
not a change in the patches themselves; it is fixed for this posting.
Thanks to Waqar Hameed for reporting it.

Changes in v2:
- Move the battery information get/put pair into bq25630_setup().
- Remove the now-unused batinfo member from the driver data.
- Use power_supply_desc::init to complete the hardware setup before the
  power supply is exposed.
- Split the changes into two patches.

Link to v2:
https://lore.kernel.org/linux-pm/20260728024558.3611522-1-lilinmao@kylinos.cn/
Link to v1:
https://lore.kernel.org/linux-pm/20260727093738.2611185-1-lilinmao@kylinos.cn/

Compile-tested on power-supply/for-next with CONFIG_CHARGER_BQ25630=m; both
patches build cleanly with W=1. Not tested on hardware.

Linmao Li (2):
  power: supply: bq25630: Scope battery information to bq25630_setup()
  power: supply: bq25630: Initialize hardware before exposing the power
    supply

 drivers/power/supply/bq25630_charger.c | 56 +++++++++++++-------------
 1 file changed, 29 insertions(+), 27 deletions(-)


base-commit: 5584ad5706e594c7648655171785aa4fffdd3db5
-- 
2.25.1

