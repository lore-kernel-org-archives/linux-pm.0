From: Todd E Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH] export suspend_resume trace event
Date: Fri, 12 Dec 2014 20:06:46 -0800
Message-ID: <20141213040646.GA22352@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5239 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965023AbaLMEHH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Dec 2014 23:07:07 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, rafael.j.wysocki@intel.com, todd.e.brandt@intel.com

Export the suspend_resume tracepoint so it can be used
in loadable modules.

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
----
 kernel/trace/power-traces.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index 1c71382..eb4220a 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -13,5 +13,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/power.h>
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(suspend_resume);
 EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
 
