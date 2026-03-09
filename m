Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFED344056;
	Mon,  9 Mar 2026 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094840; cv=none; b=q3mL6jIrplQBFYXVS5//ffmsNgcL2VJ9pw2Vda3AXhT9zqoNd5TeYmQdpHmrF+ooI/h3twfu5TiLmVxXAurBYdYkZ1x3ODzG1UCOLoB9AbXxIBXqQabB7RMeXT+KZ/cfmvU37qq5ewX15SqHPlXks8DeY3ZGPo2ndbzE3fsTaL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094840; c=relaxed/simple;
	bh=EDdGFDPMjPJeXpzZfHj7rGFIrb+heEvPRYiArFUSnm8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mu+5p6bHQ704HqfzoKLMEhUmXep9WHNljyrjsfY+f4JVo7NAeAcxSd+ODc1hPapseI4mJ+rtpTA9M8caLak6XFkEyQMYDRzE2bJ9Y4cN7owS5pW+CbUO74e0J+LtUPHF/ibpb5nQGuVW9T+U6IvDJFWw8RdEMZcFED/xIIjY3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWHsPSC6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWHsPSC6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773094838; x=1804630838;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=EDdGFDPMjPJeXpzZfHj7rGFIrb+heEvPRYiArFUSnm8=;
  b=YWHsPSC6ONCHndtan82t515Q/DjopyWzaY80WnHdj/Z6f83Uo3fBbZRe
   awIs/C/fA9jf+iHLEUWXlau/eZMu38gb4S+oMIBye6TCPhI8tzdzF6ewN
   H9XeMTDlz9yjLwaEV/P2g+cmw0ly9loMHOlYCYeamZjvNoejfWd6f7J6b
   X4pTCRqGRU/8vYNZNRpRnZ/XMWWOZOTEdtH40GWSF653kozyf71Cuuwcl
   0D5M5jVg72i4NLjT0UaISN96ETRFhM2tFkx+l8qE7I2pC/wBaQR0kQlK0
   8r3byA3txiJXE9ytnHjtssTyaE53d6IPF+pTUsEVQlFWRfHjaCaJqYd5C
   w==;
X-CSE-ConnectionGUID: iia1f+zoRzCscGmurUb71w==
X-CSE-MsgGUID: NHO/JQAdShiPusBwdzh6XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74050651"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="74050651"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:20:37 -0700
X-CSE-ConnectionGUID: GljfEYSwTqi30ch+iHAbmA==
X-CSE-MsgGUID: jYPkrT+GRDamvD1FAaQUpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="224004282"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 15:20:37 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/4] thermal: intel: Add support for Directed Package
 Thermal Interrupts
Date: Mon, 09 Mar 2026 15:19:23 -0700
Message-Id: <20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGxHr2kC/x2MMQqAMAwAvyKZDVQLon5FHKxNbQarpEUE8e8Gb
 7vh7oFMwpRhrB4QujjzkVSauoI1LmkjZK8OrWk7Y02HkjRAz0JrIY8lkuzIqQgOwYZecc4G0P4
 UCnz/72l+3w9YCAltawAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773094782; l=2119;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=EDdGFDPMjPJeXpzZfHj7rGFIrb+heEvPRYiArFUSnm8=;
 b=buTowQ3HMsPl9JM5rOsSC1/t//wI9u2j/j0C+I6SE9sOS1ReBwg5IzgpsYnp1BrYStIwI4fL4
 0o584gKiVDWCHwVc3uHVZzzWOP7eP26LVQuYSJi/GQvs7HO3QRkwBzY
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Hi,

Package-level thermal interrupts are currently broadcast to all CPUs in a
package. Only one CPU is needed to service package-wide events. Moreover,
broadcasting may create resource contention. An example of this are thermal
interrupts posted for Hardware Feedback Interface[1] updates: all CPUs in
the package receive the interrupt and then race to grab a lock to update a
data structure common to all CPUs. Idle CPUs were needlessly woken up.

Newer Intel processors allow directing package-level thermal interrupts
only to CPUs that explicitly request them. A CPU opts in by setting bit 25
in IA32_THERM_INTERRUPT. Hardware acknowledges the request by setting bit 25
in IA32_PACKAGE_THERM_STATUS.

This series enables directed package thermal interrupts and designates one
handler CPU per package using the CPU hotplug infrastructure. A new CPU is
selected if the handler CPU goes offline.

Because CPU0's hotplug callbacks are not invoked during suspend and resume,
syscore callbacks are added to restore the handler for the boot package.
The series also disables directed delivery during kexec reboot, avoiding
stale interrupt routing when rebooting into a kernel that does not support
the feature.

[1]. Intel Software Developer's Manual Vol. 3, Section 17.6, Feb 2026

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Ricardo Neri (4):
      x86/thermal: Add bit definitions for Intel Directed Package Thermal Interrupt
      thermal: intel: Enable Directed Package-level Thermal Interrupts
      thermal: intel: Add syscore callbacks for suspend and resume
      thermal: intel: Add a syscore shutdown callback for kexec reboot

 arch/x86/include/asm/cpufeatures.h  |   1 +
 arch/x86/include/asm/msr-index.h    |   2 +
 drivers/thermal/intel/therm_throt.c | 223 +++++++++++++++++++++++++++++++++++-
 3 files changed, 225 insertions(+), 1 deletion(-)
---
base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681
change-id: 20260306-rneri-directed-therm-intr-9f3f8888bb3f

Best regards,
-- 
Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

