From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Use thermal fuse value for thermal zone
 0 on Exynos5420
Date: Mon, 13 Feb 2017 17:51:06 +0530
Message-ID: <CANAwSgQ94irFT6kkeRao6rqnXO0ejTAozSegu2Y3DLsLWJe9=w@mail.gmail.com>
References: <20170211201456.27974-1-krzk@kernel.org> <CANAwSgSJRv6XGKvysbw+cXYyVUEcNyGv=6tYSWsvOn42dX5f1w@mail.gmail.com>
 <CAJKOXPeVLNRCWcWMT_subo2VRXdS1147MjFNCeGot8DpqguVNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPeVLNRCWcWMT_subo2VRXdS1147MjFNCeGot8DpqguVNg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Willy WOLFF <willy.mh.wolff@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 13 February 2017 at 17:29, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Feb 13, 2017 at 1:38 PM, Anand Moon <linux.amoon@gmail.com> wrote:
>> Hi Krzysztof,
>>
>>
>>
>> On 12 February 2017 at 01:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>> In Odroid XU3 Lite board, the temperature levels reported for thermal
>>> zone 0 were weird. In warm room:
>>>         /sys/class/thermal/thermal_zone0/temp:32000
>>>         /sys/class/thermal/thermal_zone1/temp:51000
>>>         /sys/class/thermal/thermal_zone2/temp:55000
>>>         /sys/class/thermal/thermal_zone3/temp:54000
>>>         /sys/class/thermal/thermal_zone4/temp:51000
>>>
>>> Sometimes after booting the value was even equal to ambient temperature
>>> which is highly unlikely to be a real temperature of sensor in SoC.
>>>
>>> The thermal sensor's calibration (trimming) is based on fused values.
>>> In case of the board above, the fused values are: 35, 52, 43, 58 and 43
>>> (corresponding to each TMU device).  However driver defined a minimum value
>>> for fused data as 40 and for smaller values it was using a hard-coded 55
>>> instead.  This lead to mapping data from sensor to wrong temperatures
>>> for thermal zone 0.
>>>
>>> Various vendor 3.10 trees (Hardkernel's based on Samsung LSI, Artik 10)
>>> do not impose any limits on fused values.  Since we do not have any
>>> knowledge about these limits, use 0 as a minimum accepted fused value.
>>> This should essentially allow accepting any reasonable fused value thus
>>> behaving like vendor driver.
>>>
>>
>> On HK following values are define in drivers/thermal/exynos_thermal.c
>>
>> #define EFUSE_MIN_VALUE                         40
>> #define EFUSE_MAX_VALUE                         100
>
> Are they being used?

Opps: sorry it's not used for Exynos5422 platform.

Best regards,
-Anand
