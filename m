Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6323A984;
	Thu, 29 Jan 2026 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710737; cv=none; b=mvqueqLlgIZAdk/VPFeobcyMvUIecccn4Jih5nU5pi/mKDiJAGdjx1YbeRge5R6Pf/NiwV09BXzzQFM7WCNFXzl4GgcZr51mN08WPKR5+zmu3PSPwaup57KpD8siVdVMJ0vVdez/vw4gh60fsc+coVy+STDECi7TbLHLmNh1aQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710737; c=relaxed/simple;
	bh=k2kV1md/c6oz+3Vmgv89T8BHEt7KRo1xA7RQ1bJVq8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPLdqK4nKUoHSjTv3hRokOop5PtVkP1sFuz1ctXccWJ0AXUCZJbUnpLDpCmEY+4KOYy4v89qJKvFipbbyrOLfrMpgblk/F7PTO2A55UFnEVhSR8MTIldxoumY+4M6r3J08aVw/w8f3M3HTZ/u1PCaN/OaRDI4W1y4mSx2RpgTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzauM3JQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzauM3JQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769710736; x=1801246736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k2kV1md/c6oz+3Vmgv89T8BHEt7KRo1xA7RQ1bJVq8k=;
  b=PzauM3JQcKLm3Y01cGnlGegQQl5bR6fF3tt0IX5ErngnjJhnHwNgq9Eq
   Eku+JSYWT+L0Wif8xaAVw3whsMllBwAY/HbCVGvVs71GkGhaq7fTzb3qB
   La1Vs700mtFlEXjLL71VEKlOQJSvWT8zSj+nlHshOWVPeCa18kNYABiVW
   Bq42OtEDOGLKh1hUTES66F1RD88kWTaRfKYKA4js9XtZtmpsE+L00KXJR
   SE+McRAkwuAVm8cQZor2v+wGYBEDswZr4xdZzBpsOleVUnOzHeo99gZES
   L08fGKsV2fESGY7C0sptsb4omhDF/mbonUvhQmYgdJXGMneU4sywAeuky
   A==;
X-CSE-ConnectionGUID: dQ0BNf63RFynR4ifKc4Vng==
X-CSE-MsgGUID: LGziwY2lT2St+og4Id4WEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70158271"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="70158271"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:18:55 -0800
X-CSE-ConnectionGUID: dtscTdSNTGWESIdqmkfSuw==
X-CSE-MsgGUID: FgYPC/z8Qw6Ktlwcx4w5ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="208255170"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.96])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:18:53 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/7] i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
Date: Thu, 29 Jan 2026 20:18:34 +0200
Message-ID: <20260129181841.130864-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Here are patches related to enabling IBI while runtime suspended for Intel
controllers.

Intel LPSS I3C controllers can wake from runtime suspend to receive
in-band interrupts (IBIs).

It is non-trivial to implement because the parent PCI device has 2 I3C bus
instances (MIPI I3C HCI Multi-Bus Instance capability) represented by
platform devices with a separate driver, but the IBI-wakeup is shared by
both, which means runtime PM has to be managed by the parent PCI driver.

To make that work, the PCI driver handles runtime PM, but leverages the
mipi-i3c-hci platform driver's functionality for saving and restoring
controller state.


Adrian Hunter (7):
      i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
      i3c: master: Allow controller drivers to select runtime PM device
      i3c: master: Mark last_busy on IBI when runtime PM is allowed
      i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
      i3c: mipi-i3c-hci: Allow parent to manage runtime PM
      i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
      i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers

 drivers/i3c/master.c                               |  14 +-
 drivers/i3c/master/mipi-i3c-hci/core.c             |  30 ++--
 drivers/i3c/master/mipi-i3c-hci/hci.h              |   7 +
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 158 ++++++++++++++++++++-
 include/linux/i3c/master.h                         |   2 +
 5 files changed, 194 insertions(+), 17 deletions(-)


Regards
Adrian
