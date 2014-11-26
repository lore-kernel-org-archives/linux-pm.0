From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
Date: Wed, 26 Nov 2014 22:25:00 +0100
Message-ID: <5476452C.9040107@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>	<1414194024-55547-3-git-send-email-lina.iyer@linaro.org> <7hy4qxet3c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36914 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbaKZVZH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 16:25:07 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so4821393wgg.35
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 13:25:05 -0800 (PST)
In-Reply-To: <7hy4qxet3c.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>
Cc: sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 11/26/2014 07:04 PM, Kevin Hilman wrote:
> Oops, I thought I had sent this, but it was sitting in the drafts
> folder.  Sending anyways because it looks like most of these issues
> still exist in v10.

[ ... ]

>> +	 * On some SoC's if the control registers are written first and if=
 the
>> +	 * CPU was held in reset, the reset signal could trigger the SPM s=
tate
>> +	 * machine, before the sequences are completely written.
>> +	 */
>> +	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
>> +	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
>> +	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly)=
;
>> +
>> +	spm_register_write(drv, SPM_REG_PMIC_DATA_0,
>> +				drv->reg_data->pmic_data[0]);
>> +	spm_register_write(drv, SPM_REG_PMIC_DATA_1,
>> +				drv->reg_data->pmic_data[1]);
>> +
>> +	/**
>> +	 * Ensure all observers see the above register writes before the
>> +	 * cpuidle driver is allowed to use the SPM.
>> +	 */
>> +	wmb();
>> +	drv->available =3D true;
>
> Others have already commented on this, but I'll add my $0.02 that thi=
s
> suggest something is not right in the init sequence.

Yep, I did the same comment. There is very likely something wrong in th=
e=20
init sequence somewhere.

Lina, you really have to lean over that.

>> +	if ((cpu > -1) && !cpuidle_drv_init) {
>> +		platform_device_register(&qcom_cpuidle_device);
>> +		cpuidle_drv_init =3D true;
>> +	}
>> +
>> +	return 0;
>> +}
>> +

[ ... ]

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

