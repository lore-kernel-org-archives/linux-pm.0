From: Thomas Renninger <trenn@suse.com>
Subject: [PATCH 1/5] cpupower: Fix precedence issue
Date: Tue,  1 Dec 2015 17:14:13 +0100
Message-ID: <1448986457-12844-2-git-send-email-trenn@suse.com>
References: <1448986457-12844-1-git-send-email-trenn@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49840 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574AbbLAQOU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Dec 2015 11:14:20 -0500
In-Reply-To: <1448986457-12844-1-git-send-email-trenn@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>

Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/utils/helpers/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/helpers/topology.c b/tools/power/cpupower/utils/helpers/topology.c
index 9cbb7fd..5f9c908 100644
--- a/tools/power/cpupower/utils/helpers/topology.c
+++ b/tools/power/cpupower/utils/helpers/topology.c
@@ -106,7 +106,7 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 			cpu_top->pkgs++;
 		}
 	}
-	if (!cpu_top->core_info[0].pkg == -1)
+	if (!(cpu_top->core_info[0].pkg == -1))
 		cpu_top->pkgs++;
 
 	/* Intel's cores count is not consecutively numbered, there may
-- 
2.1.4

