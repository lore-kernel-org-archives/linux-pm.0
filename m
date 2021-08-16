Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6CAC432BE
	for <linux-pm@archiver.kernel.org>; Mon, 16 Aug 2021 07:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1AC661AFD
	for <linux-pm@archiver.kernel.org>; Mon, 16 Aug 2021 07:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhHPHxu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 16 Aug 2021 03:53:50 -0400
Received: from foss.arm.com ([217.140.110.172]:41146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234359AbhHPHxs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Aug 2021 03:53:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C72D1042;
        Mon, 16 Aug 2021 00:53:17 -0700 (PDT)
Received: from [10.57.13.98] (unknown [10.57.13.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DD3C3F66F;
        Mon, 16 Aug 2021 00:53:15 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: memory: convert Samsung Exynos DMC to
 dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
References: <20210813125414.104467-1-krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <73eebe7b-46da-137b-1938-09a5b453320a@arm.com>
Date:   Mon, 16 Aug 2021 08:53:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210813125414.104467-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 8/13/21 1:54 PM, Krzysztof Kozlowski wrote:
> Convert Samsung Exynos5422 SoC frequency and voltage scaling for
> Dynamic Memory Controller to DT schema format using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   .../memory-controllers/exynos5422-dmc.txt     |  84 -----------
>   .../samsung,exynos5422-dmc.yaml               | 137 ++++++++++++++++++
>   MAINTAINERS                                   |   2 +-

I'm not an expert in this DT scripts and why it complains. Maybe it
complains because the "samsung,exynos-ppmu" is defined in the .txt
file... (?)
Although, in general looks OK.

Acked-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
