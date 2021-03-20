Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8505BC433E1
	for <linux-pm@archiver.kernel.org>; Sat, 20 Mar 2021 19:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5908F6191C
	for <linux-pm@archiver.kernel.org>; Sat, 20 Mar 2021 19:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCTTtJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 20 Mar 2021 15:49:09 -0400
Received: from relay02.th.seeweb.it ([5.144.164.163]:44951 "EHLO
        relay02.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhCTTsg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Mar 2021 15:48:36 -0400
Received: from [192.168.1.101] (abac242.neoplus.adsl.tpnet.pl [83.6.166.242])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 743991F53D;
        Sat, 20 Mar 2021 20:48:31 +0100 (CET)
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: tsens: qcom: Document MDM9607
 compatible
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210319220802.198215-1-konrad.dybcio@somainline.org>
 <5733a2bf-8a75-2224-b821-eeb8556c6914@somainline.org>
 <a7018d4d-7c95-370e-9d47-615f63a65a22@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <fafa8304-2445-8413-b98c-8269ee033776@somainline.org>
Date:   Sat, 20 Mar 2021 20:48:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <a7018d4d-7c95-370e-9d47-615f63a65a22@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 20.03.2021 20:47, Daniel Lezcano wrote:
> On 20/03/2021 20:01, Konrad Dybcio wrote:
>> Add the compatible for MDM9607.
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>> ---
>>> v4: separate from the main patch
>>>
>>>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>> This change was previously a-b Rob Herring, I forgot to add the ack back in after separating the patch, sorry for that.
> Can you point it to a lkml@ archive ?
>

Sure, it's been acked here [1].


[1] https://lore.kernel.org/patchwork/patch/1372052/


Konrad

