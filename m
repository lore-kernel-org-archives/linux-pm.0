From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v17 01/10] ARM: qcom: Add Subsystem Power Manager (SPM) driver
Date: Mon, 23 Mar 2015 16:38:12 -0700
Message-ID: <26C515E5-5CA8-4E67-9FC4-2F87208F50C4@codeaurora.org>
References: <1426882877-33008-1-git-send-email-lina.iyer@linaro.org> <1426882877-33008-2-git-send-email-lina.iyer@linaro.org> <F7886F3F-50DF-4E1B-A6DF-5463362B2BC7@codeaurora.org> <20150323231534.GB1790@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150323231534.GB1790@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org


On Mar 23, 2015, at 4:15 PM, Lina Iyer <lina.iyer@linaro.org> wrote:

> On Mon, Mar 23 2015 at 16:06 -0600, Kumar Gala wrote:
>>=20
>> On Mar 20, 2015, at 1:21 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>=20
>>>=20
>>> Based on work by: Mahesh Sivasubramanian <msivasub@codeaurora.org>,
>>> Ai Li <ali@codeaurora.org>, Praveen Chidambaram <pchidamb@codeauror=
a.org>
>>> Original tree available at -
>>> git://codeaurora.org/quic/la/kernel/msm-3.10.git
>>>=20
>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Kevin Hilman <khilman@linaro.org>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> ---
>>> .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  29 +-
>>> drivers/soc/qcom/Kconfig                           |   7 +
>>> drivers/soc/qcom/Makefile                          |   1 +
>>> drivers/soc/qcom/spm.c                             | 405 ++++++++++=
+++++++++++
>>> 4 files changed, 436 insertions(+), 6 deletions(-)
>>> create mode 100644 drivers/soc/qcom/spm.c
>>>=20
>>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.tx=
t b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>>> index 1505fb8..664aa91 100644
>>> --- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>>> @@ -2,11 +2,20 @@ SPM AVS Wrapper 2 (SAW2)
>>>=20
>>> The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and =
the
>>> Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
>>> -micro-controller that transitions a piece of hardware (like a proc=
essor or
>>> +power-controller that transitions a piece of hardware (like a proc=
essor or
>>> subsystem) into and out of low power modes via a direct connection =
to
>>> the PMIC. It can also be wired up to interact with other processors=
 in the
>>> system, notifying them when a low power state is entered or exited.
>>>=20
>>> +Multiple revisions of the SAW hardware are supported using these D=
evice Nodes.
>>> +SAW2 revisions differ in the register offset and configuration dat=
a. Also, the
>>> +same revision of the SAW in different SoCs may have different conf=
iguration
>>> +data due the the differences in hardware capabilities. Hence the S=
oC name, the
>>> +version of the SAW hardware in that SoC and the distinction betwee=
n cpu (big
>>> +or Little) or cache, may be needed to uniquely identify the SAW re=
gister
>>> +configuration and initialization data. The compatible string is us=
ed to
>>> +indicate this parameter.
>>> +
>>> PROPERTIES
>>>=20
>>> - compatible:
>>> @@ -14,10 +23,11 @@ PROPERTIES
>>> 	Value type: <string>
>>> 	Definition: shall contain "qcom,saw2". A more specific value shoul=
d be
>>> 		    one of:
>>=20
>> Does =93qcom,saw2=94 have any meaning anymore?  I see we use it in s=
ome places, but not everywhere on the .dts.  We also see to have the L2=
 just be a =93qcom,saw2=94 node, do we expect that to change?
>>=20
> It does help match a regulator node as opposed to the specific values
> below.

Than we should cleanup the wording.  Right now it reads such that =91qc=
om,saw2=92 is always required.

>>> -			 "qcom,saw2-v1"
>>> -			 "qcom,saw2-v1.1"
>>> -			 "qcom,saw2-v2"
>>> -			 "qcom,saw2-v2.1"
>>> +			"qcom,saw2-v2"
>>> +			"qcom,saw2-v2.1"
>>> +			"qcom,apq8064-saw2-v1.1-cpu"
>>> +			"qcom,msm8974-saw2-v2.1-cpu"
>>> +			"qcom,apq8084-saw2-v2.1-cpu"
>>>=20
>>> - reg:
>>> 	Usage: required
>>> @@ -26,10 +36,17 @@ PROPERTIES
>>> 		    the register region. An optional second element specifies
>>> 		    the base address and size of the alias register region.
>>>=20
>>> +- regulator:
>>> +	Usage: optional
>>> +	Value type: boolean
>>> +	Definition: Indicates that this SPM device acts as a regulator de=
vice
>>> +			device for the core (CPU or Cache) the SPM is attached
>>> +			to.
>>>=20
>>> Example:
>>>=20
>>> -	regulator@2099000 {
>>> +	power-controller@2099000 {
>>> 		compatible =3D "qcom,saw2";
>>> 		reg =3D <0x02099000 0x1000>, <0x02009000 0x1000>;
>>> +		regulator;
>>> 	};

- k

--=20
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
a Linux Foundation Collaborative Project
