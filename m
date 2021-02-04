Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8E7C433E0
	for <linux-pm@archiver.kernel.org>; Thu,  4 Feb 2021 01:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB91664E2A
	for <linux-pm@archiver.kernel.org>; Thu,  4 Feb 2021 01:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhBDBNK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 3 Feb 2021 20:13:10 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12412 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbhBDBNK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 20:13:10 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DWL964FX6zjHbq;
        Thu,  4 Feb 2021 09:11:22 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 09:12:24 +0800
Subject: Re: [PATCH v3 1/5] ACPI: AC: Clean up printing messages
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Joe Perches" <joe@perches.com>
References: <2367702.B5bJTmGzJm@kreacher> <1991501.dpTHplkurC@kreacher>
 <1961054.9MKZ8ejxOh@kreacher> <15677254.uJehtQVoeh@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <062472ce-362b-b799-98a1-a3d122aeb92e@huawei.com>
Date:   Thu, 4 Feb 2021 09:12:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <15677254.uJehtQVoeh@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021/2/4 2:43, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> in ac.c with acpi_handle_debug() and acpi_handle_info() calls,
> respectively, which among other things causes the excessive log
> level of the messages previously printed via ACPI_EXCEPTION() to
> be increased.
> 
> Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
> used any more, drop the no longer needed ACPI_AC_COMPONENT definition
> from the headers and update the documentation accordingly.
> 
> While at it, replace the direct printk() invocation with pr_info(),
> add a pr_fmt() definition to ac.c and drop the unneeded PREFIX
> symbol definition from there.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v2 -> v3: Also add a pr_fmt() definition to ac.c and replace direct
>            printk() with pr_info (no log level change).

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
