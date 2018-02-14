From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5] Documentation/ABI: update cpuidle sysfs documentation
Date: Wed, 14 Feb 2018 11:51:00 +0100
Message-ID: <6470168.Bc58CWhkOs@aspire.rjw.lan>
References: <20180207133436.GA7440@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180207133436.GA7440@mordor.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org

On Wednesday, February 7, 2018 2:34:36 PM CET Aishwarya Pant wrote:
> Update cpuidle documentation using git logs and existing documentation
> in Documentation/cpuidle/sysfs.txt. This might be useful for scripting
> and tracking changes in the ABI.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
> Changes in v5:
> - Update contact information- LKML -> power management mailing list
> v4:
> - Fix patch formatting
> v3:
> - Fix subject line
> v2:
> - Merge cpuidle_sysfs_switch attributes' description with the previous
>   entry.
> 
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 77 +++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index bfd29bc8d37a..4ed63b6cfb15 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -108,6 +108,8 @@ Description:	CPU topology files that describe a logical CPU's relationship
>  
>  What:		/sys/devices/system/cpu/cpuidle/current_driver
>  		/sys/devices/system/cpu/cpuidle/current_governer_ro
> +		/sys/devices/system/cpu/cpuidle/available_governors
> +		/sys/devices/system/cpu/cpuidle/current_governor
>  Date:		September 2007
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:	Discover cpuidle policy and mechanism
> @@ -119,13 +121,84 @@ Description:	Discover cpuidle policy and mechanism
>  		Idle policy (governor) is differentiated from idle mechanism
>  		(driver)
>  
> -		current_driver: displays current idle mechanism
> +		current_driver: (RO) displays current idle mechanism
>  
> -		current_governor_ro: displays current idle policy
> +		current_governor_ro: (RO) displays current idle policy
> +
> +		With the cpuidle_sysfs_switch boot option enabled (meant for
> +		developer testing), the following three attributes are visible
> +		instead:
> +
> +		current_driver: same as described above
> +
> +		available_governors: (RO) displays a space separated list of
> +		available governors
> +
> +		current_governor: (RW) displays current idle policy. Users can
> +		switch the governor at runtime by writing to this file.
>  
>  		See files in Documentation/cpuidle/ for more information.
>  
>  
> +What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/name
> +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/latency
> +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
> +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
> +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
> +Date:		September 2007
> +KernelVersion:	v2.6.24
> +Contact:	Linux power management list <linux-pm@vger.kernel.org>
> +Description:
> +		The directory /sys/devices/system/cpu/cpuX/cpuidle contains per
> +		logical CPU specific cpuidle information for each online cpu X.
> +		The processor idle states which are available for use have the
> +		following attributes:
> +
> +		name: (RO) Name of the idle state (string).
> +
> +		latency: (RO) The latency to exit out of this idle state (in
> +		microseconds).
> +
> +		power: (RO) The power consumed while in this idle state (in
> +		milliwatts).
> +
> +		time: (RO) The total time spent in this idle state (in microseconds).
> +
> +		usage: (RO) Number of times this state was entered (a count).
> +
> +
> +What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/desc
> +Date:		February 2008
> +KernelVersion:	v2.6.25
> +Contact:	Linux power management list <linux-pm@vger.kernel.org>
> +Description:
> +		(RO) A small description about the idle state (string).
> +
> +
> +What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/disable
> +Date:		March 2012
> +KernelVersion:	v3.10
> +Contact:	Linux power management list <linux-pm@vger.kernel.org>
> +Description:
> +		(RW) Option to disable this idle state (bool). The behavior and
> +		the effect of the disable variable depends on the implementation
> +		of a particular governor. In the ladder governor, for example,
> +		it is not coherent, i.e. if one is disabling a light state, then
> +		all deeper states are disabled as well, but the disable variable
> +		does not reflect it. Likewise, if one enables a deep state but a
> +		lighter state still is disabled, then this has no effect.
> +
> +
> +What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/residency
> +Date:		March 2014
> +KernelVersion:	v3.15
> +Contact:	Linux power management list <linux-pm@vger.kernel.org>
> +Description:
> +		(RO) Display the target residency i.e. the minimum amount of
> +		time (in microseconds) this cpu should spend in this idle state
> +		to make the transition worth the effort.
> +
> +
>  What:		/sys/devices/system/cpu/cpu#/cpufreq/*
>  Date:		pre-git history
>  Contact:	linux-pm@vger.kernel.org
> 

Applied, thanks!
