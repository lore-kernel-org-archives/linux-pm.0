From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] Documentation: cpufreq: Additional interface for
 acpi-cpufreq
Date: Tue, 1 Mar 2016 08:09:42 +0530
Message-ID: <20160301023942.GC16437@vireshk-i7>
References: <1456791009-950-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1456791009-950-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35700 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbcCACjp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 21:39:45 -0500
Received: by mail-pf0-f181.google.com with SMTP id w128so58456166pfb.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 18:39:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456791009-950-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

On 29-02-16, 16:10, Srinivas Pandruvada wrote:
> Added new file for acpi-cpufreq driver, with explanation for
> base_frequency.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/cpu-freq/acpi-cpufreq-addition.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/cpu-freq/acpi-cpufreq-addition.txt
> 
> diff --git a/Documentation/cpu-freq/acpi-cpufreq-addition.txt b/Documentation/cpu-freq/acpi-cpufreq-addition.txt

s/-addition//

> new file mode 100644
> index 0000000..40efb22
> --- /dev/null
> +++ b/Documentation/cpu-freq/acpi-cpufreq-addition.txt
> @@ -0,0 +1,20 @@
> +Additional sysfs attribute for acpi-cpufreq

You should be adding a description of freqdomain_cpus in this file, which was
never documented (yes, in a separate patch).

> +In addition to the standard sysfs interface as defined in the
> +user-guide.txt under section "Preferred Interface: sysfs",
> +acpi-cpufreq can have following additional sysfs attribute:

Maybe rewrite as:

acpi-cpufreq have following sysfs attributes in addition to standard cpufreq
attributes:

> +
> +base_frequency: 	Max non-turbo frequency
> +For example:

Please keep the formatting similar to user-guide.txt

> +scaling_available_frequencies displays list of available frequencies 

> which can be used to set max/min or current scaling frequency.

Just drop above line.

> +>cat scaling_available_frequencies
> +2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
> +1300000 1100000 1000000 900000 800000 600000 500000

A blank line here.. This is documentation and should be really readable.

> +If the base_frequency attribute is present,

*is present* isn't sufficient, right? It should be readable as well?

> then any frequency above is

s/above/above base_frequency/

> +purely opportunistic or turbo frequency. For example

s/purely opportunistic or / a/

> +>cat base_frequency
> +2200000

Blank line here as well:

> +Then in the above displayed list of scaling_available_frequencies, any
> +frequency 2300000 or 2301000 is opportunistic or turbo frequency.

Maybe just:

i.e. 2300000 and 2301000 are turbo frequencies now..

> +
> -- 
> 2.5.0

-- 
viresh
