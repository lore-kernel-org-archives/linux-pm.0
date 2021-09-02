Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B09C432BE
	for <linux-pm@archiver.kernel.org>; Thu,  2 Sep 2021 06:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FA5610E7
	for <linux-pm@archiver.kernel.org>; Thu,  2 Sep 2021 06:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhIBG7L (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Sep 2021 02:59:11 -0400
Received: from relay06.th.seeweb.it ([5.144.164.167]:33949 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237106AbhIBG7J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 02:59:09 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 56AC83ED8D;
        Thu,  2 Sep 2021 08:58:09 +0200 (CEST)
Received: by mail-ua1-f44.google.com with SMTP id l24so412106uai.1;
        Wed, 01 Sep 2021 23:58:09 -0700 (PDT)
X-Gm-Message-State: AOAM531XV3XgqE/5HI9K3MyW41XpqZf9EG5cFMGAFRFsK8HovbpS5ith
        JBEpr7Aw+wuW3HPJZP3JOXVVIklBMJSxpNMXnk8=
X-Google-Smtp-Source: ABdhPJzUX9uJgNjbyU7OioFrFDftw53DV1EqfCvPbQebm6ZbsKFfndrY7pxjSTUBYmQ1T7vqhYGBIykzhQhpQCWm2Vs=
X-Received: by 2002:a9f:2661:: with SMTP id 88mr803765uag.62.1630565888332;
 Wed, 01 Sep 2021 23:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210902054915.28689-1-shawn.guo@linaro.org>
In-Reply-To: <20210902054915.28689-1-shawn.guo@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Date:   Thu, 2 Sep 2021 08:57:57 +0200
X-Gmail-Original-Message-ID: <CAK7fi1bsB1K5ZpMLUjt9+O2w0Z5aqc_qgHdX3du-Z+LnHE4QYw@mail.gmail.com>
Message-ID: <CAK7fi1bsB1K5ZpMLUjt9+O2w0Z5aqc_qgHdX3du-Z+LnHE4QYw@mail.gmail.com>
Subject: Re: [PATCH v2] interconnect: qcom: sdm660: Correct NOC_QOS_PRIORITY
 shift and mask
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        MSM <linux-arm-msm@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il giorno gio 2 set 2021 alle ore 07:49 Shawn Guo
<shawn.guo@linaro.org> ha scritto:
>
> The NOC_QOS_PRIORITY shift and mask do not match what vendor kernel
> defines [1].  Correct them per vendor kernel.  As the result of
> NOC_QOS_PRIORITY_P0_SHIFT being 0, the definition can be dropped and
> regmap_update_bits() call on P0 can be simplified a bit.
>
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/soc/qcom/msm_bus/msm_bus_noc_adhoc.c?h=LA.UM.8.2.r1-04800-sdm660.0#n37
>
> Fixes: f80a1d414328 ("interconnect: qcom: Add SDM660 interconnect provider driver")
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno
<angelogioacchino.delregno@somainline.org>
