From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 1/2] thermal: exynos: Reorder exynos_map_dt_data() function
Date: Wed, 22 Apr 2015 10:34:42 +0900
Message-ID: <5536FAB2.2070009@samsung.com>
References: <1421667844-13627-1-git-send-email-l.majewski@samsung.com>
 <1421667844-13627-2-git-send-email-l.majewski@samsung.com>
 <CAM4voakDBLbshW3EvFN4YRx1o1ApMLJVZ2ZQ0Bb6NwhmoT8WFA@mail.gmail.com>
 <20150122100124.65e7a19e@amdc2363>
 <CAM4voani1xcgRU3e11_pnYw4d7Yj=QOKun8g_DywmxDxOwEgRQ@mail.gmail.com>
 <20150129230616.GJ29837@developer.amazonguestwifi.org>
 <20150130091422.669930c8@amdc2363> <552E091A.2000902@samsung.com>
 <20150415130554.264b61cc@amdc2363> <552F09FD.7020200@samsung.com>
 <20150417143921.36a5a66e@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20150417143921.36a5a66e@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 04/17/2015 09:39 PM, Lukasz Majewski wrote:
> Hi Joonyoung,
> 
>> Hi Lukasz,
>>
>> On 04/15/2015 08:05 PM, Lukasz Majewski wrote:
>>> Hi Joonyoung,
>>>
>>>> Hi Lukasz,
>>>>
>>>> On 01/30/2015 05:14 PM, Lukasz Majewski wrote:
>>>>> Hi Eduardo, Abhilash,
>>>>>
>>>>>> On Thu, Jan 22, 2015 at 06:02:07PM +0530, Abhilash Kesavan wrote:
>>>>>>> Hi Lukasz,
>>>>>>>
>>>>>>> On Thu, Jan 22, 2015 at 2:31 PM, Lukasz Majewski
>>>>>>> <l.majewski@samsung.com> wrote:
>>>>>>>> Hi Abhilash,
>>>>>>>>
>>>>>>>>> Hi Lukasz,
>>>>>>>>>
>>>>>>>>> On Mon, Jan 19, 2015 at 5:14 PM, Lukasz Majewski
>>>>>>>>> <l.majewski@samsung.com> wrote:
>>>>>>>>>> The exynos_map_dt_data() function must be called before
>>>>>>>>>> thermal_zone_of_sensor_register(), and hence provide
>>>>>>>>>> tmu_read() function, before it is needed.
>>>>>>>>>>
>>>>>>>>>> This change is driven by adding support for enabling
>>>>>>>>>> thermal_zoneX when it is properly initialized.
>>>>>>>>>>
>>>>>>>>>> One can read the mode of operation
>>>>>>>>>> at /sys/class/thermal/thermal_zone0/mode Such functionality
>>>>>>>>>> was missing in the of-thermal.c code.
>>>>>>>>>>
>>>>>>>>>> Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>>>>>>>>> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>>>>>>>>>> ---
>>>>>>>>>>  drivers/thermal/samsung/exynos_tmu.c | 7 ++++---
>>>>>>>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/thermal/samsung/exynos_tmu.c
>>>>>>>>>> b/drivers/thermal/samsung/exynos_tmu.c index 9d2d685..5d946ab
>>>>>>>>>> 100644 --- a/drivers/thermal/samsung/exynos_tmu.c
>>>>>>>>>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>>>>>>>>>> @@ -975,15 +975,16 @@ static int exynos_tmu_probe(struct
>>>>>>>>>> platform_device *pdev) platform_set_drvdata(pdev, data);
>>>>>>>>>>         mutex_init(&data->lock);
>>>>>>>>>>
>>>>>>>>>> +       ret = exynos_map_dt_data(pdev);
>>>>>>>>>> +       if (ret)
>>>>>>>>>> +               goto err_sensor;
>>>>
>>>> It's enough to just return ret.
>>>>
>>>> One more, i think to need to take out regulator enable codes from
>>>> exynos_map_dt_data. If not, can't restore about regulator when
>>>> error occurs.
>>>>
>>>>>>>>>> +
>>>>>>>>>>         data->tzd =
>>>>>>>>>> thermal_zone_of_sensor_register(&pdev->dev, 0, data,
>>>>>>>>>> &exynos_sensor_ops); if (IS_ERR(data->tzd)) {
>>>>>>>>>>                 pr_err("thermal: tz: %p ERROR\n", data->tzd);
>>>>>>>>>>                 return PTR_ERR(data->tzd);
>>>>>>>>>>         }
>>>>>>>>>> -       ret = exynos_map_dt_data(pdev);
>>>>>>>>>> -       if (ret)
>>>>>>>>>> -               goto err_sensor;
>>>>>>>>>>
>>>>>>>>>>         pdata = data->pdata;
>>>>>>>>>
>>>>>>>>> I have been testing this along with your v5 patch set and am
>>>>>>>>> seeing incorrect temperature being reported at boot-up on
>>>>>>>>> exynos7.
>>>>>>>>
>>>>>>>> Does it show a maximal temperature value (0x1FF)?
>>>>>>>
>>>>>>> I did not print the current temperature register, but I remember
>>>>>>> the message showing ~105C. Will give you the register value when
>>>>>>> I test with more debug prints tomorrow.
>>>>>>>
>>>>>>>>
>>>>>>>>>  It looks
>>>>>>>>> like exynos_tmu_read gets called from
>>>>>>>>> thermal_zone_of_device_update during boot-up, now that we have
>>>>>>>>> it populated early. However, as the tmu initialization
>>>>>>>>> function has not been called yet it returns a wrong value.
>>>>>>>>> Does that sound correct ?
>>>>>>>>
>>>>>>>> No, this is a mistake. However, I'm wondering why on Exynos4/5
>>>>>>>> this error didn't show up...
>>>>>>>
>>>>>>> I have been lowering the software trip point temperature in the
>>>>>>> exynos7 dts file (to 55C) for testing purposes. Hence, when the
>>>>>>> temperature is read incorrectly as ~105C the board trips at
>>>>>>> boot-up
>>>>>
>>>>> 					^^^^ this is a very
>>>>> unusual value - I had problems with
>>>>> 					reading 0xFF values with
>>>>> 					similar symptom (but this
>>>>> was caused by lack of vtmu).
>>>>>
>>>>>>> itself. Maybe for exynos4/5 the incorrect value read during
>>>>>>> boot-up is in the non-tripping range and once the tmu is
>>>>>>> initialized later it continues to function properly thereafter ?
>>>>>>>
>>>>>>>>
>>>>>>>> The reordering is needed to be able to call set_mode callback
>>>>>>>> at of-thermal.c to set the mode.
>>>>>>>>
>>>>>>>> If this change causes problems, then another solution (probably
>>>>>>>> not so neat) must be found.
>>>>>>>
>>>>>>> Please let me know if you need any further details.
>>>>>
>>>>> Abhilash, could you provide more details (like relevant output
>>>>> from dmesg) and point me a list of patches which shall I apply to
>>>>> test this issue on Exynos4/5?
>>>>>
>>>>>>
>>>>>> What is the status of this patch? Is it still required?
>>>>>
>>>>> It is strange, since on Exynos4/5 this works and some problems
>>>>> show up when run on Exynos7.
>>>>>
>>>>
>>>> I'm also wondering the status of this patch.
>>>
>>> This patch has been dropped.
>>>
>>>>
>>>> I get below errors when boots odroidxu3 board without this patch.
>>>
>>> Could you share the exact SHA1 and branch which you use in your
>>> setup?
>>>
>>
>> I tested with of odroidxu3 patchset for pwm-fan control of Anand Moon
>> on 20150414 -next.
>>
>> http://www.spinics.net/lists/arm-kernel/msg412031.html
>>
>>> For a reference please check following branch at github (this is the
>>> code which should be merged to v4.1-rc1)
>>>
>>> git@github.com:lmajewski/linux-samsung-thermal.git
>>>
>>> branch: next [1]
>>>
>>> This branch includes exynos7 support done by Chanwoo.
>>>
>>
>> I got following errors from branch [1] without patchset of Anand Moon,
>>
>> [    4.576442] thermal thermal_zone0: failed to read out thermal zone
>> 0 [    4.581685] 10060000.tmu supply vtmu not found, using dummy
>> regulator [    4.588223] thermal thermal_zone1: failed to read out
>> thermal zone 1 [    4.594110] 10064000.tmu supply vtmu not found,
>> using dummy regulator [    4.600849] thermal thermal_zone2: failed to
>> read out thermal zone 2 [    4.606847] 10068000.tmu supply vtmu not
>> found, using dummy regulator [    4.613640] thermal thermal_zone3:
>> failed to read out thermal zone 3 [    4.619584] 1006c000.tmu supply
>> vtmu not found, using dummy regulator [    4.626370] thermal
>> thermal_zone4: failed to read out thermal zone 4 [    4.632324]
>> 100a0000.tmu supply vtmu not found, using dummy regulator
> 
> Could you check if after booting you can read temperature from thermal
> zones?
> 

Yes, i can read temperature from
/sys/devices/virtual/thermal/thermal_zone[X]/temp after booting.

Thanks.

>>
>>>>
>>>> [    4.831980] thermal thermal_zone0: failed to read out thermal
>>>> zone (-22) [    4.838096] thermal thermal_zone1: failed to read out
>>>> thermal zone (-22) [    4.844894] thermal thermal_zone2: failed to
>>>> read out thermal zone (-22) [    4.851470] thermal thermal_zone3:
>>>> failed to read out thermal zone (-22) [    4.858186] thermal
>>>> thermal_zone4: failed to read out thermal zone (-22)
>>>>
>>>
>>> This issue has been fixed by following patch:
>>> "thermal: exynos: fix: Check if data->tmu_read callback is present
>>> before read"
>>>
>>> SHA1: 4531fa1684bb883ee01f1a182900b1e15d461b3
>>>
>>
>> I already have this commit on my test branch.
>>
>>> Please check [1] if it solves your problems.
>>>
>>>> Thanks.
>>>
>>
>> Thanks.
> 
> 
> 
