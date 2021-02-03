Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9C6C433E6
	for <linux-pm@archiver.kernel.org>; Wed,  3 Feb 2021 02:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3088C64F59
	for <linux-pm@archiver.kernel.org>; Wed,  3 Feb 2021 02:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBCCRB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 2 Feb 2021 21:17:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12010 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbhBCCQ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2021 21:16:59 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DVlcy6tvKzjJ8L;
        Wed,  3 Feb 2021 10:14:58 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 10:16:16 +0800
Subject: Re: [PATCH v2 4/5] ACPI: video: Clean up printing messages
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
 <14420740.AtFQDP28HA@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9fe936a0-0293-74af-2168-5530f7732d07@huawei.com>
Date:   Wed, 3 Feb 2021 10:16:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <14420740.AtFQDP28HA@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2021/2/3 2:18, Rafael J. Wysocki wrote:
[...]
> Also make one unrelated janitorial change to fix up white space and
> use ACPI_FAILURE() instead of negating ACPI_SUCCESS().

[...]

>   	status = acpi_evaluate_object(video->device->handle, "_DOD", NULL, &buffer);
>   	if (!ACPI_SUCCESS(status)) {

if (ACPI_FAILURE(status))

> -		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _DOD"));
> +		acpi_handle_info(video->device->handle,
> +				 "_DOD evaluation failed: %s\n",
> +				 acpi_format_exception(status));


Thanks
Hanjun
