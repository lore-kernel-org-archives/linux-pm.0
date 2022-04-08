Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE5DC433FE
	for <linux-pm@archiver.kernel.org>; Fri,  8 Apr 2022 03:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiDHD5S (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 7 Apr 2022 23:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiDHD5Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2022 23:57:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588ABCEE30;
        Thu,  7 Apr 2022 20:55:10 -0700 (PDT)
X-UUID: 262dc70b01fc411286516e30d5904859-20220408
X-UUID: 262dc70b01fc411286516e30d5904859-20220408
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1024826225; Fri, 08 Apr 2022 11:55:05 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 8 Apr 2022 11:55:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Apr
 2022 11:55:03 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 11:55:03 +0800
Message-ID: <a48c74e447c233799a497702fe90cfa126eb952a.camel@mediatek.com>
Subject: Re: [PATCH 0/4] cpufreq: mediatek: introduce mtk cpufreq
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Tim Chang <jia-wei.chang@mediatek.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>
Date:   Fri, 8 Apr 2022 11:55:03 +0800
In-Reply-To: <20220308043615.uamxqylo3mvw4rhs@vireshk-i7>
References: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
         <20220308043615.uamxqylo3mvw4rhs@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2022-03-08 at 10:06 +0530, Viresh Kumar wrote:
> On 07-03-22, 20:21, Tim Chang wrote:
> > CPUFREQ is DVFS driver used for power saving by scaling clock
> > frequency
> > and supply voltage of CPUs. This module cooperates with CCI DEVFREQ
> > for
> > certain Mediatek SoCs.
> 
> Both subject and this log talks as if you are adding a new cpufreq
> driver, while what you are doing is just cleanup mostly. This isn't
> how it should be done.
> 
> You need to be very explicit with what you are doing and make that
> change in a separate patch. The cover letter should tell what you are
> doing and why.
> 

Hello Viresh,

Thanks for your suggestion.
Indeed, the subject is not proper for this series.
I will help to upstream next version and fix the issue because of
resource issues.

Thanks.

BRs,
Rex

