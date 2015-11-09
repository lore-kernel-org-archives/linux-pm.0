From: Jacob Tanenbaum <jtanenba@redhat.com>
Subject: [PATCH 2/2] fix how "cpupower frequency-info" interprets latency
Date: Mon,  9 Nov 2015 14:26:59 -0500
Message-ID: <1447097219-31370-3-git-send-email-jtanenba@redhat.com>
References: <1447097219-31370-1-git-send-email-jtanenba@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46967 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbbKIT1F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 14:27:05 -0500
In-Reply-To: <1447097219-31370-1-git-send-email-jtanenba@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: trenn@suse.com, prarit@redhat.com, Jacob Tanenbaum <jtanenba@redhat.com>

the intel-pstate driver does not support the ondemand governor and does not
have a valid value in
/sys/devices/system/cpu/cpu[x]/cpufreq/cpuinfo_transition_latency. The
intel-pstate driver sets cpuinfo_transition_latency to CPUFREQ_ETERNAL (-1),
the value written into cpuinfo_transition_latency is defind as an unsigned
int so checking the read value against max unsigned int will determine if the
value is valid.

output before the patch set is applied
[jtanenba@dhcp-17-90 cpupower]$ ./cpupower frequency-info -d
analyzing CPU 0:
intel_pstate
[jtanenba@dhcp-17-90 cpupower]$ ./cpupower frequency-info -y
analyzing CPU 0:
4294967295
[jtanenba@dhcp-17-90 cpupower]$ ./cpupower frequency-info -y -m
analyzing CPU 0:
0.97 ms

output after patch set is applied
[jtanenba@dhcp-17-90 cpupower]$ ./cpupower frequency-info -d
analyzing CPU 0:
  driver: intel_pstate
[jtanenba@dhcp-17-90 cpupower]$ ./cpupower frequency-info -y
analyzing CPU 0:
  maximum transition latency:  Cannot determine or is not supported.
[jtanenba@dhcp-17-90 cpupower]$ ./cpupower frequency-info -y -m
analyzing CPU 0:
  maximum transition latency:  Cannot determine or is not supported.

Signed-off-by: Jacob Tanenbaum <jtanenba@redhat.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 8f40b79..a6efb6a 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -433,8 +433,8 @@ static int get_latency(unsigned int cpu, unsigned int human)
 	unsigned long latency = cpufreq_get_transition_latency(cpu);
 
 	printf(_("  maximum transition latency: "));
-	if (!latency) {
-		printf(_(" Cannot determine latency.\n"));
+	if (!latency || latency == UINT_MAX) {
+		printf(_(" Cannot determine or is not supported.\n"));
 		return -EINVAL;
 	}
 
-- 
2.4.3

