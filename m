Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B03AEB35;
	Mon, 15 Jun 2026 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506400; cv=none; b=AWkS+P5gDdiPAgL7C223tzRcrICco2eIBsyDSX0waklZOoj5lt8WkpxEI0QWRlCOCr3PKAoF5JnbXi28vQycFkP94FVXvWgq/iOgtQcgrrimgZA7IT2q9/NjRNbSZgEDNVrbANKYj+MwovXFXjloMDGzk1ijLX+9h0tC/OmG2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506400; c=relaxed/simple;
	bh=2f4IOE9zfxhSDcU1Tusf9K4cvRlBhopAz69eP5BaYYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CA9rCFSCMig8lY+rxFhDu8tkWhmeQtzZjoTYF0CC0eMYteF1vxOll6ZKm5KRVS3sbKZCBuC5EAK4Iz2E6GpOBjZoKpRpEVhH1jERUi7e8gPQki22d5qrMV1J+8ZifHxKWcfJUr6WXRxYKy3j6o61e+0/9S003Et5g9lZfc0CWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowACnMwdWoS9qsO+TEw--.39597S2;
	Mon, 15 Jun 2026 14:53:10 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pengpeng@iscas.ac.cn
Subject: [PATCH] thermal: intel: int340x: clean up RFIM groups on DVFS failure
Date: Mon, 15 Jun 2026 14:52:41 +0800
Message-ID: <20260615065245.84252-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnMwdWoS9qsO+TEw--.39597S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4xWrWUXr1DJw18Gw45KFg_yoW8Cw45pa
	yjgF90grn3Gw4UZayDAw4YqF95t3W0yay3XFWfG3ySkr4ayr93WryfKFyjyry8CFZxCa17
	XrWFyr4jyr98urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbUPEDUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

proc_thermal_rfim_add() can create the FIVR and DLVR sysfs groups
before creating the DVFS group.

If DVFS group creation fails while both earlier groups are enabled, the
current error handling removes only one group: the FIVR branch returns
before the DLVR cleanup branch can run.  This leaves the DLVR group
behind even though RFIM setup fails.

Use one DVFS failure path that removes all previously created RFIM
groups before returning the error.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 .../intel/int340x_thermal/processor_thermal_rfim.c    | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 1a7e134dfcf8..96279756177f 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -491,12 +491,11 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 
 	if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS) {
 		ret = sysfs_create_group(&pdev->dev.kobj, &dvfs_attribute_group);
-		if (ret && proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR) {
-			sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
-			return ret;
-		}
-		if (ret && proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR) {
-			sysfs_remove_group(&pdev->dev.kobj, &dlvr_attribute_group);
+		if (ret) {
+			if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DLVR)
+				sysfs_remove_group(&pdev->dev.kobj, &dlvr_attribute_group);
+			if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_FIVR)
+				sysfs_remove_group(&pdev->dev.kobj, &fivr_attribute_group);
 			return ret;
 		}
 	}
-- 
2.50.1 (Apple Git-155)

