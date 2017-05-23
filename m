From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V4 03/17] thermal: cpu_cooling: Name cpufreq cooling
 devices as cpufreq_cdev
Date: Tue, 23 May 2017 14:37:40 +0800
Message-ID: <1495521460.2303.4.camel@intel.com>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
         <323c25bfc9454e54102b0956bae049365f1ba2bb.1493115651.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <323c25bfc9454e54102b0956bae049365f1ba2bb.1493115651.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-04-25 at 15:57 +0530, Viresh Kumar wrote:
> Objects of "struct cpufreq_cooling_device" are named a bit
> inconsistently. Lets use cpufreq_cdev everywhere. Also note that the
> lists containing such devices is renamed similarly too.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/thermal/cpu_cooling.c | 248 +++++++++++++++++++++-----------
> ----------
>  1 file changed, 124 insertions(+), 124 deletions(-)
> 
> 

>  
>  	num_cpus = cpumask_weight(clip_cpus);
> -	cpufreq_dev->time_in_idle = kcalloc(num_cpus,
> -					    sizeof(*cpufreq_dev-
> >time_in_idle),
> +	cpufreq_cdev->time_in_idle = kcalloc(num_cpus,
> +					    sizeof(*cpufreq_cdev-
> >time_in_idle),
>  					    GFP_KERNEL);

checkpatch complains about this line

WARNING: Prefer kmalloc_array over kmalloc with multiply
#544: FILE: drivers/thermal/cpu_cooling.c:827:
+	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev-
>freq_table) *
+					  cpufreq_cdev->max_level,
GFP_KERNEL);

total: 0 errors, 1 warnings, 614 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-
inplace.

and also patch 8/17.

It's better to get this fixed.

thanks,
rui


