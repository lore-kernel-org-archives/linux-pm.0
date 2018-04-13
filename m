From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH][v4] tools/power turbostat: if --iterations, print for
 specific time of iterations
Date: Fri, 13 Apr 2018 09:48:56 +0300
Message-ID: <1523602136.2753.240.camel@gmail.com>
References: <20180413034047.1240-1-yu.c.chen@intel.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180413034047.1240-1-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Chen <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>
Cc: Rafael J Wysocki <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2018-04-13 at 11:40 +0800, Yu Chen wrote:
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index bd9c6b31a504..a2fe96f038f0 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -48,6 +48,7 @@ char *proc_stat = "/proc/stat";
>  FILE *outf;
>  int *fd_percpu;
>  struct timespec interval_ts = {5, 0};
> +int iterations;
>  unsigned int debug;
>  unsigned int quiet;
>  unsigned int sums_need_wide_columns;
> @@ -470,6 +471,7 @@ void help(void)
>  	"		{core | package | j,k,l..m,n-p }\n"
>  	"--quiet	skip decoding system configuration header\n"
>  	"--interval sec	Override default 5-second measurement interval\n"
> +	"--iterations count	Number of measurement iterations(requires '--interval'\n"

Missing white-space and ")".

-- 
Best Regards,
Artem Bityutskiy
