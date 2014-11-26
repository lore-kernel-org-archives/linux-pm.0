From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v10 07/10] qcom: cpuidle: Add cpuidle driver for QCOM
 cpus
Date: Wed, 26 Nov 2014 11:04:09 +0100
Message-ID: <5475A599.1010601@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org> <1416593037-27527-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416593037-27527-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/21/2014 07:03 PM, Lina Iyer wrote:
> Add cpuidle driver interface to allow cpus to go into C-States. Use t=
he
> cpuidle DT interface, common across ARM architectures, to provide the
> idle state information to the cpuidle framework.
>
> Supported modes at this time are Standby and Standalone Power Collaps=
e.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

One nit and one comment below. Other than that:

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]

> +static int qcom_cpu_stby(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	lpm_ops->standby(NULL);

In my last comment I was referring about a check for entering=20
successfully the idle state:

	if (lpm_ops->standby(NULL))
		return -1;

> +	return index;
> +}
> +
> +static int qcom_cpu_spc(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv, int index)
> +{
> +	lpm_ops->spc(NULL);
> +
> +	return index;
> +}
> +
> +static struct cpuidle_driver qcom_cpuidle_driver =3D {
> +	.name	=3D "qcom_cpuidle",
> +};
> +
> +static const struct of_device_id qcom_idle_state_match[] =3D {
> +	{ .compatible =3D "qcom,idle-state-stby", .data =3D qcom_cpu_stby},

                                                                    ^^^=
^
		a missing space right before the closing bracket.

> +	{ .compatible =3D "qcom,idle-state-spc", .data =3D qcom_cpu_spc },
> +	{ },
> +};
> +

Thanks!

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
