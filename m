Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2F3E9F78;
	Wed,  4 Feb 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203724; cv=none; b=T0aV3fBI6PQPveoC5Oo9rPT7ROGktyARW6eTKT3rB8kTBRvdKZCX3IcGXWtIKNtzYC/NA5jjonFvgsYk9ThuZju2OJCTYHm8I/dVH1se3SNp+0f74QMfZWLajd1IuRv1nMP3cIRMet3KJQkCn5kWRX5axjbVDYlWD+c68DZ6m6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203724; c=relaxed/simple;
	bh=1LR0jNMOWOcTc3yDkCe9j2hyAXae4IGjcC2V8uLYor0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBbUH9e4Ywk0K0tcZrLwCVuPhLkEPXZdADg13szinRygY/S23IgXL1f4jXACWWKat/ZDJOW2e0IXav5iL+5MIniewiwpy1Ha0iwOslmDE7XWrh5vL1giZnlU4/rds+nKBlP4AjRjmUeeLo96Zaua0FE91umL9p7+x2NC0diANC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtbYC092; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtbYC092"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770203724; x=1801739724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1LR0jNMOWOcTc3yDkCe9j2hyAXae4IGjcC2V8uLYor0=;
  b=NtbYC092AZkkRE+X6Azqvj4zTVw21ChlEbjsCM+duAB2ojH7P4uuC+wY
   mGbCnl3ZGrj9qQ/5JdiaX6pY/QSVem+3cVr/g89N/QAgNKMjd9CdKHJkB
   ti1dueG30FVEAUVYnoKGm0oVMg0Ub+7DhcANafV5bciLgRBKU/rbeHkki
   1a2psq47DSwuxY7uzEcJPyhabgMDPz70zeuM3uIaX6OMW/RKXsd9n35K6
   SjnHE7+gXhbCOITSm02vMv8/+Zgw7Y4kAlB8PSg7252xQDv7XVJNKPrCH
   CjiZitRXK4HCSwClqQoZ4zcQwW9z5/2X1CBPhqdkEwzQA+plSdAW7DDvg
   Q==;
X-CSE-ConnectionGUID: 1JdvMKxlTGuBetR7YZigPg==
X-CSE-MsgGUID: XvVmiy0mTL2Ir9ojAHaLgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70406042"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="70406042"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 03:15:24 -0800
X-CSE-ConnectionGUID: hWsvumg5Tl+nyabMW8g7BA==
X-CSE-MsgGUID: M+wjN3+cT0O6lELowOgrZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209739274"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.181])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 03:15:22 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 1/6] i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
Date: Wed,  4 Feb 2026 13:15:06 +0200
Message-ID: <20260204111511.78626-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260204111511.78626-1-adrian.hunter@intel.com>
References: <20260204111511.78626-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Set d3hot_delay to 0 for Intel controllers because a delay is not needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---


Changes in V2:

	Add Frank's Rev'd-by


 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
index 0f05a15c14c7..bc83caad4197 100644
--- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
+++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
@@ -164,6 +164,7 @@ static int intel_i3c_init(struct mipi_i3c_hci_pci *hci)
 	dma_set_mask_and_coherent(&hci->pci->dev, DMA_BIT_MASK(64));
 
 	hci->pci->d3cold_delay = 0;
+	hci->pci->d3hot_delay = 0;
 
 	hci->private = host;
 	host->priv = priv;
-- 
2.51.0

