Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78602AE78;
	Wed,  1 Apr 2026 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070635; cv=none; b=UteAwK9EdZYEraA/oqf3sM6mDY4LRbXcn5VnmMl/9pH4WYHye4IuI6fiQ8Ws/m4r3JxhpI61GcA5HX+OxYKzTC2Tp+uYfRuTYHlfAIk7+IjrgYKLRbmXADdJ/bofdjJcjstGhVdJzUkOdVstRY09uQWClIkVqUz9/fHglWze/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070635; c=relaxed/simple;
	bh=lphvbihV1wAW8TB3Ql0vED5csSpeQy4zVfGMp/y0Kg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fOxpayRJrq9SfCyV+IxkZLWXEljYMZHVNFnW1h1qCX9A3wtGTE0D70MRdojPgF3G91/wO4X6JmKl+ZfNwwrllqpPyDkloSRxgF1o5B/24DfpC+0Q7QIbR8rMdJCMkcIL1G4yFPd4mf3nQnsZcCE/Pi1m28w5cX4/RcrhAoOPuj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laBB4E96; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laBB4E96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CE5C4CEF7;
	Wed,  1 Apr 2026 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775070635;
	bh=lphvbihV1wAW8TB3Ql0vED5csSpeQy4zVfGMp/y0Kg0=;
	h=From:To:Cc:Subject:Date:From;
	b=laBB4E96W2vD9PJyC9ziKCZz1OXof/M+Ye5Ye1E0o7ldZESlDdWyeJgjY541jxLII
	 WpCYepwc8SD58pZSgp/9dc7DGYb0UNCU4TvKCQrILOcvfQXKbDNSZusM7I1IfUpVUZ
	 yL1PPkI3Jr1yRgynetU3uPjTGR4bhfmc33ljk1+H1Duix0iGpqa/hi+jzZkMrPCO+h
	 F/jV0KwnzVmU/B06j6gj2ckO8XP3rhxjcC9dsxcIdxetT07OA2ZDxwVUKNp/l7i02J
	 iVP3QKDM5ADqNV0Wnw0zPTrDdGDrwUAw7ZYWsuvcIHPkjGIXkNbysVmQ1F1x56ce4S
	 2fXed37muYB5g==
From: Arnd Bergmann <arnd@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: sequencing: pcie-m2: add SERIAL_DEV_BUS dependency
Date: Wed,  1 Apr 2026 21:10:13 +0200
Message-Id: <20260401191030.948046-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added serdev code fails to link when serdev is turned off:

arm-linux-gnueabi-ld: drivers/power/sequencing/pwrseq-pcie-m2.o: in function `pwrseq_pcie_m2_remove_serdev':
pwrseq-pcie-m2.c:(.text+0xc8): undefined reference to `serdev_device_remove'
arm-linux-gnueabi-ld: drivers/power/sequencing/pwrseq-pcie-m2.o: in function `pwrseq_m2_pcie_notify':
pwrseq-pcie-m2.c:(.text+0x69c): undefined reference to `of_find_serdev_controller_by_node'
arm-linux-gnueabi-ld: pwrseq-pcie-m2.c:(.text+0x6f8): undefined reference to `serdev_device_alloc'
arm-linux-gnueabi-ld: pwrseq-pcie-m2.c:(.text+0x724): undefined reference to `serdev_device_add'

Add another Kconfig dependency for this

Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I noticed this one only after I had already sent the patch to add the other
two dependency, feel free to combine the patches into one
---
 drivers/power/sequencing/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 77c6d9227251..1c5f5820f5b7 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -39,6 +39,7 @@ config POWER_SEQUENCING_PCIE_M2
 	tristate "PCIe M.2 connector power sequencing driver"
 	depends on OF
 	depends on PCI
+	depends on SERIAL_DEV_BUS
 	select OF_DYNAMIC
 	help
 	  Say Y here to enable the power sequencing driver for PCIe M.2
-- 
2.39.5

