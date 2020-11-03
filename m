Return-Path: <SRS0=+UCx=EJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93BEC388F7
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 08:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D7222400
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 08:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgKCIaE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Nov 2020 03:30:04 -0500
Received: from foss.arm.com ([217.140.110.172]:44152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgKCIaE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 03:30:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A393139F;
        Tue,  3 Nov 2020 00:30:03 -0800 (PST)
Received: from [10.57.19.30] (unknown [10.57.19.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF6343F718;
        Tue,  3 Nov 2020 00:29:59 -0800 (PST)
Subject: Re: [PATCH v3 0/4] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, amitk@kernel.org, corbet@lwn.net,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        dianders@chromium.org, mka@chromium.org, rnayak@codeaurora.org,
        rafael@kernel.org, sudeep.holla@arm.com, viresh.kumar@linaro.org,
        sboyd@kernel.org, nm@ti.com
References: <20201019140601.3047-1-lukasz.luba@arm.com>
 <d3c64655-dc31-73dc-8483-bf5805a9d389@arm.com>
 <20201102135449.GE2221764@google.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <af50b82f-015a-ad32-4e57-da3de9ac0a77@arm.com>
Date:   Tue, 3 Nov 2020 08:29:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201102135449.GE2221764@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 11/2/20 1:54 PM, Quentin Perret wrote:
> On Monday 02 Nov 2020 at 08:54:38 (+0000), Lukasz Luba wrote:
>> Gentle ping to Quentin and Daniel for sharing opinion on this patch set.
>> If you are OK, then I could use this as a base for next work.
> 
> One or two small nits, but overall this LGTM. Thanks Lukasz.

Thank you Quentin for the review. I am going to send v4 with these small
changes.

Regards,
Lukasz

> 
>> As you probably know I am working also on 'sustainable power' estimation
>> which could be used when there is no DT value but it comes from FW.
>> That would meet requirement from Doug, when the DT cannot be used,
>> but we have sustainable levels from FW [1].
> 
> Cool, and also, I'd be happy to hear from Doug if passing the sustained
> power via sysfs is good enough for his use-case in the meantime?
> 
> Thanks,
> Quentin
> 
