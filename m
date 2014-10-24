From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v13 3/5] ARM: dts: add RK3288 Thermal data
Date: Fri, 24 Oct 2014 10:19:23 +0800
Message-ID: <5449B72B.5090005@rock-chips.com>
References: <1414057207-1576-1-git-send-email-caesar.wang@rock-chips.com> <1414057207-1576-4-git-send-email-caesar.wang@rock-chips.com> <20141024004811.GE9463@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20141024004811.GE9463@dtor-ws>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: heiko@sntech.de, rui.zhang@intel.com, edubezval@gmail.com, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dbasehore@chromium.org, huangtao@rock-chips.com, cjf@rock-chips.com, zhengsq@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Dmitry,

=E5=9C=A8 2014/10/24 8:48, Dmitry Torokhov =E5=86=99=E9=81=93:
> Hi Caesar,
>
> On Thu, Oct 23, 2014 at 05:40:05PM +0800, Caesar Wang wrote:
>> This patch changes a dtsi file to contain the thermal data
>> on RK3288 and later SoCs. This data will
>> enable a thermal shutdown over 125C.
>>
>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> ---
>>   arch/arm/boot/dts/rk3288-thermal.dtsi | 65 +++++++++++++++++++++++=
++++++++++++
>>   1 file changed, 65 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/rk3288-thermal.dtsi
>>
>> diff --git a/arch/arm/boot/dts/rk3288-thermal.dtsi b/arch/arm/boot/d=
ts/rk3288-thermal.dtsi
>> new file mode 100644
>> index 0000000..c361262
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/rk3288-thermal.dtsi
>> @@ -0,0 +1,65 @@
>> +/*
>> + * Device Tree Source for RK3288 SoC thermal
>> + *
>> + * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This file is licensed under the terms of the GNU General Public =
License
>> + * version 2.  This program is licensed "as is" without any warrant=
y of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +reserve_thermal: reserve_thermal {
>> +	polling-delay-passive =3D <500>; /* milliseconds */
>> +	polling-delay =3D <1000>; /* milliseconds */
>> +
>> +			/* sensor	ID */
>> +	thermal-sensors =3D <&tsadc	0>;
>> +
>> +};
>> +
>> +cpu_thermal: cpu_thermal {
>> +	polling-delay-passive =3D <500>; /* milliseconds */
>> +	polling-delay =3D <1000>; /* milliseconds */
> Given that the hardware supports alarm interrupts I think we should b=
e
> able to lower polling frequency. I'd say 5 seconds for polling-delay =
and
> 1 second for when we trip over passive point?
As you say:

+cpu_thermal: cpu_thermal {
+	polling-delay-passive =3D <1000>; /* milliseconds */
+	polling-delay =3D <5000>; /* milliseconds */

I think it's ok for me if the driver follow your change.


>
> Thanks.
>

--=20
Best regards,
Caesar


