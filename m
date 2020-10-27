Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F43C61DD8
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 19:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5034D20759
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 19:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaFIazKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829610AbgJ0TT3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 15:19:29 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45201 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1823202AbgJ0TSk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 15:18:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id r127so3740189lff.12;
        Tue, 27 Oct 2020 12:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rRmJEoczOaPt5oIq8pBYfrOwwnQx9zBhEX8LjsvLjPU=;
        b=eaFIazKFNB5vyc1tXwMSYIlIFQxt6JNrRMyBSHpb7iU0RRmO77n4dc1iUE32UC4l5Y
         ZGr96oD5UyzDGZUvJDqXU/yGz+us6hS0pomjhWv9z6Wf7KslMSImDcTLqNZhThgDPkuV
         9zTHIVk9mkeHWhow/fn6FJE58nRSHHmZxFMDLLUnTnAzK4BRE1NrtwyF60Ms7YuBR/01
         lsR2ZiwIrnPgwpUvIqx8l+VnyS3qKhIB71QRirpTh1Q3pe8XUZhexHWEWRFYcHxtflHm
         Es08TcFSdBLKRYTUkSAetPSJtGJk1dhCDazar1+WDc8X+FMV3dzmzEq5iAKiJ/U2Rd0I
         G3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rRmJEoczOaPt5oIq8pBYfrOwwnQx9zBhEX8LjsvLjPU=;
        b=F2mjxDwZ4d87UTiEdzpCvLvDYXi4kjHKaXWAtY0x/qOpOP1yc6UbJTJMh7bW4eYPjr
         lQOiuIPtCDmwsyJntMjOb+AA+Y8mEJ21wOI89vrZ0E8u9+X+WF/I5tpZu3cRxfLSJxsv
         gjfqQ/gFLz37QtodkR7asFxX56WODETNVM9E/oE/QGy1qjCzFcVD+wVVGHUk7PMKVYtp
         P3b03vP7SVJb332qJpcslYxm/ikAXsDtvsi9KN3tA3cIQ3To1pJhYSIynV2DRJ4QOn3U
         ZF0Tp+KbaQT0d+ZDXSvQflul4eTFyzQw6dV1iYK7MoDogvMaHQzeF4QIUb2gZF9m3CRc
         r0Ww==
X-Gm-Message-State: AOAM5330g+t2pdV5dCIsKulFYIdS8FdXrc14F0E2gN6ZvMTkNnEzZ11I
        lCmmMbYaRvKPltUXKSP9jyHsf2dUj3c=
X-Google-Smtp-Source: ABdhPJwIxxkDDHFxByTXYZCyDddCnWVGWPKWYwM/m33Y+OUz7VXxGlN+z1qlQDVq2IYrih/LUJUV3A==
X-Received: by 2002:a19:3f57:: with SMTP id m84mr1532664lfa.17.1603826317134;
        Tue, 27 Oct 2020 12:18:37 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id x19sm265377lff.189.2020.10.27.12.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:18:36 -0700 (PDT)
Subject: Re: [PATCH v6 09/52] dt-bindings: memory: tegra30: mc: Document new
 interconnect property
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-10-digetx@gmail.com> <20201027090550.GI4244@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7770b89e-f30b-3bfd-1e21-8ebbe905efcd@gmail.com>
Date:   Tue, 27 Oct 2020 22:18:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027090550.GI4244@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 12:05, Krzysztof Kozlowski пишет:
> On Mon, Oct 26, 2020 at 01:16:52AM +0300, Dmitry Osipenko wrote:
>> Memory controller is interconnected with memory clients and with the
>> External Memory Controller. Document new interconnect property which
>> turns memory controller into interconnect provider.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
>> index 84fd57bcf0dc..5436e6d420bc 100644
>> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
>> @@ -57,6 +57,9 @@ properties:
>>    "#iommu-cells":
>>      const: 1
>>  
>> +  "#interconnect-cells":
>> +    const: 1
>> +
>>  patternProperties:
>>    "^emc-timings-[0-9]+$":
>>      type: object
>> @@ -120,6 +123,7 @@ required:
>>    - clock-names
>>    - "#reset-cells"
>>    - "#iommu-cells"
>> +  - "#interconnect-cells"
> 
> Rob,
> 
> You were fine with adding a new required property which breaks all
> existing DTBs?

This is a required property for the new bindings and optional for the
older. Does it really need to be made optional in the binding?

> Were these bindings marked as unstable? The patchset does not even
> say/scream that it breaks the ABI, so this might be quite a surprise for
> someone...

Please see tegra_mc_interconnect_setup() in "memory: tegra-mc: Add
interconnect framework" patch, which check presence of the new ICC DT
property.
