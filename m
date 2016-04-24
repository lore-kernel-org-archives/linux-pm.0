From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v8 1/4] gadget: Introduce the usb charger framework
Date: Sun, 24 Apr 2016 13:32:46 +0800
Message-ID: <CAMz4ku+3+A03AiyGEiHQPPawDBbTJ-zgYkSVLquQUD-FmCHGEA@mail.gmail.com>
References: <cover.1458822334.git.baolin.wang@linaro.org>
	<612d9e7b1444a2a26923ca97ef1eb1312016c8e0.1458822334.git.baolin.wang@linaro.org>
	<20160423195345.GD15755@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36368 "EHLO
	mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbcDXFcr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Apr 2016 01:32:47 -0400
Received: by mail-yw0-f169.google.com with SMTP id o66so160771093ywc.3
        for <linux-pm@vger.kernel.org>; Sat, 23 Apr 2016 22:32:47 -0700 (PDT)
In-Reply-To: <20160423195345.GD15755@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

Hi Pavel,

On 24 April 2016 at 03:53, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> +/*
>> + * Sysfs attributes:
>> + *
>> + * These sysfs attributes are used for showing and setting different type
>> + * (SDP/DCP/CDP/ACA) chargers' current limitation.
>> + */
>> +static ssize_t sdp_limit_show(struct device *dev,
>> +                           struct device_attribute *attr,
>> +                           char *buf)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +
>> +     return sprintf(buf, "%d\n", uchger->cur_limit.sdp_cur_limit);
>> +}
>> +
>
> Sysfs attributes... can we get appropriate documentation for them?

I've send out the v10 patchset which fixed this issue. Thanks.

>
> Thanks,
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
Baolin.wang
Best Regards
