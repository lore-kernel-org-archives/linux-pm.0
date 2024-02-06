Received: from njjs-sys-mailin01.njjs.baidu.com (mx309.baidu.com [180.101.52.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82329128812
	for <linux-pm@vger.kernel.org>; Tue,  6 Feb 2024 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707203707; cv=none; b=jUxYJ692rTlntxRzcYYI3wsp9NEWyWT/TdMrsWifOamhMwmZVdp/a3RXwaBVgcu3FickRNwwi/L9Dyw7DieCsXAodBXwuUa5RXXW+IEsTIDb+wqskRglWbuQwVOzaifOkRv4cyw1aQ2CkNK4266is/QFRoJ+RVACsd3kG0daOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707203707; c=relaxed/simple;
	bh=j/fGjAySdZAgYmz09kBEVUmJjIVI4vI7Cyf3Za32EUY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rCL/zHt5Oa/aAXtBGCCq0YBs2Wp3ihBWrCQfSbeuCSwFZyaHuVKw4oICtOn1xvM+hVkB7475zzcbgC0F+nLb9nSBOmfAv95o81rSVX6WC0dy7mWMpTI6mxSRAZQQ1qW0VqynV+aS3Ga4px0t+0XJbJ0BexKIIeEQUMgextWYT9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id AE5A37F0004B;
	Tue,  6 Feb 2024 15:14:54 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: linux-pm@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] intel_idle: update spec_ctrl register only when necessary
Date: Tue,  6 Feb 2024 15:14:52 +0800
Message-Id: <20240206071452.42673-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

spec_ctrl maybe 0 when mitigations is off, and writing spec_ctrl MSR
is expensive operation, so update spec_ctrl only when necessary

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/idle/intel_idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index bcf1198..8150d5f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -176,12 +176,12 @@ static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 	u64 spec_ctrl = spec_ctrl_current();
 	int ret;
 
-	if (smt_active)
+	if (smt_active && spec_ctrl)
 		__update_spec_ctrl(0);
 
 	ret = __intel_idle(dev, drv, index, true);
 
-	if (smt_active)
+	if (smt_active && spec_ctrl)
 		__update_spec_ctrl(spec_ctrl);
 
 	return ret;
-- 
2.9.4

