Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D9C4332E
	for <linux-pm@archiver.kernel.org>; Thu, 14 Jan 2021 02:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63F8235FA
	for <linux-pm@archiver.kernel.org>; Thu, 14 Jan 2021 02:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbhANCLl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:11:41 -0500
Received: from relay08.th.seeweb.it ([5.144.164.169]:46675 "EHLO
        relay08.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbhAMWOP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 17:14:15 -0500
X-Greylist: delayed 100318 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2021 17:14:14 EST
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 2110D3EFD1;
        Wed, 13 Jan 2021 23:12:30 +0100 (CET)
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20210112095236.20515-1-shawn.guo@linaro.org>
 <X/210llTiuNt3haG@builder.lan> <20210113043143.y45mmnw3e2kjkxnl@vireshk-i7>
 <X/5+GbueKg66DoEE@builder.lan> <20210113050651.q2txref3d6bifrf3@vireshk-i7>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <cbd4fb28-24b8-9aa7-fe5f-24571ef6258d@somainline.org>
Date:   Wed, 13 Jan 2021 23:12:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210113050651.q2txref3d6bifrf3@vireshk-i7>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 13/01/21 06:06, Viresh Kumar ha scritto:
> On 12-01-21, 22:59, Bjorn Andersson wrote:
>> But that said, why are the ioremap done at init and not at probe time?
> 
> These are some hardware registers per cpufreq policy I believe, and so
> they did it from policy init instead.
> 
> And yes I agree that we shouldn't use devm_ from init() for the cases
> where we need to put the resources in exit() as well. But things like
> devm_kzalloc() are fine there.
> 
> Ionela, since you were the first one to post a patch about this, can
> you send a fix for this by dropping the devm_ thing altogether for the
> ioremap thing ? Mark it suggested by Bjorn. Thanks.
> 

Sorry, are you sure that the eventual fix shouldn't be rebased on top of 
my change (12014503) [1] that is enabling CPU scaling for all of the 
platforms that aren't getting the OSM set-up entirely by the TZ/bootloader?
It's a pretty big series, that I've rebased 3 times already...

[1]: 
https://patchwork.kernel.org/project/linux-arm-msm/patch/20210112182052.481888-15-angelogioacchino.delregno@somainline.org/
