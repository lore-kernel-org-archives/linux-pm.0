Return-Path: <SRS0=8MB0=AT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339CBC433E0
	for <linux-pm@archiver.kernel.org>; Wed,  8 Jul 2020 14:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161C4206E2
	for <linux-pm@archiver.kernel.org>; Wed,  8 Jul 2020 14:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgGHOBa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:01:30 -0400
Received: from foss.arm.com ([217.140.110.172]:42246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbgGHOBa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 10:01:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB7941FB;
        Wed,  8 Jul 2020 07:01:29 -0700 (PDT)
Received: from [10.37.12.67] (unknown [10.37.12.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CB353F237;
        Wed,  8 Jul 2020 07:01:25 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] PM / devfreq: Add delayed timer for polling
To:     Chanwoo Choi <cw00.choi@samsung.com>, k.konieczny@samsung.com,
        krzk@kernel.org, kgene@kernel.org
Cc:     s.nawrocki@samsung.com, willy.mh.wolff.ml@gmail.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <CGME20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742@epcas1p1.samsung.com>
 <20200703062622.11773-1-cw00.choi@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <cea8d850-131f-6121-6d96-8b8dc2a33432@arm.com>
Date:   Wed, 8 Jul 2020 15:01:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200703062622.11773-1-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

On 7/3/20 7:26 AM, Chanwoo Choi wrote:
> Add the delayed timer to devfreq framework in order to support
> the periodical polling mode without stop caused by CPU idle state.
> Some Non-CPU device must need to monitor the device status like
> utilization regardless of CPU state.
> 
> - patch1 explains the detailed reason why the delayed timer is required.
> - patch2 initializes that exynos5422-dmc device use delayed timer as default
> instead of deferrable timer.
> 
> Chanwoo Choi (2):
>    PM / devfreq: Add support delayed timer for polling mode
>    memory: samsung: exynos5422-dmc: Use delayed timer as default
> 
>   Documentation/ABI/testing/sysfs-class-devfreq | 12 +++
>   drivers/devfreq/devfreq.c                     | 83 ++++++++++++++++++-
>   drivers/memory/samsung/exynos5422-dmc.c       |  1 +
>   include/linux/devfreq.h                       |  9 ++
>   4 files changed, 104 insertions(+), 1 deletion(-)
> 


My apologizes for being late for the party. I wasn't able to run tests
and I had to fix my setup after I messed up some scripts.

The patch set looks good to me, so you can add my (to both patches):

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

I have run these Willy's benchmark tests and I will send some
follow up patches in a few minutes.

Regards,
Lukasz
