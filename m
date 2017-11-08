From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] cpuidle: Add new macro to enter a retention idle
 state
Date: Wed, 8 Nov 2017 18:14:11 +0000
Message-ID: <a3b485e4-fa22-98e4-2b9b-dcb604c89bc2@arm.com>
References: <1510076133-18139-1-git-send-email-pprakash@codeaurora.org>
 <1510076133-18139-2-git-send-email-pprakash@codeaurora.org>
 <c60a1552-e722-f548-45d4-1529e129c231@arm.com>
 <3aa849d6-d456-670b-2c77-a26fa7d597af@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37118 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbdKHSOP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Nov 2017 13:14:15 -0500
In-Reply-To: <3aa849d6-d456-670b-2c77-a26fa7d597af@codeaurora.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org, will.deacon@arm.com, catalin.marinas@arm.com



On 08/11/17 17:15, Prakash, Prashanth wrote:
> Hi Sudeep,
> 
> On 11/8/2017 7:38 AM, Sudeep Holla wrote:

>> I am fine with this change as initial step. But I am wondering if we
>> will have a retention state which loses partial state ?
>>
>> The specification has flags to specify that difference but will we see
>> that in reality is a different question. If we see such hardware, then
>> we may need to revert this and handle in the callbacks as we can't skip
>> cpu_pm notifier callbacks all together right ?
> I agree. This is a initial and quick first step and will help only fully retention states.
> 
> If there are devices with partial retention states and necessary support in cpu
> PM framework we can revert this and handle it in more generic way.
> 

Sounds good. Just wanted to be aware of that fact. Hope we don't get
such crazy hardware(but you never know).

-- 
Regards,
Sudeep
