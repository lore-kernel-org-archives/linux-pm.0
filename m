From: Craig <ctatlor97@gmail.com>
Subject: Re: [PATCH v7 3/4] dt-bindings: power: supply: qcom_bms: Add bindings
Date: Thu, 20 Sep 2018 20:13:52 +0100
Message-ID: <5039A15E-E604-4D03-AFEF-4B139EB18A30@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180614151435.6471-1-ctatlor97@gmail.com> <20180614151435.6471-3-ctatlor97@gmail.com> <20180916121045.aptj6nciwskfg4st@earth.universe> <4BBA3F28-A769-4F09-86DC-1E3906C53B26@gmail.com> <20180920165847.6xqzeoqzqkyotshx@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920165847.6xqzeoqzqkyotshx@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.com>, Baolin Wang <baolin.wang@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 20 September 2018 17:58:47 BST, Sebastian Reichel <sebastian=2Ereichel@=
collabora=2Ecom> wrote:
>[Dropped a couple of people from CC, added Baolin]
>
>Hi Craig, Baolin and Rob,
>
>On Thu, Sep 20, 2018 at 03:32:29PM +0100, Craig wrote:
>> On 16 September 2018 13:10:45 BST, Sebastian Reichel
><sebastian=2Ereichel@collabora=2Ecom> wrote:
>> >Sorry for my long delay in reviewing this=2E I like the binding,
>> >but the "qcom," specific properties should become common properties
>> >in
>> >
>> >Documentation/devicetree/bindings/power/supply/battery=2Etxt
>> >and referenced via monitored-battery=2E
>
>> Thanks for the review, what bindings for ocv would you prefer? The
>> spreadtrum ones or mine?
>
>Most importantly I want to see only one generic binding supporting
>both use cases=2E As far as I can see there are two major differences:
>
>1=2E Qcom uses legend properties and SC27XX embedds this into data
>2=2E Qcom supports temperature based mapping
>
>The second point is easy: Not having temperature information can
>be a subset of the data with temperature info=2E The main thing to
>discuss are the legend properties=2E I suppose we have these
>proposals:
>
>Proposal A (from Qcom BMS binding):
>
>ocv-capacity-legend =3D /bits/ 8 <100 95 90 85 80 75 70 65 60 55 50 45
>=2E=2E=2E>;
>ocv-temp-legend-celsius =3D /bits/ 8 <(-10) 0 25 50 65>;
>ocv-lut-microvolt =3D <43050000 43050000 43030000 42990000
>
>Proposal B (from SC27XX binding):
>
>ocv-cap-table =3D <4185 100>, <4113 95>, <4066 90>, <4022 85> =2E=2E=2E;
>
>I prefer the second binding (with mV -> uV), but I think it becomes
>messy when temperature is added=2E What do you think about the
>following proposal (derived from pinctrl style):
>
>Proposal C:
>
>ocv-capacity-table-temperatures =3D <(-10) 0 10>;
>ocv-capacity-table-0 =3D <4185000 100>, <4113000 95>, <4066000 90>, =2E=
=2E=2E;
>ocv-capacity-table-1 =3D <4200000 100>, <4185000 95>, <4113000 90>, =2E=
=2E=2E;
>ocv-capacity-table-2 =3D <4250000 100>, <4200000 95>, <4185000 90>, =2E=
=2E=2E;
>
>-- Sebastian

C looks good to me however I do kinda think it should be millivolts as I d=
on't think any hardware reads in microvolts and the zeroes make it look qui=
te ugly
