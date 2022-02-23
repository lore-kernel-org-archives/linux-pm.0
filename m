Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24899C433FE
	for <linux-pm@archiver.kernel.org>; Wed, 23 Feb 2022 10:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbiBWKQr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 23 Feb 2022 05:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbiBWKQq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Feb 2022 05:16:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 988BD8B6E0;
        Wed, 23 Feb 2022 02:16:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 454E31042;
        Wed, 23 Feb 2022 02:16:19 -0800 (PST)
Received: from [10.57.9.184] (unknown [10.57.9.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F1013F70D;
        Wed, 23 Feb 2022 02:16:17 -0800 (PST)
Message-ID: <e2ee5603-0745-6d17-d389-fbee530a1985@arm.com>
Date:   Wed, 23 Feb 2022 10:16:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] Introduce 'advanced' Energy Model in DT
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael@kernel.org, nm@ti.com, sboyd@kernel.org, mka@chromium.org,
        dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220222140746.12293-1-lukasz.luba@arm.com>
 <467a7de4-df84-8e9e-a26a-80449ca55950@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <467a7de4-df84-8e9e-a26a-80449ca55950@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On 2/23/22 09:52, Daniel Lezcano wrote:
> 
> Hi Lukasz,
> 
> why not extend the energy model to any kind of devices?
> 
> The changes are shyly proposing a new entry in the OPP table like that 
> is the only place where power management can happen.

It was Viresh proposal to make it in the OPP v2 table. I've checked
the code and this u_watt fits perfectly there. New power value looks
natural there. We also have the interconnect info in the opp, so even
this kind of extensions are there.
It is a clean solution which meats the GPU requirements.

> 
> Is the approach to describe by small pieces here and there, specific 
> attributes and let the kernel create an energy model from that soap?
> 
> I prefer the RFC approach where the energy model is described clearly 
> but, IMHO, it should be more abstracted, without reference to frequency 
> or whatever but index <-> power (t-uple or equation)
> 
> By this way, it could be possible to describe the battery with the 
> different charges, the LCD bright light, etc ...

I can see your need, but I would focus on existing issues and devices.
This change was motivated by existing mainline platform which wants
to have EM in GPU (Chromebook) from DT. The GPU has OPP table, thus it
meets this requirement. The requirements are clear for the GPU (and
similar like DSP/ISP/etc which all have OPP table).

This is a clean, small step forward with the OPP approach and it
doesn't block your future needs and requirements. IMO it's orthogonal,
devices which have OPP table naturally might provide power there.
Devices which wouldn't have OPP table, but wanted to register EM
via DT - it's a different story (not the existing Chromebook's GPU).

This future story can be addressed in some next step. We need real
devices and examples to figure out the requirements and craft something.
