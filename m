From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: Re: [PATCH v2] thermal: Add QPNP PMIC temperature alarm driver
Date: Tue, 30 Sep 2014 10:00:23 +0530
Message-ID: <542A31DF.7020402@smartplayin.com>
References: <1411651825-14240-1-git-send-email-iivanov@mm-sol.com>  <54254C4E.3070807@smartplayin.com> <1411998865.5395.5.camel@iivanov-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411998865.5395.5.camel@iivanov-dev>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Monday 29 September 2014 07:24 PM, Ivan T. Ivanov wrote:
> On Fri, 2014-09-26 at 16:51 +0530, Kiran Padwal wrote:
>> On Thursday 25 September 2014 07:00 PM, Ivan T. Ivanov wrote:
>>> Add support for the temperature alarm peripheral found inside
>>> Qualcomm plug-and-play (QPNP) PMIC chips.  The temperature alarm
>>> peripheral outputs a pulse on an interrupt line whenever the
>>> thermal over temperature stage value changes.  Implement an ISR
>>> to manage this interrupt.
>>>
>>
>> <snip>
>>
>>> + * This function updates the internal temp value based on the
>>> + * current thermal stage and threshold as well as the previous sta=
ge
>>> + */
>>> +static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
>>> +{
>>> +	unsigned int stage;
>>> +	int rc;
>>> +	u8 reg;
>>> +
>>> +	rc =3D qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
>>> +	if (rc < 0)
>>> +		return rc;
>>> +
>>> +	stage =3D reg & STATUS_STAGE_MASK;
>>
>> During compilation, getting a waring as below,
>>
>> drivers/thermal/qpnp-temp-alarm.c: In function =E2=80=98qpnp_tm_upda=
te_temp_no_adc=E2=80=99:
>> drivers/thermal/qpnp-temp-alarm.c:135:8: warning: =E2=80=98reg=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]
>>   stage =3D reg & STATUS_STAGE_MASK;
>=20
> Could you share compiler version and options which you are using.
> I am unable to trigger this warning. Looking code I can not=20
> see how this could happen.

I have Linaro cross tool chain with version-4.8.3 and I am simply doing=
 "make zImage" without any option.

Thanks,
--Kiran
>=20
>>
>>> +
>>> +	if (stage > chip->stage) {
>>> +		/* increasing stage, use lower bound */
>>> +		chip->temp =3D (stage - 1) * TEMP_STAGE_STEP +
>>> +			     chip->thresh * TEMP_THRESH_STEP +
>>> +			     TEMP_STAGE_HYSTERESIS + TEMP_THRESH_MIN;
>>> +	} else if (stage < chip->stage) {
>>> +		/* decreasing stage, use upper bound */
>>> +		chip->temp =3D stage * TEMP_STAGE_STEP +
>>> +			     chip->thresh * TEMP_THRESH_STEP -
>>> +			     TEMP_STAGE_HYSTERESIS + TEMP_THRESH_MIN;
>>> +	}
>>> +
>>> +	chip->stage =3D stage;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>
>> <snip>
>>
>>> +
>>> +#define QPNP_TM_PM_OPS	(&qpnp_tm_pm_ops)
>>> +#else
>>> +#define QPNP_TM_PM_OPS	NULL
>>> +#endif
>>> +
>>> +static struct of_device_id qpnp_tm_match_table[] =3D {
>>
>> It must be static const struct of_device_id, because all OF function=
s handle it as const.
>=20
> Sure, will fix it.
>=20
> Thank you,
> Ivan
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-m=
sm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
