Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164637268B;
	Wed,  8 Apr 2026 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686909; cv=none; b=iNTyZ7VyQnYb1yUxUiJacR1pweGNn9LXkmGHdyEm4NGylYB94WLKeNx4LTpNwEY7o0hyxJGX1J4ArZU6OmQfQHKG6BrwVU+ZyWdsgaqyNClUQba4L6/OSDQh7lxX1FJDq7prAF+x6ONa6+I+rQt2Tvn+8iwSedSD4uuc98yoLXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686909; c=relaxed/simple;
	bh=VNN9D9wjXdv/G//VFLBsU+eWDcbzKGEbA1+8C4pcdR4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNoB1smKdJRXX6pprElAYVDtEl6nNlBp303IIOplOMBPm5h9PMGutyTtBxT8lUn6BL1T7A4f/TajYLM6CWAKmBZ/M2QNeFvWeCj9sVJSwpal9jz63FYm9co3oLT8s9+4p5dFGHDycIiOSxlgqkj/Xd9S9Mz5LUQwGJLA/Lmo1MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+VXKxfe; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+VXKxfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775686908; x=1807222908;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VNN9D9wjXdv/G//VFLBsU+eWDcbzKGEbA1+8C4pcdR4=;
  b=d+VXKxfeuGgXZXkAQ7ktJezkN/hCj0WttEiyHIqJmMUtsRnunThEgkqz
   FjJVuJ1y5nS/RRr7mswq4w8Mi0mZ2fDVirvC3c27shWla63nmvbcEfKmC
   /BTtAcJ2aYdxf8fvWylrD0p3e4NmVdebBriJW73WIdTyuPSSIwfCSG54n
   0pbXGDaaarsm8IJ3sYjAOOS8XB1WZlnRGeH2KquA/W8A8P2BIiGzrWyv3
   cIGBBzrdYBKxX/3VqI2uqoViO60+sQZW2qSM5ZHJBFs7R/jD3XG2oIYeq
   iJ8RpVTSFbTRZ7eniHfLWxP2pXxAcd0ncwy/Z2OrnKaYLvmjrasu5lGyM
   w==;
X-CSE-ConnectionGUID: xeghoHSlSMSJfTTcCdwirA==
X-CSE-MsgGUID: 3lJp+f6FQoS2+JvjP6Xewg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88068070"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="88068070"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:48 -0700
X-CSE-ConnectionGUID: sHUxapMhTYSkMxdmxPbm5g==
X-CSE-MsgGUID: R5jA6sQSSIG+v4SABJrs1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; 
   d="scan'208";a="223837823"
Received: from aschende-mobl.amr.corp.intel.com (HELO xpardee-desk.intel.com) ([10.125.108.200])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 15:21:47 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 1/7] platform/x86/intel/pmc: Use __free() in pmc_core_punit_pmt_init()
Date: Wed,  8 Apr 2026 15:21:34 -0700
Message-ID: <20260408222144.3288928-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408222144.3288928-1-xi.pardee@linux.intel.com>
References: <20260408222144.3288928-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scope-based cleanup in pmc_core_punit_pmt_init() instead of manually
freeing. This simplifies the code flow by removing the explicit put call,
making it less error-prone.

Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index d91e1ab842d65..c8a92d6235203 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1325,16 +1325,15 @@ static struct telem_endpoint *pmc_core_register_endpoint(struct pci_dev *pcidev,
 void pmc_core_punit_pmt_init(struct pmc_dev *pmcdev, u32 *guids)
 {
 	struct telem_endpoint *ep;
-	struct pci_dev *pcidev;
 
-	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(10, 0));
+	struct pci_dev *pcidev __free(pci_dev_put) = pci_get_domain_bus_and_slot(0, 0,
+										 PCI_DEVFN(10, 0));
 	if (!pcidev) {
 		dev_err(&pmcdev->pdev->dev, "PUNIT PMT device not found.");
 		return;
 	}
 
 	ep = pmc_core_register_endpoint(pcidev, guids);
-	pci_dev_put(pcidev);
 	if (IS_ERR(ep)) {
 		dev_err(&pmcdev->pdev->dev,
 			"pmc_core: couldn't get DMU telem endpoint %ld",
-- 
2.43.0

