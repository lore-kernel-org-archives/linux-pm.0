From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH 06/16] tools/power turbostat: allow sub-sec intervals
Date: Sat, 27 Feb 2016 19:43:06 -0800
Message-ID: <001201d171da$22f11850$68d348f0$@net>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org> <24781860a144a6792cb7697307f36b4486b611da.1456563103.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta14.telus.net ([209.171.16.87]:42231 "EHLO cmta14.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932421AbcB1DnK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 27 Feb 2016 22:43:10 -0500
In-Reply-To: <24781860a144a6792cb7697307f36b4486b611da.1456563103.git.len.brown@intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Len Brown' <lenb@kernel.org>
Cc: 'Len Brown' <len.brown@intel.com>, linux-pm@vger.kernel.org

Hi Len,

On 2016.02.27 01:01 Len Brown wrote:

> From: Len Brown <len.brown@intel.com>
>
> turbostat -i interval_sec
>
> will sample and display statistics every interval_sec.
> interval_sec used to be a whole number of seconds,
> but now we accept a decimal, as small as 0.001 sec (1 ms).

Shouldn't you be cautious allowing this?
At such a high sampling rate, the user can significantly
effect the system being measured with turbostat's own overhead.

I tried down to 1 millisecond, and noted greatly
reduced C6 time (my processor only goes to C6), greatly increased
busy% for all CPU's, over 4 watts extra package power, ...

>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> tools/power/x86/turbostat/turbostat.8 |  2 +-
> tools/power/x86/turbostat/turbostat.c | 20 ++++++++++++++++----
> 2 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
> index 622db68..8a9727b 100644
> --- a/tools/power/x86/turbostat/turbostat.8
> +++ b/tools/power/x86/turbostat/turbostat.8
> @@ -34,7 +34,7 @@ name as necessary to disambiguate it from others is necessary.  Note that option
>  \fB--debug\fP displays additional system configuration information.  Invoking this parameter
>  more than once may also enable internal turbostat debug information.
>  .PP
> -\fB--interval seconds\fP overrides the default 5-second measurement interval.
> +\fB--interval decimal_seconds\fP overrides the default 5.0 second measurement interval.
>  .PP
>  \fB--help\fP displays usage for the most common parameters.
>  .PP

Don't you also need to update these lines?:

- .RB [ "\--interval seconds" ]
+ .RB [ "\--interval decimal_seconds" ]

- The 5-second interval can be changed with th "-i sec" option.
+ The 5-second interval can be changed with the "--interval decimal_seconds" option.

> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index c600340..e411cc4 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -38,12 +38,13 @@
>  #include <string.h>
>  #include <ctype.h>
>  #include <sched.h>
> +#include <time.h>
>  #include <cpuid.h>
>  #include <linux/capability.h>
>  #include <errno.h>
> 
>  char *proc_stat = "/proc/stat";
> -unsigned int interval_sec = 5;
> +struct timespec interval_ts = {5, 0};
>  unsigned int debug;
>  unsigned int rapl_joules;
>  unsigned int summary_only;
> @@ -1728,7 +1729,7 @@ restart:
>  			re_initialize();
>  			goto restart;
>  		}
> -		sleep(interval_sec);
> +		nanosleep(&interval_ts, NULL);
>  		retval = for_all_cpus(get_counters, ODD_COUNTERS);
>  		if (retval < -1) {
>  			exit(retval);
> @@ -1742,7 +1743,7 @@ restart:
>  		compute_average(EVEN_COUNTERS);
>  		format_all_counters(EVEN_COUNTERS);
>  		flush_stdout();
> -		sleep(interval_sec);
> +		nanosleep(&interval_ts, NULL);

In the limit of a very high sampling rate, doesn't the assumption
that the time spent in turbostat itself is negligible become
invalid?
And shouldn't the sleep time be compensated accordingly?

Perhaps something like (sorry for format, and not tested):

void __usleep(int us) {
   struct timespec time;

   time.tv_sec = us / 1000;
   time.tv_nsec = (us - time.tv_sec * 1000) * 1000;
   while(nanosleep(&time, &time) == -1 && errno == EINTR)
      continue;
}

unsigned long long stamp(void){
   struct timeval tv;

   gettimeofday(&tv, NULL);

   return (unsigned long long)tv.tv_sec * 1000000 + tv.tv_usec;
} /* endprocedure */

   now = stamp();
   if ((long long)(now - begin) < total ) {
      current_sleep = total - (now - begin);
      __usleep(current_sleep);
   } /* endif */
   begin += total;

Where total is the sample interval, in uSec, and begin was initialized
somewhere outside this loop.

Even if the time spent in turbostat is still almost negligible,
this will prevent sampling time error accumulation, by sleeping just
a little less every so often. However, there is also some extra
overhead, which is also undesirable.

>  		retval = for_all_cpus(get_counters, EVEN_COUNTERS);
>  		if (retval < -1) {
>  			exit(retval);
> @@ -3347,7 +3348,18 @@ void cmdline(int argc, char **argv)
>  			help();
>  			exit(1);
>  		case 'i':
> -			interval_sec = atoi(optarg);
> +			{
> +				double interval = strtod(optarg, NULL);
> +
> +				if (interval < 0.001) {
> +					fprintf(stderr, "interval %f seconds is too small\n",
> +						interval);
> +					exit(2);
> +				}
> +
> +				interval_ts.tv_sec = interval;
> +				interval_ts.tv_nsec = (interval - interval_ts.tv_sec) * 1000000000;
> +			}
>  			break;
>  		case 'J':
>  			rapl_joules++;
> -- 
> 2.7.1.339.g0233b80

... Doug


