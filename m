From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: how to enable suspend to ram for arm-64 bits
Date: Tue, 18 Oct 2016 11:21:27 +0100
Message-ID: <c8b7e093-5fc2-4425-b415-0d5e68a16d53@arm.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <20161018100002.GA4347@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753552AbcJRKVa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Oct 2016 06:21:30 -0400
In-Reply-To: <20161018100002.GA4347@xo-6d-61-c0.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sudeep Holla <sudeep.holla@arm.com>, yoma sophian <sophian.yoma@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 18/10/16 11:00, Pavel Machek wrote:
> Hi!
>
>>> b. in arm64, if some platform has its own suspend flow,  couldn't it
>>> adopts arm/match-xxx to register its own global suspend method?
>>>
>>
>> No, PSCI is highly recommended.
>
> Relying on firmware for suspend on x86 was a great disaster, lets not repeat
> that mistake.

Could you be more elaborate on this ?

  arm32 has better powermanagement than x86 ever will (see Nokia N900
> for example) -- feel free to copy that code from arm32.

OK are you suggesting that pull in all the low level assembly code that
are very platform specific in to the kernel ?

Sorry, no thanks. We don't want that in the kernel and IMO that's one of
the reason why many platforms lacked PM support in the upstream kernel
as they were too platform specific and hinders the progress towards
single kernel.

-- 
Regards,
Sudeep
