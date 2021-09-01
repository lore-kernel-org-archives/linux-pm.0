Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B937EC43214
	for <linux-pm@archiver.kernel.org>; Wed,  1 Sep 2021 15:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997D0610C9
	for <linux-pm@archiver.kernel.org>; Wed,  1 Sep 2021 15:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244176AbhIAPBF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 1 Sep 2021 11:01:05 -0400
Received: from relay02.th.seeweb.it ([5.144.164.163]:34289 "EHLO
        relay02.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbhIAPBF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 11:01:05 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 10AE01F73C;
        Wed,  1 Sep 2021 17:00:06 +0200 (CEST)
Subject: Re: [PATCH v2 2/3] interconnect: qcom: sdm660: Add missing a2noc qos
 clocks
To:     Shawn Guo <shawn.guo@linaro.org>, Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210824043435.23190-1-shawn.guo@linaro.org>
 <20210824043435.23190-3-shawn.guo@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <11cbb70c-b99f-1ddc-cb44-c28d2ae84bbe@somainline.org>
Date:   Wed, 1 Sep 2021 17:00:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210824043435.23190-3-shawn.guo@linaro.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 24/08/21 06:34, Shawn Guo ha scritto:
> It adds the missing a2noc clocks required for QoS registers programming
> per downstream kernel[1].  Otherwise, qcom_icc_noc_set_qos_priority()
> call on mas_ufs or mas_usb_hs node will simply result in a hardware hang
> on SDM660 SoC.
> 
> [1] https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/sdm660-bus.dtsi?h=LA.UM.8.2.r1-04800-sdm660.0#n43
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>

My Xperia devices are not locking up on any call to qos priority setting, but 
that's surely because such clocks are left on by the bootloader before booting 
Linux... and then after booting my USB is up, which is probably why I still don't 
experience any hang, I guess.

In any case, I do recognize that the a2noc does effectively need these clocks to be 
on in order to be reachable, as also reported in the downstream dtsi.

Thank you!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
