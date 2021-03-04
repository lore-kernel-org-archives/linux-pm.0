Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A669DC433E0
	for <linux-pm@archiver.kernel.org>; Thu,  4 Mar 2021 17:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C7D64E89
	for <linux-pm@archiver.kernel.org>; Thu,  4 Mar 2021 17:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbhCDR2w (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 4 Mar 2021 12:28:52 -0500
Received: from foss.arm.com ([217.140.110.172]:42038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236785AbhCDR2f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Mar 2021 12:28:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAC4731B;
        Thu,  4 Mar 2021 09:27:49 -0800 (PST)
Received: from [10.57.19.206] (unknown [10.57.19.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AFE43F7D7;
        Thu,  4 Mar 2021 09:27:48 -0800 (PST)
Subject: Re: [PATCH] opp: Invalidate current opp when draining the opp list
To:     Beata Michalska <beata.michalska@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
References: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <2ffd8863-9ea9-85dd-60a9-035d21e2ee11@arm.com>
Date:   Thu, 4 Mar 2021 17:27:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1614870454-18709-1-git-send-email-beata.michalska@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Beata,

On 3/4/21 3:07 PM, Beata Michalska wrote:
> The current_opp when set, grabs additional reference on the opp,
> which is then supposed to be dropped upon releasing the opp table.
> Still both dev_pm_opp_remove_table and dev_pm_opp_remove_all_dynamic
> will completely drain the OPPs list, including dropping the additional
> reference on current_opp. This may lead to an attempt to access
> memory that has already been released. Make sure that while draining
> the list (in both dynamic and static cases) the current_opp gets
> actually invalidated.
> 
> Fixes: 81c4d8a3c414 ("opp: Keep track of currently programmed OPP")
> 
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> ---
>   drivers/opp/core.c | 49 ++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 32 insertions(+), 17 deletions(-)

The change looks good.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
