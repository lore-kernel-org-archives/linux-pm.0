Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBFDC4361B
	for <linux-pm@archiver.kernel.org>; Sun, 13 Dec 2020 01:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB83222AEC
	for <linux-pm@archiver.kernel.org>; Sun, 13 Dec 2020 01:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392119AbgLMBLr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 12 Dec 2020 20:11:47 -0500
Received: from cavan.codon.org.uk ([176.126.240.207]:54644 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgLMBLq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Dec 2020 20:11:46 -0500
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id BE78341575; Sun, 13 Dec 2020 01:11:05 +0000 (UTC)
Date:   Sun, 13 Dec 2020 01:11:05 +0000
From:   Matthew Garrett <mjg59@codon.org.uk>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] thermal/core: Make 'forced_passive' as obsolete candidate
Message-ID: <20201213011105.GA21385@codon.org.uk>
References: <20201208153046.297456-1-daniel.lezcano@linaro.org>
 <cc2085ca-ada9-d616-eed5-3496889da3bb@linaro.org>
 <20201212035012.GA11926@codon.org.uk>
 <20015331-955b-756f-3dce-4eb78e473704@linaro.org>
 <20201212200806.GA19048@codon.org.uk>
 <6105a8e5-7590-5ba1-5f2b-aa24bf286150@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6105a8e5-7590-5ba1-5f2b-aa24bf286150@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 13, 2020 at 12:39:26AM +0100, Daniel Lezcano wrote:
> On 12/12/2020 21:08, Matthew Garrett wrote:
> > Anything that provides a trip point that has no active notifications and
> > doesn't provide any information that tells the kernel to poll it.
> 
> I'm not able to create a setup as you describe working correctly with
> the forced passive trip point.
> 
> The forced passive trip can not be detected as there is no comparison
> with the defined temperature in the thermal_zone_device_update() function.

The logic seems to be in the step_wise thermal governor. I'm not sure
why it would be used in thermal_zone_device_update() - the entire point
is that we don't get updates from the device?
 
> If my analysis is correct, this 'feature' is broken since years, more
> than 8 years to be exact and nobody complained.

I've no problem with it being removed if there are no users, but in that
case the justification should be rewritten - ACPI table updates aren't a
complete replacement for the functionality offered (and can't be used if
the lockdown LSM is being used in any case).
