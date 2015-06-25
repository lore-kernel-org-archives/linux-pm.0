From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V3] PM / Domains: Remove intermediate states from the
 power off sequence
Date: Thu, 25 Jun 2015 10:09:35 +0200
Message-ID: <CAPDyKFrhjCZTf=-oXUXp=4siMQbU5aMp5sfq_Yc-jHGapM=-og@mail.gmail.com>
References: <1434020737-13354-1-git-send-email-ulf.hansson@linaro.org>
	<7ha8w01qir.fsf@deeprootsystems.com>
	<CAPDyKFqvNp0PcjikZqj4XapfbrNqAUW=ZBFQvvzQZLPMcpS1oQ@mail.gmail.com>
	<7hy4j9q9aq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:33485 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbFYIJg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2015 04:09:36 -0400
Received: by qcbcf1 with SMTP id cf1so18612468qcb.0
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2015 01:09:36 -0700 (PDT)
In-Reply-To: <7hy4j9q9aq.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Axel Haslam <ahaslam+renesas@baylibre.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 24 June 2015 at 19:57, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> [...]
>
>>> Minor nit: I think you should leave these 3 helpers and just simplify
>>> them.  It will make the changes below easier to read as well.
>>
>> I would rather like to remove them. The reason is to create consistency.
>>
>> For the locking part, there are currently mixtures of
>> mutex_lock|unlock() and genpd_acquire|release_lock(). Following your
>> suggestion will leave around 6-7 places where mutex_lock() will remain
>> used (additionally for mutex_unlock()). So removing the helper
>> functions creates a consistent behaviour.
>
> OK, that makes more sense.
>
>> For the genpd->status, it's currently being assigned at various places
>> without using a helper function. Again I wanted to create a consistent
>> behaviour and make the code more readable.
>>
>>>
>>> Also, for the locking, Lina will be adding these locking functions back
>>> anyways, so let's just avoid the extra churn.
>>
>> Actually I think it becomes more evident what Lina's patchset does if
>> she re-introduces an API to deal with the locking. Moreover we can
>> "force" that patchset to not break consistently around the locking.
>>
>>>
>>> Otherwise, I think this version is looking really good.
>>>
>>> With the above tweaks, feel free to add
>>>
>>> Reviewed-by: Kevin Hilman <khilman@linaro.org>
>>>
>>> Kevin
>>
>> Thanks a lot for reviewing!
>>
>> If you have a strong opinion about your suggestions, I will happily
>> adapt to them, please let me know.
>
> No strong option, you convinced me your way will actually make things
> more consistent, and Lina prefers them gone as well, so I'm fine with
> them gone (as you've done in V4).
>
> Kevin
>
>

Kevin, thanks for your review!

I haven't applied your Reviewed-by tag to V4, as there where one more
minor additional change added, regarding IRQ safe devices. I
appreciate if could have a look, whenever you have some time.

Kind regards
Uffe
