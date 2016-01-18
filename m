From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] MAINTAINERS: update bq27xxx driver
Date: Mon, 18 Jan 2016 09:29:52 -0600
Message-ID: <569D04F0.6070703@ti.com>
References: <1453063539-18483-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44961 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754939AbcARP3z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 Jan 2016 10:29:55 -0500
In-Reply-To: <1453063539-18483-1-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>

On 01/17/2016 02:45 PM, Sebastian Reichel wrote:
> Update reviewers for bq27xxx, so that Pali and Andrew
> are reviewers with status and maintainer inherited from
> the power supply subsystem entry.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> Cc: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Cc: Andrew F. Davis <afd@ti.com>

Acked-by: Andrew F. Davis <afd@ti.com>

> ---
>   MAINTAINERS | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04d62b1e8b17..6b0098f0a098 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7581,13 +7581,13 @@ S:	Maintained
>   F:	arch/nios2/
>
>   NOKIA N900 POWER SUPPLY DRIVERS
> -M:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
> -S:	Maintained
> +R:	Pali Roh=C3=A1r <pali.rohar@gmail.com>
>   F:	include/linux/power/bq2415x_charger.h
>   F:	include/linux/power/bq27xxx_battery.h
>   F:	include/linux/power/isp1704_charger.h
>   F:	drivers/power/bq2415x_charger.c
>   F:	drivers/power/bq27xxx_battery.c
> +F:	drivers/power/bq27xxx_battery_i2c.c
>   F:	drivers/power/isp1704_charger.c
>   F:	drivers/power/rx51_battery.c
>
> @@ -9414,6 +9414,12 @@ M:	Andreas Noever <andreas.noever@gmail.com>
>   S:	Maintained
>   F:	drivers/thunderbolt/
>
> +TI BQ27XXX POWER SUPPLY DRIVER
> +R:	Andrew F. Davis <afd@ti.com>
> +F:	include/linux/power/bq27xxx_battery.h
> +F:	drivers/power/bq27xxx_battery.c
> +F:	drivers/power/bq27xxx_battery_i2c.c
> +
>   TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
>   M:	John Stultz <john.stultz@linaro.org>
>   M:	Thomas Gleixner <tglx@linutronix.de>
>
