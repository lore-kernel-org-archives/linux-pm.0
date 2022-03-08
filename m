Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61021C433FE
	for <linux-pm@archiver.kernel.org>; Tue,  8 Mar 2022 05:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245188AbiCHFhy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 8 Mar 2022 00:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245261AbiCHFhq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2022 00:37:46 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF693BA53;
        Mon,  7 Mar 2022 21:36:46 -0800 (PST)
X-UUID: 590c72de5e204734b02e6b7b267bab2d-20220308
X-UUID: 590c72de5e204734b02e6b7b267bab2d-20220308
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1641817070; Tue, 08 Mar 2022 13:36:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 8 Mar 2022 13:36:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 13:36:25 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <linmq006@gmail.com>
CC:     <amitk@kernel.org>, <daniel.lezcano@linaro.org>,
        <henry.yen@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <rafael@kernel.org>,
        <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: mediatek: Fix some leaks in mtk_thermal_probe
Date:   Tue, 8 Mar 2022 13:36:25 +0800
Message-ID: <20220308053625.21359-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220307113438.21338-1-linmq006@gmail.com>
References: <20220307113438.21338-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Miaoqian,

> If an error occurs after a successful 'of_iomap()' call, it must be undone
> by a corresponding 'iounmap()' call
> 
> Fixes: 89945047b166 ("thermal: mediatek: Add tsensor support for V2 thermal system")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>

Thanks for fixing this.

Reviewed-by: Miles Chen <miles.chen@mediatek.com>


Thanks,
Miles
