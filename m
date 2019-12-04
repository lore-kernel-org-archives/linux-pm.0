Return-Path: <SRS0=yql6=Z2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54783C2BC73
	for <linux-pm@archiver.kernel.org>; Wed,  4 Dec 2019 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C832073B
	for <linux-pm@archiver.kernel.org>; Wed,  4 Dec 2019 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575484095;
	bh=T/p4aso19eJ2lIy8YScENpKqBWzAkMfjPk2vkFpT52c=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=TloHmeEkauF5nWWnosBTqPB6fZjetg744bQL3jlseMfN6BoxmDIEhIkxQxgKTFDQq
	 C1AXE/M//wOqw7aT4eGTAgLCfamiogR1uSqdwy4XWdUJqLfBjDpKuoFzAyhgPV2RHZ
	 SmEASIDAHIIRtye7IWqbFnyG6sQcWQApBZRpjnuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfLDS2O (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:28:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbfLDR5w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Dec 2019 12:57:52 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053C52073B;
        Wed,  4 Dec 2019 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482272;
        bh=T/p4aso19eJ2lIy8YScENpKqBWzAkMfjPk2vkFpT52c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FT4Vdraixb3aSw27uz7MdrBcZbsMALTLL3a4ORcChVOPpBR6kl6024uMXluK3bpbU
         vdCCJ3o1pScmh1lYGOGNuWDdn+iVuKGFl/Z4TjTUhZiv67AD+3DJB5sB3O3L2xMeoU
         5ngTZQ4rP2ADEYWPIUrwsIOS7hEy0iwxFzD2O3jk=
Subject: Re: Revert library ABI changes from commit ae2917093fb60bdc1ed3e
To:     trenn@suse.com, linux-pm@vger.kernel.org
Cc:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>
References: <36653115.R70aLYaqeR@skinner.arch.suse.de>
From:   shuah <shuah@kernel.org>
Message-ID: <b8dce3f5-3d5c-41dd-17dc-e43c745c1990@kernel.org>
Date:   Wed, 4 Dec 2019 10:57:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <36653115.R70aLYaqeR@skinner.arch.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Thomas,

On 12/2/19 8:00 AM, trenn@suse.com wrote:
> Commit ae2917093fb60bdc1ed3e modified the library function:
>

Can you add PATCH tag please.


> struct cpufreq_available_frequencies
> *cpufreq_get_available_frequencies(unsigned int cpu)
> 
> to
> struct cpufreq_frequencies
> *cpufreq_get_frequencies(const char *type, unsigned int cpu)
> 
> This patch recovers the old API and implements the new functionality
> in a newly introduce method:
> struct cpufreq_boost_frequencies
> *cpufreq_get_available_frequencies(unsigned int cpu)
> 
> 
> This one should get merged into stable kernels back to 5.0 when
> commit ae2917093fb60bdc1ed3e had been introduced.

Please add Fixes tag e.g:

Fixes: ae2917093fb6 ("tools/power/cpupower: Display boost frequency 
separately")

> 
> Cc: stable@vger.kernel.org
> 

thanks,
-- Shuah
