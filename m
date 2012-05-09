From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH v3 5/6] thermal: exynos: Register the tmu sensor with the
 kernel thermal layer
Date: Wed, 9 May 2012 14:56:51 +0530
Message-ID: <CAK44p20481BR0QBmh=Hgkc-3A=AmFypdM1UpK95VHsaJcOuw7g@mail.gmail.com>
References: <1336493898-7039-1-git-send-email-amit.kachhap@linaro.org>
	<1336493898-7039-2-git-send-email-amit.kachhap@linaro.org>
	<1336493898-7039-3-git-send-email-amit.kachhap@linaro.org>
	<1336493898-7039-4-git-send-email-amit.kachhap@linaro.org>
	<1336493898-7039-5-git-send-email-amit.kachhap@linaro.org>
	<1336493898-7039-6-git-send-email-amit.kachhap@linaro.org>
	<20120508131637.a2f59904.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20120508131637.a2f59904.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, durgadoss.r@intel.com, linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On 9 May 2012 01:46, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, =A08 May 2012 21:48:17 +0530
> Amit Daniel Kachhap <amit.kachhap@linaro.org> wrote:
>
>> This code added creates a link between temperature sensors, linux th=
ermal
>> framework and cooling devices for samsung exynos platform. This laye=
r
>> monitors the temperature from the sensor and informs the generic the=
rmal
>> layer to take the necessary cooling action.
>>
>>
>> ...
>>
>> +static void exynos_report_trigger(void)
>> +{
>> + =A0 =A0 unsigned int i;
>> + =A0 =A0 char data[2];
>> + =A0 =A0 char *envp[] =3D { data, NULL };
>> +
>> + =A0 =A0 if (!th_zone || !th_zone->therm_dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 thermal_zone_device_update(th_zone->therm_dev);
>> +
>> + =A0 =A0 mutex_lock(&th_zone->therm_dev->lock);
>> + =A0 =A0 /* Find the level for which trip happened */
>> + =A0 =A0 for (i =3D 0; i < th_zone->sensor_conf->trip_data.trip_cou=
nt; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (th_zone->therm_dev->last_temperature <
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_zone->sensor_conf->trip=
_data.trip_val[i] * 1000)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (th_zone->mode =3D=3D THERMAL_DEVICE_ENABLED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (i > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_zone->therm_dev->pollin=
g_delay =3D ACTIVE_INTERVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 th_zone->therm_dev->pollin=
g_delay =3D IDLE_INTERVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 sprintf(data, "%u", i);
>
> yikes, if `i' exceeds 9, we have a stack scribble. =A0Please review t=
his
> and at least use snprintf(... =A0sizeof(data)) to prevent accidents.
Ok
>
>
>> + =A0 =A0 kobject_uevent_env(&th_zone->therm_dev->device.kobj, KOBJ_=
CHANGE, envp);
>> + =A0 =A0 mutex_unlock(&th_zone->therm_dev->lock);
>> +}
>> +
>>
>> ...
>>
>> +/* Get trip temperature callback functions for thermal zone */
>> +static int exynos_get_trip_temp(struct thermal_zone_device *thermal=
, int trip,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned l=
ong *temp)
>> +{
>> + =A0 =A0 if (trip < 0 || trip > 2)
>
> I don't know what `trip' does and I don't know the meaning of the
> values 0, 1 and 2. =A0Documentation, please.
Agreed will put their description.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 *temp =3D th_zone->sensor_conf->trip_data.trip_val[trip];
>> + =A0 =A0 /* convert the temperature into millicelsius */
>> + =A0 =A0 *temp =3D *temp * 1000;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>>
>> ...
>>
>> +/* Bind callback functions for thermal zone */
>> +static int exynos_bind(struct thermal_zone_device *thermal,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct thermal_cooling_dev=
ice *cdev)
>> +{
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 /* if the cooling device is the one from exynos4 bind it *=
/
>> + =A0 =A0 if (cdev !=3D th_zone->cool_dev[0])
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 if (thermal_zone_bind_cooling_device(thermal, 0, cdev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error binding cooling dev inst 0\n=
");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> + =A0 =A0 if (thermal_zone_bind_cooling_device(thermal, 1, cdev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error binding cooling dev inst 1\n=
");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto error_bind1;
>> + =A0 =A0 }
>
> There can never be more than two instances?
As of now it is fixed as we register only 2 zones
>
>> + =A0 =A0 return ret;
>> +error_bind1:
>> + =A0 =A0 thermal_zone_unbind_cooling_device(thermal, 0, cdev);
>> + =A0 =A0 return ret;
>> +}
>> +
>>
>> ...
>>
>> +/* Get temperature callback functions for thermal zone */
>> +static int exynos_get_temp(struct thermal_zone_device *thermal,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *temp)
>> +{
>> + =A0 =A0 void *data;
>> +
>> + =A0 =A0 if (!th_zone->sensor_conf) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info("Temperature sensor not initialise=
d\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> + =A0 =A0 data =3D th_zone->sensor_conf->private_data;
>> + =A0 =A0 *temp =3D th_zone->sensor_conf->read_temperature(data);
>> + =A0 =A0 /* convert the temperature into millicelsius */
>> + =A0 =A0 *temp =3D *temp * 1000;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/* Operation callback functions for thermal zone */
>> +static struct thermal_zone_device_ops exynos_dev_ops =3D {
>
> Can it be const? =A0That sometimes saves space, as the table doesn't =
need
> to be moved into writeable storage at runtime.
Yes it can be made const
>
>> + =A0 =A0 .bind =3D exynos_bind,
>> + =A0 =A0 .unbind =3D exynos_unbind,
>> + =A0 =A0 .get_temp =3D exynos_get_temp,
>> + =A0 =A0 .get_mode =3D exynos_get_mode,
>> + =A0 =A0 .set_mode =3D exynos_set_mode,
>> + =A0 =A0 .get_trip_type =3D exynos_get_trip_type,
>> + =A0 =A0 .get_trip_temp =3D exynos_get_trip_temp,
>> + =A0 =A0 .get_crit_temp =3D exynos_get_crit_temp,
>> +};
>> +
>> +/* Register with the in-kernel thermal management */
>> +static int exynos_register_thermal(struct thermal_sensor_conf *sens=
or_conf)
>> +{
>> + =A0 =A0 int ret, count, tab_size;
>> + =A0 =A0 struct freq_clip_table *tab_ptr;
>> +
>> + =A0 =A0 if (!sensor_conf || !sensor_conf->read_temperature) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Temperature sensor not initialised=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 th_zone =3D kzalloc(sizeof(struct exynos_thermal_zone), GF=
P_KERNEL);
>> + =A0 =A0 if (!th_zone) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_unregister;
>
> This seems wrong? =A0If we need to call exynos_unregister_thermal() o=
n
> this error path then we needed to call it on the predecing one?
> Perhaps?
ok my fault.
>
>> + =A0 =A0 }
>> +
>> + =A0 =A0 th_zone->sensor_conf =3D sensor_conf;
>> +
>> + =A0 =A0 tab_ptr =3D (struct freq_clip_table *)sensor_conf->cooling=
_data.freq_data;
>> + =A0 =A0 tab_size =3D sensor_conf->cooling_data.freq_clip_count;
>> +
>> + =A0 =A0 /* Register the cpufreq cooling device */
>> + =A0 =A0 th_zone->cool_dev_size =3D 1;
>> + =A0 =A0 count =3D 0;
>> + =A0 =A0 th_zone->cool_dev[count] =3D cpufreq_cooling_register(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (struct freq_clip_table *)=
&(tab_ptr[count]),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tab_size, cpumask_of(0));
>> +
>> + =A0 =A0 if (IS_ERR(th_zone->cool_dev[count])) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed to register cpufreq cooling=
 device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 th_zone->cool_dev_size =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_unregister;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 th_zone->therm_dev =3D thermal_zone_device_register(sensor=
_conf->name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 3, NULL, &exynos_dev_ops, =
0, 0, 0, IDLE_INTERVAL);
>> +
>> + =A0 =A0 if (IS_ERR(th_zone->therm_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed to register thermal zone de=
vice\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_unregister;
>> + =A0 =A0 }
>> + =A0 =A0 th_zone->mode =3D THERMAL_DEVICE_ENABLED;
>> +
>> + =A0 =A0 pr_info("Exynos: Kernel Thermal management registered\n");
>> +
>> + =A0 =A0 return 0;
>> +
>> +err_unregister:
>> + =A0 =A0 exynos_unregister_thermal();
>> + =A0 =A0 return ret;
>> +}
>> +
>>
>> ...
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
