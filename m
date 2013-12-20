From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 7/9] intel_idle: remove superfluous dev->state_count
 initialization
Date: Fri, 20 Dec 2013 22:48:36 +0100
Message-ID: <52B4BB34.70804@linaro.org>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com> <1387565251-7051-8-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:56482 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab3LTVse (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2013 16:48:34 -0500
Received: by mail-we0-f171.google.com with SMTP id q58so3070316wes.16
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2013 13:48:33 -0800 (PST)
In-Reply-To: <1387565251-7051-8-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kyungmin.park@samsung.com

On 12/20/2013 07:47 PM, Bartlomiej Zolnierkiewicz wrote:
> intel_idle driver sets dev->state_count to drv->state_count so
> the default dev->state_count initialization in cpuidle_enable_device(=
)
> (called from cpuidle_register_device()) can be used instead.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Len Brown <lenb@kernel.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/idle/intel_idle.c | 29 -----------------------------
>   1 file changed, 29 deletions(-)
>
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 38da3fb..524d07b 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -639,39 +639,10 @@ static int __init intel_idle_cpuidle_driver_ini=
t(void)
>    */
>   static int intel_idle_cpu_init(int cpu)
>   {
> -	int cstate;
>   	struct cpuidle_device *dev;
>
>   	dev =3D per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
>
> -	dev->state_count =3D 1;
> -
> -	for (cstate =3D 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
> -		int num_substates, mwait_hint, mwait_cstate, mwait_substate;
> -
> -		if (cpuidle_state_table[cstate].enter =3D=3D NULL)
> -			break;
> -
> -		if (cstate + 1 > max_cstate) {
> -			printk(PREFIX "max_cstate %d reached\n", max_cstate);
> -			break;
> -		}
> -
> -		mwait_hint =3D flg2MWAIT(cpuidle_state_table[cstate].flags);
> -		mwait_cstate =3D MWAIT_HINT2CSTATE(mwait_hint);
> -		mwait_substate =3D MWAIT_HINT2SUBSTATE(mwait_hint);
> -
> -		/* does the state exist in CPUID.MWAIT? */
> -		num_substates =3D (mwait_substates >> ((mwait_cstate + 1) * 4))
> -					& MWAIT_SUBSTATE_MASK;
> -
> -		/* if sub-state in table is not enumerated by CPUID */
> -		if ((mwait_substate + 1) > num_substates)
> -			continue;
> -
> -		dev->state_count +=3D 1;
> -	}
> -
>   	dev->cpu =3D cpu;
>
>   	if (cpuidle_register_device(dev)) {
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

