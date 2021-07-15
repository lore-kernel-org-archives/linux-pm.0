Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6CAC47E4B
	for <linux-pm@archiver.kernel.org>; Thu, 15 Jul 2021 15:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485D76136E
	for <linux-pm@archiver.kernel.org>; Thu, 15 Jul 2021 15:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhGOPjb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbhGOPja (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jul 2021 11:39:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47FCC061760;
        Thu, 15 Jul 2021 08:36:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q4so9415453ljp.13;
        Thu, 15 Jul 2021 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DYS+BayRuU8Fs2QSDK+ROjJHNwqWsJ/l7sPEVXB3gQ0=;
        b=WGB8jy40SjrJgQrhjnlB8ggM/f/tXPGR6wnZpNIMnt7ZNrYz8VraZOvUBxba4UWVot
         0xbxMdnq33m0fhY+TJ3c3rNlvuLLk9b5h8k3mGDzXkj4s23PKtn98KixUnR3JZydkfdl
         t6rMasxdeDjztQGP3E2kujCmNsa6dcv5vKHv8rNYx17GLhFh5p9m3pb5JxrK4EYLDR87
         dGcUD4NPiZCqZf8WfIKyNAlMB72r5LHFI2t3wm8rGhUTWx7TUbNoWDqaqD1JkYXMU7+n
         8KDWqGjSkHBMxq+/mMi9kzRRDQvYE2ga4AkEb05590J88zESz+eDuwQoiXCeBW+UCH48
         LZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DYS+BayRuU8Fs2QSDK+ROjJHNwqWsJ/l7sPEVXB3gQ0=;
        b=my7b8oAKaDalEbtF/w1JSSV4EofPItVwAdjpMtMn8YR1Xi+TN0xhBFhDbNmcKYSx0T
         0RnAuNeqpUw0nThJgsbHZV9cxHai5FR9M70AhIr/vdo2JTzf+dXcHqhSnRaRwAywxWAH
         U98GqzC54qOJCZR9W958mpMkgVCMdTxFzqDh+Vz/xrVRXIPG28QIzX7InlyoMiO2zCpT
         kcvf8yerJtzcPwmV99ykZ6jHYtLDRKELQfRvX/YoKrZkIOsKXHXAIJEOnrweOT+hIFzI
         ilvF0l1IWFNUFN2iOqPFXeM3vSnAeqS6t6qhfr2l9qJXo4T2ppAG+RhEYiond9pW/drq
         Zufw==
X-Gm-Message-State: AOAM530LAKPOmVLoc1jWZJ7NnFUxSP0xLo6528KNPgdvhk8bDgc2sS/4
        t7LzQb2E0r0EVAqYqHvCVk1AalF1FHA=
X-Google-Smtp-Source: ABdhPJwSQ7bGsFCDaY2a9vzgN6jb+tOqQ+1Omrqc/hNFv6/2KiyvvsPzv8rt7TaCnq8+0Hpb9Me15w==
X-Received: by 2002:a2e:9d7:: with SMTP id 206mr4624308ljj.499.1626363393765;
        Thu, 15 Jul 2021 08:36:33 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id s5sm689535ljg.63.2021.07.15.08.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 08:36:32 -0700 (PDT)
Subject: Re: [PATCH v3 02/12] dt-bindings: phy: tegra20-usb-phy: Document
 properties needed for OTG mode
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210704225433.32029-1-digetx@gmail.com>
 <20210704225433.32029-3-digetx@gmail.com>
 <20210712154139.GB1980362@robh.at.kernel.org>
 <8fe56e89-9e1e-f5e2-5a47-242b5b3d085a@gmail.com>
 <20210714231000.GB3697673@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <73e1e3a2-c2dd-364b-7829-84e66b114909@gmail.com>
Date:   Thu, 15 Jul 2021 18:36:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714231000.GB3697673@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

15.07.2021 02:10, Rob Herring пишет:
> On Tue, Jul 13, 2021 at 02:33:11AM +0300, Dmitry Osipenko wrote:
>> 12.07.2021 18:41, Rob Herring пишет:
>>>> +  nvidia,pmc:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description:
>>>> +      Phandle to Power Management controller.
>>>> +
>>> Add a cell to this for the PHY reg offset and then get rid of the index:
>>>
>>>> +  nvidia,phy-instance:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    minimum: 0
>>>> +    maximum: 2
>>>> +    description: Unique hardware ID.
>>
>> The instance ID belongs to the USB h/w and not to PMC. It may look like
>> I added the ID just to get offsets within PMC, but it's not like that.
>> The Tegra documentation explicitly assigns unique IDs to the USB
>> controllers and PHYs. Hence this ID should be the property of the PHY
>> hardware, IMO.
> 
> It looks like the use is calculating register offsets in a PMC register. 
> That's quite common and including that with the phandle is the preferred 
> way to describe it.
> 
> Lots of docs have UART1, UART2, UART3, etc. module numbering. We don't 
> copy that into DT.

Alright. Judging by downstream code, we will need to use that ID only
for PMC offsets.
