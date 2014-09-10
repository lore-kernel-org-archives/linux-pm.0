From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCHv2 2/4] cpufreq: cpufreq-dt: extend with platform_data
Date: Wed, 10 Sep 2014 18:02:59 +0530
Message-ID: <CAKohpo=EPrwbu7RhyXAXeq2U9uV2BeLZHrMKTg3oAF1oZb0QmA@mail.gmail.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
	<1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1410350908-11316-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAKohpokH4ZoM=+i3wW73o_Xf26ysBaXbNNzGUB0ofcc0EkK3WA@mail.gmail.com>
	<20140910142841.17ae320a@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:48266 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbaIJMdA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 08:33:00 -0400
Received: by mail-oa0-f49.google.com with SMTP id m19so1722767oag.8
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2014 05:33:00 -0700 (PDT)
In-Reply-To: <20140910142841.17ae320a@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Arnd Bergmann <arnd.bergmann@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>

On 10 September 2014 17:58, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Viresh Kumar,
>
> On Wed, 10 Sep 2014 17:52:59 +0530, Viresh Kumar wrote:
>> On 10 September 2014 17:38, Thomas Petazzoni
>> <thomas.petazzoni@free-electrons.com> wrote:
>> > +       dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
>>
>> I don't think this is right. What if platform device's platform data
>> is freed later?
>> That's why its always better to duplicate that structure instead of playing with
>> pointers.
>
> Isn't the piece of code registering the platform_device supposed to
> make sure that platform_data doesn't disappear? At least, in PATCH 3/4,

I don't know. I remember this from the days when I used to write individual
drivers for SPEAr platform... Its been some time now that I have seen this :)

> I'm using platform_device_register_data(), which does a kmemdup() of
> the custom data being passed before assigning the struct
> device->platform_data field.

Atleast in your case it isn't required to copy anymore but this driver can be
used by others which may not guarantee that..

> But if you like, I can add one more memory copy :)

Its not what I like, as wasting memory isn't sensible at all.. But about what's
the right thing to do to make this code un-breakable..

@Arnd: Any inputs?
