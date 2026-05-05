Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB13B637C;
	Tue,  5 May 2026 04:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955629; cv=none; b=G8rcpE++Z6sOEg1mgJJ5JJG0aBklaxR6JKWbpZMKegocmmoFj1HGHOuXrcPRIePlr+wDVjqSWSOuR+2H4VzeR+aohJ/QiyWzghTNHA2WUu+BTcmPJ1EAXL9Wa061d+/xmyUj7usqEfC2SJm8tCxzELKm2WBy10EcByvIwrjKbuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955629; c=relaxed/simple;
	bh=VNN9D9wjXdv/G//VFLBsU+eWDcbzKGEbA1+8C4pcdR4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoNU2JIS8tnoIsebvup4F+3avPvzcf1FJ0hNRy2kvtSsVDxBpSvxFaMdRn+cjIQVTvfI3+tXk4iAlU+Os6dzgmOsKq5uVUlH7ePyCvLSh5so2Alo4p7ESHYKMlgfI7vLNA2Ns4TiFbLqQwduyUzOklYPSlZPUcwhE5TkslkN/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWkO/6Bv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWkO/6Bv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777955628; x=1809491628;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=VNN9D9wjXdv/G//VFLBsU+eWDcbzKGEbA1+8C4pcdR4=;
  b=OWkO/6Bviedc/XrwRFj8uQH9f5vAbjM8IkdQWkKpe3dkcMzUboZ6uW37
   ygltThBjkFrnBoqPdkuTor7bVwnMKSdORDtEfytexrPSYd1vaxrjoSI6Q
   cRtdqiTiz9MC5D6IquOjMQeYsR36o93NDUthByRRaLG88+uPhAFOuxE5L
   b6gX7ivChzA8x8pl2qaol8X1Na3vGsMOGQlepl6zOQJ+oZJphtdaTiS78
   JCZsI2l9KvA71o2O2qRg2GdI+zSVR4jj6KIy//tQMvrNIPxb6Lx5zzwZE
   6x04hJRcS3fp9PoPKiAVeIZoB2wdFYsP15+JcuIRwGnNflqM4VFo85GoE
   g==;
X-CSE-ConnectionGUID: 9rA5vCuoT5mIygBtBwTFIw==
X-CSE-MsgGUID: 7AqXfzmQTzyq+xiX+W0E8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78841283"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="78841283"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:47 -0700
X-CSE-ConnectionGUID: +FZ0KapFRbCcPI32VDP7qg==
X-CSE-MsgGUID: XeTrGagsT+elhhwY2sQ0Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="232565208"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO xpardee-desk.lan) ([10.125.110.35])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:33:46 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 1/7] platform/x86/intel/pmc: Use __free() in pmc_core_punit_pmt_init()
Date: Mon,  4 May 2026 21:33:32 -0700
Message-ID: <20260505043342.2573556-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505043342.2573556-1-xi.pardee@linux.intel.com>
References: <20260505043342.2573556-1-xi.pardee@linux.intel.com>
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

