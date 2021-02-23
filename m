Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392ECC433E0
	for <linux-pm@archiver.kernel.org>; Tue, 23 Feb 2021 11:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73CA64E4B
	for <linux-pm@archiver.kernel.org>; Tue, 23 Feb 2021 11:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhBWLvO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:51:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12200 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhBWLvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Feb 2021 06:51:13 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DlHPV4GyfzlNJW;
        Tue, 23 Feb 2021 19:48:30 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Feb 2021 19:50:25 +0800
Subject: Re: [PATCH v1 0/4] ACPI: Get rid of ACPICA message printing from core
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <5138173.kHyPcihzTF@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <daadf47e-dac2-93a8-3070-9e9cbc0dae50@huawei.com>
Date:   Tue, 23 Feb 2021 19:50:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5138173.kHyPcihzTF@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021/2/23 2:57, Rafael J. Wysocki wrote:
> Hi All,
> 
> This series replaces ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() in the ACPI
> processor driver and sysfs code and drops definitions of related symbols
> that are not used for anything meaningful any more.
> 
> Please refer to the patch changelogs for details.

Except patch 1/4, others are looking good to me. some
legacy printk(PRIFIX ...) are still there, but we can
clean up them later.

Feel feel to add my review tag with minor issue addressed.

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
