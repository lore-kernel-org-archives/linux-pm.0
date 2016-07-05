From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] thermal: qcom: tsens-8974: Add support for 8974 family
 of SoCs
Date: Tue, 5 Jul 2016 19:46:57 +0300
Message-ID: <20160705164657.GA1379@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:46651 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbcGEQrs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2016 12:47:48 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rnayak@codeaurora.org
Cc: linux-pm@vger.kernel.org

Hello Rajendra Nayak,

The patch ffd6a56b9a88: "thermal: qcom: tsens-8974: Add support for
8974 family of SoCs" from May 5, 2016, leads to the following static
checker warning:

	drivers/thermal/qcom/tsens-8974.c:152 calibrate_8974()
	warn: mask and shift to zero

drivers/thermal/qcom/tsens-8974.c
  141                  case ONE_PT_CALIB:
   142                  case ONE_PT_CALIB2:
   143                          base1 = bkp[0] & BASE1_MASK;
   144                          p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
   145                          p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
   146                          p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
   147                          p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
   148                          p1[4] = (bkp[1] & S4_P1_MASK);
   149                          p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
   150                          p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
   151                          p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
   152                          p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;

0x3f >> 24 is zero.  This looks like a cut-and-paste bug but it's not
clear to me what was intended.

   153                          p1[9] = (bkp[2] & S9_P1_MASK_BKP) >> S9_P1_BKP_SHIFT;
   154                          p1[10] = (bkp[2] & S10_P1_MASK_BKP) >> S10_P1_BKP_SHIFT;
   155                          break;
   156                  }

regards,
dan carpenter
