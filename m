From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/7] tools: Allow tools to be installed in a user specified location
Date: Wed, 14 Nov 2012 15:43:22 -0500
Message-ID: <b63cb742e185caf39cc0238d151076a6d06832c5.1352925508.git.len.brown@intel.com>
References: <1352925804-6746-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352925804-6746-1-git-send-email-lenb@kernel.org>
In-Reply-To: <39300ffb9b6666714c60735cf854e1280e4e75f4.1352925508.git.len.brown@intel.com>
References: <39300ffb9b6666714c60735cf854e1280e4e75f4.1352925508.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Josh Boyer <jwboyer@redhat.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Josh Boyer <jwboyer@redhat.com>

When building x86_energy_perf_policy or turbostat within the confines of
a packaging system such as RPM, we need to be able to have it install to
the buildroot and not the root filesystem of the build machine.  This
adds a DESTDIR variable that when set will act as a prefix for the
install location of these tools.

Signed-off-by: Josh Boyer <jwboyer@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/Makefile              | 6 ++++--
 tools/power/x86/x86_energy_perf_policy/Makefile | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
index 51880e8..e79f794 100644
--- a/tools/power/x86/turbostat/Makefile
+++ b/tools/power/x86/turbostat/Makefile
@@ -1,3 +1,5 @@
+DESTDIR ?=
+
 turbostat : turbostat.c
 CFLAGS +=	-Wall
 CFLAGS +=	-I../../../../arch/x86/include/
@@ -6,5 +8,5 @@ clean :
 	rm -f turbostat
 
 install :
-	install turbostat /usr/bin/turbostat
-	install turbostat.8 /usr/share/man/man8
+	install turbostat ${DESTDIR}/usr/bin/turbostat
+	install turbostat.8 ${DESTDIR}/usr/share/man/man8
diff --git a/tools/power/x86/x86_energy_perf_policy/Makefile b/tools/power/x86/x86_energy_perf_policy/Makefile
index f458237..971c9ff 100644
--- a/tools/power/x86/x86_energy_perf_policy/Makefile
+++ b/tools/power/x86/x86_energy_perf_policy/Makefile
@@ -1,8 +1,10 @@
+DESTDIR ?=
+
 x86_energy_perf_policy : x86_energy_perf_policy.c
 
 clean :
 	rm -f x86_energy_perf_policy
 
 install :
-	install x86_energy_perf_policy /usr/bin/
-	install x86_energy_perf_policy.8 /usr/share/man/man8/
+	install x86_energy_perf_policy ${DESTDIR}/usr/bin/
+	install x86_energy_perf_policy.8 ${DESTDIR}/usr/share/man/man8/
-- 
1.8.0
