From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [RFC 3/3] ARM: dts: Don't overheat the Odroid XU3-Lite on high load
Date: Thu, 18 Feb 2016 08:24:34 +0530
Message-ID: <CANAwSgTGod7kR0fWMZuCFG9oAnt6CrUXsQs=JWz4LtqWi5P8Tw@mail.gmail.com>
References: <1455692128-28504-1-git-send-email-k.kozlowski@samsung.com>
 <1455692128-28504-4-git-send-email-k.kozlowski@samsung.com>
 <CANAwSgQHiJGSYB7Qhq066Mqfskwrr_3SDQGXH-WN=Wt3SEF-QA@mail.gmail.com>
 <56C522A9.8070800@samsung.com> <20160218023622.GA2610@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35686 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423886AbcBRCyz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 21:54:55 -0500
In-Reply-To: <20160218023622.GA2610@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, linux-arm-kernel@lists.infradead.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>

Hi Viresh,

On 18 February 2016 at 08:06, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18-02-16, 10:47, Krzysztof Kozlowski wrote:
>> On 18.02.2016 04:53, Anand Moon wrote:
>> > I also got lot's of error.
>> >
>> > root@odroidxu4l:~# cpu[ 3050.847663] cpu cpu4: Failed to find dev_opp: -19
>> > [ 3171.640836] cpu cpu4: device_opp_debug_create_link: Failed to create link
>> > [ 3171.646197] cpu cpu4: _add_list_dev: Failed to register opp debugfs (-12)
>> > [ 3171.653574] cpu cpu7: device_opp_debug_create_link: Failed to create link
>> > [ 3171.659752] cpu cpu7: _add_list_dev: Failed to register opp debugfs (-12)
>> > [ 3171.697011] cpu cpu5: cpufreq_init: failed to get clk: -2
>> > [ 3171.732505] cpu cpu6: cpufreq_init: failed to get clk: -2
>> > [ 3171.768160] cpu cpu7: cpufreq_init: failed to get clk: -2
>> >
>> > Tested on Odroid-XU4
>> >
>> > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
>> > Tested-by: Anand Moon <linux.amoon@gmail.com>
>
> What was this Tested-by supposed to mean? You got errors out there ...
>

I had done some stress testing, as pointed by Krzysztof.
I got myself in two minds on this part, please don't consider the
Tested-by and Reviewed-by part.
Thanks for pointing out.

-Anand  Moon

>> The patch is not sufficient. It does not work the way it should...
>>
>> BTW, I found the issue. The order of trip points in DT:
>> thermal_zone0/trip_point_0_hyst:5000
>> thermal_zone0/trip_point_0_temp:50000
>> thermal_zone0/trip_point_0_type:active
>> thermal_zone0/trip_point_1_hyst:5000
>> thermal_zone0/trip_point_1_temp:60000
>> thermal_zone0/trip_point_1_type:active
>> thermal_zone0/trip_point_2_hyst:5000
>> thermal_zone0/trip_point_2_temp:70000
>> thermal_zone0/trip_point_2_type:active
>> thermal_zone0/trip_point_3_hyst:0
>> thermal_zone0/trip_point_3_temp:120000        <---- this should be last one!
>> thermal_zone0/trip_point_3_type:critical
>> thermal_zone0/trip_point_4_hyst:5000
>> thermal_zone0/trip_point_4_temp:90000
>> thermal_zone0/trip_point_4_type:passive
>> thermal_zone0/trip_point_5_hyst:5000
>> thermal_zone0/trip_point_5_temp:110000
>> thermal_zone0/trip_point_5_type:passive
>>
>> After fixing the order in DT, the cpu cooler starts working.
>
> Ahh, nice.
>
> --
> viresh
