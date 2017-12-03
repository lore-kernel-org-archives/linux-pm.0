From: Linus Walleij <linus.walleij@linaro.org>
Subject: Bridging hwmon and thermal
Date: Sun, 3 Dec 2017 14:24:42 +0100
Message-ID: <CACRpkdYcrFQtp4h2_EfAz1K1dd083RbLzZ7jk1V6mitQLWpS9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:37436 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdLCNYn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Dec 2017 08:24:43 -0500
Received: by mail-io0-f174.google.com with SMTP id d16so15853182iob.4
        for <linux-pm@vger.kernel.org>; Sun, 03 Dec 2017 05:24:43 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-hwmon@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi folks,

This system:
https://dflund.se/~triad/krad/dlink-dns-313/

Has:
- 1 GPIO fan using drivers/hwmon/gpio-fan.c
- 1 temperature sensor using drivers/hwmon/lm75.c

So it is the simplest form of chassis cooling.

Is it possible to use drivers/thermal to set up a policy
for controlling the HWMON fan directly by reading the
HWMON sensor input periodically?

If not: should it be? It seems natural to me.

I guess this stuff is normally "policy in userspace"
but we already have thermal policies in the kernel,
so...

Yours,
Linus Walleij
