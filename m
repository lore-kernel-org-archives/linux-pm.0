From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 0/2] cpufreq: ondemand: add AMD specific powersave bias
Date: Fri, 5 Apr 2013 10:19:07 +0530
Message-ID: <CAKohpomhBtR2aONp=GsOUeaM1=8f2ZN7EfcGyc1NYZX=ZsweWA@mail.gmail.com>
References: <1365092344-11310-1-git-send-email-jacob.shin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1365092344-11310-1-git-send-email-jacob.shin@amd.com>
Sender: cpufreq-owner@vger.kernel.org
To: Jacob Shin <jacob.shin@amd.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On 4 April 2013 21:49, Jacob Shin <jacob.shin@amd.com> wrote:
> This patchset adds AMD specific powersave bias function to the ondemand
> governor; which can be used to help ondemand governor make more power conscious
> frequency change decisions based on feedback from hardware (availble on AMD
> Family 16h and above).
>
> Hardware feedback tells software how "sensitive" to frequency changes the
> workloads are. CPU-bound workloads will be more sensitive -- they will
> perform better as frequency increases. Memory/IO-bound workloads will be less
> sensitive -- they will not necessarily perform better as frequnecy increases.
>
> This patchset was compared against ondemand governor without powersave bias
> and did not show any performance degradation on CPU-bound workloads such as
> kernbench and unixbench. While saving power on Memory-bound workloads such as
> stream.
>
> V4:
> * Added proper documentation to Documentation/cpu-freq/
> * Revised so that when this driver loads, the feature is enabled by
>   default with a sane tunable value.
>
> V3:
> * Added to CPUID bit to cpufeature.h
> * Added MODULE_DEVICE_TABLE to autoload this driver.
> * Other small changes per feedback from:
>   https://lkml.org/lkml/2013/4/2/349
>
> V2:
> * Added proper include files to amd_freq_sensitivity.c
> * Only register powersave_bias_target function pointer and not the entire
>   od_ops.
>
> Jacob Shin (2):
>   cpufreq: ondemand: allow custom powersave_bias_target handler to be
>     registered
>   cpufreq: AMD "frequency sensitivity feedback" powersave bias for
>     ondemand governor
>
>  Documentation/cpu-freq/governors.txt   |   21 +++++
>  arch/x86/include/asm/cpufeature.h      |    1 +
>  arch/x86/kernel/cpu/scattered.c        |    3 +-
>  drivers/cpufreq/Kconfig.x86            |   17 ++++
>  drivers/cpufreq/Makefile               |    1 +
>  drivers/cpufreq/amd_freq_sensitivity.c |  148 ++++++++++++++++++++++++++++++++
>  drivers/cpufreq/cpufreq_governor.h     |    4 +
>  drivers/cpufreq/cpufreq_ondemand.c     |   56 ++++++++++--
>  8 files changed, 242 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/cpufreq/amd_freq_sensitivity.c

For the latest versions sent by you (including {get|put}_online_cpus()):

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
