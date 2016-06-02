From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 20/20] x86, powercap, rapl: add Skylake Server model number
Date: Wed, 01 Jun 2016 17:12:25 -0700
Message-ID: <20160602001225.6F281D8E@viggo.jf.intel.com>
References: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, jacob.jun.pan@linux.intel.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


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
--- a/drivers/powercap/intel_rapl.c~x86-intel-familites-powercap-rapl-add-skx	2016-06-01 15:45:11.070258232 -0700
+++ b/drivers/powercap/intel_rapl.c	2016-06-01 15:45:11.075258460 -0700
@@ -1114,6 +1114,7 @@ static const struct x86_cpu_id rapl_ids[
 
 	RAPL_CPU(INTEL_FAM6_MODEL_SKYLAKE_DESKTOP,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_MODEL_SKYLAKE_MOBILE,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_MODEL_SKYLAKE_X,		rapl_defaults_hsw_server),
 	RAPL_CPU(INTEL_FAM6_MODEL_KABYLAKE_MOBILE,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_MODEL_KABYLAKE_DESKTOP,	rapl_defaults_core),
 
_
