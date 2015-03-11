From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: [PATCH] Revert "cpupower Makefile change to help run the tool
 without 'make install'"
Date: Tue, 10 Mar 2015 20:26:36 -0400
Message-ID: <20150311002635.GC8393@hansolo.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60998 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbbCKA2A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 10 Mar 2015 20:28:00 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Renninger <trenn@suse.de>, "sriram@marirs.net.in" <sriram@marirs.net.in>, Linux PM list <linux-pm@vger.kernel.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

This reverts commit 5c1de006e8e66b0be05be422416629e344c71652.

While the original commit makes it easier to run cpupower from the local build
directory, it also leaves the binary with a rather poor rpath of './' in it
after it is installed on a system via 'make install'.

This is considered bad practice and can cause cpupower to fail in rpmbuild
with the following error:

ERROR   0004: file '/usr/bin/cpupower' contains an insecure rpath './' in [./]
error: Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)
    Bad exit status from /var/tmp/rpm-tmp.A6u26r (%install)

Developers should be able to use LD_LIBRARY_PATH to achieve the same effect
and not introduce rpath into the binary.

Signed-off-by: Josh Boyer <jwboyer@feoraproject.org>
---
 tools/power/cpupower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 3ed7c0476d48..2e2ba2efa0d9 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -209,7 +209,7 @@ $(OUTPUT)%.o: %.c
 
 $(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)libcpupower.so.$(LIB_MAJ)
 	$(ECHO) "  CC      " $@
-	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lcpupower -Wl,-rpath=./ -lrt -lpci -L$(OUTPUT) -o $@
+	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lcpupower -lrt -lpci -L$(OUTPUT) -o $@
 	$(QUIET) $(STRIPCMD) $@
 
 $(OUTPUT)po/$(PACKAGE).pot: $(UTIL_SRC)
-- 
2.1.0

