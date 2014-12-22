From: sriram@marirs.net.in
Subject: [PATCH] cpupower Makefile change
Date: Mon, 22 Dec 2014 22:17:37 +0530
Message-ID: <1419266857.3837604.205784097.7B0DB495@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57811 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754939AbaLVQrj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Dec 2014 11:47:39 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 5E80520B83
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2014 11:47:38 -0500 (EST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, trenn@suse.de

The cpupower tool, when compiled against libcpupower.so fail's to run as
the linker file path's are missing during compilation. So added changes
in the Makefile to run cpupower tool, which helps us run the tool
without doing a 'make install'. 


Signed-off-by: Sriram Raghunathan <sriram@marirs.net.in>
---
 tools/power/cpupower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile
b/tools/power/cpupower/Makefile
index 2e2ba2e..3ed7c04 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -209,7 +209,7 @@ $(OUTPUT)%.o: %.c
 
 $(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)libcpupower.so.$(LIB_MAJ)
 	$(ECHO) "  CC      " $@
-       $(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lcpupower -lrt
-lpci -L$(OUTPUT) -o $@
+       $(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lcpupower
-Wl,-rpath=./ -lrt -lpci -L$(OUTPUT) -o $@
 	$(QUIET) $(STRIPCMD) $@
 
 $(OUTPUT)po/$(PACKAGE).pot: $(UTIL_SRC)
-- 
1.8.3.2

