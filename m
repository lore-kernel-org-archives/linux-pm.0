From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Wed, 15 Nov 2017 08:22:54 +0100
Message-ID: <CAPDyKFoZ7wj8Cx_P1FiNxE-5qOt-_sPY6Tt1z8bmi2TPxwdF_Q@mail.gmail.com>
References: <1713438.irjm9MTSvo@aspire.rjw.lan> <CAPDyKFrzJuWVr9hmcU-S6LMMGTh2pyQcjMJc2+ky5AmctatOLQ@mail.gmail.com>
 <CAPDyKFo0pufKdZ=5Dn84UewE7qN3ztVKjRV1_TyM_DcxX2B7Ug@mail.gmail.com> <5072995.lhOZmqyh0S@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:43296 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbdKOHW4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 02:22:56 -0500
Received: by mail-io0-f174.google.com with SMTP id 189so604486iow.10
        for <linux-pm@vger.kernel.org>; Tue, 14 Nov 2017 23:22:56 -0800 (PST)
In-Reply-To: <5072995.lhOZmqyh0S@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linus Walleij <linus.walleij@linaro.org>

[...]

>>
>> When pm_runtime_set_suspended(dev) is called, dev's child device may
>> still be runtime PM enabled and active.
>> I was suggesting to add a check for this scenario, to see if dev's
>> child device is runtime PM is enabled, as and additional constraint
>> before deciding to return an error code.
>
> Well, that's sort of difficult to do, however, because the code would need to
> walk all of the children of the device and the child power lock cannot be
> acquired under the one of the parent, so it would be fragile and ugly.

Yeah, you have a point.

>
>> The idea was to get a consistent behavior, from the
>> pm_runtime_set_active|suspended() APIs point of view, and not from the
>> runtime PM core point of view.
>
> Yes, but the cost is high and the benefit is shallow.
>
> The enable-time WARN() should cover the really broken cases without that
> much complexity.

Fair enough!

Feel free to add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
