From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2] ARM: cpuidle: Support asymmetric idle definition
Date: Tue, 6 Jun 2017 19:28:32 +0200
Message-ID: <3d97f2a9-cff3-b5e1-d568-5d6d7e3b5abb@linaro.org>
References: <1496317188-15272-1-git-send-email-daniel.lezcano@linaro.org>
 <3ec88de3-7d18-0ea6-bc27-e98084f2b6f6@arm.com>
 <4fe4558f-5881-11dc-5d36-93c92a272eed@linaro.org>
 <a96db56b-a773-f0a7-431e-acbb969333d1@arm.com>
 <d96a6da1-318f-3465-9227-714036431f81@linaro.org>
 <47e3d236-8d36-d04d-5f87-9fece6875d66@arm.com>
 <e79e44d6-6f01-6829-3924-6feca7633eae@linaro.org>
 <342f052b-03e2-8b1e-935f-b125c57dc051@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33797 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdFFR2g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jun 2017 13:28:36 -0400
Received: by mail-wr0-f178.google.com with SMTP id g76so57242969wrd.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Jun 2017 10:28:35 -0700 (PDT)
In-Reply-To: <342f052b-03e2-8b1e-935f-b125c57dc051@arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, leo.yan@linaro.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 02/06/2017 15:45, Sudeep Holla wrote:

[ ... ]

>> We can live with a driver per cpu and do the memory optimization.
>>
>> If we have an observed regression with large SMP systems, we fix it.
>>
> 
> OK, I am fine with that if you agree that we can fix it later.

Yes, I agree.

Shall I consider adding your acked-by ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
