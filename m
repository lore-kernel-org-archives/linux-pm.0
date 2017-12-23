From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] PM / core: Assign the wakeup_path status flag in __device_prepare()
Date: Sat, 23 Dec 2017 16:17:58 +0100
Message-ID: <CAPDyKFqKoOuLK2NG+kXthCUSRJnNUf57wCq_eYrkh+-2KTPWhQ@mail.gmail.com>
References: <1513353391-30806-1-git-send-email-ulf.hansson@linaro.org>
 <CAJZ5v0hctW_-WR2Gy4tszeXYJJfTRQbLCr_NRhAXao5_XR5NOw@mail.gmail.com>
 <CAPDyKFqa5Lt6jrDQd+V_cE+Bz2ZRJRe95-8bbJgV=LbkGPM0mw@mail.gmail.com>
 <1742152.iLm4rp6jIy@aspire.rjw.lan> <CAPDyKFpO7_GxjcANYPUO3aEp2uTrnioQ3=hsWSzPg_nDM3Sh-w@mail.gmail.com>
 <CAJZ5v0jp-kmuQGnxc-v9QsFxoCRwULhVDeSjHmCGh93wdRPcDA@mail.gmail.com> <CAJZ5v0iu-5Y9j+Qc-no_BUAamYZ7tq=24qSUu4H=vU98YBXCxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35702 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbdLWPR7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Dec 2017 10:17:59 -0500
Received: by mail-io0-f180.google.com with SMTP id 14so20834391iou.2
        for <linux-pm@vger.kernel.org>; Sat, 23 Dec 2017 07:17:59 -0800 (PST)
In-Reply-To: <CAJZ5v0iu-5Y9j+Qc-no_BUAamYZ7tq=24qSUu4H=vU98YBXCxw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

[...]

>>>> How many drivers actually do call device_set_wakeup_enable() during suspend?
>>>
>>> There are some ethernet/wifi drivers, although it hard to say how many
>>> without a more thorough investigation.
>>>
>>> Besides those I found these more obvious ones:
>>> drivers/ssb/pcihost_wrapper.c
>>> drivers/staging/rtlwifi/core.c
>>> drivers/tty/serial/atmel_serial.c
>>> drivers/usb/core/hcd-pci.c
>>
>> Ugh.  I need to look at the last one at least ...
>
> The drivers/usb/core/hcd-pci.c instance is actually valid, because it
> calls device_set_wakeup_enable() to remove the wakeup source object in
> case the device is dead.  Moreover, it does that in the "noirq" phase
> which is not covered by your patch anyway.

Right, but this puzzles me a bit.

Could you explain what you mean by valid here? Is it okay to call
device_set_wakeup_enable() in the suspend phase after all? No?

My very vague idea at this point is, if we find cases where
device_set_wakeup_enable() makes sense to call during system suspend,
probably those could/should be replaces by using the "wakeup_path"
flag instead, somehow.

Kind regards
Uffe
