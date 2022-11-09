Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6EEC4332F
	for <linux-pm@archiver.kernel.org>; Wed,  9 Nov 2022 15:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiKIPzm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiKIPzk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Nov 2022 10:55:40 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8443017E07
        for <linux-pm@vger.kernel.org>; Wed,  9 Nov 2022 07:55:39 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1osnQQ-0004uJ-4T; Wed, 09 Nov 2022 16:55:38 +0100
Message-ID: <2889908a-6bef-fd34-5a57-ceea4138a0a9@leemhuis.info>
Date:   Wed, 9 Nov 2022 16:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Regression after recent changes to drivers/thermal/thermal_of.c
 #forregzbot
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
References: <CACRpkdbB5hgkrPZVb-+9tuKErvwjTKNaBQ1LvH1==fR7bndjSQ@mail.gmail.com>
 <9e747f87-1854-dbd7-ef3a-1effc2b90e3b@leemhuis.info>
In-Reply-To: <9e747f87-1854-dbd7-ef3a-1effc2b90e3b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1668009339;e11a0168;
X-HE-SMSGID: 1osnQQ-0004uJ-4T
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26.10.22 11:29, Thorsten Leemhuis wrote:
> [Note: this mail is primarily send for documentation purposes and/or for
> regzbot, my Linux kernel regression tracking bot. That's why I removed
> most or all folks from the list of recipients, but left any that looked
> like a mailing lists. These mails usually contain '#forregzbot' in the
> subject, to make them easy to spot and filter out.]

> #regzbot ^introduced 8c596324232d22e19f
> #regzbot title dt-bindings: thermal: thermal zone without trip points broke
> #regzbot ignore-activity

#regzbot fixed-by: cd73adcdba
