From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH RFC 1/2] thermal/cpu idle cooling: Introduce cpu idle
 cooling driver
Date: Fri, 9 Jun 2017 10:20:40 +0200
Message-ID: <20170609082040.GE2244@mai>
References: <1496653645-20283-1-git-send-email-kevin.wangtao@hisilicon.com>
 <20170606034135.GA5103@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170606034135.GA5103@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tao Wang <kevin.wangtao@hisilicon.com>, rui.zhang@intel.com, edubezval@gmail.com, amit.kachhap@gmail.com, javi.merino@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sunzhaosheng@hisilicon.com, vincent.guittot@linaro.org, jean.wangtao@linaro.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 06, 2017 at 09:11:35AM +0530, viresh kumar wrote:
> + Daniel
> 
> On 05-06-17, 17:07, Tao Wang wrote:
> > cpu idle cooling driver performs synchronized idle injection across
> > all cpu in same cluster, offers a new method to cooling down cpu,
> > that is similar to intel_power_clamp driver, but is basically
> > designed for ARM platform.
> > Each cluster has its own idle cooling device, each core has its own
> > idle injection thread, idle injection thread use play_idle to enter
> > idle. In order to reach deepest idle state, all cores are aligned by
> > jiffies. the injected idle ratio can be controlled through cooling
> > device interface.
> > 
> > Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>

[ ... ]

Hi Kevin,

I'm failing to understand all the cpumask logic.

Can you explain the rational?

Thanks.

  -- Daniel


