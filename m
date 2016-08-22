From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: how to enable suspend to ram for arm-64 bits
Date: Mon, 22 Aug 2016 16:00:46 +0100
Message-ID: <6fa7fdb7-7b8d-f955-75e6-75647a6d57a3@arm.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <CADUS3omw=WYhGF00S3DY8mkg_c-59WvD2AHYs4SQSzCYoHQraQ@mail.gmail.com>
 <62cbf1a0-268a-f9f5-09af-c155a8a77508@arm.com>
 <CADUS3on-Y63EgUUudhH1cbgihnMmHe_aXra0CG2WEQWRQTo+AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54005 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754906AbcHVPAu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Aug 2016 11:00:50 -0400
In-Reply-To: <CADUS3on-Y63EgUUudhH1cbgihnMmHe_aXra0CG2WEQWRQTo+AA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: yoma sophian <sophian.yoma@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 22/08/16 15:41, yoma sophian wrote:
> hi Sudeep:
>
>>> Yes, I agree with you.
>>> But it may not mean the ONLY way for all armv8 platform that support
>>> suspend method is PSCI.
>>
>> I would say yes but if you have a real good reason not to adopt PSCI on
>> your platform then you can try present that. It should be convincing
>> enough to deviate from the standards :)
>
> Since we don't implement full features of PSCI on our platform, that
> is why we wants to know whether there is registration of platform
> suspend method.
>

For adding support for your platform in the mainline kernel, you need to
support SYSTEM_SUSPEND in psci. There's no other way currently with the
mainline.

> BTW, from the git log, it seems psci.c doesn't register system suspend
> until Linux 4.4.

Correct.

> if so, before 4.4, how aarch64 support such as str, echo mem >
> /sys/power/state , suspend flow?
>

You can back-port those patches, they are quite trivial if you need
it on pre-v4.4 kernel.

Moreover, how do you plan to support system system without PSCI ?
How will you let the higher exception softwares know that you are
entering system suspend. How will their context resumed back ?

-- 
Regards,
Sudeep
