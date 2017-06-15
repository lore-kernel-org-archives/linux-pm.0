From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v15 2/7] power: add power sequence library
Date: Thu, 15 Jun 2017 11:35:20 +0200
Message-ID: <CAPDyKFrZoyoYCQA1rnRbz9tmT9vJigzSb+xyTZpJjhd=5eFA5A@mail.gmail.com>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
 <1497319166-17287-3-git-send-email-peter.chen@nxp.com> <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
 <20170614015338.GA4635@b29397-desktop> <CAPDyKFrLL10TY1JZAhF44_0+qGETLNtFc6ujKVUu7Ay=O8+M5A@mail.gmail.com>
 <20170615065854.GA24157@b29397-desktop> <CAPDyKFpc8GRKK8bafMU_HPaqWNrger3grPSd5rWWCTYhUGHZLA@mail.gmail.com>
 <20170615091131.GB24157@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35978 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbdFOJfW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Jun 2017 05:35:22 -0400
Received: by mail-qt0-f182.google.com with SMTP id u19so12622403qta.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Jun 2017 02:35:21 -0700 (PDT)
In-Reply-To: <20170615091131.GB24157@b29397-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Peter Chen <peter.chen@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <stephen.boyd@linaro.org>, frank.li@nxp.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Gary Bisson <gary.bisson@boundarydevices.com>, Fabio Estevam <festevam@gmail.com>, Joshua Clayton <stillcompiling@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, mka@chromium.org, Alan Stern <stern@rowland.harvard.edu>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.>

On 15 June 2017 at 11:11, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Thu, Jun 15, 2017 at 10:11:45AM +0200, Ulf Hansson wrote:
>> > Yes, you are right. This is the limitation for this power sequence
>> > library, the registration for the 1st power sequence instance must
>> > be finished before device driver uses it. I am appreciated that
>> > you can supply some suggestions for it.
>>
>> In general this kind of problems is solved by first parsing the DTB,
>> which means you will find out whether there is a resource (a pwrseq)
>> required for the device. Then you try to fetch that resource, and if
>> that fails, it means the resource is not yet available, and hence you
>> want to retry later and should return -EPROBE_DEFER.
>>
>> In this case, of_pwrseq_on() needs to be converted to start looking
>> for a pwrseq compatible in it's child node - I guess. Then if that is
>> found, you try to fetch the instance of the corresponding library.
>> Failing to fetch the library instance should then cause a return
>> -EPROBE_DEFER.
>
> The most difficulty for this is we can't know whether the requested
> pwrseq instance will be registered or not, the kernel configuration
> for this pwrseq library may not be chosen at all.

In such case it is still correct to return -EPROBE_DEFER, because the
driver that tries to probe its device will fail unless it can run the
needed pwrseq. Right?

>
>>
>> >
>> >> Moreover, I have found yet another severe problem but reviewing the code:
>> >> In the struct pwrseq, you have a "bool used", which you are setting to
>> >> "true" once the pwrseq has been hooked up with the device, when a
>> >> driver calls of_pwrseq_on(). Setting that variable to true, will also
>> >> prevent another driver from using the same instance of the pwrseq for
>> >> its device. So, to cope with multiple users, you register a new
>> >> instance of the same pwrseq library that got hooked up, once the
>> >> ->get() callback is about to complete.
>> >>
>> >> The problem the occurs, when there is another driver calling
>> >> of_pwrseq_on() in between, meaning that the new instance has not yet
>> >> been registered. This will simply fail, won't it?
>> >
>> > Yes, you are right, thanks for pointing that, I will add mutex_lock for
>> > of_pwrseq_on.
>>
>> Another option is to entirely skip to two step approach.
>>
>> In other words, make the library to cope with multiple users via the
>> same registered library instance.
>>
>
> No, the pwrseq instance stores dtb information (clock, gpio, etc), it
> needs to be per device.

I think you misunderstood my suggestion here. Of course you need to
allocate one pwrseq data per device.

However, my point is that you shouldn't need more than one instance of
the library functions to be registered in the list of available pwrseq
libraries.

Kind regards
Uffe
