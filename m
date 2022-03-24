Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09BAC433EF
	for <linux-pm@archiver.kernel.org>; Thu, 24 Mar 2022 12:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350033AbiCXMVK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350104AbiCXMUv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2022 08:20:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E765A381AF;
        Thu, 24 Mar 2022 05:19:10 -0700 (PDT)
X-UUID: 6258cb461a494012984001847761f29c-20220324
X-UUID: 6258cb461a494012984001847761f29c-20220324
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1483301356; Thu, 24 Mar 2022 20:19:06 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 24 Mar 2022 20:19:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Mar
 2022 20:19:04 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 20:19:04 +0800
Message-ID: <77fe195475c67b092a0bd8b6b6515ee64938ea4f.camel@mediatek.com>
Subject: Re: [PATCH 3/3] devfreq: mediatek: add platform data to support
 mt8186
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.corp-partner.google.com>
Date:   Thu, 24 Mar 2022 20:19:04 +0800
In-Reply-To: <7f99b453-5510-d7f2-3d9b-b3ac3415fa62@canonical.com>
References: <20220307122513.11822-1-jia-wei.chang@mediatek.com>
         <20220307122513.11822-4-jia-wei.chang@mediatek.com>
         <7f99b453-5510-d7f2-3d9b-b3ac3415fa62@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2022-03-07 at 22:52 +0100, Krzysztof Kozlowski wrote:
> On 07/03/2022 13:25, Tim Chang wrote:
> > add specific platform data to support mt8186.
> > 
> 
> You just added this driver in patch 2. No need to split such actions
> because this is initial submission, so it can support two devices.
> Squash with previous.

Sure, I will squash this commit with previous one.

> 
> Best regards,
> Krzysztof

