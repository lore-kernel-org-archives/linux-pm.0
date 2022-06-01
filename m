Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DCBC433EF
	for <linux-pm@archiver.kernel.org>; Wed,  1 Jun 2022 13:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiFANO2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 1 Jun 2022 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351588AbiFANOZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jun 2022 09:14:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C1D3CA4B;
        Wed,  1 Jun 2022 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654089263; x=1685625263;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=dqVezMSCCdxjIXBoNBJGF1g26ZpD3xFCE0ZdxtLFCk4=;
  b=jwmjyWHb/BiAVsNLJavNJZORLtzmPbR5vNIJYtRMC3P2iWiRc50j6LHw
   FHwWjMLjHmujE7JD1MuPdaKPbEbggDTAiUgjDbwyzik2Ft7LhbGaN6SE1
   Ym1ibSC9Et1q25CjiVDigow1IRbISrvxALMPW3gnAbtaFPPqwFKwnE+VQ
   g=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Jun 2022 06:14:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 06:14:23 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 06:14:23 -0700
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 06:14:20 -0700
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
Subject: [PATCH 0/1] drivers/thermal/thermal_of: Add critical/hot ops support for thermal_of sensor
Date:   Wed, 1 Jun 2022 18:43:59 +0530
Message-ID: <20220601131400.24627-1-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for critical and hot trip violation notification ops in
thermal_of interface.

Manaf Meethalavalappu Pallikunhi (1):
  drivers/thermal/thermal_of: Add critical/hot ops support for
    thermal_of sensor

 drivers/thermal/thermal_of.c | 21 +++++++++++++++++++++
 include/linux/thermal.h      |  6 ++++++
 2 files changed, 27 insertions(+)

base-commit: 268db333b561c77dee3feb6831806412293b4a7e
