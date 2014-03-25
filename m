From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] ARM: machine_power_off should not return
Date: Tue, 25 Mar 2014 19:45:55 -0300
Message-ID: <20140325224554.GC12185@arch.cereza>
References: <1395684784-12601-1-git-send-email-sebastian.capella@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49753 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751806AbaCYWqR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Mar 2014 18:46:17 -0400
Content-Disposition: inline
In-Reply-To: <1395684784-12601-1-git-send-email-sebastian.capella@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Capella <sebastian.capella@linaro.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org

Let's Cc: LAKML, and To: Russell.

Russell, any comments on this?

Without this patch we got the heartbeat's reboot_notifier called twice =
while
testing the recent hibernation patches, which was unexpected and produc=
ed a
kernel panic: https://lkml.org/lkml/2014/3/19/363

Instead of fixing the heartbeat LED trigger, or the hibernation code, i=
t
seems better to fix the ARM machine_power_off, as it's not supposed to =
return.

On Mar 24, Sebastian Capella wrote:
> Add loop to prevent return from machine_power_off if
> pm_power_off is null or does not halt the system.
> This caused a panic during hibernation testing on Kirkwood
> Openblocks A6 board.
>=20
> Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
> Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  arch/arm/kernel/process.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index f58b723..6ffdc2c 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -217,6 +217,8 @@ void machine_power_off(void)
> =20
>  	if (pm_power_off)
>  		pm_power_off();
> +	while (1)
> +		cpu_relax();
>  }
> =20
>  /*
> --=20
> 1.7.9.5
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
