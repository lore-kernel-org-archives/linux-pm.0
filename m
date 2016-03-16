From: malattia@linux.it
Subject: [PATCH 1/3] =?UTF-8?q?warning:=20comparison=20of=20constant=20?= =?UTF-8?q?=E2=80=98-1=E2=80=99=20with=20boolean=20expression=20is=20alway?= =?UTF-8?q?s=20false?=
Date: Wed, 16 Mar 2016 07:13:06 -0700
Message-ID: <1458137588-6126-2-git-send-email-malattia@linux.it>
References: <1458137588-6126-1-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33386 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966442AbcCPONU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 10:13:20 -0400
Received: by mail-pf0-f181.google.com with SMTP id 124so77056501pfg.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 07:13:20 -0700 (PDT)
In-Reply-To: <1458137588-6126-1-git-send-email-malattia@linux.it>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 tools/power/cpupower/utils/helpers/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/helpers/topology.c b/tools/power/cpupower/utils/helpers/topology.c
index 9cbb7fd..771ec60 100644
--- a/tools/power/cpupower/utils/helpers/topology.c
+++ b/tools/power/cpupower/utils/helpers/topology.c
@@ -106,7 +106,7 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 			cpu_top->pkgs++;
 		}
 	}
-	if (!cpu_top->core_info[0].pkg == -1)
+	if (cpu_top->core_info[0].pkg != -1)
 		cpu_top->pkgs++;
 
 	/* Intel's cores count is not consecutively numbered, there may
-- 
2.7.0

