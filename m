From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH 1/2] thermal: exynos: Reorder exynos_map_dt_data() function
Date: Mon, 2 Feb 2015 11:06:45 +0530
Message-ID: <CAM4voakQAUZe2nWtxBfqXeXH-T=gGq22BSX+a9UQeqObwsoe2g@mail.gmail.com>
References: <1421667844-13627-1-git-send-email-l.majewski@samsung.com>
	<1421667844-13627-2-git-send-email-l.majewski@samsung.com>
	<CAM4voakDBLbshW3EvFN4YRx1o1ApMLJVZ2ZQ0Bb6NwhmoT8WFA@mail.gmail.com>
	<20150122100124.65e7a19e@amdc2363>
	<CAM4voani1xcgRU3e11_pnYw4d7Yj=QOKun8g_DywmxDxOwEgRQ@mail.gmail.com>
	<20150129230616.GJ29837@developer.amazonguestwifi.org>
	<20150130091422.669930c8@amdc2363>
	<CAM4voa=aEZbCx5KDoZW1NgindOeM8UZshU5ioFjiux3aoqHYFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAM4voa=aEZbCx5KDoZW1NgindOeM8UZshU5ioFjiux3aoqHYFA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On Fri, Jan 30, 2015 at 8:36 PM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Lukasz,
>
> On Fri, Jan 30, 2015 at 1:44 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> Hi Eduardo, Abhilash,
>>
>>> On Thu, Jan 22, 2015 at 06:02:07PM +0530, Abhilash Kesavan wrote:
>>> > Hi Lukasz,
>>> >
>>> > On Thu, Jan 22, 2015 at 2:31 PM, Lukasz Majewski
>>> > <l.majewski@samsung.com> wrote:
>>> > > Hi Abhilash,
>>> > >
>>> > >> Hi Lukasz,
>>> > >>
>>> > >> On Mon, Jan 19, 2015 at 5:14 PM, Lukasz Majewski
>>> > >> <l.majewski@samsung.com> wrote:
>>> > >> > The exynos_map_dt_data() function must be called before
>>> > >> > thermal_zone_of_sensor_register(), and hence provide tmu_read()
>>> > >> > function, before it is needed.
>>> > >> >
>>> > >> > This change is driven by adding support for enabling
>>> > >> > thermal_zoneX when it is properly initialized.
>>> > >> >
>>> > >> > One can read the mode of operation
>>> > >> > at /sys/class/thermal/thermal_zone0/mode Such functionality was
>>> > >> > missing in the of-thermal.c code.
>>> > >> >
>>> > >> > Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> > >> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>>> > >> > ---
>>> > >> >  drivers/thermal/samsung/exynos_tmu.c | 7 ++++---
>>> > >> >  1 file changed, 4 insertions(+), 3 deletions(-)
>>> > >> >
>>> > >> > diff --git a/drivers/thermal/samsung/exynos_tmu.c
>>> > >> > b/drivers/thermal/samsung/exynos_tmu.c index 9d2d685..5d946ab
>>> > >> > 100644 --- a/drivers/thermal/samsung/exynos_tmu.c
>>> > >> > +++ b/drivers/thermal/samsung/exynos_tmu.c
>>> > >> > @@ -975,15 +975,16 @@ static int exynos_tmu_probe(struct
>>> > >> > platform_device *pdev) platform_set_drvdata(pdev, data);
>>> > >> >         mutex_init(&data->lock);
>>> > >> >
>>> > >> > +       ret = exynos_map_dt_data(pdev);
>>> > >> > +       if (ret)
>>> > >> > +               goto err_sensor;
>>> > >> > +
>>> > >> >         data->tzd =
>>> > >> > thermal_zone_of_sensor_register(&pdev->dev, 0, data,
>>> > >> > &exynos_sensor_ops); if (IS_ERR(data->tzd)) {
>>> > >> >                 pr_err("thermal: tz: %p ERROR\n", data->tzd);
>>> > >> >                 return PTR_ERR(data->tzd);
>>> > >> >         }
>>> > >> > -       ret = exynos_map_dt_data(pdev);
>>> > >> > -       if (ret)
>>> > >> > -               goto err_sensor;
>>> > >> >
>>> > >> >         pdata = data->pdata;
>>> > >>
>>> > >> I have been testing this along with your v5 patch set and am
>>> > >> seeing incorrect temperature being reported at boot-up on
>>> > >> exynos7.
>>> > >
>>> > > Does it show a maximal temperature value (0x1FF)?
>>> >
>>> > I did not print the current temperature register, but I remember the
>>> > message showing ~105C. Will give you the register value when I test
>>> > with more debug prints tomorrow.
>>> >
>>> > >
>>> > >>  It looks
>>> > >> like exynos_tmu_read gets called from
>>> > >> thermal_zone_of_device_update during boot-up, now that we have
>>> > >> it populated early. However, as the tmu initialization function
>>> > >> has not been called yet it returns a wrong value. Does that
>>> > >> sound correct ?
>>> > >
>>> > > No, this is a mistake. However, I'm wondering why on Exynos4/5
>>> > > this error didn't show up...
>>> >
>>> > I have been lowering the software trip point temperature in the
>>> > exynos7 dts file (to 55C) for testing purposes. Hence, when the
>>> > temperature is read incorrectly as ~105C the board trips at boot-up
>>
>>                                         ^^^^ this is a very unusual
>>                                         value - I had problems with
>>                                         reading 0xFF values with
>>                                         similar symptom (but this was
>>                                         caused by lack of vtmu).
>>
>>> > itself. Maybe for exynos4/5 the incorrect value read during boot-up
>>> > is in the non-tripping range and once the tmu is initialized later
>>> > it continues to function properly thereafter ?
>>> >
>>> > >
>>> > > The reordering is needed to be able to call set_mode callback at
>>> > > of-thermal.c to set the mode.
>>> > >
>>> > > If this change causes problems, then another solution (probably
>>> > > not so neat) must be found.
>>> >
>>> > Please let me know if you need any further details.
>>
>> Abhilash, could you provide more details (like relevant output from
>> dmesg) and point me a list of patches which shall I apply to test this
>> issue on Exynos4/5?
> Sorry, I have not had the time to re-check this and provide you with
> the current temperature register value. I will definitely do so on
> Monday and also provide you the dmesg output. I applied the following
> patches on linux-next:
>
> bbf872d thermal: exynos: Add TMU support for Exynos7 SoC
> b8190ac dts: Documentation: Add documentation for Exynos7 SoC thermal bindings
> 9330ec1 thermal: exynos: Reorder exynos_map_dt_data() function
> 4dd41c4 thermal: exynos: dts: Provide device tree bindings identical
> to the one in exynos_tmu_data.c
> a7b80b9 thermal: dts: exynos: Trip points and sensor configuration
> data for Exynos5440
> 77d072e thermal: exynos: dts: Define default thermal-zones for Exynos4
> 964dd36 thermal: dts: Default trip points definition for Exynos5420 SoCs
> c1d2f97 thermal: exynos: dts: Add default definition of the TMU sensor parameter
> 02a4496 arm: dts: Adding CPU cooling binding for Exynos SoCs
> bfadff0 arm: dts: odroid: Enable TMU at Exynos4412 based Odroid U3 device
> 862764c arm: dts: odroid: Add LDO10 regulator node necessary for TMU on Odroid
> c064731 arm: dts: trats: Enable TMU on the Exynos4210 trats device
>
> Along with the above list I have a patch which adds the dt changes
> required for exynos7 on similar lines as done for exynos4/exynos5. In
> the exyno7 trip point dts file I have modified the cpu-crit-0
> temperature to a low value of 55C for testing purposes.
>
>>
>>>
>>> What is the status of this patch? Is it still required?
>>
>> It is strange, since on Exynos4/5 this works and some problems show up
>> when run on Exynos7.
>
> I would have expected the issue to show up on Exynos4/5 too. I will
> test this on the 5420 based board I have on Monday.

