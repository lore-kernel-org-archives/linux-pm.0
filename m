Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56035C433DB
	for <linux-pm@archiver.kernel.org>; Thu,  4 Feb 2021 01:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26C964E42
	for <linux-pm@archiver.kernel.org>; Thu,  4 Feb 2021 01:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbhBDBnk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 3 Feb 2021 20:43:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12413 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhBDBnk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2021 20:43:40 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DWLrL4yrSzjHfM;
        Thu,  4 Feb 2021 09:41:54 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 09:42:57 +0800
Subject: Re: [PATCH v3 4/5] ACPI: video: Clean up printing messages
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
 <1961054.9MKZ8ejxOh@kreacher> <1924490.ZvBDFke9FE@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <53bc0b9e-e036-1dda-139c-8347e90f0921@huawei.com>
Date:   Thu, 4 Feb 2021 09:42:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1924490.ZvBDFke9FE@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021/2/4 2:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
> 
> Replace the ACPI_DEBUG_PRINT() instances in acpi_video.c with
> acpi_handle_debug() calls and the ACPI_EXCEPTION()/ACPI_ERROR()/
> ACPI_WARNING() instances in there with acpi_handle_info() calls,
> which among other things causes the excessive log levels of those
> messages to be increased.
> 
> Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
> used any more from acpi_video.c, drop the no longer needed
> ACPI_VIDEO_COMPONENT definition from the headers and update the
> documentation accordingly.
> 
> While at it, add a pr_fmt() definition to acpi_video.c, replace the
> direct printk() invocations in there with acpi_handle_info() or
> pr_info() (and reduce the excessive log level where applicable) and
> drop the PREFIX sybmbol definition which is not necessary any more
> from acpi_video.c.
> 
> Also make unrelated janitorial changes to fix up white space and
> use ACPI_FAILURE() instead of negating ACPI_SUCCESS().
> 
> Signed-off-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
