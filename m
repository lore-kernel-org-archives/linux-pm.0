Return-Path: <SRS0=thCJ=B3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F02C433E1
	for <linux-pm@archiver.kernel.org>; Mon, 17 Aug 2020 12:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF7520658
	for <linux-pm@archiver.kernel.org>; Mon, 17 Aug 2020 12:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHQM2s (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:28:48 -0400
Received: from foss.arm.com ([217.140.110.172]:54458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHQM2s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Aug 2020 08:28:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA29330E;
        Mon, 17 Aug 2020 05:28:47 -0700 (PDT)
Received: from [10.37.12.68] (unknown [10.37.12.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF22B3F66B;
        Mon, 17 Aug 2020 05:28:45 -0700 (PDT)
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: Additional locking for
 'curr_rate'
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     oss-self-reviewed-patches@listhost.cambridge.arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kgene@kernel.org, b.zolnierkie@samsung.com
References: <20200811101727.3976-1-lukasz.luba@arm.com>
 <20200817115435.GA2346@kozik-lap>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <b1cbd097-b31d-b1f2-243b-f4ed3074a9ce@arm.com>
Date:   Mon, 17 Aug 2020 13:28:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200817115435.GA2346@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 8/17/20 12:54 PM, Krzysztof Kozlowski wrote:
> On Tue, Aug 11, 2020 at 11:17:27AM +0100, Lukasz Luba wrote:
>> The 'curr_rate' is protected by local 'dmc->lock' in various places, but
>> not in a function exynos5_dmc_get_status(). The lock protects frequency
>> (and voltage) change process and the corresponding value stored in
>> 'curr_rate'. Add the locking mechanism to protect the 'curr_rate' reading
>> also in the exynos5_dmc_get_status().
>>
>> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/memory/samsung/exynos5422-dmc.c | 3 +++
> 
> Thanks, applied.
> 

Thank you for applying it.

Regards,
Lukasz
