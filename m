From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v5 0/3] PM: Intel PowerClamp driver
Date: Thu,  3 Jan 2013 07:10:01 -0800
Message-ID: <1357225804-27191-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41404 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986Ab3ACXKS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Jan 2013 18:10:18 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Zhang Rui <rui.zhang@intel.com>, Rob Landley <rob@landley.net>, Arjan van de Ven <arjan@linux.intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Joe Perches <joe@perches.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

v5 changes:
- use bool for clamping flag.
- removed duplicated #define MSR_PKG_Cx_RESIDENCY
- adjust window_size range test to match comments, which is between
  2 and 10.

We have done some experiment with idle injection on Intel platforms.
The idea is to use the increasingly power efficient package level
C-states for power capping and passive thermal control.

Documentation is included in the patch to explain the theory of
operation, performance implication, calibration, scalability, and user
interface. Please refer to the following file for more details.

Documentation/thermal/intel_powerclamp.txt

Arjan van de Ven created the original idea and driver, I have been
refining driver in hope that they can be to be useful beyond a proof
of concept.


Jacob Pan (3):
  tick: export nohz tick idle symbols for module use
  x86/nmi: export local_touch_nmi() symbol for modules
  PM: Introduce Intel PowerClamp Driver

 Documentation/thermal/intel_powerclamp.txt |  307 +++++++++++
 arch/x86/kernel/nmi.c                      |    1 +
 drivers/thermal/Kconfig                    |   10 +
 drivers/thermal/Makefile                   |    2 +
 drivers/thermal/intel_powerclamp.c         |  758 ++++++++++++++++++++++++++++
 kernel/time/tick-sched.c                   |    2 +
 6 files changed, 1080 insertions(+)
 create mode 100644 Documentation/thermal/intel_powerclamp.txt
 create mode 100644 drivers/thermal/intel_powerclamp.c

-- 
1.7.9.5

