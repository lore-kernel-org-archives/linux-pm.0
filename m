From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH] cpupower: Fix build error in cpufreq-info
Date: Mon, 18 Jan 2016 20:44:43 +0530
Message-ID: <1453130083-16055-1-git-send-email-shreyas@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:44226 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939AbcARPP0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2016 10:15:26 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Mon, 18 Jan 2016 08:15:25 -0700
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: trenn@suse.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com, jtanenba@redhat.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>

=46ix the following build error by including limits.h -

utils/cpufreq-info.c: In function =E2=80=98get_latency=E2=80=99:
utils/cpufreq-info.c:437:29: error: =E2=80=98UINT_MAX=E2=80=99 undeclar=
ed (first use in
this function)
  if (!latency || latency =3D=3D UINT_MAX) {
                             ^
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
=46ixes: e98f033f94f3 (cpupower: fix how "cpupower frequency-info" inte=
rprets latency)
---
 tools/power/cpupower/utils/cpufreq-info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cp=
upower/utils/cpufreq-info.c
index 8f3f5bb9c74e..590d12a25f6e 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <limits.h>
=20
 #include <getopt.h>
=20
--=20
1.9.3

