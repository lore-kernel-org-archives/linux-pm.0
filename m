From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/3] cpufreq: ondemand: Change the calculation of
 target frequency
Date: Thu, 6 Jun 2013 12:24:09 +0530
Message-ID: <CAKohpokYqXD9owu2-dDgo_+8bq702RqEEeVraPNSyeaNxcha_Q@mail.gmail.com>
References: <51AF60C1.9050409@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51AF60C1.9050409@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 5 June 2013 21:31, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> Changes since v2:
>         - Reorder patches 2/3 and 3/3
>         - Fix typos in patch changelog
>
> Changes since v1:
>         - Use policy->cpuinfo.max_freq in the calculation formula
>                 of target frequency instead of policy->max
>         - Split the patch into 3 parts
>
> Stratos Karafotis (3):
>   cpufreq: ondemand: Change the calculation of target frequency
>   cpufreq: Remove unused APERF/MPERF support
>   cpufreq: Remove unused function __cpufreq_driver_getavg
>
>  arch/x86/include/asm/processor.h   | 29 ----------------------
>  drivers/cpufreq/Makefile           |  2 +-
>  drivers/cpufreq/acpi-cpufreq.c     |  5 ----
>  drivers/cpufreq/cpufreq.c          | 12 ---------
>  drivers/cpufreq/cpufreq_governor.c | 10 +-------
>  drivers/cpufreq/cpufreq_governor.h |  1 -
>  drivers/cpufreq/cpufreq_ondemand.c | 39 ++++++-----------------------
>  drivers/cpufreq/mperf.c            | 51 --------------------------------------
>  drivers/cpufreq/mperf.h            |  9 -------
>  include/linux/cpufreq.h            |  6 -----
>  10 files changed, 9 insertions(+), 155 deletions(-)
>  delete mode 100644 drivers/cpufreq/mperf.c
>  delete mode 100644 drivers/cpufreq/mperf.h

Functionally your patchset looks fine to me.. I know there are few
concerns about the real impact on power/performance, and I am
not talking about them here (Though they are very important :) ).

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
