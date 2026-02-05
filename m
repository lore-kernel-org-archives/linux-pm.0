Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82835CB71;
	Thu,  5 Feb 2026 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770286169; cv=none; b=oNbL6UZj/tnSpY8EZH9AvHmreoZEE/kF+UQu4fghhvx49bVKRFTNnRnjSKrLkITOu3h05kTTFT7acpHtrK6lqG5BYUvo/M5Icfd9/w+LPQigGGaAWpTwHwdlraIpE6oIJgcP15569xqBjXr7o7Kjh/LqBSq84aCOr0Jdg3aexCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770286169; c=relaxed/simple;
	bh=rjVLBS5suny7TVIF9orh2XiBjCfmzgAyQsFZn3Fe0bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8exWlWdo3OA/tDS8OJOL3HR3Ts/3aBxbj9dhWi5lQErYF6UP8KruxPmbnx4fFPlReYJ3Kge+Svu455okHitsY0etg6CyjkIlE2sCE5MY6TUYMQakwKkL/ssdMhlWj8ZaCMsiGuY2838Z6ZFLjGLNNgoTnUaOZhQB2n+BwDH0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inWK0mzk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inWK0mzk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770286168; x=1801822168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rjVLBS5suny7TVIF9orh2XiBjCfmzgAyQsFZn3Fe0bQ=;
  b=inWK0mzkZyGTNCNCi9d2aMT9ZvOayjNSjhfd24vMgjQZ8f0b0AZBhaJZ
   tOrOvT+Rjm+AmcwGcNCYIcvkvmUaYBrDt2OUzTwasIBYD2vNViTVk2/Bh
   3tFuTsf8FTCALdOhUjv5CE86nhzeAtrv1dLL/88iQfbc7sw9R8R3yzSfd
   Ye9dq3cMG8zHGA8/iQ1cce7CRPF5oHi5tKjYEnSKjW37VnW4RQxKccRSH
   rxmzYwHwyNjCAhstepuDwdeHxjcqn7j21sDXPQ3hwHMWkIAkPe+vvJKmU
   z/11ep8OdXFrDKExv3P9zA3IAKIcEz372o9ozxB4OtMYfsOa5wjdfEJsc
   Q==;
X-CSE-ConnectionGUID: F2sOMeUoTjeHxfTfKbbc0g==
X-CSE-MsgGUID: nIwoDMSlRkmtbz4A1TeRjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71471703"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71471703"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 02:09:28 -0800
X-CSE-ConnectionGUID: 40eQDyFBSduOqP0Pgrzo6w==
X-CSE-MsgGUID: tPh/v2gLTSmrep5kf70AoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="214631170"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.244.58])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 02:09:26 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V3 1/5] i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
Date: Thu,  5 Feb 2026 12:09:11 +0200
Message-ID: <20260205100915.19792-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205100915.19792-1-adrian.hunter@intel.com>
References: <20260205100915.19792-1-adrian.hunter@intel.com>
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


Changes in V3:

	None

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

