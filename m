Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30211C433E0
	for <linux-pm@archiver.kernel.org>; Sat, 27 Feb 2021 11:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C3864EC4
	for <linux-pm@archiver.kernel.org>; Sat, 27 Feb 2021 11:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhB0LDo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 27 Feb 2021 06:03:44 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:54815 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhB0LDo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2021 06:03:44 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Feb 2021 06:03:42 EST
Received: from [192.168.1.57] (adsl-dyn192.91-127-215.t-com.sk [91.127.215.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 784991F49F;
        Sat, 27 Feb 2021 12:02:56 +0100 (CET)
Date:   Sat, 27 Feb 2021 12:02:50 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 34/41] arm64: dts: qcom: sdm630-nile: Configure WCN3990
 Bluetooth
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <QCP6PQ.MCHV7FHSE6SG1@somainline.org>
In-Reply-To: <71ea4ebd-f446-ede3-7623-ae5b339d7905@somainline.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
        <20210226200414.167762-35-konrad.dybcio@somainline.org>
        <71ea4ebd-f446-ede3-7623-ae5b339d7905@somainline.org>
X-Mailer: geary/3.36.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Martin Botka <martin.botka@somainline.org>

Sorry for the second Sob. Previous one was HTML. Sorry

On Sat, Feb 27, 2021 at 11:40, Konrad Dybcio 
<konrad.dybcio@somainline.org> wrote:
> 
>>  From: AngeloGioacchino Del Regno 
>> <angelogioacchino.delregno@somainline.org>
> 
> From: Martin Botka <martin.botka@somainline.org>
> 
> 
> That got caught in rebasing madness.. Should any additional mistakes 
> appear, I'll send a V2.
> 
> 
> Konrad
> 


