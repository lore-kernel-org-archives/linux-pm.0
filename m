From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Mon, 1 Dec 2014 10:57:09 -0700
Message-ID: <20141201175709.GA499@linaro.org>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org>
 <1417065854-37745-4-git-send-email-lina.iyer@linaro.org>
 <1417077863.10282.3.camel@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417077863.10282.3.camel@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Ivan,

On Thu, Nov 27 2014 at 01:43 -0700, Ivan T. Ivanov wrote:
>
>Hi,
>
>On Wed, 2014-11-26 at 22:24 -0700, Lina Iyer wrote:
>>
>
>>  - compatible:
>> @@ -14,10 +23,13 @@ PROPERTIES
>>         Value type: <string>
>>         Definition: shall contain "qcom,saw2". A more specific value=
 should be
>>                                                 one of:
>
>Which driver is supposed to handle this property?
>
drivers/soc/qcom/spm.c - SAW power controller driver.
>> -                               "qcom,saw2-v1"
>> -                               "qcom,saw2-v1.1"
>> -                               "qcom,saw2-v2"
>> -                               "qcom,saw2-v2.1"
>> +                       "qcom,saw2-v1"
>> +                       "qcom,saw2-v1.1"
>> +                       "qcom,saw2-v2"
>> +                       "qcom,saw2-v2.1"
>
>Doesn't seems to be used or supported?
>
Used for identify the version of the SAW that does voltage changes.  An=
y
SAW that can change the voltage would use one of the above compatible
strings. We only need a generic version number for regulator
functionality as opposed to the ones used for idle control (like below)=
,
which needs to correctly identify the version number (saw2-v1.1), cpu/L=
2
(-cpu_variant of the SAW on a particlar SoC (qcom,apq/msmXXXX) to set
the correct register values for that SoC.

L2 SAW is currently not upstream or part of this series. Will follow
suit, when we have the power domains to control cluster low power modes=
=2E
The regulator functionality is currently not available upstream, as wel=
l
for 8084 and 8074.

Thanks,
Lina

>> +                       "qcom,apq8064-saw2-v1.1-cpu"
>> +                       "qcom,msm8974-saw2-v2.1-cpu"
>> +                       "qcom,apq8084-saw2-v2.1-cpu"
>>
>
><snip>
>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator@2099000 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0power-controller@2099000 =
{
>>                 compatible =3D "qcom,saw2";
>>                 reg =3D <0x02099000 0x1000>, <0x02009000 0x1000>;
>> +               regulator;
>>
>
><snip>
>
>> +static const struct of_device_id spm_match_table[] =3D {
>> +       { .compatible =3D "qcom,msm8974-saw2-v2.1-cpu",
>> +                       .data =3D &spm_reg_8974_8084_cpu },
>> +       { .compatible =3D "qcom,apq8084-saw2-v2.1-cpu",
>> +                       .data =3D &spm_reg_8974_8084_cpu },
>> +       { .compatible =3D "qcom,apq8064-saw2-v1.1-cpu",
>> +                       .data =3D &spm_reg_8064_cpu },
>> +       { },
>> +};
>> +
>
>Regards,
>Ivan
