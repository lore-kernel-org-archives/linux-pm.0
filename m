Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B80C433E6
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93320650DF
	for <linux-pm@archiver.kernel.org>; Tue,  9 Mar 2021 15:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhCIPCs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 9 Mar 2021 10:02:48 -0500
Received: from foss.arm.com ([217.140.110.172]:54938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231254AbhCIPCP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Mar 2021 10:02:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895971042;
        Tue,  9 Mar 2021 07:02:14 -0800 (PST)
Received: from [10.57.15.199] (unknown [10.57.15.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C8B43F71B;
        Tue,  9 Mar 2021 07:02:13 -0800 (PST)
Subject: Re: [PATCH 3/5] powercap/drivers/dtpm: Simplify the dtpm table
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
 <20210301212149.22877-3-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <79af4b58-e82c-66a5-3992-e7af5d386e4f@arm.com>
Date:   Tue, 9 Mar 2021 15:02:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20210301212149.22877-3-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/1/21 9:21 PM, Daniel Lezcano wrote:
> The dtpm table is an array of pointers, that forces the user of the
> table to define initdata along with the declaration of the table
> entry. It is more efficient to create an array of dtpm structure, so
> the declaration of the table entry can be done by initializing the
> different fields.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/powercap/dtpm.c     |  4 ++--
>   drivers/powercap/dtpm_cpu.c |  4 +++-
>   include/linux/dtpm.h        | 22 +++++++++-------------
>   3 files changed, 14 insertions(+), 16 deletions(-)
> 

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
