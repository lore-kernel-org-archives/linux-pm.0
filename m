From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v1 5/7] thermal: add trace events to the power allocator
 governor
Date: Mon, 2 Feb 2015 15:44:50 +0000
Message-ID: <20150202154450.GA8092@e104805>
References: <1422464438-16761-1-git-send-email-javi.merino@arm.com>
 <1422464438-16761-6-git-send-email-javi.merino@arm.com>
 <20150128123106.05e28afc@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150128123106.05e28afc@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 28, 2015 at 05:31:06PM +0000, Steven Rostedt wrote:
> On Wed, 28 Jan 2015 17:00:36 +0000
> Javi Merino <javi.merino@arm.com> wrote:
> 
> > +	if (trace_thermal_power_cpu_limit_enabled() && load_cpu) {
> > +		trace_thermal_power_cpu_get_power(
> > +			&cpufreq_device->allowed_cpus,
> > +			freq, load_cpu, i, dynamic_power, static_power);
> > +
> > +		devm_kfree(&cdev->device, load_cpu);
> 
> You may want to move the devm_kfree() out of the
> trace_thermal_power_cpu_limit_enabled() check. There could be a race
> where that gets disabled while this function is running and you just
> leaked memory.
> 
> 	if (load_cpu)
> 		devm_kfree(&cdev->device, load_cpu);
> 
> should be done by itself.

Good catch!  I've changed it to 

	if (load_cpu) {
		trace_thermal_power_cpu_get_power(
			&cpufreq_device->allowed_cpus,
			freq, load_cpu, i, dynamic_power, static_power);

		devm_kfree(&cdev->device, load_cpu);
	}

This way, if the trace is disabled while in the function,
trace_thermal_power_cpu_get_power() doesn't get executed but you free
load_cpu.  If the opposite happens (the trace gets enabled while in
the function), load_cpu is NULL and you don't pass the NULL pointer to
trace_thermal_power_cpu_get_power().

Cheers,
Javi
