Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91DFC4320A
	for <linux-pm@archiver.kernel.org>; Tue, 31 Aug 2021 16:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D7F6108B
	for <linux-pm@archiver.kernel.org>; Tue, 31 Aug 2021 16:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbhHaQvS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbhHaQvS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 12:51:18 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB133C061575
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 09:50:22 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id n24so25735029ion.10
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 09:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9DgEycQMGsPFJfjxU5xvxrR4KHhDrk4WSJNzhOW4AfQ=;
        b=MfjSCVNRe434fYhenU9ffr8sZqfGAcf1uUoqNOVaIRgH+JaKZSNKzJHusmvxK81+C3
         8CDko/RSC3or7OxXyVLlmiifUT5pRiw5wyL47f3ED22Kad1Ie/Q1cWV7Ruotylp+l4Vp
         WB40MKtUpWJ1InzLUYKdHuVwCVDgddn42mr+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9DgEycQMGsPFJfjxU5xvxrR4KHhDrk4WSJNzhOW4AfQ=;
        b=CtNHC39RixCvWsPlI2W1ls8padBu4K6V1Z8p/Iv4EHM1TuisXQFmPgDYIagJLmFl14
         nf0ybk2EJuxXiqRdzkiwPgsXpybkppGtbyzg9CjOVukRDrcOK+CC9f+rQO9HsmhxGHpS
         tl/UUt54hqc2NGur6TXj1v+wYzAJ35rJmjpNnYfdYzXJCi9M8Ye5b+BxZkOGZm1xhlOL
         bqQf2mze936tPEmUyKsxYVbDO7DPm2uNvMJI6mWxtSCvZ9L+ig8cN1H+QiVHJANv5LGo
         sRDHBJw1qmjFLF4LPQDFZxbhrZZX7ztpzgSFg9dZ22a1WPojmN1xOlBaUsod9rQbG38k
         +FHA==
X-Gm-Message-State: AOAM533zdD4oEVjBGjsNcdeRFh+HeDmRYgrQVmqM4VpZJWD14zK4rnnb
        fa0r0zYOsUrW2SUcEuYngipDfA==
X-Google-Smtp-Source: ABdhPJyJg5KBLvWmLAPWyRpm+uePjJeTSZiwMFAFjgh5Ssa6EJ4XJ4Xc7U5XLea3QhF1v9iT5FAxQA==
X-Received: by 2002:a6b:7a03:: with SMTP id h3mr23648569iom.39.1630428622224;
        Tue, 31 Aug 2021 09:50:22 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 3sm6079565iln.79.2021.08.31.09.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 09:50:21 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] kselftests: clean configs
To:     Li Zhijian <lizhijian@cn.fujitsu.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     philip.li@intel.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210831102316.280512-1-lizhijian@cn.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3a386a77-80f5-81c0-5bda-df656c057fa6@linuxfoundation.org>
Date:   Tue, 31 Aug 2021 10:50:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210831102316.280512-1-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/31/21 4:23 AM, Li Zhijian wrote:
> 0Day will check if all configs listing under selftests are able
> to be enabled properly.
> 
> For the missing configs, it will report something like:
> LKP WARN miss config CONFIG_SYNC= of sync/config
> 
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: linux-pm@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Li Zhijian (2):
>    selftests/sync: Remove the deprecated config SYNC
>    selftests/cpufreq: Rename DEBUG_PI_LIST to DEBUG_PLIST
> 
>   tools/testing/selftests/cpufreq/config | 2 +-
>   tools/testing/selftests/sync/config    | 1 -
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 

Thank you. These two patches will be queued up for 5.15

thanks,
-- Shuah
