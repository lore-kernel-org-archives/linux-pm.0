Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62291218592;
	Sat,  4 Jul 2026 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783178622; cv=none; b=hzU+fGS+eH9hLeA4iIH19yXBOBWZiWK3QisymERlOhPCFB966BHBLCixsBNRfuq+S3G7Tqm2a4pxy66FJ0hWTYmnuwUL6CLrUZAZ856jWxUV2zpN7nrnkliuy4cs8eqLqshnO4kvixl71V/0sjiq7x6/GnZIPUVBO69y9SCHN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783178622; c=relaxed/simple;
	bh=uUFlQ9KK3s8iq6VpM3pFS4wflBs41vvpt7JUb7ifVF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBx+FHK8Ln5TnxZDI4dKY62deSWzDMj/gACxdJ++ZNyFeu1ftjifQJAo5lNDqJA+ekpHEa/HB6RGFfPPkfQNK9Ak2Kmt7j+MlRVi+MbygvTx8fWfItd4Gmwqh4cuhAGMervcP2t5q0Q5JNRtv8IdbQEyde4T6G+sEEal0Ku/LKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAD3fAB6JUlqjbnbFg--.46104S2;
	Sat, 04 Jul 2026 23:23:38 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Sebastian Reichel <sre@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: piix4-poweroff: add missing MODULE_DEVICE_TABLE()
Date: Sat,  4 Jul 2026 23:23:36 +0800
Message-ID: <20260704152336.51384-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3fAB6JUlqjbnbFg--.46104S2
X-Coremail-Antispam: 1UD129KBjvdXoWruryUGF1fCF1rCF47Cr18Grg_yoWkZwb_C3
	4xK3yI93WkGry2kanxCan3ZryIk3WxWFn7W348tr9xGF13Z34DJF97Gr9xJF1DJw15XF98
	XFyqqr4FkFyxtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUdpnPUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The driver has a match table for the pci bus wired into its driver
structure, but the table is not exported with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE() entry so module alias information
is generated for automatic module loading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the driver registration structure, and the missing module alias
publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/power/reset/piix4-poweroff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/piix4-poweroff.c b/drivers/power/reset/piix4-poweroff.c
index e6822c021000..1a6f3d22d297 100644
--- a/drivers/power/reset/piix4-poweroff.c
+++ b/drivers/power/reset/piix4-poweroff.c
@@ -96,6 +96,7 @@ static const struct pci_device_id piix4_poweroff_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3) },
 	{ 0 },
 };
+MODULE_DEVICE_TABLE(pci, piix4_poweroff_ids);
 
 static struct pci_driver piix4_poweroff_driver = {
 	.name		= "piix4-poweroff",
-- 
2.53.0