I tested this on a 5420 based chromebook that I have (Peach Pit) and
observed similar results as that on Exynos7. Following are the patches
applied on next-20150130:

5b1194d thermal: exynos: Reorder exynos_map_dt_data() function
30c6165 thermal: exynos: dts: Provide device tree bindings identical
to the one in exynos_tmu_data.c
d94c248 thermal: dts: exynos: Trip points and sensor configuration
data for Exynos5440
aac8b3a thermal: exynos: dts: Define default thermal-zones for Exynos4
5e8cf52 thermal: dts: Default trip points definition for Exynos5420 SoCs
17ec9c2 thermal: exynos: dts: Add default definition of the TMU sensor parameter
36e247b arm: dts: Adding CPU cooling binding for Exynos SoCs
7aa1bb1 arm: dts: odroid: Enable TMU at Exynos4412 based Odroid U3 device
8884a76 arm: dts: odroid: Add LDO10 regulator node necessary for TMU on Odroid
aae2e51 arm: dts: trats: Enable TMU on the Exynos4210 trats device
827e3bd Add linux-next specific files for 20150130

On top of these patches, I have the following diff for
debugging/testing pruposes:

diff --git a/arch/arm/boot/dts/exynos5420-trip-points.dtsi
b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
index 09d6c56..ac8b6a0 100644
--- a/arch/arm/boot/dts/exynos5420-trip-points.dtsi
+++ b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
@@ -13,22 +13,22 @@ polling-delay-passive = <0>;
 polling-delay = <0>;
 trips {
        cpu-alert-0 {
-               temperature = <85000>; /* millicelsius */
+               temperature = <55000>; /* millicelsius */
                hysteresis = <10000>; /* millicelsius */
                type = "active";
        };
        cpu-alert-1 {
-               temperature = <103000>; /* millicelsius */
+               temperature = <63000>; /* millicelsius */
                hysteresis = <10000>; /* millicelsius */
                type = "active";
        };
        cpu-alert-2 {
-               temperature = <110000>; /* millicelsius */
+               temperature = <70000>; /* millicelsius */
                hysteresis = <10000>; /* millicelsius */
                type = "active";
        };
        cpu-crit-0 {
-               temperature = <1200000>; /* millicelsius */
+               temperature = <75000>; /* millicelsius */
                hysteresis = <0>; /* millicelsius */
                type = "critical";
        };
diff --git a/drivers/thermal/samsung/exynos_tmu.c
b/drivers/thermal/samsung/exynos_tmu.c
index 852e622..7281581 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -237,6 +237,7 @@ static int code_to_temp(struct exynos_tmu_data
*data, u8 temp_code)
                break;
        case TYPE_ONE_POINT_TRIMMING:
                temp = temp_code - data->temp_error1 + pdata->first_point_trim;
+               printk("temp_code is %d, err1 is %d, trim is %d, temp
is %d\n", temp_code, data->temp_error1, pdata->first_point_trim,
temp);
                break;
        default:
                temp = temp_code - pdata->default_temp_offset;
@@ -585,6 +586,7 @@ static int exynos_get_temp(void *p, long *temp)

        *temp = code_to_temp(data, data->tmu_read(data)) * MCELSIUS;

+       printk("temperature is %ld\n", *temp);
        clk_disable(data->clk);
        mutex_unlock(&data->lock);

@@ -675,6 +677,7 @@ static int exynos4210_tmu_read(struct exynos_tmu_data *data)

 static int exynos4412_tmu_read(struct exynos_tmu_data *data)
 {
+       printk("\n%s: Reading the current temperature register value:
0x%x\n\n", __func__, readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP));
        return readb(data->base + EXYNOS_TMU_REG_CURRENT_TEMP);
 }

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 48491d1..981fc99 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -469,7 +469,7 @@ static void update_temperature(struct
thermal_zone_device *tz)
        mutex_unlock(&tz->lock);

        trace_thermal_temperature(tz);
-       dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
+       dev_err(&tz->device, "last_temperature=%d, current_temperature=%d\n",
                                tz->last_temperature, tz->temperature);
 }

Also, I noticed  a typo (an extra zero) in cpu-crit-0 temperature above.

Following is the relevant boot-up log:

[    3.160126] TPS65090_RAILSLDO2: supplied by vbat-supply
[    3.343421] thermal thermal_zone5: last_temperature=0,
current_temperature=25900
[    3.349365] sbs-battery 20-000b: sbs-battery: battery gas gauge
device registered
[    3.374280] 10060000.tmu supply vtmu not found, using dummy regulator
[    3.379408]
[    3.379408] exynos4412_tmu_read: Reading the current temperature
register value: 0x36
[    3.379408]
[    3.390026] temp_code is 54, err1 is 0, trim is 25, temp is 79
[    3.395827] temperature is 79000
[    3.399053] thermal thermal_zone0: last_temperature=0,
current_temperature=79000
[    3.406429] thermal thermal_zone0: critical temperature reached(79
C),shutting down
[    3.414241] reboot: Failed to start orderly shutdown: forcing the issue
[    3.420690] usb 5-1: new high-speed USB device number 2 using exynos-ehci
[    3.427819] 10064000.tmu supply vtmu not found, using dummy regulator
[    3.434011] Emergency Sync complete
[    3.434355]
[    3.434355] exynos4412_tmu_read: Reading the current temperature
register value: 0x3
[    3.434355]
[    3.434367] temp_code is 3, err1 is 0, trim is 25, temp is 28
[    3.434373] temperature is 28000
[    3.434393] thermal thermal_zone1: last_temperature=0,
current_temperature=28000
[    3.434744] 10068000.tmu supply vtmu not found, using dummy regulator
[    3.435069]
[    3.435069] exynos4412_tmu_read: Reading the current temperature
register value: 0x2
[    3.435069]
[    3.435080] temp_code is 2, err1 is 0, trim is 25, temp is 27
[    3.435086] temperature is 27000
[    3.435103] thermal thermal_zone2: last_temperature=0,
current_temperature=27000
[    3.435427] 1006c000.tmu supply vtmu not found, using dummy regulator
[    3.435762]
[    3.435762] exynos4412_tmu_read: Reading the current temperature
register value: 0x2
[    3.435762]
[    3.435772] temp_code is 2, err1 is 0, trim is 25, temp is 27
[    3.435778] temperature is 27000
[    3.435794] thermal thermal_zone3: last_temperature=0,
current_temperature=27000
[    3.436112] 100a0000.tmu supply vtmu not found, using dummy regulator
[    3.436464]
[    3.436464] exynos4412_tmu_read: Reading the current temperature
register value: 0x33
[    3.436464]
[    3.436475] temp_code is 51, err1 is 0, trim is 25, temp is 76
[    3.436480] temperature is 76000
[    3.436496] thermal thermal_zone4: last_temperature=0,
current_temperature=76000
[    3.436527] thermal thermal_zone4: critical temperature reached(76
C),shutting down

>From the log, thermal_zone0 and thermal_zone4 show incorrect
temperatures. It looks like the first point trim error1 would need to
be intialized before we do a read ?
Please let me know if you need any more details.

Regards,
Abhilash
