Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4882BC433DB
	for <linux-pm@archiver.kernel.org>; Thu, 25 Feb 2021 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE3C64F0C
	for <linux-pm@archiver.kernel.org>; Thu, 25 Feb 2021 14:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBYOTt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Feb 2021 09:19:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12579 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhBYOTr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2021 09:19:47 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DmZbc2dQxzMdvS;
        Thu, 25 Feb 2021 22:16:44 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Feb 2021 22:18:41 +0800
Subject: Re: [PATCH v1] ACPI: processor: idle: Drop extra prefix from
 pr_notice()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <1888725.8kdNXL6VX8@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e70654da-0593-c238-e600-f9be41cc68c8@huawei.com>
Date:   Thu, 25 Feb 2021 22:18:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1888725.8kdNXL6VX8@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021/2/25 2:37, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop "ACPI: " from the pr_noitice() instance in
> acpi_processor_cstate_first_run_checks(), because pr_fmt() causes
> that prefix to be added to the message already.
> 
> Reported-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/processor_idle.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/processor_idle.c
> +++ linux-pm/drivers/acpi/processor_idle.c
> @@ -780,8 +780,8 @@ static inline void acpi_processor_cstate
>   	dmi_check_system(processor_power_dmi_table);
>   	max_cstate = acpi_processor_cstate_check(max_cstate);
>   	if (max_cstate < ACPI_C_STATES_MAX)
> -		pr_notice("ACPI: processor limited to max C-state %d\n",
> -			  max_cstate);
> +		pr_notice("processor limited to max C-state %d\n", max_cstate);
> +
>   	first_run++;
>   
>   	if (nocst)

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
