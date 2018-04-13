From: Craig Tatlor <ctatlor97@gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: power: supply: qcom_bms: Add bindings
Date: Fri, 13 Apr 2018 18:10:42 +0100
Message-ID: <B86536BF-9FDB-4BDD-8F3D-1870776050F2@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180407175802.29444-1-ctatlor97@gmail.com> <20180407175802.29444-2-ctatlor97@gmail.com> <20180413163527.ludqnnc5nkj4spre@rob-hp-laptop> <1D7FA61D-2233-45DC-A244-B2914BB1B29F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1D7FA61D-2233-45DC-A244-B2914BB1B29F@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 13 April 2018 18:08:54 BST, Craig Tatlor <ctatlor97@gmail=2Ecom> wrote:
>
>
>On 13 April 2018 17:35:27 BST, Rob Herring <robh@kernel=2Eorg> wrote:
>>On Sat, Apr 07, 2018 at 06:57:45PM +0100, Craig Tatlor wrote:
>>> Add bindings for the Qualcomm Battery Monitoring system=2E
>>>=20
>>> Signed-off-by: Craig Tatlor <ctatlor97@gmail=2Ecom>
>>> ---
>>>  =2E=2E=2E/bindings/power/supply/qcom_bms=2Etxt        | 93
>>+++++++++++++++++++
>>>  1 file changed, 93 insertions(+)
>>>  create mode 100644
>>Documentation/devicetree/bindings/power/supply/qcom_bms=2Etxt
>>>=20
>>> diff --git
>>a/Documentation/devicetree/bindings/power/supply/qcom_bms=2Etxt
>>b/Documentation/devicetree/bindings/power/supply/qcom_bms=2Etxt
>>> new file mode 100644
>>> index 000000000000=2E=2E6296399edc09
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/power/supply/qcom_bms=2Etxt
>>> @@ -0,0 +1,93 @@
>>> +Qualcomm Battery Measurement System
>>> +
>>> +The Qualcomm Battery Measurement System is found inside of Qualcomm
>>PM8941
>>
>>Is it Monitoring or Measurment?
Monitoring, not sure how I missed that :)
>>
>>> +PMICs=2E It provides OCV and coulomb counter registers that allow the
>>kernel
>>> +to infer a capacity level=2E
>>
>>s/kernel/OS/
>>
>>OCV?
>Open Circuit Voltage - should I expand this?
>>
>>> +
>>> +Required properties:
>>> +- compatible:               Should contain "qcom,pm8941-bms"=2E
>>> +- reg:                      Specifies the SPMI address and length
>of
>>the
>>> +			    controller's registers=2E
>>> +- interrupts:               OCV threshold interrupt=2E
>>> +- io-channels:              Should contain IIO channel specifier
>for
>>the
>>> +			    ADC channel that reports battery temperature=2E
>>> +- io-channel-names:         Should contain "temp"=2E
>>> +- qcom,fcc-temp-legend:     An array containing the temperature, in
>>degC,
>>> +			    for each column of the FCC lookup table=2E
>>
>>What's FCC?
>Full charge capacity - Should i also expand this? or maybe explain in
>header paragraph?
>>
>>> +- qcom,fcc-lut:             An array of FCC values in mah, one
>entry
>>for each
>>> +			    temperature defined in in qcom,fcc-temp-legend=2E
>>> +- qcom,ocv-temp-legend:     An array containing the temperature, in
>>degC,
>>> +			    for each column of the OCV lookup table=2E
>>> +- qcom,ocv-capacity-legend: An array containing the capacity for
>>each
>>> +			    row of the OCV lookup table=2E
>>> +- qcom,ocv-lut:             An array of OCV values in mV, one entry
>>for each
>>> +			    capacity defined in qcom,ocv-capacity-legend=2E
>>
>>Need to specify the sizes of these if not 32-bit=2E
>Right=2E
>>
>>All these seem to have units, so add unit suffixes as defined in=20
>>property-units=2Etxt=2E
>Will do=2E
>>
>>> +
>>> +Example:
>>> +
>>> +		pm8941_vadc: vadc@3100 {
>>
>>adc@=2E=2E=2E
>Okay=2E
>>
>>> +			compatible =3D "qcom,spmi-vadc";
>>> +			reg =3D <0x3100>;
>>> +			interrupts =3D <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>>> +			#address-cells =3D <1>;
>>> +			#size-cells =3D <0>;
>>> +			#io-channel-cells =3D <1>;
>>> +
>>> +			bat_temp {
>>> +				reg =3D <VADC_LR_MUX1_BAT_THERM>;
>>> +			};
>>> +		};
>>> +
>>> +		bms@4000 {
>>> +			compatible =3D "qcom,pm8941-bms";
>>> +			reg =3D <0x4000>;
>>> +			interrupts =3D <0x0 0x40 0x4 IRQ_TYPE_EDGE_RISING>;
>>> +			interrupt-names =3D "ocv_thr";
>>> +
>>> +			io-channels =3D <&pm8941_vadc VADC_LR_MUX1_BAT_THERM>;
>>> +			io-channel-names =3D "temp";
>>> +
>>> +			qcom,fcc-temp-legend =3D /bits/ 8 <(-10) 0 25 50 65>;
>>> +			qcom,fcc-lut =3D /bits/ 16 <6010 6070 6680 6780 6670>;
>>> +
>>> +			qcom,ocv-capacity-legend =3D /bits/ 8 <100 95 90 85
>>> +							     80 75 70 65
>>> +							     60 55 50 45
>>> +							     40 35 30 25
>>> +							     20 15 10 9
>>> +							     8 7 6 5 4
>>> +							     3 2 1 0>;
>>> +
>>> +			qcom,ocv-temp-legend =3D /bits/ 8 <(-10) 0 25 50 65>;
>>> +			qcom,ocv-lut =3D /bits/ 16 <4288 4288 4306 4315 4315
>>> +						  4261 4241 4259 4266 4246
>>> +						  4201 4181 4201 4207 4187
>>> +						  4153 4133 4150 4155 4135
>>> +						  4105 4085 4100 4104 4084
>>> +						  4058 4038 4052 4058 4038
>>> +						  4012 3992 4004 4014 3994
>>> +						  3970 3950 3959 3971 3951
>>> +						  3931 3911 3915 3927 3907
>>> +						  3899 3879 3880 3884 3864
>>> +						  3873 3853 3851 3853 3833
>>> +						  3848 3828 3827 3829 3809
>>> +						  3829 3809 3808 3809 3789
>>> +						  3815 3795 3791 3791 3771
>>> +						  3801 3781 3775 3772 3752
>>> +						  3785 3765 3751 3746 3726
>>> +						  3767 3747 3727 3719 3699
>>> +						  3750 3730 3702 3692 3672
>>> +						  3728 3708 3680 3672 3652
>>> +						  3720 3700 3676 3665 3645
>>> +						  3712 3692 3670 3660 3645
>>> +						  3695 3675 3658 3648 3633
>>> +						  3662 3647 3629 3620 3610
>>> +						  3620 3605 3589 3580 3570
>>> +						  3562 3552 3538 3529 3519
>>> +						  3490 3480 3474 3470 3465
>>> +						  3403 3398 3388 3380 3375
>>> +						  3320 3300 3255 3221 3206
>>> +						  3000 3000 3000 3000 3000>;
>>> +		};
>>> +	};
>>> +};
>>> --=20
>>> 2=2E17=2E0
>>>=20
