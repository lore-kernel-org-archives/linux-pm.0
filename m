From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] Documentation: cpufreq: intel_pstate: enhance documentation
Date: Tue, 22 Dec 2015 09:26:12 -0800
Message-ID: <000001d13cdd$dc0fff90$942ffeb0$@net>
References: <1450721117-7620-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta2.telus.net ([209.171.16.75]:34910 "EHLO cmta2.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932948AbbLVR0S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Dec 2015 12:26:18 -0500
In-Reply-To: <1450721117-7620-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org, trenn@suse.de, prarit@redhat.com, rafael@kernel.org, Doug Smythies <dsmythies@telus.net>

Hi Srinivas,
Just two typos.

On 2015.12.21 10:05 Srinivas Pandruvada wrote:

> +scaling_governor: This displays current active policy. Since each CPU has a
> +cpufreq sysfs, it is possible to set a scaling governor to each CPU. But this
> +is not possible with Intel P-States, as there is one common policy for all
> +CPUs. Here, the last requested policy will be applicable to all CPUs. It is

> >suggested that use the cpupower utility to change policy to all CPUs at the

+suggested that one use the cpupower utility to change policy to all CPUs at the

> +same time.
> +
> +scaling_setspeed: This attribute can never be used with Intel P-State.

> +      setpoint = 80
> +
> +If the current P-State = 0x08 and current load = 100, this will result in the
> +next P-State = 0x08 - ((80 - 100) * 0.2) = 12
> +For the same load at setpoint = 60 this will result in the next P-State
> += 0x08 - ((60 - 100) * 0.2) = 16
> +So by changing the setpoint from 80 to 60, there is an increase of the

> >next P-State from 12 to 16. So this will make processor to execute at

+ next P-State from 12 to 16. So this will make the processor execute at

> +higher P-State for the same CPU load.


