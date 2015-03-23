From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v17 01/10] ARM: qcom: Add Subsystem Power Manager (SPM)
 driver
Date: Mon, 23 Mar 2015 17:15:34 -0600
Message-ID: <20150323231534.GB1790@linaro.org>
References: <1426882877-33008-1-git-send-email-lina.iyer@linaro.org>
 <1426882877-33008-2-git-send-email-lina.iyer@linaro.org>
 <F7886F3F-50DF-4E1B-A6DF-5463362B2BC7@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33280 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbCWXPh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 19:15:37 -0400
Received: by pabxg6 with SMTP id xg6so193163263pab.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2015 16:15:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <F7886F3F-50DF-4E1B-A6DF-5463362B2BC7@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org, Arnd Bergmann <arnd@arndb.de>

On Mon, Mar 23 2015 at 16:06 -0600, Kumar Gala wrote:
>
>On Mar 20, 2015, at 1:21 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>>
>> Based on work by: Mahesh Sivasubramanian <msivasub@codeaurora.org>,
>> Ai Li <ali@codeaurora.org>, Praveen Chidambaram <pchidamb@codeaurora=
=2Eorg>
>> Original tree available at -
>> git://codeaurora.org/quic/la/kernel/msm-3.10.git
>>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>> .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  29 +-
>> drivers/soc/qcom/Kconfig                           |   7 +
>> drivers/soc/qcom/Makefile                          |   1 +
>> drivers/soc/qcom/spm.c                             | 405 +++++++++++=
++++++++++
>> 4 files changed, 436 insertions(+), 6 deletions(-)
>> create mode 100644 drivers/soc/qcom/spm.c
>>
>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt=
 b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>> index 1505fb8..664aa91 100644
>> --- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>> +++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>> @@ -2,11 +2,20 @@ SPM AVS Wrapper 2 (SAW2)
>>
>> The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and t=
he
>> Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
>> -micro-controller that transitions a piece of hardware (like a proce=
ssor or
>> +power-controller that transitions a piece of hardware (like a proce=
ssor or
>> subsystem) into and out of low power modes via a direct connection t=
o
>> the PMIC. It can also be wired up to interact with other processors =
in the
>> system, notifying them when a low power state is entered or exited.
>>
>> +Multiple revisions of the SAW hardware are supported using these De=
vice Nodes.
>> +SAW2 revisions differ in the register offset and configuration data=
=2E Also, the
>> +same revision of the SAW in different SoCs may have different confi=
guration
>> +data due the the differences in hardware capabilities. Hence the So=
C name, the
>> +version of the SAW hardware in that SoC and the distinction between=
 cpu (big
>> +or Little) or cache, may be needed to uniquely identify the SAW reg=
ister
>> +configuration and initialization data. The compatible string is use=
d to
>> +indicate this parameter.
>> +
>> PROPERTIES
>>
>> - compatible:
>> @@ -14,10 +23,11 @@ PROPERTIES
>> 	Value type: <string>
>> 	Definition: shall contain "qcom,saw2". A more specific value should=
 be
>> 		    one of:
>
>Does =E2=80=9Cqcom,saw2=E2=80=9D have any meaning anymore?  I see we u=
se it in some places, but not everywhere on the .dts.  We also see to h=
ave the L2 just be a =E2=80=9Cqcom,saw2=E2=80=9D node, do we expect tha=
t to change?
>
It does help match a regulator node as opposed to the specific values
below.

>> -			 "qcom,saw2-v1"
>> -			 "qcom,saw2-v1.1"
>> -			 "qcom,saw2-v2"
>> -			 "qcom,saw2-v2.1"
>> +			"qcom,saw2-v2"
>> +			"qcom,saw2-v2.1"
>> +			"qcom,apq8064-saw2-v1.1-cpu"
>> +			"qcom,msm8974-saw2-v2.1-cpu"
>> +			"qcom,apq8084-saw2-v2.1-cpu"
>>
>> - reg:
>> 	Usage: required
>> @@ -26,10 +36,17 @@ PROPERTIES
>> 		    the register region. An optional second element specifies
>> 		    the base address and size of the alias register region.
>>
>> +- regulator:
>> +	Usage: optional
>> +	Value type: boolean
>> +	Definition: Indicates that this SPM device acts as a regulator dev=
ice
>> +			device for the core (CPU or Cache) the SPM is attached
>> +			to.
>>
>> Example:
>>
>> -	regulator@2099000 {
>> +	power-controller@2099000 {
>> 		compatible =3D "qcom,saw2";
>> 		reg =3D <0x02099000 0x1000>, <0x02009000 0x1000>;
>> +		regulator;
>> 	};
>
>--=20
>Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Fo=
rum,
>a Linux Foundation Collaborative Project
>
