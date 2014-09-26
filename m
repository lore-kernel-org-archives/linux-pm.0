From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: Re: [PATCH v2] thermal: Add QPNP PMIC temperature alarm driver
Date: Fri, 26 Sep 2014 16:51:50 +0530
Message-ID: <54254C4E.3070807@smartplayin.com>
References: <1411651825-14240-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp101.ord1c.emailsrvr.com ([108.166.43.101]:49024 "EHLO
	smtp101.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753714AbaIZLYC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 07:24:02 -0400
In-Reply-To: <1411651825-14240-1-git-send-email-iivanov@mm-sol.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>

On Thursday 25 September 2014 07:00 PM, Ivan T. Ivanov wrote:
> Add support for the temperature alarm peripheral found inside
> Qualcomm plug-and-play (QPNP) PMIC chips.  The temperature alarm
> peripheral outputs a pulse on an interrupt line whenever the
> thermal over temperature stage value changes.  Implement an ISR
> to manage this interrupt.
>=20

<snip>

> + * This function updates the internal temp value based on the
> + * current thermal stage and threshold as well as the previous stage
> + */
> +static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
> +{
> +	unsigned int stage;
> +	int rc;
> +	u8 reg;
> +
> +	rc =3D qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> +	if (rc < 0)
> +		return rc;
> +
> +	stage =3D reg & STATUS_STAGE_MASK;

During compilation, getting a waring as below,

drivers/thermal/qpnp-temp-alarm.c: In function =91qpnp_tm_update_temp_n=
o_adc=92:
drivers/thermal/qpnp-temp-alarm.c:135:8: warning: =91reg=92 may be used=
 uninitialized in this function [-Wmaybe-uninitialized]
  stage =3D reg & STATUS_STAGE_MASK;

> +
> +	if (stage > chip->stage) {
> +		/* increasing stage, use lower bound */
> +		chip->temp =3D (stage - 1) * TEMP_STAGE_STEP +
> +			     chip->thresh * TEMP_THRESH_STEP +
> +			     TEMP_STAGE_HYSTERESIS + TEMP_THRESH_MIN;
> +	} else if (stage < chip->stage) {
> +		/* decreasing stage, use upper bound */
> +		chip->temp =3D stage * TEMP_STAGE_STEP +
> +			     chip->thresh * TEMP_THRESH_STEP -
> +			     TEMP_STAGE_HYSTERESIS + TEMP_THRESH_MIN;
> +	}
> +
> +	chip->stage =3D stage;
> +
> +	return 0;
> +}
> +

<snip>

> +
> +#define QPNP_TM_PM_OPS	(&qpnp_tm_pm_ops)
> +#else
> +#define QPNP_TM_PM_OPS	NULL
> +#endif
> +
> +static struct of_device_id qpnp_tm_match_table[] =3D {

It must be static const struct of_device_id, because all OF functions h=
andle it as const.

Thanks,
--Kiran

> +	{ .compatible =3D "qcom,spmi-temp-alarm" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, qpnp_tm_match_table);
> +
> +static struct platform_driver qpnp_tm_driver =3D {
> +	.driver =3D {
> +		.name =3D "spmi-temp-alarm",
> +		.of_match_table =3D qpnp_tm_match_table,
> +		.pm =3D QPNP_TM_PM_OPS,
> +	},
> +	.probe  =3D qpnp_tm_probe,
> +	.remove =3D qpnp_tm_remove,
> +};
> +module_platform_driver(qpnp_tm_driver);
> +
> +MODULE_ALIAS("platform:spmi-temp-alarm");
> +MODULE_DESCRIPTION("QPNP PMIC Temperature Alarm driver");
> +MODULE_LICENSE("GPL v2");
>=20

