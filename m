From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH] cpupower: Warn if values are truncated in frequency-info
Date: Wed,  9 Nov 2016 10:47:58 +0530
Message-ID: <1478668678-21556-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34271 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751884AbcKIFS0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2016 00:18:26 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA95DWZv126127
        for <linux-pm@vger.kernel.org>; Wed, 9 Nov 2016 00:18:26 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
        by mx0b-001b2d01.pphosted.com with ESMTP id 26kwax916r-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 09 Nov 2016 00:18:25 -0500
Received: from localhost
        by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Wed, 9 Nov 2016 10:48:21 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: trenn@suse.com, rafael.j.wysocki@intel.com, jtanenba@redhat.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

frequency-info currently rounds the frequnecy values to 2 decimal places
while printing "available frequency steps". Hence frequencies with 3rd
decimal place being greater than 5 will be rounded to next higher number
like 2.227GHz will be rounded to 2.23Ghz. On setting this frequency,
using "cpupower frequency-set -f <freq>" ,if the value does not match,
then it will set to the next lowest frequency greater than provided
frequency value (according to the userspace governor).

Hence adding a warning if there are any cases where the displayed
frequency cannot be used directly to set a perticular frequency, and
insist the user to use the "-n" option.

Simple usecase where it give counter intuitive results :
bash# cpupower frequency-info
...
  available frequency steps: 2.43 GHz, 2.39 GHz, 2.36 GHz, 2.33 GHz,
2.29 GHz, 2.26 GHz, 2.23 GHz, 2.19 GHz, 2.16 GHz, 2.13 GHz

bash# cpupower frequency-info -n
...
available frequency steps: 2.427000 GHz, 2.394000 GHz, 2.360000 GHz,
2.327000 GHz, 2.294000 GHz, 2.261000 GHz, 2.227000 GHz, 2.194000 GHz,
2.161000 GHz, 2.128000 GHz

bash# cpupower frequency-set -f 2.23Ghz

bash# cpupower frequency-info
...
 current CPU frequency: 2.26 GHz (asserted by call to hardware)

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 590d12a..4f13b06 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -85,6 +85,7 @@ static void proc_cpufreq_output(void)
 }
 
 static int no_rounding;
+static int freq_info_truncated;
 static void print_speed(unsigned long speed)
 {
 	unsigned long tmp;
@@ -103,8 +104,10 @@ static void print_speed(unsigned long speed)
 	} else {
 		if (speed > 1000000) {
 			tmp = speed%10000;
-			if (tmp >= 5000)
+			if (tmp >= 5000) {
+				freq_info_truncated = 1;
 				speed += 10000;
+			}
 			printf("%u.%02u GHz", ((unsigned int) speed/1000000),
 				((unsigned int) (speed%1000000)/10000));
 		} else if (speed > 100000) {
@@ -243,6 +246,7 @@ static int get_boost_mode(unsigned int cpu)
 			printf(_("    %.0f MHz max turbo 1 active cores\n"),
 			       ratio * bclk);
 	}
+
 	return 0;
 }
 
@@ -641,5 +645,12 @@ int cmd_freq_info(int argc, char **argv)
 			return ret;
 		printf("\n");
 	}
+
+	if (freq_info_truncated) {
+		printf("  Warning! Frequency values shown are rounded off\n");
+		printf("  To set frequency use frequency values provided\n");
+		printf("  by \"cpupower frequency-info -n \"\n");
+	}
+
 	return ret;
 }
-- 
2.5.5

