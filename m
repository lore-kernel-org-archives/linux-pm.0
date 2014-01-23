From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] PM / devfreq: Disable Exynos4 driver build on multiplatform
Date: Thu, 23 Jan 2014 17:15:50 +0530
Message-ID: <CAK9yfHzqTL0RSzJ6mXE+JRP8G2u1YWD2jtwqVk4Qqq9GyS4DpA@mail.gmail.com>
References: <33543877.132991390475569978.JavaMail.weblogic@epml17>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:44696 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbaAWLpv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2014 06:45:51 -0500
Received: by mail-oa0-f42.google.com with SMTP id i7so1983817oag.29
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2014 03:45:50 -0800 (PST)
In-Reply-To: <33543877.132991390475569978.JavaMail.weblogic@epml17>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>

On 23 January 2014 16:42, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> Exynos4 devfreq driver uses mach/map.h which is not available on
>> multiplatform. Hence disable build on multiplatform for now.
>> Without this patch we get the following build errors:
>> drivers/devfreq/exynos/exynos4_bus.h:15:22: fatal error: mach/map.h: No such file or directory
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Isn't this also required to be sent to linux-stable?

No. This will be needed in the upcoming cycle onwards.

>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Wouldn't you be queueing this in your tree?

-- 
With warm regards,
Sachin