> -	if (!cpufreq_dev->time_in_idle) {
> +	if (!cpufreq_cdev->time_in_idle) {
>  		cool_dev = ERR_PTR(-ENOMEM);
>  		goto free_cdev;
>  	}
>  
> -	cpufreq_dev->time_in_idle_timestamp =
> -		kcalloc(num_cpus, sizeof(*cpufreq_dev-
> >time_in_idle_timestamp),
> +	cpufreq_cdev->time_in_idle_timestamp =
> +		kcalloc(num_cpus, sizeof(*cpufreq_cdev-
> >time_in_idle_timestamp),
>  			GFP_KERNEL);
> -	if (!cpufreq_dev->time_in_idle_timestamp) {
> +	if (!cpufreq_cdev->time_in_idle_timestamp) {
>  		cool_dev = ERR_PTR(-ENOMEM);
>  		goto free_time_in_idle;
>  	}
>  
>  	/* Find max levels */
>  	cpufreq_for_each_valid_entry(pos, table)
> -		cpufreq_dev->max_level++;
> +		cpufreq_cdev->max_level++;
>  
> -	cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev-
> >freq_table) *
> -					  cpufreq_dev->max_level,
> GFP_KERNEL);
> -	if (!cpufreq_dev->freq_table) {
> +	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev-
> >freq_table) *
> +					  cpufreq_cdev->max_level,
> GFP_KERNEL);
> +	if (!cpufreq_cdev->freq_table) {
>  		cool_dev = ERR_PTR(-ENOMEM);
>  		goto free_time_in_idle_timestamp;
>  	}
>  
>  	/* max_level is an index, not a counter */
> -	cpufreq_dev->max_level--;
> +	cpufreq_cdev->max_level--;
>  
> -	cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
> +	cpumask_copy(&cpufreq_cdev->allowed_cpus, clip_cpus);
>  
>  	if (capacitance) {
> -		cpufreq_dev->plat_get_static_power =
> plat_static_func;
> +		cpufreq_cdev->plat_get_static_power =
> plat_static_func;
>  
> -		ret = build_dyn_power_table(cpufreq_dev,
> capacitance);
> +		ret = build_dyn_power_table(cpufreq_cdev,
> capacitance);
>  		if (ret) {
>  			cool_dev = ERR_PTR(ret);
>  			goto free_table;
> @@ -856,12 +855,12 @@ __cpufreq_cooling_register(struct device_node
> *np,
>  		cool_dev = ERR_PTR(ret);
>  		goto free_power_table;
>  	}
> -	cpufreq_dev->id = ret;
> +	cpufreq_cdev->id = ret;
>  
>  	/* Fill freq-table in descending order of frequencies */
> -	for (i = 0, freq = -1; i <= cpufreq_dev->max_level; i++) {
> +	for (i = 0, freq = -1; i <= cpufreq_cdev->max_level; i++) {
>  		freq = find_next_max(table, freq);
> -		cpufreq_dev->freq_table[i] = freq;
> +		cpufreq_cdev->freq_table[i] = freq;
>  
>  		/* Warn for duplicate entries */
>  		if (!freq)
> @@ -871,20 +870,21 @@ __cpufreq_cooling_register(struct device_node
> *np,
>  	}
>  
>  	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
> -		 cpufreq_dev->id);
> +		 cpufreq_cdev->id);
>  
> -	cool_dev = thermal_of_cooling_device_register(np, dev_name,
> cpufreq_dev,
> +	cool_dev = thermal_of_cooling_device_register(np, dev_name,
> +						      cpufreq_cdev,
>  						      cooling_ops);
>  	if (IS_ERR(cool_dev))
>  		goto remove_ida;
>  
> -	cpufreq_dev->clipped_freq = cpufreq_dev->freq_table[0];
> -	cpufreq_dev->cool_dev = cool_dev;
> +	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0];
> +	cpufreq_cdev->cool_dev = cool_dev;
>  
>  	mutex_lock(&cooling_list_lock);
>  	/* Register the notifier for first cpufreq cooling device */
> -	first = list_empty(&cpufreq_dev_list);
> -	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
> +	first = list_empty(&cpufreq_cdev_list);
> +	list_add(&cpufreq_cdev->node, &cpufreq_cdev_list);
>  	mutex_unlock(&cooling_list_lock);
>  
>  	if (first)
> @@ -894,17 +894,17 @@ __cpufreq_cooling_register(struct device_node
> *np,
>  	goto put_policy;
>  
>  remove_ida:
> -	ida_simple_remove(&cpufreq_ida, cpufreq_dev->id);
> +	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
>  free_power_table:
> -	kfree(cpufreq_dev->dyn_power_table);
> +	kfree(cpufreq_cdev->dyn_power_table);
>  free_table:
> -	kfree(cpufreq_dev->freq_table);
> +	kfree(cpufreq_cdev->freq_table);
>  free_time_in_idle_timestamp:
> -	kfree(cpufreq_dev->time_in_idle_timestamp);
> +	kfree(cpufreq_cdev->time_in_idle_timestamp);
>  free_time_in_idle:
> -	kfree(cpufreq_dev->time_in_idle);
> +	kfree(cpufreq_cdev->time_in_idle);
>  free_cdev:
> -	kfree(cpufreq_dev);
> +	kfree(cpufreq_cdev);
>  put_policy:
>  	cpufreq_cpu_put(policy);
>  free_cpumask:
> @@ -1029,30 +1029,30 @@
> EXPORT_SYMBOL(of_cpufreq_power_cooling_register);
>   */
>  void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>  {
> -	struct cpufreq_cooling_device *cpufreq_dev;
> +	struct cpufreq_cooling_device *cpufreq_cdev;
>  	bool last;
>  
>  	if (!cdev)
>  		return;
>  
> -	cpufreq_dev = cdev->devdata;
> +	cpufreq_cdev = cdev->devdata;
>  
>  	mutex_lock(&cooling_list_lock);
> -	list_del(&cpufreq_dev->node);
> +	list_del(&cpufreq_cdev->node);
>  	/* Unregister the notifier for the last cpufreq cooling
> device */
> -	last = list_empty(&cpufreq_dev_list);
> +	last = list_empty(&cpufreq_cdev_list);
>  	mutex_unlock(&cooling_list_lock);
>  
>  	if (last)
>  		cpufreq_unregister_notifier(&thermal_cpufreq_notifie
> r_block,
>  					    CPUFREQ_POLICY_NOTIFIER)
> ;
>  
> -	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
> -	ida_simple_remove(&cpufreq_ida, cpufreq_dev->id);
> -	kfree(cpufreq_dev->dyn_power_table);
> -	kfree(cpufreq_dev->time_in_idle_timestamp);
> -	kfree(cpufreq_dev->time_in_idle);
> -	kfree(cpufreq_dev->freq_table);
> -	kfree(cpufreq_dev);
> +	thermal_cooling_device_unregister(cpufreq_cdev->cool_dev);
> +	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
> +	kfree(cpufreq_cdev->dyn_power_table);
> +	kfree(cpufreq_cdev->time_in_idle_timestamp);
> +	kfree(cpufreq_cdev->time_in_idle);
> +	kfree(cpufreq_cdev->freq_table);
> +	kfree(cpufreq_cdev);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
