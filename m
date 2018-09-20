From: Craig <ctatlor97@gmail.com>
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Date: Thu, 20 Sep 2018 15:32:29 +0100
Message-ID: <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180614151435.6471-1-ctatlor97@gmail.com> <20180614151435.6471-3-ctatlor97@gmail.com> <20180916121045.aptj6nciwskfg4st@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180916121045.aptj6nciwskfg4st@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 16 September 2018 13:10:45 BST, Sebastian Reichel <sebastian=2Ereichel@=
collabora=2Ecom> wrote:
>Hi,
>
>Sorry for my long delay in reviewing this=2E I like the binding,
>but the "qcom," specific properties should become common properties
>in
>
>Documentation/devicetree/bindings/power/supply/battery=2Etxt
Thanks for the review, what bindings for ocv would you prefer? The spreadt=
rum ones or mine?
>and referenced via monitored-battery=2E
>
>-- Sebastian
>
>On Thu, Jun 14, 2018 at 04:14:16PM +0100, Craig Tatlor wrote:
>> Add bindings for the Qualcomm Battery Monitoring system=2E
>>=20
>> Signed-off-by: Craig Tatlor <ctatlor97@gmail=2Ecom>
>> Reviewed-by: Rob Herring <robh@kernel=2Eorg>
>> ---
>>=20
>> * Changes from v6:
>>   s/celcius/celsius
>>   change uah to uAh=2E
>>=20
>> * Changes from v5:                                                  =20
>                                                                      =20
>>   Mentions which values are 8 bit=2E                                  =
=20
>                                                                      =20
>>                                                                     =20
>                                                                      =20
>> * Changes from v4:                                                  =20
>                                                                      =20
>>   Uses proper units and expands some definitions,                   =20
>                                                                      =20
>>   along with changing vadc@ to adc@=2E   =20
>>=20
>>  =2E=2E=2E/bindings/power/supply/qcom_bms=2Etxt        | 92
>+++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>>  create mode 100644
>Documentation/devicetree/bindings/power/supply/qcom_bms=2Etxt
>>=20
>> diff --git
>a/Documentation/devicetree/bindings/power/supply/qcom_bms=2Etxt
>b/Documentation/devicetree/bindings/power/supply/qcom_bms=2Etxt
>> new file mode 100644
>> index 000000000000=2E=2Edc0a9ab9aa64
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/qcom_bms=2Etxt
>> @@ -0,0 +1,92 @@
>> +Qualcomm Battery Monitoring System
>> +
>> +The Qualcomm Battery Monitoring System is found inside of Qualcomm
>PM8941
>> +PMICs=2E It provides open circuit voltage (OCV) and coulomb counter
>registers
>> +that allow the OS to infer a capacity level=2E
>> +
>> +Required properties:
>> +- compatible:                   Should contain "qcom,pm8941-bms"=2E
>> +- reg:                          Specifies the SPMI address and
>length of the
>> +				controller's registers=2E
>> +- interrupts:                   OCV threshold interrupt=2E
>> +- io-channels:                  Should contain IIO channel specifier
>for the
>> +				ADC channel that reports battery temperature=2E
>> +- io-channel-names:             Should contain "temp"=2E
>> +- qcom,fcc-temp-legend-celsius: An 8 bit array containing the
>temperature,
>> +				in degC, for each column of the full charge
>> +				capacity lookup table=2E
>> +- qcom,fcc-lut-microamp-hours:  An array of full charge capacity
>values in uAh,
>> +				one entry for each temperature defined in in
>> +				qcom,fcc-temp-legend-celsius=2E
>> +- qcom,ocv-temp-legend-celsius: An 8 bit array containing the
>temperature,
>> +				in degC, for each column of the OCV lookup
>> +				table=2E
>> +- qcom,ocv-capacity-legend:     An 8 bit array containing the
>capacity for each
>> +				row of the OCV lookup table=2E
>> +- qcom,ocv-lut-microvolt:       An array of OCV values in uV, one
>entry for each
>> +				capacity defined in qcom,ocv-capacity-legend=2E
>> +
>> +Example:
>> +		pm8941_vadc: adc@3100 {
>> +			compatible =3D "qcom,spmi-vadc";
>> +			reg =3D <0x3100>;
>> +			interrupts =3D <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +			#io-channel-cells =3D <1>;
>> +
>> +			bat_temp {
>> +				reg =3D <VADC_LR_MUX1_BAT_THERM>;
>> +			};
>> +		};
>> +
>> +		bms@4000 {
>> +			compatible =3D "qcom,pm8941-bms";
>> +			reg =3D <0x4000>;
>> +			interrupts =3D <0x0 0x40 0x4 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names =3D "ocv_thr";
>> +
>> +			io-channels =3D <&pm8941_vadc VADC_LR_MUX1_BAT_THERM>;
>> +			io-channel-names =3D "temp";
>> +
>> +			qcom,fcc-temp-legend-celsius =3D /bits/ 8 <(-10) 0 25 50 65>;
>> +			qcom,fcc-lut-microamp-hours =3D <3230000 3260000 3380000 3410000
>3360000>;
>> +
>> +			qcom,ocv-capacity-legend =3D /bits/ 8 <100 95 90 85 80 75
>> +							     70 65 60 55 50 45
>> +							     40 35 30 25 20 15
>> +							     10 9 8 7 6 5 4 3 2
>> +							     1 0>;
>> +			qcom,ocv-temp-legend-celsius =3D /bits/ 8 <(-10) 0 25 50 65>;
>> +			qcom,ocv-lut-microvolt =3D <43050000 43050000 43030000 42990000
>42950000
>> +						  42770000 42570000 42550000 42510000 42310000
>> +						  42180000 41980000 41970000 41920000 41720000
>> +						  41590000 41390000 41450000 41400000 41200000
>> +						  41010000 40810000 40920000 40890000 40690000
>> +						  40480000 40280000 40440000 40420000 40220000
>> +						  40040000 39840000 40010000 39980000 39780000
>> +						  39620000 39420000 39550000 39560000 39360000
>> +						  39210000 39010000 39090000 39160000 38960000
>> +						  38830000 38630000 38740000 38790000 38590000
>> +						  38550000 38350000 38440000 38430000 38230000
>> +						  38310000 38110000 38230000 38180000 37980000
>> +						  38190000 37990000 38040000 38000000 37800000
>> +						  38060000 37860000 37900000 37840000 37640000
>> +						  37890000 37690000 37770000 37660000 37460000
>> +						  37720000 37520000 37560000 37450000 37250000
>> +						  37480000 37280000 37290000 37250000 37050000
>> +						  37240000 37040000 37020000 36990000 36790000
>> +						  37030000 36830000 36730000 36700000 36500000
>> +						  36940000 36740000 36670000 36640000 36440000
>> +						  36850000 36650000 36600000 36590000 36390000
>> +						  36750000 36550000 36520000 36550000 36350000
>> +						  36690000 36490000 36380000 36400000 36200000
>> +						  36460000 36260000 36180000 36120000 35920000
>> +						  36080000 35880000 35680000 35640000 35440000
>> +						  35510000 35310000 35050000 35020000 34820000
>> +						  34730000 34530000 34300000 34250000 34050000
>> +						  33870000 33670000 33040000 32820000 32620000
>> +						  30000000 30000000 30000000 30000000 30000000>;
>> +		};
>> +	};
>> +};
>> --=20
>> 2=2E17=2E0
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
