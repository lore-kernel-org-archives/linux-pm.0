Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86A3C4708F
	for <linux-pm@archiver.kernel.org>; Wed,  2 Jun 2021 08:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C04613CD
	for <linux-pm@archiver.kernel.org>; Wed,  2 Jun 2021 08:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhFBIPn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Jun 2021 04:15:43 -0400
Received: from relay01.th.seeweb.it ([5.144.164.162]:42849 "EHLO
        relay01.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhFBIPn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 04:15:43 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2021 04:15:42 EDT
Received: from [192.168.1.101] (83.6.168.57.neoplus.adsl.tpnet.pl [83.6.168.57])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A4F111FA23;
        Wed,  2 Jun 2021 10:07:14 +0200 (CEST)
Subject: Re: [PATCH RFC 1/2] thermal: qcom: tsens-v1: Add support for MSM8994
 TSENS
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210209195346.457803-1-konrad.dybcio@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <31ceef3f-57a9-81f8-2a8e-0155d87a63f1@somainline.org>
Date:   Wed, 2 Jun 2021 10:07:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210209195346.457803-1-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Bumping again!


Konrad

