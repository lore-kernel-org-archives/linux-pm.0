From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v17 04/10] ARM: dts: qcom: Add power-controller device
 node for 8074 Krait CPUs
Date: Mon, 23 Mar 2015 17:06:28 -0600
Message-ID: <20150323230628.GA1790@linaro.org>
References: <1426882877-33008-1-git-send-email-lina.iyer@linaro.org>
 <1426882877-33008-5-git-send-email-lina.iyer@linaro.org>
 <292C2E97-ED74-4F17-B592-B5EA7BDD1E8E@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <292C2E97-ED74-4F17-B592-B5EA7BDD1E8E@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, agross@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 23 2015 at 16:05 -0600, Kumar Gala wrote:
>
>On Mar 20, 2015, at 1:21 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>
>> Each Krait CPU in the QCOM 8074/8974 SoC has an SAW power controller=
 to
>> regulate the power to the cpu and aide the core in entering idle sta=
tes.
>> Reference the SAW instance and associate the instance with the CPU c=
ore.
>>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>> arch/arm/boot/dts/qcom-msm8974.dtsi | 26 +++++++++++++++++++++++++-
>> 1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts=
/qcom-msm8974.dtsi
>> index e265ec1..5a41f44 100644
>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>> @@ -21,6 +21,7 @@
>> 			reg =3D <0>;
>> 			next-level-cache =3D <&L2>;
>> 			qcom,acc =3D <&acc0>;
>> +			qcom,saw =3D <&saw0>;
>> 		};
>>
>> 		cpu@1 {
>> @@ -30,6 +31,7 @@
>> 			reg =3D <1>;
>> 			next-level-cache =3D <&L2>;
>> 			qcom,acc =3D <&acc1>;
>> +			qcom,saw =3D <&saw1>;
>> 		};
>>
>> 		cpu@2 {
>> @@ -39,6 +41,7 @@
>> 			reg =3D <2>;
>> 			next-level-cache =3D <&L2>;
>> 			qcom,acc =3D <&acc2>;
>> +			qcom,saw =3D <&saw2>;
>> 		};
>>
>> 		cpu@3 {
>> @@ -48,6 +51,7 @@
>> 			reg =3D <3>;
>> 			next-level-cache =3D <&L2>;
>> 			qcom,acc =3D <&acc3>;
>> +			qcom,saw =3D <&saw3>;
>> 		};
>>
>> 		L2: l2-cache {
>> @@ -144,7 +148,27 @@
>> 			};
>> 		};
>>
>> -		saw_l2: regulator@f9012000 {
>> +		saw0: power-controller@f9089000 {
>> +			compatible =3D "qcom,msm8974-saw2-v2.1-cpu=E2=80=9D;
>
>Should these include =E2=80=9Cqcom,saw=E2=80=9D?
>
I believe the qcom,saw2 is a way for the regulator node to identify
which node is also a regulator.

Only saw_l2 is a regulator node as well on 8074 and thereby needs qcom,=
saw2.

>> +			reg =3D <0xf9089000 0x1000>, <0xf9009000 0x1000>;
>> +		};
>> +
>> +		saw1: power-controller@f9099000 {
>> +			compatible =3D "qcom,msm8974-saw2-v2.1-cpu";
>> +			reg =3D <0xf9099000 0x1000>, <0xf9009000 0x1000>;
>> +		};
>> +
>> +		saw2: power-controller@f90a9000 {
>> +			compatible =3D "qcom,msm8974-saw2-v2.1-cpu";
>> +			reg =3D <0xf90a9000 0x1000>, <0xf9009000 0x1000>;
>> +		};
>> +
>> +		saw3: power-controller@f90b9000 {
>> +			compatible =3D "qcom,msm8974-saw2-v2.1-cpu";
>> +			reg =3D <0xf90b9000 0x1000>, <0xf9009000 0x1000>;
>> +		};
>> +
>> +		saw_l2: power-controller@f9012000 {
>> 			compatible =3D "qcom,saw2";
>> 			reg =3D <0xf9012000 0x1000>;
>> 			regulator;
>> --
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-arm-=
msm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>--=20
>Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Fo=
rum,
>a Linux Foundation Collaborative Project
>
