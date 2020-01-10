Return-Path: <SRS0=bbN6=27=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB43C33CA2
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jan 2020 10:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF78206ED
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jan 2020 10:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="C9kWgr3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgAJKQf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:16:35 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22082 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727364AbgAJKQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 05:16:34 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00AAE9Ns029506;
        Fri, 10 Jan 2020 11:16:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=I+2Jh41DPPQg0BnU2mDecRhoZBPH5KFuDv0ySmlY5mM=;
 b=C9kWgr3JnhtXeBgg64jBh4ZkGIxHXsbcoS0w93qJi4SoOAJAd+WaZsqlFIj6/1v4TpSl
 D7huim9bk+A0nONC1MsMXoKASpTz5Yk/7idwzkbBRWrhTd2NeIyLz/OBOfJoKdQ+lfSh
 4ye2xHMmOZpWPB8nQtRlL48zke3pZ8VApjnNNH4+FzjRuxO5gyf0fG5Ab72qtfys8K70
 sn6JlZzJE9vBo2JBiteyWvGsru7LsZ6sjAJEvFAnubbWgJ6G88Y0ErseyPYbLgCG6lbx
 4saIAHxLe4chevMmleIRgq1AFf2SzMKPenAW3OmAi9WvxFL/oZWARFYehuTIaPAI/4Oh FA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xakkb742b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jan 2020 11:16:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7466B10002A;
        Fri, 10 Jan 2020 11:16:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5C6B52A6197;
        Fri, 10 Jan 2020 11:16:08 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Jan 2020 11:16:07
 +0100
From:   Pascal Paillet <p.paillet@st.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <p.paillet@st.com>, <david.hernandezsanchez@st.com>,
        <horms+renesas@verge.net.au>, <wsa+renesas@sang-engineering.com>,
        <linux-pm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH_V3 0/6] thermal: stm32: driver improvements
Date:   Fri, 10 Jan 2020 11:15:59 +0100
Message-ID: <20200110101605.24984-1-p.paillet@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-10_01:2020-01-10,2020-01-09 signatures=0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The goal of this patchset is to improve and simplify the stm32 thermal
driver:
* let the framework handle the trip points: it very is hard to split this patch
into smaller ones and keep each individual patch functional.
* fix interrupt management to avoid receiving hundreds of
interrupts when the temperature is close to the low threshold.
* improve temperature reading resolution
* the dirver is backawrd compatible.

Pascal Paillet (6):
changes in v2:
* Split "handle multiple trip points" patch to make ones:
*   rework sensor mode management
*   disable interrupts at probe
* "remove hardware irq handler" is squashed in "handle multiple trip points"

  thermal: stm32: fix icifr register name
  thermal: stm32: rework sensor mode management
  thermal: stm32: disable interrupts at probe
  thermal: stm32: handle multiple trip points
  thermal: stm32: improve temperature computing
  thermal: stm32: fix low threshold interrupt flood

 drivers/thermal/st/stm_thermal.c | 388 ++++++++++---------------------
 1 file changed, 120 insertions(+), 268 deletions(-)

-- 
2.17.1

