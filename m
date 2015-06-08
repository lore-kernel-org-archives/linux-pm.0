From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2] power: max17042_battery: add HEALTH and TEMP_*
 properties support
Date: Mon, 8 Jun 2015 10:22:21 +0900
Message-ID: <CAJKOXPeUvdC5LwRLgsFfxz2=SZwkjq2soGius+j6kb76Ea940A@mail.gmail.com>
References: <1432438918-31002-1-git-send-email-ramakrishna.pallala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f42.google.com ([209.85.216.42]:34991 "EHLO
	mail-vn0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbbFHBWW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2015 21:22:22 -0400
In-Reply-To: <1432438918-31002-1-git-send-email-ramakrishna.pallala@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>

2015-05-24 12:41 GMT+09:00 Ramakrishna Pallala <ramakrishna.pallala@intel.com>:
> This patch adds the support for following battery properties
> to max17042 fuel gauge driver.
>
> POWER_SUPPLY_PROP_TEMP_ALERT_MIN
> POWER_SUPPLY_PROP_TEMP_ALERT_MAX
> POWER_SUPPLY_PROP_TEMP_MIN
> POWER_SUPPLY_PROP_TEMP_MAX
> POWER_SUPPLY_PROP_HEALTH

I wonder, have you tested the patch? After booting on Trats2 device
(max77693 which identifies itself as 17047-like) the values are:
POWER_SUPPLY_TEMP_ALERT_MIN=1280
POWER_SUPPLY_TEMP_ALERT_MAX=1270
POWER_SUPPLY_TEMP=257
This is okay, datasheet says that register after booting will have
value of 0x7f80.

However setting them to some value which should trigger interrupts
(like 300 for MIN or 200 for MAX) does not trigger the interrupt. I
added a printk in max17042_thread_handler().

Is the temperature alert feature working?

Best regards,
Krzysztof
