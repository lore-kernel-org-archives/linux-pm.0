From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] Documentation: intel_pstate: Fix typo
Date: Wed, 20 Jun 2018 10:42:07 +0200
Message-ID: <1536315.piAVWLTAmD@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix a typo in the intel_pstate admin-guide documentation.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -410,7 +410,7 @@ argument is passed to the kernel in the
 	That only is supported in some configurations, though (for example, if
 	the `HWP feature is enabled in the processor <Active Mode With HWP_>`_,
 	the operation mode of the driver cannot be changed), and if it is not
-	supported in the current configuration, writes to this attribute with
+	supported in the current configuration, writes to this attribute will
 	fail with an appropriate error.
 
 Interpretation of Policy Attributes
