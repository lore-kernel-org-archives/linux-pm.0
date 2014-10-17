From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 6/6] cpufreq: Loongson1: Add cpufreq driver for Loongson1B
Date: Fri, 17 Oct 2014 15:18:00 +0530
Message-ID: <CAKohpokYhpTU-SXYuLbGz4TxhhWvring_2PB-CVBWeGjdeeXKA@mail.gmail.com>
References: <1413527826-22906-1-git-send-email-keguang.zhang@gmail.com>
	<CAKohpo=iRubshWkv0xj6DDomeR-wdYs3y2QebCgW5u-dvu0J3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:41115 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaJQJsB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Oct 2014 05:48:01 -0400
Received: by mail-ob0-f182.google.com with SMTP id uy5so328142obc.27
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2014 02:48:01 -0700 (PDT)
In-Reply-To: <CAKohpo=iRubshWkv0xj6DDomeR-wdYs3y2QebCgW5u-dvu0J3g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kelvin Cheung <keguang.zhang@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>

On 17 October 2014 13:47, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 17 October 2014 12:07, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
>> V2:
>>    Use devm_clk_get() instead of clk_get().
>
> Search for a few drivers which have used this API and understand how
> to use it.

To elaborate it a bit further, devm_* routines are there to make our
lives simple.
And they do it by allowing us to skip error handling.

So in your case because you are doing devm_clk_get(), you don't have to put
the clk on errors or in remove() routine. The device core will do that for you
once the device/driver bond finishes.

Also, what about clk_enable/prepare for these clks? You don't need them ?

--
viresh
