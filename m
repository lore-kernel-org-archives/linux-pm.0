Return-Path: <SRS0=gkov=VI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28112C74A3F
	for <linux-pm@archiver.kernel.org>; Thu, 11 Jul 2019 00:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB6D21530
	for <linux-pm@archiver.kernel.org>; Thu, 11 Jul 2019 00:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfGKAV7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Jul 2019 20:21:59 -0400
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:51440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727325AbfGKAV7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 20:21:59 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 20:21:58 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 69EAE1800B461
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2019 00:14:43 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BC0308774;
        Thu, 11 Jul 2019 00:14:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pail12_bbc0872fcd3a
X-Filterd-Recvd-Size: 1927
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Jul 2019 00:14:40 +0000 (UTC)
Message-ID: <cd61708e47cd63f3efaaa3e079982f63bfc88933.camel@perches.com>
Subject: Re: [PATCH] thermal: Add some error messages
From:   Joe Perches <joe@perches.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org
Date:   Wed, 10 Jul 2019 17:14:38 -0700
In-Reply-To: <0d3d6111f8a8bd199f1a5a5cd8c4e83e4f0690be.1562757659.git.amit.kucheria@linaro.org>
References: <cover.1562757659.git.amit.kucheria@linaro.org>
         <0d3d6111f8a8bd199f1a5a5cd8c4e83e4f0690be.1562757659.git.amit.kucheria@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2019-07-10 at 17:16 +0530, Amit Kucheria wrote:
> When registering a thermal zone device, we currently return -EINVAL in
> four cases. This makes it a little hard to debug the real cause of the
> failure.
> 
> Print some error messages to make it easier for developer to figure out
> what happened.
[]
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
[]
> @@ -1238,17 +1238,26 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>  	int count;
>  	struct thermal_governor *governor;
>  
> -	if (!type || strlen(type) == 0)
> +	if (!type || strlen(type) == 0) {
> +		pr_err("Error: No thermal zone type defined");

Please use terminating newlines like:

		pr_err("Error: No thermal zone type defined\n");

[]
> +		pr_err("Error: Thermal zone name (%s) too long, should be under %d chars",

etc...


