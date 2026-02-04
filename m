Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7FA36EABB;
	Wed,  4 Feb 2026 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203722; cv=none; b=H+euSNr/sTwqgz3muXVB9hcXwPS3+jm4/W6ihptV1EF8buQ41R57TocxFveG109cVrowtM+N4ZpKmvpQ+qcmzGZg8hX6Nzg+vEpSXaX9mCkNy16sDJGjCr/3SSTwQ13bLiHgXfMK/ctHl4xFcaqlD8ql1837uOyknehSkusILM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203722; c=relaxed/simple;
	bh=JiZ/8/1B53sXpMXRHgNEYOv16nTOw7GQIOE1NQHCNxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHasBhFxJ2tHX0KmyqVTwbrLqbCym1w9K4HSu5pSdU2Y2DMxC7OJvk7S58oNUrMm97O+0FBwCW878C9PyPe2ucgltX41A8/80qs4AKgv2SYZBl8a9O0yrKkEBEElR6f7dsKjhBL2Typ/ROKPDeA2MxQrJfXaohPgKyoZt9u53pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqKBvUv7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqKBvUv7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770203723; x=1801739723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JiZ/8/1B53sXpMXRHgNEYOv16nTOw7GQIOE1NQHCNxs=;
  b=ZqKBvUv7EYbgrXoO/fckN3B3mEOOjL7KvzRVAEAZ/MjmSDiNn9fpoFH8
   rxQVVUqGSR0ZOpVRo2LjyvFoTINDG2kWrM8N4N471DMYoPhudmGuSS0D7
   B2IqpRAvBleLQE+vp4iqDOMh7tqNmz76cIZthKYd6j0FaC2Dxg9DN3x3n
   03d8pg1MKuNXA8lOsMfElPFfXVSZXoQuYU5NMNjdObLuG2NQFbuWtUdht
   KskektMKvALMm7uU0mdmRQPUsPDythRjlGBsIt5VFE/TjRUAvBPPZrVaM
   yPU87k8iM009vKUuRTUTZnopXQsm4BPYYxro22yUyogf39ntHWt9xw64a
   A==;
X-CSE-ConnectionGUID: uHWNIxXGQ4iQRO7hXuohOg==
X-CSE-MsgGUID: 4P4Pq49uTZSEZJM4vbTb3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70406037"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="70406037"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 03:15:22 -0800
X-CSE-ConnectionGUID: Mf7uEao5Q8ORbfZbTiJlsQ==
X-CSE-MsgGUID: EllE/dtDTBCmTJoTe5fotA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209739270"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.181])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 03:15:20 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	rafael@kernel.org,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 0/6] i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
Date: Wed,  4 Feb 2026 13:15:05 +0200
Message-ID: <20260204111511.78626-1-adrian.hunter@intel.com>
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

Changes in V2:

    i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
	Add Frank's Rev'd-by

    i3c: master: Allow controller drivers to select runtime PM device
	Patch dropped

    i3c: master: Mark last_busy on IBI when runtime PM is allowed
	Adjusted slightly for earlier changes

    i3c: mipi-i3c-hci: Allow parent to manage runtime PM
	For HCI_QUIRK_RPM_PARENT_MANAGED case, change from
	disabling runtime PM to instead causing the runtime PM
	callbacks to do nothing

    i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
	Do not enable autosuspend.
	Callbacks for parent-managed invocation were renamed
	from i3c_hci_runtime_suspend to i3c_hci_rpm_suspend and
	from i3c_hci_runtime_resume to i3c_hci_rpm_resume.
	Amend commit message slightly.

    i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
	Retain HCI_QUIRK_RPM_ALLOWED
	Amend commit message accordingly


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


Adrian Hunter (6):
      i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
      i3c: master: Mark last_busy on IBI when runtime PM is allowed
      i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
      i3c: mipi-i3c-hci: Allow parent to manage runtime PM
      i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
      i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers

 drivers/i3c/master.c                               |   5 +
 drivers/i3c/master/mipi-i3c-hci/core.c             |  35 +++++-
 drivers/i3c/master/mipi-i3c-hci/hci.h              |   7 ++
 drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c | 138 +++++++++++++++++++++
 4 files changed, 180 insertions(+), 5 deletions(-)

Regards
Adrian
