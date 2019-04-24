Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0170C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 14:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDB421773
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 14:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MABW/1lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfDXOOx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:14:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57700 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfDXOOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 10:14:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3OE8qgA048456;
        Wed, 24 Apr 2019 14:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=rzgN05gODJ01MRz24tgRfnhrJkDAEI1+MrTL7sv+tuk=;
 b=MABW/1lw2q5H4kODcP1sL4f5/y88L3lA7lvKjxi9imKD2krPDIGBUllxJD25YqcQtb7d
 Vp4rmv9JSGKqO0jr0thArrBiB80EUdfQJ2f/bGx1SJ9zeMgXkcUraHbkDLm4N583ClI5
 DF1t0VGEn37Vl/b6Se6WzzOUB51KGVhpln+S9P+xyyPfwzVWVEglLzhg8VuEt4LUIHAJ
 d61URC+lL4PkxfHqbLLsq+AU0GQpWxl1hpdg+ImKWKF+5vrzHONYRm59hHBPPUMnfWtF
 yYGKgEeCmMN98E41Mb7HP8P2flFk04ApEGI1Nan+09h+OXUL3JGFDgP1RDSjrYdJd9H6 3Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2rytut2nnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 14:14:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3OEEjDv145229;
        Wed, 24 Apr 2019 14:14:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2s0dwev8af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 14:14:48 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3OEElbG014358;
        Wed, 24 Apr 2019 14:14:47 GMT
Received: from kadam (/196.111.187.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Apr 2019 07:14:46 -0700
Date:   Wed, 24 Apr 2019 17:14:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Amit Kucheria <amit.kucheria@linaro.org>
Cc:     kbuild-all@01.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [soc-thermal:for-kernelci 19/35]
 drivers/thermal/qcom/tsens-v0_1.c:189 calibrate_8974() warn: passing zero to
 'PTR_ERR'
Message-ID: <20190424141439.GG14820@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904240111
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904240111
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190424141439.RueIa2Ftdd7nqJ58k0fFLQBgm1VgWjp10xaHOiB0V0I@z>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git for-kernelci
head:   0e50a5ee6b8a23c6798aae23efcd4b8e055c06ef
commit: 5853cb769573b58c319fa62e1987d063b8c5b77e [19/35] drivers: thermal: tsens: Merge tsens-8974 into tsens-v0_1

New smatch warnings:
drivers/thermal/qcom/tsens-v0_1.c:228 calibrate_8974() warn: mask and shift to zero

# https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?id=5853cb769573b58c319fa62e1987d063b8c5b77e
git remote add soc-thermal https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
git remote update soc-thermal
git checkout 5853cb769573b58c319fa62e1987d063b8c5b77e
vim +/PTR_ERR +189 drivers/thermal/qcom/tsens-v0_1.c

5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  216  			/* Fall through */
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  217  		case ONE_PT_CALIB:
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  218  		case ONE_PT_CALIB2:
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  219  			base1 = bkp[0] & BASE1_MASK;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  220  			p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  221  			p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  222  			p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  223  			p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  224  			p1[4] = (bkp[1] & S4_P1_MASK);
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  225  			p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  226  			p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  227  			p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20 @228  			p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;
                                                                                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
p1[8] always ends up being zero.  (I haven't look at the code, that's
what the static checker is saying).


5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  229  			p1[9] = (bkp[2] & S9_P1_MASK_BKP) >> S9_P1_BKP_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  230  			p1[10] = (bkp[2] & S10_P1_MASK_BKP) >> S10_P1_BKP_SHIFT;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  231  			break;
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  232  		}
5853cb7695 drivers/thermal/qcom/tsens-v0_1.c Amit Kucheria  2019-03-20  233  	} else {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
