Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC61C433EF
	for <linux-pm@archiver.kernel.org>; Mon, 27 Jun 2022 15:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbiF0PES (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 27 Jun 2022 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiF0PER (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 11:04:17 -0400
X-Greylist: delayed 550 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 08:04:16 PDT
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23191758D
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 08:04:16 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 686473F81B;
        Mon, 27 Jun 2022 16:55:02 +0200 (CEST)
Message-ID: <8c20bd56-2c25-b5ad-f0c2-84c2719707e9@somainline.org>
Date:   Mon, 27 Jun 2022 16:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/2] thermal: qcom: tsens-v1: Add support for MSM8992/4
 TSENS
Content-Language: en-US
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220501202025.211567-1-konrad.dybcio@somainline.org>
 <20220501202025.211567-2-konrad.dybcio@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220501202025.211567-2-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 1.05.2022 22:20, Konrad Dybcio wrote:
> MSM8994, despite being heavily based on MSM8974, uses the
> 1.2 version of TSENS. Also, 8994 being 8994, it has a custom
> way of calculating the slope.
> 
> MSM8992 in turn is a cut-down version of MSM8994 and uses
> the same TSENS hardware, albeit with a different set of sensors.
> 
> Also tested on 8976 (by a person who didn't want to be named)
> to make sure the 11->16 max_sensors changes didn't break anything.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
Bumping this, as it's seemingly went unseen.

Konrad
