From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/17][UPDATE] mfd: qcom_rpm: Drop use of IRQF_NO_SUSPEND
 flag
Date: Fri, 25 Sep 2015 17:08:28 +0100
Message-ID: <20150925160828.GG27197@x1>
References: <1442850433-5903-8-git-send-email-sudeep.holla@arm.com>
 <1443184753-6803-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443184753-6803-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Sep 2015, Sudeep Holla wrote:

> The driver handles wakeup irq correctly using irq_set_irq_wake. There=
's
> no need to use IRQF_NO_SUSPEND while registering the interrupt.
>=20
> This patch removes the use of IRQF_NO_SUSPEND flag.
>=20
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/mfd/qcom_rpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Updated version with the $subject fixed and Lee's ACK.

Applied, thanks.

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
