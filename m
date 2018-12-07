From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH] cpuidle: Add 'above' and 'below' idle state metrics
Date: Fri, 7 Dec 2018 12:02:05 +0000
Message-ID: <20181207120203.ohc7icj5wf3gbwi3@queper01-lin>
References: <1688146.Dmze7u1T7F@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1688146.Dmze7u1T7F@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Friday 07 Dec 2018 at 12:57:00 (+0100), Rafael J. Wysocki wrote:
> --- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -145,6 +145,8 @@ What:		/sys/devices/system/cpu/cpuX/cpui
>  		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
>  		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
>  		/sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
> +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/high

That should be s/high/above I suppose.

> +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/below

Other than that this seems really useful :-)

Thanks,
Quentin
