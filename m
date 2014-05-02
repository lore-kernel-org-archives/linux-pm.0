From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] cpuidle / menu: Return error code if there are no
 suitable states
Date: Fri, 02 May 2014 10:47:48 +0200
Message-ID: <53635BB4.30900@linaro.org>
References: <2471963.urOyfY8mOG@vostro.rjw.lan> <535E3818.2040905@linaro.org> <2000825.kO1es8ShkW@vostro.rjw.lan> <1516317.nEvPfS8aZ7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37908 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbaEBIrq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 May 2014 04:47:46 -0400
Received: by mail-wi0-f179.google.com with SMTP id bs8so1966278wib.0
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2014 01:47:45 -0700 (PDT)
In-Reply-To: <1516317.nEvPfS8aZ7@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>

On 04/30/2014 01:16 AM, Rafael J. Wysocki wrote:
> On Tuesday, April 29, 2014 01:28:03 AM Rafael J. Wysocki wrote:
>> On Monday, April 28, 2014 01:14:32 PM Daniel Lezcano wrote:
>>> On 04/27/2014 02:55 PM, Rafael J. Wysocki wrote:

[ ... ]

> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: cpuidle / menu: Return (-1) if there are no suitable states
>
> If there is a PM QoS latency limit and all of the sufficiently shallo=
w
> C-states are disabled, the cpuidle menu governor returns 0 which on
> some systems is CPUIDLE_DRIVER_STATE_START and shouldn't be returned
> if that C-state has been disabled.
>
> Fix the issue by modifying the menu governor to return (-1) in such
> situations.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/cpuidle/governors/menu.c |    2 +-
>   include/linux/cpuidle.h          |    2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -296,7 +296,7 @@ static int menu_select(struct cpuidle_dr
>   		data->needs_update =3D 0;
>   	}
>
> -	data->last_state_idx =3D 0;
> +	data->last_state_idx =3D CPUIDLE_DRIVER_STATE_START - 1;

In case of x86, CPUIDLE_DRIVER_STATE_START will be 1, so the select=20
function could return 0 even this one is disabled and this is not what=20
you want to happen, no ?


>   	/* Special case when user has set very strict latency requirement =
*/
>   	if (unlikely(latency_req =3D=3D 0))
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

