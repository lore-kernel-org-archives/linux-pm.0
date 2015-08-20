From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] thermal: cpu_cooling: Add MAINTAINERS entry
Date: Thu, 20 Aug 2015 10:28:34 +0900
Message-ID: <CAJKOXPcyAxLXscpcN+t-P=MOPKcvKAW-BnuEg1Lah2iXjYhW9g@mail.gmail.com>
References: <298acc438cba5f64121d883db7ff2b860c0a9610.1439967508.git.viresh.kumar@linaro.org>
	<20150819174444.GA6643@localhost.localdomain>
	<20150819180350.GH14544@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35976 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbHTB2f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 21:28:35 -0400
Received: by qkep139 with SMTP id p139so9328750qke.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2015 18:28:34 -0700 (PDT)
In-Reply-To: <20150819180350.GH14544@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, amit.daniel@samsung.com
Cc: Eduardo Valentin <edubezval@gmail.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rui.zhang@intel.com

2015-08-20 3:03 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> On 19-08-15, 10:44, Eduardo Valentin wrote:
>> Interesting. I would expect that by this point, you would be already
>> listed.. anyways..
>
> No, its just you and Zhang.
>
>> > +THERMAL/CPU_COOLING
>> > +M: Amit Daniel Kachhap <amit.daniel@samsung.com>
>>
>> Is this still a valid email? I remember one of his email was bouncing
>> back.
>
> I see his last mail to LKML on 27th March, and I didn't receive a
> bounced email auto-reply, so it should be just fine :)

Yes, the email is correct. However before adding a new maintainer
could we get a confirmation/agreement form Amit?

Unfortunately it seems that a lot of guys previously working on Exynos
BSP with (or in) Linaro are not responding on LKML any more. No
reviews, no comments. That does not apply to everyone but I think its
better not to add a "dead" entry.


Amit,
Could you ack this patch?

Best regards,
Krzysztof
