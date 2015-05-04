From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/4] cpuidle: Check the sign of index in cpuidle_reflect()
Date: Mon, 04 May 2015 16:02:31 +0200
Message-ID: <55477BF7.2020102@linaro.org>
References: <3084951.QaIkFrZ3VU@vostro.rjw.lan> <1452615.qnuzHTbuFj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34744 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbbEDOCe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 10:02:34 -0400
Received: by wgso17 with SMTP id o17so151331371wgs.1
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2015 07:02:33 -0700 (PDT)
In-Reply-To: <1452615.qnuzHTbuFj@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 05/04/2015 03:57 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Avoid calling the governor's ->reflect method if the state index
> passed to cpuidle_reflect() is negative.
>
> This allows the analogous check to be dropped from menu_reflect(),
> so do that too, and ensures that arbitrary error codes can be
> passed to cpuidle_reflect() as the index with no adverse
> consequences.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>   drivers/cpuidle/cpuidle.c        |    2 +-
>   drivers/cpuidle/governors/menu.c |    4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -249,7 +249,7 @@ int cpuidle_enter(struct cpuidle_driver
>    */
>   void cpuidle_reflect(struct cpuidle_device *dev, int index)
>   {
> -	if (cpuidle_curr_governor->reflect)
> +	if (cpuidle_curr_governor->reflect && index >=3D 0)
>   		cpuidle_curr_governor->reflect(dev, index);
>   }
>
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -367,9 +367,9 @@ static int menu_select(struct cpuidle_dr
>   static void menu_reflect(struct cpuidle_device *dev, int index)
>   {
>   	struct menu_device *data =3D this_cpu_ptr(&menu_devices);
> +
>   	data->last_state_idx =3D index;
> -	if (index >=3D 0)
> -		data->needs_update =3D 1;
> +	data->needs_update =3D 1;
>   }
>
>   /**
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

