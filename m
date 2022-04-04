Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D706BC46467
	for <linux-pm@archiver.kernel.org>; Mon,  4 Apr 2022 21:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378902AbiDDVSV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379085AbiDDQdD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2022 12:33:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9006436E0C;
        Mon,  4 Apr 2022 09:31:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 520B3D6E;
        Mon,  4 Apr 2022 09:31:07 -0700 (PDT)
Received: from [10.57.8.9] (unknown [10.57.8.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65D843F73B;
        Mon,  4 Apr 2022 09:31:04 -0700 (PDT)
Message-ID: <74a2f038-50dd-91e5-227d-a1c633a87184@arm.com>
Date:   Mon, 4 Apr 2022 17:31:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RESEND][PATCH 5/8] PM: EM: Remove old debugfs files and print
 all 'flags'
Content-Language: en-US
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
References: <20220321095729.20655-1-lukasz.luba@arm.com>
 <20220321095729.20655-6-lukasz.luba@arm.com> <YksWj8GhZWUimF74@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <YksWj8GhZWUimF74@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ionela,

Thank you for reviewing these patches.

On 4/4/22 17:02, Ionela Voinescu wrote:
> Hi Lukasz,
> 
> IMO the debugfs files were fine as they were:
>   - They offered information on units and inefficiencies without having
>     to dig into the code to see which bit is for which flag.
>   - I believe the artificial EM power values fit under bogoWatts as unit,
>     so that part would still be correct.
> 
> On the other hand, your new file offers more information: we'd be able
> to see in debugfs whether we're dealing with an artificial EM, despite
> needing a bit more looking over the code to understand the output.

I have consolidated them, so we would support more features in the flag
automatically when there will be a need.

In Android kernel we don't have unfortunately the debugfs compiled-in,
so this information is still only for kernel testing with some Linux
distro.

I have been thinking to switch into sysfs interface, so we could
have it in Android as well. This patch change adding a generic 'flags'
which would be more 'stable' (which is a requirement for sysfs contract)
is also a closer step into that direction. But that is for longer
discussion and not for this $subject.

> 
> I don't have a strong opinion and the code looks fine, so:
> 
> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> 