> > +struct thermal_cooling_device * __init
> > +cpu_idle_cooling_register(const struct cpumask *clip_cpus)
> > +{
> > +	struct cpu_idle_cooling_device *idle_cooling_dev;
> > +	struct thermal_cooling_device *ret;
> > +	unsigned long cpu;
> > +	char dev_name[THERMAL_NAME_LENGTH];
> > +
> > +	if (cpumask_empty(clip_cpus))
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	mutex_lock(&cpu_idle_cooling_lock);
> > +	get_online_cpus();
> > +	list_for_each_entry(idle_cooling_dev,
> > +		&cpu_idle_cooling_dev_list, node) {
> > +		if (cpumask_intersects(idle_cooling_dev->related_cpus,
> > +			clip_cpus)) {
> > +			ret = ERR_PTR(-EINVAL);
> > +			goto exit_unlock;
> > +		}
> > +	}
> > +
> > +	idle_cooling_dev = kzalloc(sizeof(*idle_cooling_dev), GFP_KERNEL);
> > +	if (!idle_cooling_dev) {
> > +		ret = ERR_PTR(-ENOMEM);
> > +		goto exit_unlock;
> > +	}
> > +
> > +	if (!zalloc_cpumask_var(&idle_cooling_dev->related_cpus, GFP_KERNEL)) {
> > +		ret = ERR_PTR(-ENOMEM);
> > +		goto exit_free_dev;
> > +	}
> > +
> > +	if (!zalloc_cpumask_var(&idle_cooling_dev->injected_cpus, GFP_KERNEL)) {
> > +		ret = ERR_PTR(-ENOMEM);
> > +		goto exit_free_related_cpus;
> > +	}
> > +
> > +	cpumask_copy(idle_cooling_dev->related_cpus, clip_cpus);
> > +	cpu = cpumask_first(clip_cpus);
> > +	idle_cooling_dev->control_cpu = cpu;
> > +	idle_cooling_dev->id = topology_physical_package_id(cpu);
> > +	idle_cooling_dev->window_size = DEFAULT_WINDOW_SIZE;
> > +	idle_cooling_dev->duration = jiffies_to_msecs(DEFAULT_DURATION_JIFFIES);
> > +
> > +	if (create_idle_thread(idle_cooling_dev)) {
> > +		ret = ERR_PTR(-ENOMEM);
> > +		goto exit_free_injected_cpus;
> > +	}
> > +
> > +	snprintf(dev_name, sizeof(dev_name), "thermal-cpuidle-%d",
> > +		 idle_cooling_dev->id);
> > +	ret = thermal_cooling_device_register(dev_name,
> > +					idle_cooling_dev,
> > +					&cpu_idle_injection_cooling_ops);
> > +	if (IS_ERR(ret))
> > +		goto exit_stop_thread;
> > +
> > +	idle_cooling_dev->cooling_dev = ret;
> > +
> > +	if (device_create_file(&idle_cooling_dev->cooling_dev->device,
> > +		&dev_attr_duration)) {
> > +		ret = ERR_PTR(-ENOMEM);
> > +		goto exit_unregister_cdev;
> > +	}
> > +
> > +	if (device_create_file(&idle_cooling_dev->cooling_dev->device,
> > +		&dev_attr_window_size)) {
> > +		ret = ERR_PTR(-ENOMEM);
> > +		goto exit_remove_duration_attr;
> > +	}
> > +
> > +	list_add(&idle_cooling_dev->node, &cpu_idle_cooling_dev_list);
> > +
> > +	goto exit_unlock;
> > +
> > +exit_remove_duration_attr:
> > +	device_remove_file(&idle_cooling_dev->cooling_dev->device,
> > +			&dev_attr_duration);
> > +exit_unregister_cdev:
> > +	thermal_cooling_device_unregister(idle_cooling_dev->cooling_dev);
> > +exit_stop_thread:
> > +	stop_idle_thread(idle_cooling_dev);
> > +exit_free_injected_cpus:
> > +	free_cpumask_var(idle_cooling_dev->injected_cpus);
> > +exit_free_related_cpus:
> > +	free_cpumask_var(idle_cooling_dev->related_cpus);
> > +exit_free_dev:
> > +	kfree(idle_cooling_dev);
> > +exit_unlock:
> > +	put_online_cpus();
> > +	mutex_unlock(&cpu_idle_cooling_lock);
> > +	return ret;
> > +}
> > +
> > +void cpu_idle_cooling_unregister(struct thermal_cooling_device *cdev)
> > +{
> > +	struct cpu_idle_cooling_device *idle_cooling_dev;
> > +
> > +	if (IS_ERR_OR_NULL(cdev))
> > +		return;
> > +
> > +	idle_cooling_dev = cdev->devdata;
> > +
> > +	mutex_lock(&cpu_idle_cooling_lock);
> > +	get_online_cpus();
> > +	list_del(&idle_cooling_dev->node);
> > +	put_online_cpus();
> > +	mutex_unlock(&cpu_idle_cooling_lock);
> > +
> > +	device_remove_file(&cdev->device, &dev_attr_window_size);
> > +	device_remove_file(&cdev->device, &dev_attr_duration);
> > +	thermal_cooling_device_unregister(idle_cooling_dev->cooling_dev);
> > +
> > +	stop_idle_thread(idle_cooling_dev);
> > +	free_cpumask_var(idle_cooling_dev->injected_cpus);
> > +	free_cpumask_var(idle_cooling_dev->related_cpus);
> > +	kfree(idle_cooling_dev);
> > +}
> > +
> > +static void __cpu_idle_cooling_exit(void)
> > +{
> > +	struct cpu_idle_cooling_device *idle_cooling_dev;
> > +
> > +	while (!list_empty(&cpu_idle_cooling_dev_list)) {
> > +		idle_cooling_dev = list_first_entry(&cpu_idle_cooling_dev_list,
> > +				struct cpu_idle_cooling_device, node);
> > +		cpu_idle_cooling_unregister(idle_cooling_dev->cooling_dev);
> > +	}
> > +
> > +	if (hp_state > 0)
> > +		cpuhp_remove_state_nocalls(hp_state);
> > +}
> > +
> > +static int __init cpu_idle_cooling_init(void)
> > +{
> > +	struct thermal_cooling_device *ret;
> > +	cpumask_t rest_cpu_mask = CPU_MASK_ALL;
> > +	const struct cpumask *register_cpu_mask;
> > +
> > +	hp_state = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> > +			"thermal/cpu_idle_cooling:online",
> > +			idle_injection_cpu_online,
> > +			idle_injection_cpu_predown);
> > +	if (hp_state < 0)
> > +		return hp_state;
> > +
> > +	do {
> > +		register_cpu_mask =
> > +			topology_core_cpumask(cpumask_first(&rest_cpu_mask));
> > +
> > +		if (cpumask_empty(register_cpu_mask))
> > +			break;
> > +
> > +		ret = cpu_idle_cooling_register(register_cpu_mask);
> > +		if (IS_ERR(ret)) {
> > +			__cpu_idle_cooling_exit();
> > +			return -ENOMEM;
> > +		}
> > +	} while (cpumask_andnot(&rest_cpu_mask,
> > +				&rest_cpu_mask,
> > +				register_cpu_mask));
> > +
> > +	return 0;
> > +}
> > +module_init(cpu_idle_cooling_init);
> > +
> > +static void __exit cpu_idle_cooling_exit(void)
> > +{
> > +	__cpu_idle_cooling_exit();
> > +}
> > +module_exit(cpu_idle_cooling_exit);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Tao Wang <kevin.wangtao@hisilicon.com>");
> > +MODULE_DESCRIPTION("CPU Idle Cooling Driver for ARM Platform");
> > -- 
> > 1.7.9.5
> 
> -- 
> viresh

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
