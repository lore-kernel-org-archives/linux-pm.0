From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: Add optional
 setting of trace buffer memory allocation
Date: Fri, 25 May 2018 11:04:45 -0700
Message-ID: <1527271485.14836.49.camel@linux.intel.com>
References: <1525441582-23855-1-git-send-email-dsmythies@telus.net>
         <23851272.hyr4RImLsD@aspire.rjw.lan> <9152600.1bIX9UMnel@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9152600.1bIX9UMnel@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <doug.smythies@gmail.com>
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-05-24 at 11:34 +0200, Rafael J. Wysocki wrote:
> On Sunday, May 13, 2018 10:43:02 AM CEST Rafael J. Wysocki wrote:
> > On Friday, May 4, 2018 3:46:22 PM CEST Doug Smythies wrote:
> > > Allow the user to override the default trace buffer memory
> > > allocation
> > > by adding a command line option to override the default.
> > > 
> > > The patch also:
> > > 
> > > Adds a SIGINT (i.e. CTRL C exit) handler,
> > > so that things can be cleaned up before exit.
> > > 
> > > Moves the postion of some other cleanup from after to
> > > before the potential "No valid data to plot" exit.
> > > 
> > > Replaces all quit() calls with sys.exit, because
> > > quit() is not supposed to be used in scripts.
> > > 
> > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > 
> > Srinivas, any comments here?
Somehow I missed this email. But looks fine.

> 
> No concerns, so applied.  Thanks!
> 
