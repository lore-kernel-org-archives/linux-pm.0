From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2] tools/power turbostat: bugfix: fix several invalid parameters
Date: Sun, 13 Dec 2015 21:09:49 +0800
Message-ID: <b7a8feb0effba7b59ea55288fd1b3dc0ecbfbd66.1450011064.git.yu.c.chen@intel.com>
References: <cover.1450011064.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45969 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbbLMNE7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 13 Dec 2015 08:04:59 -0500
In-Reply-To: <cover.1450011064.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: len.brown@intel.com
Cc: rjw@rjwysocki.net, srinivas.pandruvada@intel.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

dump_cstate_pstate_config_info is invoked with no parameters,
which might cause this function to misjudge the processor family
and model. Fix this by passing family and model to it.

Besides, fix the compiling warning caused by missing type declaration
in dump_cstate_pstate_config_info, get_tdp and perf_limit_reasons_probe=
:

turbostat.c: In function =E2=80=98dump_cstate_pstate_config_info=E2=80=99=
:
turbostat.c:1973:1: warning: type of =E2=80=98family=E2=80=99 defaults =
to =E2=80=98int=E2=80=99 [-Wimplicit-int]
 dump_cstate_pstate_config_info(family, model)
 ^
turbostat.c:1973:1: warning: type of =E2=80=98model=E2=80=99 defaults t=
o =E2=80=98int=E2=80=99 [-Wimplicit-int]
turbostat.c: In function =E2=80=98get_tdp=E2=80=99:
turbostat.c:2145:8: warning: type of =E2=80=98model=E2=80=99 defaults t=
o =E2=80=98int=E2=80=99 [-Wimplicit-int]
 double get_tdp(model)
        ^
turbostat.c: In function =E2=80=98perf_limit_reasons_probe=E2=80=99:
turbostat.c:2259:6: warning: type of =E2=80=98family=E2=80=99 defaults =
to =E2=80=98int=E2=80=99 [-Wimplicit-int]
 void perf_limit_reasons_probe(family, model)
      ^
turbostat.c:2259:6: warning: type of =E2=80=98model=E2=80=99 defaults t=
o =E2=80=98int=E2=80=99 [-Wimplicit-int]

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/tu=
rbostat/turbostat.c
index 9854929..47068de 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1970,7 +1970,7 @@ int has_config_tdp(unsigned int family, unsigned =
int model)
 }
=20
 static void
-dump_cstate_pstate_config_info(family, model)
+dump_cstate_pstate_config_info(unsigned int family, unsigned int model=
)
 {
 	if (!do_nhm_platform_info)
 		return;
@@ -2142,7 +2142,7 @@ int print_perf_limit(struct thread_data *t, struc=
t core_data *c, struct pkg_data
 #define	RAPL_POWER_GRANULARITY	0x7FFF	/* 15 bit power granularity */
 #define	RAPL_TIME_GRANULARITY	0x3F /* 6 bit time granularity */
=20
-double get_tdp(model)
+double get_tdp(unsigned int model)
 {
 	unsigned long long msr;
=20
@@ -2256,7 +2256,7 @@ void rapl_probe(unsigned int family, unsigned int=
 model)
 	return;
 }
=20
-void perf_limit_reasons_probe(family, model)
+void perf_limit_reasons_probe(unsigned int family, unsigned int model)
 {
 	if (!genuine_intel)
 		return;
@@ -2792,7 +2792,7 @@ void process_cpuid()
 	perf_limit_reasons_probe(family, model);
=20
 	if (debug)
-		dump_cstate_pstate_config_info();
+		dump_cstate_pstate_config_info(family, model);
=20
 	if (has_skl_msrs(family, model))
 		calculate_tsc_tweak();
--=20
1.8.4.2

