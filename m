Return-Path: <SRS0=P4yl=BO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07990C433DF
	for <linux-pm@archiver.kernel.org>; Tue,  4 Aug 2020 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE3DD206C0
	for <linux-pm@archiver.kernel.org>; Tue,  4 Aug 2020 17:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+mdW542"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgHDR1S (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgHDR1S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 13:27:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8B2C06174A;
        Tue,  4 Aug 2020 10:27:17 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id d14so39100441qke.13;
        Tue, 04 Aug 2020 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E7NJIozHt+m1AVrlcoRDMsMHIksDQclStBIFbmvuAkE=;
        b=I+mdW542d7UOQfbeQJP/xjlQS1tov89CwInKPql8afcySHNrxANla/IQ76zu+0vh+B
         ocIruu8EMGqEnbySc/94Q5F0J7FN2cWZC09Jn0k36n3TLJXu2zTO5kaYG70ewnYvIFQl
         oacmZIKAjDj2PE/N/6nwub/4GvL1aycYrNUjlznbAnvHHAx77PUI3nMq+sakBumRB0I7
         dfO99hCh2yD8RHc92ez5ogHWP2E66Kp2zEpS2Lc6VNlntAFmeAUW3p6coovgX21b22st
         /+20oVsjjQmJ54B89iZ0WhoSjDF5TLRtieHX3VXl9dFGmtpwriKFQpUYX/873OXfi+sp
         xJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E7NJIozHt+m1AVrlcoRDMsMHIksDQclStBIFbmvuAkE=;
        b=ORXKP569abWjFsfbaK2/ograYs3kncRLewx/rUhv22X2towrYqIuiDVoSoDJxNIpX2
         hQHSwjfZLtJvSmog4JV7+J2AzprmCHL2PSyYz5+tqFH3j9Xwjt4CQAZlmxxwi7OusjUM
         xE9SGaNxLMpn93NNZiq/seVOHqJLIAE8YWFbeFG8yODZbXua17mtroqrul869/OeaxLt
         Ywrrc7wz86Y03lkS+bdYqI9gibQuGgVBCsczuy/BUdzMZfON2+5W9nt6KEd9LkKSDjBE
         N/ngW2+w4RZslpyd0pdcnsRTgErk7wYLtI5OwG3d+eXjik0Jx7NTSjYT3Kds56q0SYt6
         eJNg==
X-Gm-Message-State: AOAM531DRVN40XCICzzTGUNAlZZwsDBoGYs/aNulF+yM7/Ge8+V/hSVp
        6vfzDCvV/uUerTWo9vk6eYw=
X-Google-Smtp-Source: ABdhPJxgOgWsiwGqnjZGd25tRAK+Z9iymVMCZxbhUXOhQX8Mw02dqjnCrEFAua62Drkm4YgBGJ1FTw==
X-Received: by 2002:a05:620a:234:: with SMTP id u20mr21352090qkm.54.1596562036752;
        Tue, 04 Aug 2020 10:27:16 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id 71sm22970285qkk.125.2020.08.04.10.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 10:27:15 -0700 (PDT)
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net
References: <20200729151208.27737-1-lukasz.luba@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a3354ae8-f40f-83f2-d6eb-7f588af75e97@gmail.com>
Date:   Tue, 4 Aug 2020 10:27:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729151208.27737-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/29/2020 8:12 AM, Lukasz Luba wrote:
> Hi all,
> 
> The existing CPUFreq framework does not tracks the statistics when the
> 'fast switch' is used or when firmware changes the frequency independently
> due to e.g. thermal reasons. However, the firmware might track the frequency
> changes and expose this to the kernel.

Or the firmware might have changed the CPU frequency in response to a
request from the secure world for instance.

> 
> This patch set aims to introduce CPUfreq statistics gathered by firmware
> and retrieved by CPUFreq driver. It would require a new API functions
> in the CPUFreq, which allows to poke drivers to get these stats.

From a debugging perspective, it would be helpful if the firmware
maintained statistics were exposed as a super-set of the Linux cpufreq
statistics and aggregated into them such that you could view the normal
world vs. secure world residency of a given frequency point. This would
help because a lot of times, Linux requests freq X, but the secure world
requires freq Y (with X >= Y) and people do not really understand why
the resulting power usage is higher for instance.

What are your thoughts on this?
-- 
Florian
