From: yoma sophian <sophian.yoma@gmail.com>
Subject: Re: how to enable suspend to ram for arm-64 bits
Date: Thu, 18 Aug 2016 18:43:53 +0800
Message-ID: <CADUS3omw=WYhGF00S3DY8mkg_c-59WvD2AHYs4SQSzCYoHQraQ@mail.gmail.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com> <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:32958 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990AbcHRKnz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Aug 2016 06:43:55 -0400
Received: by mail-io0-f193.google.com with SMTP id y195so2596969iod.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Aug 2016 03:43:54 -0700 (PDT)
In-Reply-To: <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

hi Sudeep:

2016-08-18 16:47 GMT+08:00 Sudeep Holla <sudeep.holla@arm.com>:
>
>> b. in arm64, if some platform has its own suspend flow,  couldn't it
>> adopts arm/match-xxx to register its own global suspend method?
>>
>
> No, PSCI is highly recommended.
Yes, I agree with you.
But it may not mean the ONLY way for all armv8 platform that support
suspend method is PSCI.

Sincerely appreciate your kind help,
