Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793916;
	b=Vp/cReBOklOSfCU5zTR3ZcSo5L9Y0zFD+h02lUmdqREinqFE2PNYTzEOJiYer75Lml7W
	 TbcRs4DsOXC3LeP5zXfMezoR7Gbg4dmD4HZ3Tr7gOV3IHaZG8r2fPW16+UDQTO2uju2Kp
	 uAyR3Of08fQsIgmG05yr/LKmg5TOim/WbW7eUyz5H6vhlobI2Xn595sdmW5Ds72Rla2js
	 Pcvxx904uTaN+RjvjBPasmb2TTNjxxJOM012f+F86HizK/ad9D5C9+1o3r1UyDxnW4nbn
	 MYKv9IpU0cL3ZD/NG1cc4aK0Kkjiex8g+K3PwOqSm2SXD29DarOC690u7SIJFFqDCuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793916;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=JnEXQ50GsOmEBuVjtTV26PpQ90byO+C1R6rTiZu9PT4=;
	b=FmxYSG60zjDIRr6M5MFstcDiBX5o0hx3BKfqw62pMbRt169YeGs5vlyVPcFHO77Ja8/5
	 0kQcws0b/DfJGbn/l1DeUZg87/6tFBxHv1ndeO+yxtSIrkBfQztVdtg1+0L7vDU8J2t1Y
	 Pqr6HMdarwXD1MzdbMIIzJcYsHB232tk0maODgWwPQjcgXnFLVYvQ/n6d3M2mOSkx58oH
	 K3GznbZ4GGc4WjPTwLZY0Z+xsoAulZRf0j5Jr1p5F7jMX1kmmhoodAbo7sW3PRBytjXWu
	 hNZcLnOhLo68nlIYHopLuEMZCWvqku20oO43w2R9ACLtQU7Z+PvROf3SszwBZ5az+dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=01PkBFBM;
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DC606A326;
	Wed,  4 Nov 2026 12:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C1DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=01PkBFBM
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JnEXQ50GsOmEBuVjtTV26PpQ90byO+C1R6rTiZu9PT4=;
	b=01PkBFBMn2IC0WbWZWxpMRf2L2np8RzHoH9j+DRHVQRtF/DuRTIsNQgsdEUU28l5ROgxnh1bM
	AKhESBtbk7qU6LDyXF0Av0ODeYoacMXnN989zCzW1buGVVNJ6HGgqN708b+2wGNcZ0bTFDmZLEI
	s8rd1wBUKFSqwa5lY5yi89Y=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jKPJX2wQPz1prM3;
	Wed,  4 Nov 2026 20:05:00 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 1587A4056D;
	Wed,  4 Nov 2026 20:05:05 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 4 Nov
 2026 20:05:04 +0800
From: Zhou Minqiang <zhouminqiang2@huawei.com>
To: <rafael@kernel.org>, <gregkh@linuxfoundation.org>, <dakr@kernel.org>,
	<bvanassche@acm.org>
CC: <linux-pm@vger.kernel.org>, <driver-core@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
	<yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] PM: runtime: Fix check_flush_dependency warning from pm_runtime_remove
Date: Wed, 4 Nov 2026 19:56:41 +0800
Message-ID: <20261104115641.2682786-1-zhouminqiang2@huawei.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemr100018.china.huawei.com (7.185.36.64)

When a WQ_MEM_RECLAIM workqueue (e.g. iscsi_ctrl) triggers device removal
via device_del -> pm_runtime_remove, the unconditional flush_work inside
pm_runtime_remove can trigger a check_flush_dependency warning:

  CPU1: pm_wq worker                 CPU2: iscsi_ctrl wq
  --------                           --------

  pm_runtime_work(starget)           pm_runtime_remove(starget)
    spin_lock_irq(&starget->lock)      __pm_runtime_disable(starget, false)
    request_pending = false              spin_lock_irq(&starget->lock)
                                         (blocked, CPU1 holds the lock)

    rpm_suspend(starget, RPM_NOWAIT)
      status = RPM_SUSPENDING
      rpm_callback(cb, starget)
        spin_unlock_irq(&starget->lock)
                                         (acquires lock)
                                         disable_depth 0→1
                                         __pm_runtime_barrier():
                                           request_pending == false
                                             → skip cancel_work_sync
                                           status == RPM_SUSPENDING
                                             → enter wait_queue, sleep
                                           spin_unlock_irq(&starget->lock)
        cb(starget) → 0
        spin_lock_irq(&starget->lock)
      status = RPM_SUSPENDED
      wake_up_all(&wait_queue)
                                           (woken up, waiting for lock)
      spin_unlock(&starget->lock)          spin_lock_irq(&starget->lock)
                                             status == RPM_SUSPENDED
      spin_lock(&parent->lock)                → exit wait_queue
      rpm_idle(parent, RPM_ASYNC)        barrier returns
      spin_unlock(&parent->lock)       flush_work(&starget->work)
      spin_lock(&starget->lock)          __flush_work(from_cancel=false)
      spin_unlock_irq(&starget->lock)      check_flush_dependency()
                                            ← WARNING!

Replace flush_work with cancel_work_sync in pm_runtime_remove.
cancel_work_sync internally calls __flush_work with from_cancel=true,
which causes check_flush_dependency to return early before the warning.
This preserves the use-after-free fix from commit 29ab76827761
("PM: runtime: Fix a race condition related to device removal")
without the warning.

Fixes: 29ab76827761 ("PM: runtime: Fix a race condition related to device removal")
Signed-off-by: Zhou Minqiang <zhouminqiang2@huawei.com>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 335288e8b5b3..31537b745c81 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1895,7 +1895,7 @@ void pm_runtime_reinit(struct device *dev)
 void pm_runtime_remove(struct device *dev)
 {
 	__pm_runtime_disable(dev, false);
-	flush_work(&dev->power.work);
+	cancel_work_sync(&dev->power.work);
 	pm_runtime_reinit(dev);
 }
 
-- 
2.52.0

