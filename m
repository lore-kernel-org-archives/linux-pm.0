Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731E348C7D
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792127902; cv=none; b=TYVWECHz+pfgYa/06p8rNtdkdNPIuwVSgH0Z+YR9GM9vnsH06r26EfUijHdmcuedmGQxDLXl5MVsWyWCzsas2jXCKZ/eI7S9EvZ9cw7HYY3hJVprcRYP4PGJi2NvOvlx1pk0NPPaOCgbpzc9vIU8tta0TqdKt8wlCSI/MeKZOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792127902; c=relaxed/simple;
	bh=nuNjUflfI/QAwtV1Y0WTEhfQS433UWGcl6mNkz5BR3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqOaS+kyCdeKXbeXAQa0NaAxleCSJz9WcHovOh0A5s5Fr/u67l7TqCGcs46k9fLO+A6USRQxoijiWEO2woRQL8AVe/HzasqVrbiLlfydRP4RJUXISvusrsNr3nOfwEtA7QqKn/nuyCKZ4krdBFTFh7bukuL3LaJcv1SBl+9Pzqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=gALhgiy3; arc=none smtp.client-ip=91.218.175.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="gALhgiy3"
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nuNjUflfI/QAwtV1Y0WTEhfQS433UWGcl6mNkz5BR3o=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792127897; v=1; x=1792732697;
 b=gALhgiy3Sf+d4p6LyUK4Rodps4ezEEHuSUAwr/F84NtQk/Rh+uKU3GUZcoMciCuf++J3DBVz
 iPWOQA/xdtaM0MEvalEeAiqMHfEFzGCSr3lJJLWGvfaVP7vXsSDKbbenayJR0sO8s8vLwCuYrs4
 IkEL1pxp+uSjm8lK23y8IRvm2HTa6484kAdCmPQF/bjRdi21xVtBqxt8VHhK+xw8fRWJB/PZQGw
 8DZSoFD0jZM/2cE7eU9iu2hq2amOXAI1X72tKdhzAN67/spB0OLdN1pKvE9biaAVpEJWyfe0bC0
 b4MaB/xADhY1b0ceXMyV21khFMGc2D19bmwgL3e+qwsiw==
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5778b54b001c9d13;
	Fri, 16 Oct 2026 05:18:16 +0000
X-Mizu-Trace-ID: 5778b54b001c9d13
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Val Packett <val@packett.cool>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: sequencing: pcie-m2: Add Foxconn WCN7850 subsystem PCI ID
Date: Fri, 16 Oct 2026 02:13:35 -0300
Message-ID: <20261016051745.577777-1-val@packett.cool>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new device match for the PCI subdev id found on the Dell
Latitude 7455 laptop.

Fixes: a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN7851 UART BT variants by subdevice ID")
Signed-off-by: Val Packett <val@packett.cool>
---

Similar to 58a003302481 ("power: sequencing: pcie-m2: Add Lenovo ThinkPad T14s gen6 WCN7850 subsystem PCI ids").
The Fixes: is present here because it was present in that one.

Thanks,
~val

---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 0febe4b3d980..56c5d51293c1 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -225,6 +225,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_LENOVO, 0xe0e9),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_FOXCONN, 0xe0ee),
+	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
 	{ } /* Sentinel */
 };
 
-- 
2.55.0

