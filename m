From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 5/7] thermal: add trace events to the power allocator
 governor
Date: Wed, 28 Jan 2015 12:31:06 -0500
Message-ID: <20150128123106.05e28afc@gandalf.local.home>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
	<1422464438-16761-6-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422464438-16761-6-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, broonie@kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 28 Jan 2015 17:00:36 +0000
Javi Merino <javi.merino@arm.com> wrote:

> +	if (trace_thermal_power_cpu_limit_enabled() && load_cpu) {
> +		trace_thermal_power_cpu_get_power(
> +			&cpufreq_device->allowed_cpus,
> +			freq, load_cpu, i, dynamic_power, static_power);
> +
> +		devm_kfree(&cdev->device, load_cpu);

You may want to move the devm_kfree() out of the
trace_thermal_power_cpu_limit_enabled() check. There could be a race
where that gets disabled while this function is running and you just
leaked memory.

	if (load_cpu)
		devm_kfree(&cdev->device, load_cpu);

should be done by itself.

-- Steve

> +	}
>  
>  	*power = static_power + dynamic_power;
>  	return 0;
> @@ -664,6 +689,8 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
>  		return -EINVAL;
>  	}
>  
> +	trace_thermal_power_cpu_limit(&cpufreq_device->allowed_cpus,
> +				      target_freq, *state, power);
>  	return 0;
>  }
>  
