From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] cpufreq: create link to policy only for registered CPUs
Date: Fri, 9 Sep 2016 13:53:55 +0100
Message-ID: <20160909125354.GT1041@n2100.armlinux.org.uk>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <a0469c333e08b3953bfe9e8356c6919c26578349.1473414746.git.viresh.kumar@linaro.org>
 <20160909111620.GQ1041@n2100.armlinux.org.uk>
 <20160909112204.GE18547@vireshk-i7>
 <20160909112841.GS1041@n2100.armlinux.org.uk>
 <20160909113459.GG18547@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160909113459.GG18547@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 09, 2016 at 05:04:59PM +0530, Viresh Kumar wrote:
> On 09-09-16, 12:28, Russell King - ARM Linux wrote:
> > On Fri, Sep 09, 2016 at 04:52:04PM +0530, Viresh Kumar wrote:
> > > Thanks for testing it.. You need another patch from Rafael, which
> > > should be in linux-next by now..
> > > 
> > > commit 3689ad7ed6a8 ("cpufreq: Drop unnecessary check from
> > > cpufreq_policy_alloc()")
> > > 
> > > Both patches combined will fix the problem you were getting.
> > 
> > Please send me this other patch.  Seems absurd to fix a reported problem
> > without copying appropriate patches to the reporter...
> 
> It got merged separately, and yes you should have been cc'd for that
> as well.
> 
> Please find it attached now..

Thanks, the warning is now gone.  From what I can tell, the sysfs
contents looks correct:

/sys/devices/system/cpu
|-- cpu0
|   |-- cpufreq -> ../cpufreq/policy0
|   |-- power
|   |   |-- autosuspend_delay_ms
|   |   |-- control
|   |   |-- runtime_active_time
|   |   |-- runtime_status
|   |   `-- runtime_suspended_time
|   |-- subsystem -> ../../../../bus/cpu
|   |-- topology
|   |   |-- core_id
|   |   |-- core_siblings
|   |   |-- core_siblings_list
|   |   |-- physical_package_id
|   |   |-- thread_siblings
|   |   `-- thread_siblings_list
|   `-- uevent
|-- cpufreq
|   `-- policy0
|       |-- affected_cpus
|       |-- cpuinfo_cur_freq
|       |-- cpuinfo_max_freq
|       |-- cpuinfo_min_freq
|       |-- cpuinfo_transition_latency
|       |-- related_cpus
|       |-- scaling_available_governors
|       |-- scaling_cur_freq
|       |-- scaling_driver
|       |-- scaling_governor
|       |-- scaling_max_freq
|       |-- scaling_min_freq
|       |-- scaling_setspeed
|       `-- stats
|           |-- time_in_state
|           `-- total_trans
|-- isolated
|-- kernel_max
|-- offline
|-- online
|-- possible
|-- power
|   |-- autosuspend_delay_ms
|   |-- control
|   |-- runtime_active_time
|   |-- runtime_status
|   `-- runtime_suspended_time
|-- present
`-- uevent

9 directories, 39 files

So, for both patches:

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
