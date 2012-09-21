From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH v6 1/6] thermal: add generic cpufreq cooling implementation
Date: Fri, 21 Sep 2012 11:23:47 +0900
Message-ID: <505BCFB3.3040004@samsung.com>
References: <0MAO00DCVFKI4NS0@ms2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <0MAO00DCVFKI4NS0@ms2.samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Cc: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org
List-Id: linux-pm@vger.kernel.org

Hi, Amit,
On 2012=B3=E2 08=BF=F9 16=C0=CF 20:41, Amit Daniel Kachhap wrote:

>  diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_coo=
ling.c
>  new file mode 100644
>  index 0000000..66cbd52
>  --- /dev/null
>  +++ b/drivers/thermal/cpu_cooling.c
>  @@ -0,0 +1,586 @@

>  +/**
>  + * cpufreq_cooling_register - function to create cpufreq cooling de=
vice.
>  + * @clip_cpus: cpumask of cpus where the frequency constraints will=
 happen.
>  + */
>  +struct thermal_cooling_device *cpufreq_cooling_register(
>  +       struct cpumask *clip_cpus)
>  +{
>  +       struct thermal_cooling_device *cool_dev;
>  +       struct cpufreq_cooling_device *cpufreq_dev =3D NULL;
>  +       unsigned int cpufreq_dev_count =3D 0, min =3D 0, max =3D 0;
>  +       char dev_name[THERMAL_NAME_LENGTH];
>  +       int ret =3D 0, id =3D 0, i;
>  +       struct cpufreq_policy policy;
>  +       ret =3D get_idr(&cpufreq_idr,&cpufreq_dev->id);
>  +       if (ret) {
>  +               kfree(cpufreq_dev);
>  +               return ERR_PTR(-EINVAL);
>  +       }
>  +
>  +       sprintf(dev_name, "thermal-cpufreq-%d", cpufreq_dev->id);
>  +
>  +       cool_dev =3D thermal_cooling_device_register(dev_name, cpufr=
eq_dev,
>  +&cpufreq_cooling_ops);
>  +       if (!cool_dev) {
>  +               release_idr(&cpufreq_idr, cpufreq_dev->id);
>  +               kfree(cpufreq_dev);
>  +               return ERR_PTR(-EINVAL);
>  +       }
>  +       cpufreq_dev->id =3D id;


Why is this needed? Should every cpufreq_dev instance's id be same for
zero? It looks odd. And it also has problem which can be occurred when
it release id during unregistering cpufreq_dev. I think it should keep
the idr value taken before.


>  1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
