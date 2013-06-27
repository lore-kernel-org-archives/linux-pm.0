From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2 V2] CPUFreq: Add new sysfs attribute freqdomain_cpus
 for acpi-freq driver
Date: Thu, 27 Jun 2013 10:54:12 +0530
Message-ID: <CAKohpokrU4LYGeL_oai+F1irHgk4y+KmO+71_MGVNOhEG6_QDw@mail.gmail.com>
References: <1372250304-20975-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1372250304-20975-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: rjw@sisk.pl, lenb@kernel.org, jean-philippe.halimi@exascale-computing.eu, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 26 June 2013 18:08, Lan Tianyu <tianyu.lan@intel.com> wrote:
> diff --git a/Documentation/cpu-freq/acpi-cpufreq.txt b/Documentation/cpu-freq/acpi-cpufreq.txt
> new file mode 100644
> index 0000000..9c59d09
> --- /dev/null
> +++ b/Documentation/cpu-freq/acpi-cpufreq.txt
> @@ -0,0 +1,7 @@
> +Sysfs interface
> +---------------------------
> +(Interface locates in the directory /sys/devices/system/cpu/cpuN/cpufreq)
> +
> +freqdomain_cpus :               List of Online + Offline CPUs in same CPU dependency
> +                                domain.
> +

Apart from the comments from Rafael, this must be described a bit
more. We must write here how is it different than related_cpus.

Write: freqdomain_cpus are the list of cpus (online+offline) that share
same clock/freq domain at hardware level. This information might
be hidden from cpufreq core and so related_cpus can have different
value compared to this. This is not used by kernel but userspace
DVFS controllers to get better power/performance values for platforms
using acpi-cpufreq.c driver.
