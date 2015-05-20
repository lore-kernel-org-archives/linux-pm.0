From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpupower: mperf monitor: fix output in MAX_FREQ_SYSFS mode
Date: Wed, 20 May 2015 02:26:47 +0200
Message-ID: <31826905.dNXxBhfo7A@vostro.rjw.lan>
References: <1431354935-7538-1-git-send-email-herton@redhat.com> <20150511154022.GA3390@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150511154022.GA3390@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: "Herton R. Krzesinski" <herton@redhat.com>, Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, May 11, 2015 12:40:22 PM Herton R. Krzesinski wrote:
> On Mon, May 11, 2015 at 11:35:35AM -0300, Herton R. Krzesinski wrote:
> > There is clearly wrong output when mperf monitor runs in MAX_FREQ_SYSFS mode:
> > average frequency shows in kHz unit (despite the intended output to be in MHz),
> > and percentages for C state information are all wrong (including high/negative
> > values shown).
> > 
> > The problem is that the max_frequency read on initialization isn't used where it
> > should have been used on mperf_get_count_percent (to estimate the number of
> > ticks in the given time period), and the value we read from sysfs is in kHz, so
> > we must divide it to get the MHz value to use in current calculations.
> > 
> > While at it, also I fixed another small issues in the debug output of
> > max_frequency value in mperf_get_count_freq.
> > 
> > Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
> > ---
> >  tools/power/cpupower/utils/idle_monitor/mperf_monitor.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Actually please consider v2 patch below, just a minor change in the debug
> output, which isn't a percentage...

Thomas, any comments?

> From: "Herton R. Krzesinski" <herton@redhat.com>
> Date: Mon, 11 May 2015 11:18:14 -0300
> Subject: [PATCH v2] cpupower: mperf monitor: fix output in MAX_FREQ_SYSFS mode
> 
> There is clearly wrong output when mperf monitor runs in MAX_FREQ_SYSFS mode:
> average frequency shows in kHz unit (despite the intended output to be in MHz),
> and percentages for C state information are all wrong (including high/negative
> values shown).
> 
> The problem is that the max_frequency read on initialization isn't used where it
> should have been used on mperf_get_count_percent (to estimate the number of
> ticks in the given time period), and the value we read from sysfs is in kHz, so
> we must divide it to get the MHz value to use in current calculations.
> 
> While at it, also I fixed another small issues in the debug output of
> max_frequency value in mperf_get_count_freq.
> 
> Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
> ---
>  tools/power/cpupower/utils/idle_monitor/mperf_monitor.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> v2: remove percent from debug output fix
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> index 90a8c4f..c83f160 100644
> --- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> @@ -135,7 +135,7 @@ static int mperf_get_count_percent(unsigned int id, double *percent,
>  		dprint("%s: TSC Ref - mperf_diff: %llu, tsc_diff: %llu\n",
>  		       mperf_cstates[id].name, mperf_diff, tsc_diff);
>  	} else if (max_freq_mode == MAX_FREQ_SYSFS) {
> -		timediff = timespec_diff_us(time_start, time_end);
> +		timediff = max_frequency * timespec_diff_us(time_start, time_end);
>  		*percent = 100.0 * mperf_diff / timediff;
>  		dprint("%s: MAXFREQ - mperf_diff: %llu, time_diff: %llu\n",
>  		       mperf_cstates[id].name, mperf_diff, timediff);
> @@ -176,7 +176,7 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
>  	dprint("%s: Average freq based on %s maximum frequency:\n",
>  	       mperf_cstates[id].name,
>  	       (max_freq_mode == MAX_FREQ_TSC_REF) ? "TSC calculated" : "sysfs read");
> -	dprint("%max_frequency: %lu", max_frequency);
> +	dprint("max_frequency: %lu\n", max_frequency);
>  	dprint("aperf_diff: %llu\n", aperf_diff);
>  	dprint("mperf_diff: %llu\n", mperf_diff);
>  	dprint("avg freq:   %llu\n", *count);
> @@ -279,6 +279,7 @@ use_sysfs:
>  		return -1;
>  	}
>  	max_freq_mode = MAX_FREQ_SYSFS;
> +	max_frequency /= 1000; /* Default automatically to MHz value */
>  	return 0;
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
