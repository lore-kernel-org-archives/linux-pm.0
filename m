From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v6 1/4] gadget: Introduce the usb charger framework
Date: Mon, 7 Dec 2015 13:27:03 +0800
Message-ID: <CAMz4kuKdKCgEncNW4tWHuMS2EPj=K-YPNzsfC+3teWYz79ax_A@mail.gmail.com>
References: <cover.1447654605.git.baolin.wang@linaro.org>
	<2ae29947ff92198d5613bfb2b925f3f4ba3b2a53.1447654606.git.baolin.wang@linaro.org>
	<20151205162721.GB30410@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33970 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbbLGF1F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 00:27:05 -0500
Received: by ykfs79 with SMTP id s79so184436833ykf.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Dec 2015 21:27:03 -0800 (PST)
In-Reply-To: <20151205162721.GB30410@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Greg KH <gregkh@linuxfoundation.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On 6 December 2015 at 00:27, Sebastian Reichel <sre@kernel.org> wrote:
> Hi,
>
> On Mon, Nov 16, 2015 at 02:33:31PM +0800, Baolin Wang wrote:
>> +static ssize_t cur_limit_show(struct device *dev,
>> +                           struct device_attribute *attr,
>> +                           char *buf)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +
>> +     return scnprintf(buf, PAGE_SIZE, "%d %d %d %d\n",
>> +                      uchger->cur_limit.sdp_cur_limit,
>> +                      uchger->cur_limit.dcp_cur_limit,
>> +                      uchger->cur_limit.cdp_cur_limit,
>> +                      uchger->cur_limit.aca_cur_limit);
>> +}
>> +
>> +static ssize_t cur_limit_store(struct device *dev,
>> +                            struct device_attribute *attr,
>> +                            const char *buf, size_t count)
>> +{
>> +     struct usb_charger *uchger = dev_to_uchger(dev);
>> +     struct usb_charger_cur_limit cur;
>> +     int ret;
>> +
>> +     ret = sscanf(buf, "%d %d %d %d",
>> +                  &cur.sdp_cur_limit, &cur.dcp_cur_limit,
>> +                  &cur.cdp_cur_limit, &cur.aca_cur_limit);
>> +     if (ret == 0)
>> +             return -EINVAL;
>> +
>> +     ret = usb_charger_set_cur_limit(uchger, &cur);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +static DEVICE_ATTR_RW(cur_limit);
>
> I think this functionality should be provided with one file per
> type. This makes it easier to parse the values from userspace
> and makes it possible to extend the frameworks functionality
> (e.g. when new types are added in a newer revision of the USB
> standard).
>

That sounds reasonable and I'll change that. Thanks.

> -- Sebastian



-- 
Baolin.wang
Best Regards
