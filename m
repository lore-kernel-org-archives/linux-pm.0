From: Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH v2] turbostat: Read extended processor family from CPUID
Date: Fri, 27 Jul 2018 07:38:09 -0400
Message-ID: <20180727113809.8427-1-calvin.walton@kepstin.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Calvin Walton <calvin.walton@kepstin.ca>
List-Id: linux-pm@vger.kernel.org

This fixes the reported family on modern AMD processors (e.g. Ryzen,
which is family 0x17). Previously these processors all showed up as
family 0xf.

See the document
https://support.amd.com/TechDocs/56255_OSRR.pdf
section CPUID_Fn00000001_EAX for how to calculate the family
from the BaseFamily and ExtFamily values.

This matches the code in arch/x86/lib/cpu.c

Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
---

I'm still working on updating the RAPL patch on top of the changes for
v4.18, but this CPUID fix doesn't have to wait.

 tools/power/x86/turbostat/turbostat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bd9c6b31a504..8452ace384b3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4031,7 +4031,9 @@ void process_cpuid()
 	family = (fms >> 8) & 0xf;
 	model = (fms >> 4) & 0xf;
 	stepping = fms & 0xf;
-	if (family == 6 || family == 0xf)
+	if (family == 0xf)
+		family += (fms >> 20) & 0xff;
+	if (family == 6 || family >= 0xf)
 		model += ((fms >> 16) & 0xf) << 4;
 
 	if (!quiet) {
-- 
2.18.0
