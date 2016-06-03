From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 20/20] x86, powercap, rapl: add Skylake Server model number
Date: Thu, 02 Jun 2016 17:19:55 -0700
Message-ID: <20160603001955.38E1E684@viggo.jf.intel.com>
References: <20160603001927.F2A7D828@viggo.jf.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:52718 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161469AbcFCATz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 2 Jun 2016 20:19:55 -0400
In-Reply-To: <20160603001927.F2A7D828@viggo.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, jacob.jun.pan@intel.com, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, jacob.jun.pan@linux.intel.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

SKX uses similar RAPL interface as Broadwell server according to
Jacob Pan.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net> 
Cc: linux-pm@vger.kernel.org 
---

 b/drivers/powercap/intel_rapl.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/powercap/intel_rapl.c~x86-intel-familites-powercap-rapl-add-skx drivers/powercap/intel_rapl.c
--- a/drivers/powercap/intel_rapl.c~x86-intel-familites-powercap-rapl-add-skx	2016-06-02 15:19:24.097481136 -0700
+++ b/drivers/powercap/intel_rapl.c	2016-06-02 15:19:24.102481364 -0700
@@ -1114,6 +1114,7 @@ static const struct x86_cpu_id rapl_ids[
 
 	RAPL_CPU(INTEL_FAM6_SKYLAKE_DESKTOP,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_SKYLAKE_MOBILE,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_SKYLAKE_X,		rapl_defaults_hsw_server),
 	RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,	rapl_defaults_core),
 
_
