From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Tue, 22 Sep 2015 00:21:32 +0100
Message-ID: <20150921232132.GE11284@x1>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-8-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36190 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788AbbIUXVj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 19:21:39 -0400
Received: by padbj2 with SMTP id bj2so4428281pad.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2015 16:21:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1442850433-5903-8-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Samuel Ortiz <sameo@linux.intel.com>

The $SUBJECT is not correct.

> The driver handles wakeup irq correctly using irq_set_irq_wake. There=
's
> no need to use IRQF_NO_SUSPEND while registering the interrupt.
>=20
> This patch removes the use of IRQF_NO_SUSPEND flag.
>=20
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/mfd/qcom_rpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

=2E.. code is fine though:

Acked-by: Lee Jones <lee.jones@linaro.org>

Please re-submit with the subject line fixed.

> diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
> index 6afc9fabd94c..207a3bd68559 100644
> --- a/drivers/mfd/qcom_rpm.c
> +++ b/drivers/mfd/qcom_rpm.c
> @@ -550,7 +550,7 @@ static int qcom_rpm_probe(struct platform_device =
*pdev)
>  	ret =3D devm_request_irq(&pdev->dev,
>  			       irq_ack,
>  			       qcom_rpm_ack_interrupt,
> -			       IRQF_TRIGGER_RISING | IRQF_NO_SUSPEND,
> +			       IRQF_TRIGGER_RISING,
>  			       "qcom_rpm_ack",
>  			       rpm);
>  	if (ret) {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
