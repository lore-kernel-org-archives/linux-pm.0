Return-Path: <SRS0=jPMq=4N=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642C5C4BA01
	for <linux-pm@archiver.kernel.org>; Tue, 25 Feb 2020 21:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345632176D
	for <linux-pm@archiver.kernel.org>; Tue, 25 Feb 2020 21:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582667516;
	bh=5jMq5pDONAU6kIPJbg00oZN6riZEktKcuVFbGD4GUtg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=JXPWVF/8roQotixQNXkKzQzpL3XqkSsnrNRUjfDHTLGSVSHSNzRkEsfkBaOpdWaZA
	 OX47BVuIrhajeP60tIlAhP1e8TUzDgr6jhmxCt+A/H9/J7LDmGEo+kG8dP27OzmsJU
	 LOiTU5aENn+sirUoh6rkdAZ9Zp/xgkkxJbg7aEIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgBYVvz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgBYVvz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Feb 2020 16:51:55 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C71F020675;
        Tue, 25 Feb 2020 21:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582667515;
        bh=5jMq5pDONAU6kIPJbg00oZN6riZEktKcuVFbGD4GUtg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XQA4dH1yvufRcshz8lSW+3k/khdum9oZWaFfOyzI4Ohe9EGTODIFD8s5h5w/Ll/eJ
         JEYLwNNb5PZH9Dhxcrgy4Xd+3kH2WNCeSwjFe/jfU90PS2Q59JPWLQP+NbUteSFs5T
         h+dOv2JbgcW46eaMsXKYXWKNFx+hDODzYYkHfkzA=
Subject: Re: [PATCH v2] cpupower: avoid multiple definition with gcc
 -fno-common
To:     Mike Gilbert <floppym@gentoo.org>
Cc:     linux-pm@vger.kernel.org, trenn@suse.com, shuah <shuah@kernel.org>
References: <20200201175046.3948500-1-floppym@gentoo.org>
 <20200224202029.877025-1-floppym@gentoo.org>
 <a4c5af79-d9f0-2ea8-4013-30fe8f2a96d3@kernel.org>
 <CAJ0EP40RZSf8nAVJ-Ot4uFOLD=JSvo_hJ3VhEJX9L7c6iDtoXA@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <2f3bf7e2-a50c-833a-9a97-79057e1f1886@kernel.org>
Date:   Tue, 25 Feb 2020 14:51:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJ0EP40RZSf8nAVJ-Ot4uFOLD=JSvo_hJ3VhEJX9L7c6iDtoXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/25/20 10:48 AM, Mike Gilbert wrote:
> On Mon, Feb 24, 2020 at 5:26 PM shuah <shuah@kernel.org> wrote:
>>
>> Hi Mike,
>>
>> On 2/24/20 1:20 PM, Mike Gilbert wrote:
>>> The -fno-common option will be enabled by default in GCC 10.
>>
>> Great. It landed in my inbox now.
>> Please include the message you are seeing in the change log.
> 
> Sure, I will roll a v3 shortly.

Great.

> 
>>> diff --git a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
>>> index 33dc34db4f3c..20f46348271b 100644
>>> --- a/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
>>> +++ b/tools/power/cpupower/utils/idle_monitor/amd_fam14h_idle.c
>>> @@ -82,7 +82,7 @@ static struct pci_access *pci_acc;
>>>    static struct pci_dev *amd_fam14h_pci_dev;
>>>    static int nbp1_entered;
>>>
>>> -struct timespec start_time;
>>> +static struct timespec start_time;
>>>    static unsigned long long timediff;
>>
>> Does it make sense to move start_time and timediff defines to
>> cpupower-monitor.c and adding externs for them in
>> cpupower-monitor.h?
> 
> I don't think that makes a lot of sense. start_time is really an
> internal value and does not need to be shared between the two object
> files.
> 

Makes sense.

thanks,
-- Shuah
