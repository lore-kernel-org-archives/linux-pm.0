From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 1/3] thermal: exynos: Fix NULL pointer exception during
 kernel booting
Date: Tue, 17 Feb 2015 02:00:38 +0900
Message-ID: <CAGTfZH1RrcQkakasV8BNuc64-3Q2cO6DUfUqzDPOB6K2tFmmPA@mail.gmail.com>
References: <1424096414-4327-1-git-send-email-cw00.choi@samsung.com>
	<1424096414-4327-2-git-send-email-cw00.choi@samsung.com>
	<20150216160633.29eac148@amdc2363>
	<CAGTfZH3tESLb3V7PNpiy-nwi+cCVq6DHxkU6+gJU-MZhNqDBzg@mail.gmail.com>
	<20150216172802.414525a9@amdc2363>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20150216172802.414525a9@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Amit Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, "inki.dae@samsung.com" <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On Tue, Feb 17, 2015 at 1:28 AM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Chanwoo,
>
>> Hi Lukasz,
>>
>> On Tue, Feb 17, 2015 at 12:06 AM, Lukasz Majewski
>> <l.majewski@samsung.com> wrote:
>> > Hi Chanwoo,
>> >
>> >> This patch fixes the NULL pointer exception during kernel booting.
>> >> The thermal_zone _of_sensor_register() registers a sensor to DT
>> >> thermal zone and then read the current temperature by '.get_temp'
>> >> callback. The callback function of exynos thermal driver is
>> >> exynos_get_temp() which must need the 'pdata' instance of
>> >> exynos_tmu _platform_data structure.
>> >> - exynos_get_temp() -> code_to_temp() -> Must need the 'pdata'
>> >> instance
>> >>
>> >> But, exynos thermal driver is executed before getting the 'pdata'
>> >> instance. To avoid the kernel panic, have to get the platform data
>> >> by executing the exynos_map_dt_data() before calling
>> >> thermal_zone_of_sensor_register() .
>> >
>> > I've already prepared patch for this (unfortunately it isn't yet
>> > applied to mainline):
>> >
>> > "[PATCH] thermal: exynos: fix: Check if data->tmu_read callback is
>> > present before read"
>> >
>> > http://www.spinics.net/lists/linux-samsung-soc/msg42245.html
>>
>> There is different issue between you patch and this patch.
>> Your patch check the whether data->tmu_read is NULL or not.
>> But, my patch check the pdata is NULL or not.
>
> I've tried to do the same previously. Please compare with:
> [PATCH 1/2] thermal: exynos: Reorder exynos_map_dt_data() function
>
> http://www.spinics.net/lists/linux-samsung-soc/msg41308.html
>
> Unfortunately, Abhilash found some issues with this code, so I've
> looked into different solution.

OK.

>
>
> However, I didn't need to move pdata = data->pdata; Hence, I wonder why
> it need to be reordered. Are you using Exynos3250 based device?

I think it is necessary to prevent kernel panic. We can check this
issue by analyzing
the thermal_zone_of_sensor_register() as following issue:

of_thermal_get_temp() executes the exynos_get_temp() finally. And
exynos_get_temp()
function must need the 'pdata' instance. The 'pdata' instance is
initialized on exynos_map_dt_data().
If exynos_tmu driver executes the exynos_map_dt_data() after
thermal_zone_of_sensor_register(),
this issue happen again.

[ 4211.945315] [<ffffffc0004de6d8>] of_thermal_get_temp+0x1c/0x30
[ 4211.951132] [<ffffffc0004db86c>] thermal_zone_get_temp+0x48/0x7c
[ 4211.957118] [<ffffffc0004dd278>] thermal_zone_device_update+0x20/0x110
[ 4211.963627] [<ffffffc0004de9c8>] of_thermal_set_mode+0x44/0x68
[ 4211.969443] [<ffffffc0004decb8>] thermal_zone_of_sensor_register+0x15c/0x1d8

I tested it on Exynos5433 based device.

>
>
>>
>> >
>> > Does applying this patch help?
>> >
>> > BTW: How can I reproduce this error? Could you point me the SHA1 and
>> > repository?
>>
>> I used your patch-set of linux-soc-thermal.git (branch: next). So I
>> applied you patchiest on Linux 3.19 for test.
>> -
>> https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git/log/?h=next
>
> Is there any special .config?

There is no special configuration.
I tested this patch with CPUFREQ for cooling device.

>
> May I ask about the target platform?
> I will look closely on this problem tomorrow.

OK.

Best Regards,
Chanwoo Choi
