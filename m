Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03576C433E0
	for <linux-pm@archiver.kernel.org>; Tue, 23 Feb 2021 11:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A956F64E22
	for <linux-pm@archiver.kernel.org>; Tue, 23 Feb 2021 11:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhBWLbA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:31:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13370 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBWLbA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2021 06:31:00 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DlGyf3nMKz7pSw;
        Tue, 23 Feb 2021 19:28:42 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Feb 2021 19:30:15 +0800
Subject: Re: [PATCH v1 1/4] ACPI: processor: Get rid of ACPICA message
 printing
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <5138173.kHyPcihzTF@kreacher> <10245832.OiMb8u2cOm@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <0faea0bd-107b-5c4c-5324-e0cd5e5cfba4@huawei.com>
Date:   Tue, 23 Feb 2021 19:30:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <10245832.OiMb8u2cOm@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021/2/23 2:59, Rafael J. Wysocki wrote:
> Index: linux-pm/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/processor_idle.c
> +++ linux-pm/drivers/acpi/processor_idle.c

In this file, function acpi_processor_cstate_first_run_checks()
has a wrong pr_notice():

pr_notice("ACPI: processor limited to max C-state %d\n",
		max_cstate);

Since we have pr_fmt() for this file, "ACPI:" is duplicate,
we'd better cleanup this as below:

pr_notice("processor limited to max C-state %d\n", max_cstate);

Thanks
Hanjun
