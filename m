From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH] cpupower tools: Fix error when running cpupower monitor
Date: Mon,  3 Aug 2015 11:46:00 +0530
Message-ID: <1438582560-13352-1-git-send-email-shreyas@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:52033 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbbHCGRF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Aug 2015 02:17:05 -0400
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Mon, 3 Aug 2015 00:17:04 -0600
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, trenn@suse.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavsubra@linux.vnet.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>

get_cpu_topology() tries to get topology info from all cpus by reading
files in the topology sysfs dir. If a cpu is offlined, since it doesn't
have topology dir, this function fails and returns -1. This causes
functions relying on get_cpu_topology() to fail. For example-

$ cpupower monitor
Cannot read number of available processors

Fix this by skipping fetching topology info for offline cpus.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
Reported-by: Pavaman Subramaniyam <pavsubra@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/helpers/topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/cpupower/utils/helpers/topology.c b/tools/power/cpupower/utils/helpers/topology.c
index c13120af519b..cea398c176e7 100644
--- a/tools/power/cpupower/utils/helpers/topology.c
+++ b/tools/power/cpupower/utils/helpers/topology.c
@@ -73,6 +73,8 @@ int get_cpu_topology(struct cpupower_topology *cpu_top)
 	for (cpu = 0; cpu < cpus; cpu++) {
 		cpu_top->core_info[cpu].cpu = cpu;
 		cpu_top->core_info[cpu].is_online = sysfs_is_cpu_online(cpu);
+		if (!cpu_top->core_info[cpu].is_online)
+			continue;
 		if(sysfs_topology_read_file(
 			cpu,
 			"physical_package_id",
-- 
1.9.3

