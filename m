From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Bridging hwmon and thermal
Date: Sun, 3 Dec 2017 07:39:16 -0800
Message-ID: <2ba33ee3-9c49-6d22-cf1e-f6b28afe5d62@roeck-us.net>
References: <CACRpkdYcrFQtp4h2_EfAz1K1dd083RbLzZ7jk1V6mitQLWpS9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41028 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbdLCPjT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Dec 2017 10:39:19 -0500
In-Reply-To: <CACRpkdYcrFQtp4h2_EfAz1K1dd083RbLzZ7jk1V6mitQLWpS9Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

On 12/03/2017 05:24 AM, Linus Walleij wrote:
> Hi folks,
> 
> This system:
> https://dflund.se/~triad/krad/dlink-dns-313/
> 
> Has:
> - 1 GPIO fan using drivers/hwmon/gpio-fan.c
> - 1 temperature sensor using drivers/hwmon/lm75.c
> 
> So it is the simplest form of chassis cooling.
> 
> Is it possible to use drivers/thermal to set up a policy
> for controlling the HWMON fan directly by reading the
> HWMON sensor input periodically?
> 

Both register with the thermal subsystem, so I would think
it should be possible, at least for devicetree enabled systems
(the hwmon subsystem uses a devm function to register
sensors with the thermal subsystem, and the only available
devm function is devm_thermal_zone_of_sensor_register).

Guenter

> If not: should it be? It seems natural to me.
> 
> I guess this stuff is normally "policy in userspace"
> but we already have thermal policies in the kernel,
> so...
> 
> Yours,
> Linus Walleij
> 
