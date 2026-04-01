Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0CB339872;
	Wed,  1 Apr 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035142; cv=none; b=t4Yx2cFndLQCu8S7+Zb4RcXjSe1RMvExfAiNyIZ1wzJVGJTLsOKMAD2253FfLg6c6fVEFA1lLdWRse+19bsljAQ2MirVYn/bOOpZ6Jy2v88w5bozHxNqSwXnQ1yHKJ6SMmo6ZKzvC/k1PgMXBsnpOKLnMMrH1g3dgNRa3riB6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035142; c=relaxed/simple;
	bh=//ZI0r5XZBi1MmxScFU0BKn5V3oSGkYwCfDdzUobDo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qk19GhqMZEZe276TtIes7HVqdUAvwBjOrZboADGiEcFmz4XSpYHGpwauZyWJ8G3c0N3/Tdpb3YECjL3qLYQAzpXpj3tWYSX4bkuO59kuhk/MxgzlZwLYDskUDr9ord7k/XwzXWtdhHCuR+EFsyXrRxssCwdoPHEFJsA4UNsiT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVq7nAA8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVq7nAA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F808C4CEF7;
	Wed,  1 Apr 2026 09:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775035141;
	bh=//ZI0r5XZBi1MmxScFU0BKn5V3oSGkYwCfDdzUobDo8=;
	h=From:To:Cc:Subject:Date:From;
	b=uVq7nAA8dMKbcMBDmbIkmSOxQlCG9XSeJJhb4uL0XlmD6R2hFNfltRsW4yKRQi+wv
	 b00g7MrlHp9OCaMFyzG7lFjdvIO3oymf/Q2wnlrxQqgjquTFra1CwR3Uevf0p1Fugn
	 IyNKn89C41zxA77EwRDMtyB0LkmBjYsMP54IxMjD68Bni1ECyAJJ2r3A3exREsh/wJ
	 LTOs9eBm4fTZf6HQLRHoCG5r7zLN3w88WGEpky+YMNEGBF1Pdql7flc8T03oI2Rbu2
	 BS30qzzVLm7zFyqoCwEl4+VJ4ir6/g0oR+jXVwN4OPkJ+hoXilVy9r9wYe9B56A78r
	 aiCnmFPYioivg==
From: Arnd Bergmann <arnd@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: sequencing: pcie-m2: enforce PCI and OF dependencies
Date: Wed,  1 Apr 2026 11:16:25 +0200
Message-Id: <20260401091847.305294-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The driver fails to build when PCI is disabled:

drivers/power/sequencing/pwrseq-pcie-m2.c: In function 'pwrseq_pcie_m2_register_notifier':
drivers/power/sequencing/pwrseq-pcie-m2.c:368:54: error: 'pci_bus_type' undeclared (first use in this function); did you mean 'pci_pcie_type'?
  368 |                         ret = bus_register_notifier(&pci_bus_type, &ctx->nb);
      |                                                      ^~~~~~~~~~~~
      |                                                      pci_pcie_type

Similarly, when CONFIG_OF is disabled:

drivers/power/sequencing/pwrseq-pcie-m2.c: In function 'pwrseq_m2_pcie_create_bt_node':
drivers/power/sequencing/pwrseq-pcie-m2.c:191:9: error: implicit declaration of function 'of_changeset_init' [-Wimplicit-function-declaration]
  191 |         of_changeset_init(ctx->ocs);
      |         ^~~~~~~~~~~~~~~~~

Make both dependencies unconditional to prevent compile-testing
in either configuration.

Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/sequencing/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 1ec142525a4a..77c6d9227251 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -37,8 +37,9 @@ config POWER_SEQUENCING_TH1520_GPU
 
 config POWER_SEQUENCING_PCIE_M2
 	tristate "PCIe M.2 connector power sequencing driver"
-	depends on (PCI && OF) || COMPILE_TEST
-	select OF_DYNAMIC if OF
+	depends on OF
+	depends on PCI
+	select OF_DYNAMIC
 	help
 	  Say Y here to enable the power sequencing driver for PCIe M.2
 	  connectors. This driver handles the power sequencing for the M.2
-- 
2.39.5

