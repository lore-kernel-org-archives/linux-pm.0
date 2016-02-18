From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [RFC 3/3] ARM: dts: Don't overheat the Odroid XU3-Lite on high load
Date: Thu, 18 Feb 2016 10:59:19 +0100
Message-ID: <56C595F7.1080406@samsung.com>
References: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
 <1455692128-28504-4-git-send-email-k.kozlowski@samsung.com>
 <CANAwSgQHiJGSYB7Qhq066Mqfskwrr_3SDQGXH-WN=Wt3SEF-QA@mail.gmail.com>
 <56C522A9.8070800@samsung.com> <20160218023622.GA2610@vireshk-i7>
 <56C54B9B.7030105@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <56C54B9B.7030105@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Anand Moon <linux.amoon@gmail.com>, Kukjin Kim <kgene@kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, linux-arm-kernel@lists.infradead.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hello,

On 2016-02-18 05:42, Krzysztof Kozlowski wrote:
> On 18.02.2016 11:36, Viresh Kumar wrote:
>>> BTW, I found the issue. The order of trip points in DT:
>>> thermal_zone0/trip_point_0_hyst:5000
>>> thermal_zone0/trip_point_0_temp:50000
>>> thermal_zone0/trip_point_0_type:active
>>> thermal_zone0/trip_point_1_hyst:5000
>>> thermal_zone0/trip_point_1_temp:60000
>>> thermal_zone0/trip_point_1_type:active
>>> thermal_zone0/trip_point_2_hyst:5000
>>> thermal_zone0/trip_point_2_temp:70000
>>> thermal_zone0/trip_point_2_type:active
>>> thermal_zone0/trip_point_3_hyst:0
>>> thermal_zone0/trip_point_3_temp:120000	<---- this should be last one!
>>> thermal_zone0/trip_point_3_type:critical
>>> thermal_zone0/trip_point_4_hyst:5000
>>> thermal_zone0/trip_point_4_temp:90000
>>> thermal_zone0/trip_point_4_type:passive
>>> thermal_zone0/trip_point_5_hyst:5000
>>> thermal_zone0/trip_point_5_temp:110000
>>> thermal_zone0/trip_point_5_type:passive
>>>
>>> After fixing the order in DT, the cpu cooler starts working.
>> Ahh, nice.
> Damn, not entirely. I almost fried my Odroid (it survived 130 degrees of
> C)... The TMU supports only 4 trip points, so when I added two new trip
> points and reordered them... the last two (including critical) was not
> receiving interrupts.
>
> Polling mode is needed. I'll sent some patches soon...

Instead of polling the driver should simply use some dynamic window for
the nearest temperature ranges and reconfigure it when interrupt of occurs.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
