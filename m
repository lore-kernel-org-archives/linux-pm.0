Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F59C433F5
	for <linux-pm@archiver.kernel.org>; Tue, 22 Feb 2022 18:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbiBVSc0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 22 Feb 2022 13:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiBVSc0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Feb 2022 13:32:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE9D53465D;
        Tue, 22 Feb 2022 10:31:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C847106F;
        Tue, 22 Feb 2022 10:31:59 -0800 (PST)
Received: from [10.57.9.152] (unknown [10.57.9.152])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BFED3F66F;
        Tue, 22 Feb 2022 10:31:56 -0800 (PST)
Message-ID: <27df4e4f-b6d7-9a58-f2dd-d6afa748e217@arm.com>
Date:   Tue, 22 Feb 2022 18:31:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amit.kachhap@gmail.com, viresh.kumar@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com>
 <4e090ffe-c19b-8e2c-0396-72dc33361f35@arm.com>
 <211a3606-2f4c-227b-33aa-177ef68a49a3@arm.com>
 <3d1719ca-d4a4-f904-e284-b857414669ba@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3d1719ca-d4a4-f904-e284-b857414669ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2/22/22 18:12, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> I don't think it makes sense to remove the support of the energy model 
> if the units are abstracts.
> 
> IIUC, regarding your previous answer, we don't really know what will do 
> the SoC vendor with these numbers and likely they will provide 
> consistent abstract values which won't prevent a correct behavior.
> 
> What would be the benefit of giving inconsistent abstract values which 
> will be unusable except of giving a broken energy model?

The power values in the EM which has abstract scale, would make sense to 
EAS, but not for IPA or DTPM. Those platforms which want to enable EAS,
but don't need IPA, would register such '<a_good_name_here>' EM.

> 
> Your proposed changes would be acceptable if the energy model has a 
> broken flag IMO

That is doable. I can add that flag, so we can call it 'artificial' EM
(when this new flag is set).

Let me craft the RFC patch with this new flag proposal then.
Do you agree? Can I also add you as 'Suggested-by'?

Thank you for coming back to me with the comments.
