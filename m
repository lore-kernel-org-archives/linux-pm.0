From: "Zhang, Lin-Bao (Linux Kernel R&D)" <linbao.zhang@hpe.com>
Subject: [PATCH v1 0/2] fix the defect that pcc-cpufreq's pcc_get_freq()
 sometimes can't get correct CPU frequency
Date: Mon, 16 Nov 2015 10:35:38 +0000
Message-ID: <92645B27BF79D04FBD2B0F8494FFD0F9199B5FA6@G2W2527.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:3432 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbbKPKf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 05:35:59 -0500
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Summary :

These 2 patches are developed for drivers/cpufreq/pcc-cpufreq.c's pcc_get_freq() function.
The pcc-cpufreq driver's function pcc_get_freq() sometimes returns invalid frequency information. 
Without the these 2 patches , it can be reproduced on booting Linux Kernel with loading pcc-cpufreq.ko and loop unloading/loading pcc-cpufreq.ko.
This problem has been reported on ProLiant systems, primarily 4-socket systems, for example DL580Gen8.

Generally speaking, as PCC spec,patch 1 can ideally ensure to get correct cpu freqency if FW works well. 
if it fails, patch 2 can be run to retry 2 times to get cpu freq as workaround. 

These 2 patches are written by HP's greg.pearson@hpe.com , enhanced/verified by Linbao.zhang@hpe.com

PATCH 1/2:
in Processor Clocking Control specification v1.0 ,there are 2 limitations :
2.1.8 Minimum Time Between Commands
2.1.9 Maximum Time Between Commands
that means 2 commands' interval should be located between Minimum Time Between Commands and Maximum 

Time Between Commands.
this patch implements this feature,while old pcc-cpufreq.c didn't strictly follow the spec.
ideally , this patch ensure pcc_get_freq() return valid freq based on the fact FW is working well.

PATCH 2/2:
if pcc_get_freq() returns 0, we will retry 2 times at most. This is a workaround patch, although it is 100% perfect.This works around a firmware/timing issue. In very rare case , it also will fail after retrying 2 times due to firmware issue. Based on current pcc cpufreq design , this workaround would be the best solution by confirmation with FW guys. patch 2 has been adoted by sles11sp4.

Detailed testing data can be found as following : 

our testing result on DL580Gen8 with upstream kernel:
a) loop unloading/loading pcc driver within 14 hours , pcc_get_freq() always succeed , the patch always succeeded, don't need the second patch to workaround
b) loop rebooting DL580Gen8 with git kernel: by writting a shell script, found about rebooting 200+ times, patch 1 and patch 2 may both failed once, means pcc_get_freq() returns 0 frequency,although its possibility is very very low. 
pcc_get_freq() doesn't affect pcc-cpufreq driver loading ,because they are running different path. 
in this loop rebooting test , pcc-cpufreq can always be loaded successfully.

We can say ,patch 1 and patch 2 would be the best solution for this issue.

Zhang Lin-Bao (2):
  enforce max/min time between commands
  retry 2 times when getting cpu frequency is zero

 drivers/cpufreq/pcc-cpufreq.c | 51 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

--
1.8.5.2


