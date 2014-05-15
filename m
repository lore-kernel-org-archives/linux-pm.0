From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH] PM / OPP: discard duplicate OPP additions
Date: Thu, 15 May 2014 13:55:39 +0530
Message-ID: <CANuQgHG23F7zGxbNJVzGAeCsNNPU_CwSu5veK2-CCjnc1RE-UQ@mail.gmail.com>
References: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
	<CAGo_u6qTZ-yq26+K5nHut92d=-9nrCHKDNK9EMLK5kGMQc+dOw@mail.gmail.com>
	<CANuQgHGehqDD8-SKTfEKMEZmT5KwofFL8bhYqge0uNm6kpPgUQ@mail.gmail.com>
	<CAKohponfdoPG7H4h-5s+V7CwB_SgnyqqUm9aa6G-K_cX3DOcfA@mail.gmail.com>
	<53737D34.5040307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:61778 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754883AbaEOIZk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 04:25:40 -0400
Received: by mail-oa0-f47.google.com with SMTP id i7so844473oag.20
        for <linux-pm@vger.kernel.org>; Thu, 15 May 2014 01:25:40 -0700 (PDT)
In-Reply-To: <53737D34.5040307@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>

On 14 May 2014 19:57, Nishanth Menon <nm@ti.com> wrote:
> On 05/14/2014 06:08 AM, Viresh Kumar wrote:
>> On 14 May 2014 15:01, Chander Kashyap <chander.kashyap@linaro.org> wrote:
>>>> say we do at this point:
>>>> if (new_opp->rate == opp->rate) {
>>>>   dev_err(dev, "%s: attempt to add duplicate OPP entry (rate=%ld)\n",
>>>> __func__, new_opp->rate)
>>>>    kfree(new_opp);
>>>>     return -EINVAL;
>>>> }
>>>
>>> Yes this is more cleaner.
>>> But instead of dev_err,  we should use dev_warn and secondly
>>
>> Correct
>>
>>> return 0 rather than EINVAL, as there are independent users for this function
>>
>> Why? We should actually use EEXIST here instead of EINVAL though..
>>
> Yep -EEXIST is the right return value here. As Viresh indicated,
> reporting back 0 when the requested operation actually was not
> performed is wrong. Caller is supposed to know when it makes an error
> - hiding it is not correct.
>

Then in that case the caller must take care for two type of errors:
-EEXIST and -ENOMEM

> --
> Regards,
> Nishanth Menon



-- 
with warm regards,
Chander Kashyap
