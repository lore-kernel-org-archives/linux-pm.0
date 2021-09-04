Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1032BC433F5
	for <linux-pm@archiver.kernel.org>; Sat,  4 Sep 2021 11:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF9660231
	for <linux-pm@archiver.kernel.org>; Sat,  4 Sep 2021 11:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351517AbhIDLGR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 4 Sep 2021 07:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351516AbhIDLGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Sep 2021 07:06:16 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC2C061575
        for <linux-pm@vger.kernel.org>; Sat,  4 Sep 2021 04:05:15 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 787DF1F73A;
        Sat,  4 Sep 2021 13:05:12 +0200 (CEST)
Date:   Sat, 4 Sep 2021 13:05:11 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 02/11] interconnect: sdm660: expand DEFINE_QNODE macros
Message-ID: <20210904110511.3y4gi3lmnqlitsya@Marijn-Arch-PC.localdomain>
References: <20210903232421.1384199-1-dmitry.baryshkov@linaro.org>
 <20210903232421.1384199-3-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903232421.1384199-3-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021-09-04 02:24:12, Dmitry Baryshkov wrote:
> Expand DEFINE_QNODE macros, which with an addition of QoS become an ugly
> beast with tons of different arguments. While we are at it also move
> links lists to separate arrays.
> 
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Tested on Sony Xperia XA2 Ultra (sdm630-discovery)

Tested-by: Marijn Suijten <marijn.suijten@somainline.org>
