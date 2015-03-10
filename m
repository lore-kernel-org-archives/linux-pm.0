From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC PATCH v15 02/11] ARM: qcom: Add Subsystem Power Manager
 (SPM) driver
Date: Tue, 10 Mar 2015 12:51:09 -0600
Message-ID: <20150310185109.GC3727@linaro.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
 <1425914206-22295-3-git-send-email-lina.iyer@linaro.org>
 <0D04D613-5916-448E-92F3-27C3D25AFE51@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0D04D613-5916-448E-92F3-27C3D25AFE51@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 10 2015 at 11:26 -0600, Kumar Gala wrote:
>
>On Mar 9, 2015, at 10:16 AM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>> SPM is a hardware block that controls the peripheral logic surroundi=
ng
>> the application cores (cpu/l$). When the core executes WFI instructi=
on,
>> the SPM takes over the putting the core in low power state as
>> configured. The wake up for the SPM is an interrupt at the GIC, whic=
h
>> then completes the rest of low power mode sequence and brings the co=
re
>> out of low power mode.
>>
>> The SPM has a set of control registers that configure the SPMs
>> individually based on the type of the core and the runtime condition=
s.
>> SPM is a finite state machine block to which a sequence is provided =
and
>> it interprets the bytes and executes them in sequence. Each low powe=
r
>> mode that the core can enter into is provided to the SPM as a sequen=
ce.
>>
>> Configure the SPM to set the core (cpu or L2) into its low power mod=
e,
>> the index of the first command in the sequence is set in the SPM_CTL
>> register. When the core executes ARM wfi instruction, it triggers th=
e
>> SPM state machine to start executing from that index. The SPM state
>> machine waits until the interrupt occurs and starts executing the re=
st
>> of the sequence until it hits the end of the sequence. The end of th=
e
>> sequence jumps the core out of its low power mode.
>>
>> Add support for an idle driver to set up the SPM to place the core i=
n
>> Standby or Standalone power collapse mode when the core is idle.
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
>> .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  31 +-
>> drivers/soc/qcom/Kconfig                           |   7 +
>> drivers/soc/qcom/Makefile                          |   1 +
>> drivers/soc/qcom/spm.c                             | 422 +++++++++++=
++++++++++
>> 4 files changed, 455 insertions(+), 6 deletions(-)
>> create mode 100644 drivers/soc/qcom/spm.c
>>
>> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt=
 b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>> index 1505fb8..690c3c0 100644
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
>> @@ -14,10 +23,13 @@ PROPERTIES
>> 	Value type: <string>
>> 	Definition: shall contain "qcom,saw2". A more specific value should=
 be
>> 		    one of:
>> -			 "qcom,saw2-v1"
>> -			 "qcom,saw2-v1.1"
>> -			 "qcom,saw2-v2"
>> -			 "qcom,saw2-v2.1"
>> +			"qcom,saw2-v1"
>> +			"qcom,saw2-v1.1"
>> +			"qcom,saw2-v2"
>> +			"qcom,saw2-v2.1"
>> +			"qcom,apq8064-saw2-v1.1-cpu"
>> +			"qcom,msm8974-saw2-v2.1-cpu"
>> +			"qcom,apq8084-saw2-v2.1-cpu=E2=80=9D
>>
>
>We don=E2=80=99t seem to use the "qcom,saw2-v1*=E2=80=9D variants so s=
hould we just drop them?

Sure. Will fix in the next.
>
>
>> - reg:
>> 	Usage: required
>> @@ -26,10 +38,17 @@ PROPERTIES
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
>- k
>
>--=20
>Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Fo=
rum,
>a Linux Foundation Collaborative Project
>
