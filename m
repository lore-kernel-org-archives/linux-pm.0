From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v9 3/4] ARM: dts: rockchip: add syscon-reboot-mode DT node
Date: Tue, 21 Jun 2016 14:08:50 +0800
Message-ID: <5768D9F2.4000309@rock-chips.com>
References: <1466404490-3315-1-git-send-email-andy.yan@rock-chips.com>
 <1466404769-3534-1-git-send-email-andy.yan@rock-chips.com>
 <20160620215545.GE1256@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160620215545.GE1256@tuxbot>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: robh+dt@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, k.kozlowski@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, sre@kernel.org, matthias.bgg@gmail.com, linux-pm@vger.kernel.org, mbrugger@suse.com, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, richard@nod.at
List-Id: linux-pm@vger.kernel.org

Hi Bjorn:
On 2016=E5=B9=B406=E6=9C=8821=E6=97=A5 05:55, Bjorn Andersson wrote:
> On Sun 19 Jun 23:39 PDT 2016, Andy Yan wrote:
>
>> Rockchip platform use a SYSCON mapped register store
>> the reboot mode magic value for bootloader to use when
>> system reboot. So add syscon-reboot-mode driver DT node
>> for rk3xxx/rk3036/rk3288 based platform
>>
>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
> [..]
>> diff --git a/include/dt-bindings/soc/rockchip_boot-mode.h b/include/=
dt-bindings/soc/rockchip_boot-mode.h
>> new file mode 100644
>> index 0000000..ae7c867
>> --- /dev/null
>> +++ b/include/dt-bindings/soc/rockchip_boot-mode.h
>> @@ -0,0 +1,15 @@
>> +#ifndef __ROCKCHIP_BOOT_MODE_H
>> +#define __ROCKCHIP_BOOT_MODE_H
>> +
>> +/*high 24 bits is tag, low 8 bits is type*/
>> +#define REBOOT_FLAG		0x5242C300
>> +/* normal boot */
>> +#define BOOT_NORMAL		(REBOOT_FLAG + 0)
>> +/* enter bootloader rockusb mode */
>> +#define BOOT_BL_DOWNLOAD	(REBOOT_FLAG + 1)
>> +/* enter recovery */
>> +#define BOOT_RECOVERY		(REBOOT_FLAG + 3)
>> + /* enter fastboot mode */
>> +#define BOOT_FASTBOOT		(REBOOT_FLAG + 9)
> The names of these defines are too generic for being in a header file=
=2E
> You should likely make them include "ROCKCHIP" and "BOOT_MODE".
>
> Regards,
> Bjorn
>
>
>
I have already named this file as rockchip_boot-mode.h, I thinks this i=
s
enough to declare it. And I also check some header files like=20
qcom,gsbi.h, thermal/theraml_exynos.h, they also don't have include som=
e=20
flag like QCOM or EXYNOS.
