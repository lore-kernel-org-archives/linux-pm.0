From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: add missing header include
Date: Sun, 28 Oct 2012 22:49:24 +0100
Message-ID: <508DA864.8020503@linaro.org>
References: <001401cdb332$93ffe450$bbffacf0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:54932 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420Ab2J1Vt2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Oct 2012 17:49:28 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so1478465eaa.19
        for <linux-pm@vger.kernel.org>; Sun, 28 Oct 2012 14:49:27 -0700 (PDT)
In-Reply-To: <001401cdb332$93ffe450$bbffacf0$%han@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/26/2012 06:30 AM, Jingoo Han wrote:
> This patch adds missing device.h header to fix build warnings as belo=
w:
>=20
> drivers/cpuidle/cpuidle.h:26:41: warning: 'struct device' declared in=
side parameter list [enabled by default]
> drivers/cpuidle/cpuidle.h:26:41: warning: its scope is only this defi=
nition or declaration, which is probably not what you want
> [enabled by default]
> drivers/cpuidle/cpuidle.h:27:45: warning: 'struct device' declared in=
side parameter list [enabled by default]
> In file included from drivers/cpuidle/driver.c:15:0:
> drivers/cpuidle/cpuidle.h:26:41: warning: 'struct device' declared in=
side parameter list [enabled by default]
> drivers/cpuidle/cpuidle.h:26:41: warning: its scope is only this defi=
nition or declaration, which is probably not what you want
> [enabled by default]
> drivers/cpuidle/cpuidle.h:27:45: warning: 'struct device' declared in=
side parameter list [enabled by default]
>=20
> This build warning is introduced by commit efeca1b
> "cpuidle / sysfs: change function parameter".
>=20
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Jingoo, could you copy-pastebin your config file. I don't have this
warning and I would like to understand why.

Thanks
  -- Daniel

>  drivers/cpuidle/cpuidle.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> index a5bbd1c..2120d9e 100644
> --- a/drivers/cpuidle/cpuidle.h
> +++ b/drivers/cpuidle/cpuidle.h
> @@ -5,6 +5,8 @@
>  #ifndef __DRIVER_CPUIDLE_H
>  #define __DRIVER_CPUIDLE_H
> =20
> +#include <linux/device.h>
> +
>  /* For internal use only */
>  extern struct cpuidle_governor *cpuidle_curr_governor;
>  extern struct list_head cpuidle_governors;


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

