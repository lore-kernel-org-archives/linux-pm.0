From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Thu, 17 Mar 2016 09:58:28 +0800
Message-ID: <CAMz4ku++hi2tXjqvUH7du2tzZ1Vjk7OtHfNuMPrmZ_m9EsOwUA@mail.gmail.com>
References: <cover.1458128215.git.baolin.wang@linaro.org>
	<11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
	<1458130190.6570.6.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36104 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbcCQB63 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Mar 2016 21:58:29 -0400
Received: by mail-yw0-f182.google.com with SMTP id g3so84012123ywa.3
        for <linux-pm@vger.kernel.org>; Wed, 16 Mar 2016 18:58:29 -0700 (PDT)
In-Reply-To: <1458130190.6570.6.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 16 March 2016 at 20:09, Oliver Neukum <oneukum@suse.com> wrote:
> On Wed, 2016-03-16 at 19:46 +0800, Baolin Wang wrote:
>> This patch introduces the usb charger driver based on usb gadget that
>> makes an enhancement to a power driver. It works well in practice but
>> that requires a system with suitable hardware.
>>
>> The basic conception of the usb charger is that, when one usb charger
>> is added or removed by reporting from the usb gadget state change or
>> the extcon device state change, the usb charger will report to power
>> user to set the current limitation.
>
> This patch adds sysfs attributes without adding Documentation for them.
> That's bad.

I'll add Documentation for the sysfs attributes in next version
patchset. Thanks for your comments.

-- 
Baolin.wang
Best Regards
