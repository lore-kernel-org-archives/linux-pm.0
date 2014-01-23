From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: Re: [PATCH 1/1] PM / devfreq: Disable Exynos4 driver build on multiplatform
Date: Thu, 23 Jan 2014 17:19:47 +0530
Message-ID: <CAK9yfHzEf8zNamx7rQQsVSJcnrzpmsg6MoGWZKqs8mGCDfTUYg@mail.gmail.com>
References: <20964708.133421390477693450.JavaMail.weblogic@epml17>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:38778 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaAWLts (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2014 06:49:48 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp4so1877444obc.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2014 03:49:48 -0800 (PST)
In-Reply-To: <20964708.133421390477693450.JavaMail.weblogic@epml17>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>

On 23 January 2014 17:18, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> On 23 January 2014 16:42, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> >> Exynos4 devfreq driver uses mach/map.h which is not available on
>> >> multiplatform. Hence disable build on multiplatform for now.
>> >> Without this patch we get the following build errors:
>> >> drivers/devfreq/exynos/exynos4_bus.h:15:22: fatal error: mach/map.h: No such file or directory
>> >>
>> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> >
>> > Isn't this also required to be sent to linux-stable?
>>
>> No. This will be needed in the upcoming cycle onwards.
>>
>> >
>> > Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>>
>> Wouldn't you be queueing this in your tree?
>
> yes, it's merged and in the tree as well. (will rebase before sending pull request)

OK. Thanks.


-- 
With warm regards,
Sachin
