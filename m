From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC 1/2] thermal/cpu idle cooling: Introduce cpu idle
 cooling driver
Date: Wed, 14 Jun 2017 17:39:12 +0200
Message-ID: <CAKfTPtDpRuFK1dYUq3mOZcV7yOb6z7NC_=Qj__0s-H36nJvrRQ@mail.gmail.com>
References: <1496653645-20283-1-git-send-email-kevin.wangtao@hisilicon.com>
 <20170606034135.GA5103@vireshk-i7> <20170609082040.GE2244@mai>
 <CAMBp1jM4KV5yj2=p=JBSfnw9u1D6qqtru49Rqp_8d3ePkHcE5Q@mail.gmail.com> <20170614125551.GI2261@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614125551.GI2261@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Jean Wangtao <jean.wangtao@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Tao Wang <kevin.wangtao@hisilicon.com>, rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, Amit Kachhap <amit.kachhap@gmail.com>, javi.merino@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Sunzhaosheng Sun(Zhaosheng)" <sunzhaosheng@hisilicon.com>
List-Id: linux-pm@vger.kernel.org

On 14 June 2017 at 14:55, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On Sat, Jun 10, 2017 at 08:00:28PM +0200, Jean Wangtao wrote:
>> On 9 June 2017 at 10:20, Daniel Lezcano <daniel.lezcano@linaro.org> wrot=
e:
>>
>> > On Tue, Jun 06, 2017 at 09:11:35AM +0530, viresh kumar wrote:
>> > > + Daniel
>> > >
>> > > On 05-06-17, 17:07, Tao Wang wrote:
>> > > > cpu idle cooling driver performs synchronized idle injection acros=
s
>> > > > all cpu in same cluster, offers a new method to cooling down cpu,
>> > > > that is similar to intel_power_clamp driver, but is basically
>> > > > designed for ARM platform.
>> > > > Each cluster has its own idle cooling device, each core has its ow=
n
>> > > > idle injection thread, idle injection thread use play_idle to ente=
r
>> > > > idle. In order to reach deepest idle state, all cores are aligned =
by
>> > > > jiffies. the injected idle ratio can be controlled through cooling
>> > > > device interface.
>> > > >
>> > > > Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
>> >
>> > [ ... ]
>> >
>> > Hi Kevin,
>> >
>> > I'm failing to understand all the cpumask logic.
>> >
>> > Can you explain the rational?
>> >
>> > Thanks.
>> >
>>
>> This driver register cooling device for each cluster, so in module_init,=
 we
>> init rest_cpu_mask as all cpu, then pick first cpu of the rest_cpu_mask,
>> set register_cpu_mask as all cpus in the cluster which contains the pick=
ed
>> cpu, and register idle cooling device, clear the register_cpu_mask out o=
f
>> rest_cpu_mask after the register. repeat the process above until there a=
re
>> no cpu left.
>>
>> In cpu_idle_cooling_register, we will check whether the input cpumask is
>> empty or have intersection with registered devices(that seems to be
>> unnecessary now, because the input is under control), the related_cpus i=
s
>> the copy of input cpumask, the injected_cpus is the same as related_cpus=
 if
>> there are no error happened during create_idle_thread(there is bug here =
if
>> create_idle_thread return error we should call stop_idle_thread to destr=
oy
>> the idle injection thread already created).
>>
>> In create_idle_thread, we create idle injection thread for each cpu in
>> related_cpus, if operation success, set cpumask in injected_cpus.
>> In stop_idle_thread, we destory idle injection thread for each cpu in
>> injected_cpus which marks the threads we have created.
>>
>> In get_cpu_idle_injection_dev, we go through all the registered devices =
to
>> find one which contain the input cpu.
>> In idle_injection_cpu_online, when a cpu plug in, if this cpu is the fir=
st
>> cpu of the cluster or current control cpu of the cooling device is offli=
ne,
>> set this cpu as the control cpu.
>> In idle_injection_cpu_predown, when a cpu plug off, we set the first onl=
ine
>> cpu of injected_cpus as the control cpu.
>>
>> In set_idle_state, the input cpu mask may cover several cooling device, =
so
>> we go through all the registered devices, each device who's related_cpus=
 is
>> the subset of the input cpumask will execute idle injection with the inp=
ut
>> ratio.
>>
>> I wish I have explained it clearly.
>>
>
> Well, you explained what it does but I was expecting the why.

Is your question about why to create cooling device per cluster ?

In order to maximize power decrease, it's worth putting all CPUs in
the same cluster in idle simultaneously in order to power down the
cluster as well and remove more static power.
On HMP system, the power budget of each cluster is different (big
cores vs LITTLE cores). injecting idle on little cores cluster doesn't
give much impact compared to big cluster

>
> Is there any document describing in details your code or the logic?
>
> For example why the following pseudo-code would it be wrong in place of t=
he
> cpumask dance?

Not sure to catch what you mean here ?

