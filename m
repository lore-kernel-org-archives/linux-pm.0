From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: how to enable suspend to ram for arm-64 bits
Date: Thu, 18 Aug 2016 11:52:04 +0100
Message-ID: <62cbf1a0-268a-f9f5-09af-c155a8a77508@arm.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <CADUS3omw=WYhGF00S3DY8mkg_c-59WvD2AHYs4SQSzCYoHQraQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57409 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945918AbcHRKwI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Aug 2016 06:52:08 -0400
In-Reply-To: <CADUS3omw=WYhGF00S3DY8mkg_c-59WvD2AHYs4SQSzCYoHQraQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: yoma sophian <sophian.yoma@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 18/08/16 11:43, yoma sophian wrote:
> hi Sudeep:
>
> 2016-08-18 16:47 GMT+08:00 Sudeep Holla <sudeep.holla@arm.com>:
>>
>>> b. in arm64, if some platform has its own suspend flow,  couldn't it
>>> adopts arm/match-xxx to register its own global suspend method?
>>>
>>
>> No, PSCI is highly recommended.
> Yes, I agree with you.
> But it may not mean the ONLY way for all armv8 platform that support
> suspend method is PSCI.

I would say yes but if you have a real good reason not to adopt PSCI on
your platform then you can try present that. It should be convincing
enough to deviate from the standards :)

-- 
Regards,
Sudeep
