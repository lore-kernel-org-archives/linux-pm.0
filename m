Return-Path: <SRS0=Jmv8=A3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB037C433E6
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5CCF2076D
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jul 2020 12:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgGPM4b (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgGPM40 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 08:56:26 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01A3C08C5C0
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2020 05:56:26 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vQB68Q7z9sVQ; Thu, 16 Jul 2020 22:56:18 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200714142424.66648-1-weiyongjun1@huawei.com>
References: <20200714142424.66648-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] cpuidle/pseries: Make symbol 'pseries_idle_driver' static
Message-Id: <159490401706.3805857.7133480973769495238.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:56:18 +1000 (AEST)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Jul 2020 22:24:24 +0800, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/cpuidle/cpuidle-pseries.c:25:23: warning:
>  symbol 'pseries_idle_driver' was not declared. Should it be static?
> 
> 'pseries_idle_driver' is not used outside of this file, so marks
> it static.

Applied to powerpc/next.

[1/1] cpuidle/pseries: Make symbol 'pseries_idle_driver' static
      https://git.kernel.org/powerpc/c/92fe8483b1660feaa602d8be6ca7efe95ae4789b

cheers
