From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v3] power: reset: use restart_notifier mechanism for msm-poweroff
Date: Tue, 23 Sep 2014 12:48:42 -0500
Message-ID: <2C40727B-BF1E-46AC-9189-6B35E358220E@codeaurora.org>
References: <1411452520-29589-1-git-send-email-pramod.gurav@smartplayin.com> <542112FD.7080302@smartplayin.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <542112FD.7080302@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Josh Cartwright <joshc@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On Sep 23, 2014, at 1:28 AM, Pramod Gurav <pramod.gurav@smartplayin.com=
> wrote:

> +linux-arm-msm
> On Tuesday 23 September 2014 11:38 AM, Pramod Gurav wrote:
>> This change replaces use of arm_pm_restart with recently introduced
>> reset mechanism in Linux kernel called restart_notifier.

Can you update the commit message to include details about the priority=
 level we are setting it to.

Probably something like Josh had:

Choose priority 128, as according to documentation, this mechanism "is
sufficient to restart the entire system=94.

Hmm, what happens if we have ps_hold restart and msm-poweroff enabled. =
 Which one should have priority?

>>=20
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: Josh Cartwright <joshc@codeaurora.org>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: linux-pm@vger.kernel.org
>>=20
>> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>> ---
>> Tested on Dragonboard APQ8074
>>=20
>> Changes since v2:
>> - Removed unwanted header file and added linux/pm.h
>>=20
>> Changes since v1:
>> - Initialized restart_nb with its declaration
>> - Removed return check for register_restart_handler as it always
>>  returns 0 as per Guenter's suggestion to Josh's similar patch.
>>  This takes care of Guenter's comments on error logs and NULL
>>  initialization of restart_nb.notifier_call.
>> ---
>> drivers/power/reset/msm-poweroff.c |   20 ++++++++++++++------
>> 1 file changed, 14 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/rese=
t/msm-poweroff.c
>> index 774f9a3..4702efd 100644
>> --- a/drivers/power/reset/msm-poweroff.c
>> +++ b/drivers/power/reset/msm-poweroff.c
>> @@ -20,21 +20,27 @@
>> #include <linux/platform_device.h>
>> #include <linux/module.h>
>> #include <linux/reboot.h>
>> -
>> -#include <asm/system_misc.h>
>> +#include <linux/pm.h>
>>=20
>> static void __iomem *msm_ps_hold;
>> -
>> -static void do_msm_restart(enum reboot_mode reboot_mode, const char=
 *cmd)
>> +static int do_msm_restart(struct notifier_block *nb, unsigned long =
action,
>> +			   void *data)
>> {
>> 	writel(0, msm_ps_hold);
>> 	mdelay(10000);
>> +
>> +	return NOTIFY_DONE;
>> }
>>=20
>> +static struct notifier_block restart_nb =3D {
>> +	.notifier_call =3D do_msm_restart,
>> +	.priority =3D 128,
>> +};
>> +
>> static void do_msm_poweroff(void)
>> {
>> 	/* TODO: Add poweroff capability */
>> -	do_msm_restart(REBOOT_HARD, NULL);
>> +	do_msm_restart(&restart_nb, 0, NULL);
>> }
>>=20
>> static int msm_restart_probe(struct platform_device *pdev)
>> @@ -47,8 +53,10 @@ static int msm_restart_probe(struct platform_devi=
ce *pdev)
>> 	if (IS_ERR(msm_ps_hold))
>> 		return PTR_ERR(msm_ps_hold);
>>=20
>> +	register_restart_handler(&restart_nb);
>> +
>> 	pm_power_off =3D do_msm_poweroff;
>> -	arm_pm_restart =3D do_msm_restart;
>> +
>> 	return 0;
>> }
>>=20
>>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-m=
sm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation
