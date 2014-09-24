From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v3] power: reset: use restart_notifier mechanism for msm-poweroff
Date: Wed, 24 Sep 2014 07:38:05 +0530
Message-ID: <54222785.5030605@smartplayin.com>
References: <1411452520-29589-1-git-send-email-pramod.gurav@smartplayin.com> <542112FD.7080302@smartplayin.com> <2C40727B-BF1E-46AC-9189-6B35E358220E@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp117.ord1c.emailsrvr.com ([108.166.43.117]:39279 "EHLO
	smtp117.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754738AbaIXCIP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Sep 2014 22:08:15 -0400
In-Reply-To: <2C40727B-BF1E-46AC-9189-6B35E358220E@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Josh Cartwright <joshc@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>

Hi Kumar,

On 23-09-2014 11:18 PM, Kumar Gala wrote:
>=20
> On Sep 23, 2014, at 1:28 AM, Pramod Gurav <pramod.gurav@smartplayin.c=
om> wrote:
>=20
>> +linux-arm-msm
>> On Tuesday 23 September 2014 11:38 AM, Pramod Gurav wrote:
>>> This change replaces use of arm_pm_restart with recently introduced
>>> reset mechanism in Linux kernel called restart_notifier.
>=20
> Can you update the commit message to include details about the priori=
ty level we are setting it to.
>=20
> Probably something like Josh had:
>=20
> Choose priority 128, as according to documentation, this mechanism "i=
s
> sufficient to restart the entire system=94.
Will update the commit message.
>=20
> Hmm, what happens if we have ps_hold restart and msm-poweroff enabled=
=2E  Which one should have priority?
In case of A-family/apq8064, the ps_hold register region is owned by
pinctrl hence the reset is implemented in pinctrl driver as the region
is already mapped there.
I have had a discussion with Stephen Boyd and was informed that ps_hold
register region in apq8074/B-family are moved to its own region and we
need to reset it through pinctrl.

So, for b family there is no need for ps_hold to be configured/muxed in
pinctrl and Josh's changes wont execute. Hence msm-poweroff wil be the
default reset as 128 in the default priority.

Hope I was able to put it well to answer your comment.
>=20
>>>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Cc: Josh Cartwright <joshc@codeaurora.org>
>>> Cc: Sebastian Reichel <sre@kernel.org>
>>> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>> Cc: linux-pm@vger.kernel.org
>>>
>>> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>>> ---
>>> Tested on Dragonboard APQ8074
>>>
>>> Changes since v2:
>>> - Removed unwanted header file and added linux/pm.h
>>>
>>> Changes since v1:
>>> - Initialized restart_nb with its declaration
>>> - Removed return check for register_restart_handler as it always
>>>  returns 0 as per Guenter's suggestion to Josh's similar patch.
>>>  This takes care of Guenter's comments on error logs and NULL
>>>  initialization of restart_nb.notifier_call.
>>> ---
>>> drivers/power/reset/msm-poweroff.c |   20 ++++++++++++++------
>>> 1 file changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/res=
et/msm-poweroff.c
>>> index 774f9a3..4702efd 100644
>>> --- a/drivers/power/reset/msm-poweroff.c
>>> +++ b/drivers/power/reset/msm-poweroff.c
>>> @@ -20,21 +20,27 @@
>>> #include <linux/platform_device.h>
>>> #include <linux/module.h>
>>> #include <linux/reboot.h>
>>> -
>>> -#include <asm/system_misc.h>
>>> +#include <linux/pm.h>
>>>
>>> static void __iomem *msm_ps_hold;
>>> -
>>> -static void do_msm_restart(enum reboot_mode reboot_mode, const cha=
r *cmd)
>>> +static int do_msm_restart(struct notifier_block *nb, unsigned long=
 action,
>>> +			   void *data)
>>> {
>>> 	writel(0, msm_ps_hold);
>>> 	mdelay(10000);
>>> +
>>> +	return NOTIFY_DONE;
>>> }
>>>
>>> +static struct notifier_block restart_nb =3D {
>>> +	.notifier_call =3D do_msm_restart,
>>> +	.priority =3D 128,
>>> +};
>>> +
>>> static void do_msm_poweroff(void)
>>> {
>>> 	/* TODO: Add poweroff capability */
>>> -	do_msm_restart(REBOOT_HARD, NULL);
>>> +	do_msm_restart(&restart_nb, 0, NULL);
>>> }
>>>
>>> static int msm_restart_probe(struct platform_device *pdev)
>>> @@ -47,8 +53,10 @@ static int msm_restart_probe(struct platform_dev=
ice *pdev)
>>> 	if (IS_ERR(msm_ps_hold))
>>> 		return PTR_ERR(msm_ps_hold);
>>>
>>> +	register_restart_handler(&restart_nb);
>>> +
>>> 	pm_power_off =3D do_msm_poweroff;
>>> -	arm_pm_restart =3D do_msm_restart;
>>> +
>>> 	return 0;
>>> }
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-=
msm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
