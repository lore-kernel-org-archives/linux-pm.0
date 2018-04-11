From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH][v3] tools/power turbostat: if --max_loop, print for
 specific time of loops
Date: Wed, 11 Apr 2018 20:51:58 +0800
Message-ID: <20180411125158.GA15388@yu-chen.sh.intel.com>
References: <20180411103038.12735-1-yu.c.chen@intel.com>
 <1523444522.2753.218.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523444522.2753.218.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Rafael J Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,
On Wed, Apr 11, 2018 at 02:02:02PM +0300, Artem Bityutskiy wrote:
> A couple of nitpicks.
> 
> On Wed, 2018-04-11 at 18:30 +0800, Yu Chen wrote:
> > @@ -48,6 +48,7 @@ char *proc_stat = "/proc/stat";
> >  FILE *outf;
> >  int *fd_percpu;
> >  struct timespec interval_ts = {5, 0};
> > +int iterations;
> 
> OK, out of several choices, you selected "iterations".
> 
> >  unsigned int debug;
> >  unsigned int quiet;
> >  unsigned int sums_need_wide_columns;
> > @@ -470,6 +471,7 @@ void help(void)
> >  	"		{core | package | j,k,l..m,n-p }\n"
> >  	"--quiet	skip decoding system configuration header\n"
> >  	"--interval sec	Override default 5-second measurement interval\n"
> > +	"--iterations loops	The number of loops if interval is specified\n"
> 
> Since "iterations" is the term, be consistent and do not mix it with
> "loops". Who knows may be the "loops" term will be used for something
> else in the future. Use something like this:
> 
> "--iterations count    Number of measurement iterations (requires '
> --interval')"
>
OK, this looks more consistent.
> >  	print this help mkk
> >  	"--list		list column headers only\n"
> >  	"--out file	create or truncate \"file\" for all output\n"
> > @@ -2565,6 +2567,7 @@ void turbostat_loop()
> >  {
> >  	int retval;
> >  	int restarted = 0;
> > +	int loops = 0;
> 
> Please, name variables in a consistent manner, this should really be
> something like 'int iters = 0'. Or may be 'done_iters', or something.
> But not "loops".
> 
OK.
> > @@ -4999,6 +5010,7 @@ void cmdline(int argc, char **argv)
> >  		{"Dump",	no_argument,		0, 'D'},
> >  		{"debug",	no_argument,		0, 'd'},	/* internal, not documented */
> >  		{"interval",	required_argument,	0, 'i'},
> > +		{"iterations",	required_argument,	0, 't'},
> 
> If you used term "count", you could have consistent long and short
> option names, like '--count / -c'. I find '--iterations / -t' to be
> inconsistent, and harder to remember the short option, because I think
> about time, not "iterations" when I see -t.
However the '-c' is already used as a short form for '--cpu',
so I chose --iterations previously.

Thanks,
Yu
