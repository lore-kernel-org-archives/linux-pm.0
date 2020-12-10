Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7B3C0018C
	for <linux-pm@archiver.kernel.org>; Thu, 10 Dec 2020 15:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FCA23D22
	for <linux-pm@archiver.kernel.org>; Thu, 10 Dec 2020 15:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391234AbgLJPuN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 10 Dec 2020 10:50:13 -0500
Received: from foss.arm.com ([217.140.110.172]:49334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391207AbgLJPuN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 10:50:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F431FB;
        Thu, 10 Dec 2020 07:49:27 -0800 (PST)
Received: from [10.57.1.60] (unknown [10.57.1.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C4A53F68F;
        Thu, 10 Dec 2020 07:49:26 -0800 (PST)
Subject: Re: [PATCH v2 1/4] thermal/core: Rename passive_delay and
 polling_delay with units
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20201207190902.30464-1-daniel.lezcano@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <515c6301-0f52-2975-2ef0-1efda6fffdba@arm.com>
Date:   Thu, 10 Dec 2020 15:49:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201207190902.30464-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/7/20 7:08 PM, Daniel Lezcano wrote:
> The input unit used by the thermal framework is the msec but it uses
> the jiffies to set the timers.
> 
> As it is stored in the thermal zone device structure, everytime the
> timer is setup at each polling interval, the msecs to jiffies
> conversion happens. The jiffies is the unit the thermal framework is
> using, so keeping it under the jiffies instead of msecs will save some
> pointless conversion.

Make sense

> 
> Set the scene to directly store the delays under their jiffies
> form by adding to the variable name the 'ms' suffix.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---


Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