>
> [pseudo code]
>
> cpumask_t cluster_id;
>
> cpumask_clear(cluster_id);
>
> for_each_cpu_possible(cpu) {
>
>         if (cpumask_test_cpu(topology_physical_package_id(cpu]),
>                                 &cluster_id))
>                 continue;
>
>         th_cool_dev =3D cpu_idle_cooling_register(cpumask_of(cpu));
>         if (IS_ERR(th_cool_dev)
>                 goto rollback;
>
>         cpumask_set(topology_physical_package_id(cpu], &cluster_id);
> }
>
>
>> > > > +struct thermal_cooling_device * __init
>> > > > +cpu_idle_cooling_register(const struct cpumask *clip_cpus)
>> > > > +{
>> > > > +   struct cpu_idle_cooling_device *idle_cooling_dev;
>> > > > +   struct thermal_cooling_device *ret;
>> > > > +   unsigned long cpu;
>> > > > +   char dev_name[THERMAL_NAME_LENGTH];
>> > > > +
>> > > > +   if (cpumask_empty(clip_cpus))
>> > > > +           return ERR_PTR(-ENOMEM);
>> > > > +
>> > > > +   mutex_lock(&cpu_idle_cooling_lock);
>> > > > +   get_online_cpus();
>> > > > +   list_for_each_entry(idle_cooling_dev,
>> > > > +           &cpu_idle_cooling_dev_list, node) {
>> > > > +           if (cpumask_intersects(idle_cooling_dev->related_cpus,
>> > > > +                   clip_cpus)) {
>> > > > +                   ret =3D ERR_PTR(-EINVAL);
>> > > > +                   goto exit_unlock;
>> > > > +           }
>> > > > +   }
>> > > > +
>> > > > +   idle_cooling_dev =3D kzalloc(sizeof(*idle_cooling_dev), GFP_KE=
RNEL);
>> > > > +   if (!idle_cooling_dev) {
>> > > > +           ret =3D ERR_PTR(-ENOMEM);
>> > > > +           goto exit_unlock;
>> > > > +   }
>> > > > +
>> > > > +   if (!zalloc_cpumask_var(&idle_cooling_dev->related_cpus,
>> > GFP_KERNEL)) {
>> > > > +           ret =3D ERR_PTR(-ENOMEM);
>> > > > +           goto exit_free_dev;
>> > > > +   }
>> > > > +
>> > > > +   if (!zalloc_cpumask_var(&idle_cooling_dev->injected_cpus,
>> > GFP_KERNEL)) {
>> > > > +           ret =3D ERR_PTR(-ENOMEM);
>> > > > +           goto exit_free_related_cpus;
>> > > > +   }
>> > > > +
>> > > > +   cpumask_copy(idle_cooling_dev->related_cpus, clip_cpus);
>> > > > +   cpu =3D cpumask_first(clip_cpus);
>> > > > +   idle_cooling_dev->control_cpu =3D cpu;
>> > > > +   idle_cooling_dev->id =3D topology_physical_package_id(cpu);
>> > > > +   idle_cooling_dev->window_size =3D DEFAULT_WINDOW_SIZE;
>> > > > +   idle_cooling_dev->duration =3D jiffies_to_msecs(DEFAULT_
>> > DURATION_JIFFIES);
>> > > > +
>> > > > +   if (create_idle_thread(idle_cooling_dev)) {
>> > > > +           ret =3D ERR_PTR(-ENOMEM);
>> > > > +           goto exit_free_injected_cpus;
>> > > > +   }
>> > > > +
>> > > > +   snprintf(dev_name, sizeof(dev_name), "thermal-cpuidle-%d",
>> > > > +            idle_cooling_dev->id);
>> > > > +   ret =3D thermal_cooling_device_register(dev_name,
>> > > > +                                   idle_cooling_dev,
>> > > > +                                   &cpu_idle_injection_cooling_op=
s);
>> > > > +   if (IS_ERR(ret))
>> > > > +           goto exit_stop_thread;
>> > > > +
>> > > > +   idle_cooling_dev->cooling_dev =3D ret;
>> > > > +
>> > > > +   if (device_create_file(&idle_cooling_dev->cooling_dev->device,
>> > > > +           &dev_attr_duration)) {
>> > > > +           ret =3D ERR_PTR(-ENOMEM);
>> > > > +           goto exit_unregister_cdev;
>> > > > +   }
>> > > > +
>> > > > +   if (device_create_file(&idle_cooling_dev->cooling_dev->device,
>> > > > +           &dev_attr_window_size)) {
>> > > > +           ret =3D ERR_PTR(-ENOMEM);
>> > > > +           goto exit_remove_duration_attr;
>> > > > +   }
>> > > > +
>> > > > +   list_add(&idle_cooling_dev->node, &cpu_idle_cooling_dev_list);
>> > > > +
>> > > > +   goto exit_unlock;
>> > > > +
>> > > > +exit_remove_duration_attr:
>> > > > +   device_remove_file(&idle_cooling_dev->cooling_dev->device,
>> > > > +                   &dev_attr_duration);
>> > > > +exit_unregister_cdev:
>> > > > +   thermal_cooling_device_unregister(idle_cooling_dev->cooling_de=
v);
>> > > > +exit_stop_thread:
>> > > > +   stop_idle_thread(idle_cooling_dev);
>> > > > +exit_free_injected_cpus:
>> > > > +   free_cpumask_var(idle_cooling_dev->injected_cpus);
>> > > > +exit_free_related_cpus:
>> > > > +   free_cpumask_var(idle_cooling_dev->related_cpus);
>> > > > +exit_free_dev:
>> > > > +   kfree(idle_cooling_dev);
>> > > > +exit_unlock:
>> > > > +   put_online_cpus();
>> > > > +   mutex_unlock(&cpu_idle_cooling_lock);
>> > > > +   return ret;
>> > > > +}
>> > > > +
>> > > > +void cpu_idle_cooling_unregister(struct thermal_cooling_device *c=
dev)
>> > > > +{
>> > > > +   struct cpu_idle_cooling_device *idle_cooling_dev;
>> > > > +
>> > > > +   if (IS_ERR_OR_NULL(cdev))
>> > > > +           return;
>> > > > +
>> > > > +   idle_cooling_dev =3D cdev->devdata;
>> > > > +
>> > > > +   mutex_lock(&cpu_idle_cooling_lock);
>> > > > +   get_online_cpus();
>> > > > +   list_del(&idle_cooling_dev->node);
>> > > > +   put_online_cpus();
>> > > > +   mutex_unlock(&cpu_idle_cooling_lock);
>> > > > +
>> > > > +   device_remove_file(&cdev->device, &dev_attr_window_size);
>> > > > +   device_remove_file(&cdev->device, &dev_attr_duration);
>> > > > +   thermal_cooling_device_unregister(idle_cooling_dev->cooling_de=
v);
>> > > > +
>> > > > +   stop_idle_thread(idle_cooling_dev);
>> > > > +   free_cpumask_var(idle_cooling_dev->injected_cpus);
>> > > > +   free_cpumask_var(idle_cooling_dev->related_cpus);
>> > > > +   kfree(idle_cooling_dev);
>> > > > +}
>> > > > +
>> > > > +static void __cpu_idle_cooling_exit(void)
>> > > > +{
>> > > > +   struct cpu_idle_cooling_device *idle_cooling_dev;
>> > > > +
>> > > > +   while (!list_empty(&cpu_idle_cooling_dev_list)) {
>> > > > +           idle_cooling_dev =3D list_first_entry(&cpu_idle_
>> > cooling_dev_list,
>> > > > +                           struct cpu_idle_cooling_device, node);
>> > > > +           cpu_idle_cooling_unregister(idle_cooling_dev->cooling_=
dev)
>> > ;
>> > > > +   }
>> > > > +
>> > > > +   if (hp_state > 0)
>> > > > +           cpuhp_remove_state_nocalls(hp_state);
>> > > > +}
>> > > > +
>> > > > +static int __init cpu_idle_cooling_init(void)
>> > > > +{
>> > > > +   struct thermal_cooling_device *ret;
>> > > > +   cpumask_t rest_cpu_mask =3D CPU_MASK_ALL;
>> > > > +   const struct cpumask *register_cpu_mask;
>> > > > +
>> > > > +   hp_state =3D cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> > > > +                   "thermal/cpu_idle_cooling:online",
>> > > > +                   idle_injection_cpu_online,
>> > > > +                   idle_injection_cpu_predown);
>> > > > +   if (hp_state < 0)
>> > > > +           return hp_state;
>> > > > +
>> > > > +   do {
>> > > > +           register_cpu_mask =3D
>> > > > +                   topology_core_cpumask(cpumask_
>> > first(&rest_cpu_mask));
>> > > > +
>> > > > +           if (cpumask_empty(register_cpu_mask))
>> > > > +                   break;
>> > > > +
>> > > > +           ret =3D cpu_idle_cooling_register(register_cpu_mask);
>> > > > +           if (IS_ERR(ret)) {
>> > > > +                   __cpu_idle_cooling_exit();
>> > > > +                   return -ENOMEM;
>> > > > +           }
>> > > > +   } while (cpumask_andnot(&rest_cpu_mask,
>> > > > +                           &rest_cpu_mask,
>> > > > +                           register_cpu_mask));
>> > > > +
>> > > > +   return 0;
>> > > > +}
>> > > > +module_init(cpu_idle_cooling_init);
>> > > > +
>> > > > +static void __exit cpu_idle_cooling_exit(void)
>> > > > +{
>> > > > +   __cpu_idle_cooling_exit();
>> > > > +}
>> > > > +module_exit(cpu_idle_cooling_exit);
>> > > > +
>> > > > +MODULE_LICENSE("GPL v2");
>> > > > +MODULE_AUTHOR("Tao Wang <kevin.wangtao@hisilicon.com>");
>> > > > +MODULE_DESCRIPTION("CPU Idle Cooling Driver for ARM Platform");
>> > > > --
>> > > > 1.7.9.5
>> > >
>> > > --
>> > > viresh
>> >
>> > --
>> >
>> >  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs
>> >
>> > Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> > <http://twitter.com/#!/linaroorg> Twitter |
>> > <http://www.linaro.org/linaro-blog/> Blog
>> >
>
> --
>
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
