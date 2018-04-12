From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH][v3] tools/power turbostat: if --max_loop, print for
 specific time of loops
Date: Thu, 12 Apr 2018 15:35:20 +0800
Message-ID: <20180412073520.GB24887@yu-chen.sh.intel.com>
References: <003e01d3d22e$7faa6b80$7eff4280$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <003e01d3d22e$7faa6b80$7eff4280$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Len Brown' <lenb@kernel.org>, 'Rafael J Wysocki' <rjw@rjwysocki.net>, 'Artem Bityutskiy' <artem.bityutskiy@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Doug,
On Thu, Apr 12, 2018 at 12:18:44AM -0700, Doug Smythies wrote:
> On 2018.04.11 03:31 Yu Chen wrote: 
> 
> > From: Chen Yu <yu.c.chen@intel.com>
> >
> > There's a use case during test to only print specific round of loops
> > if --iterations is specified, for example, with this patch applied:
> >
> > turbostat -i 5 -t 4
> > will capture 4 samples with 5 seconds interval.
> 
> Hi Yu,
> 
> This would be a very useful addition to turbostat.
> Please also update the man turbostat man page.
> 
> tools/power/x86/turbostat/turbostat.8
> 
OK, I will do this.
Thanks,
Yu
> ... Doug
> 
> 
