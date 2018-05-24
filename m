From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: Add optional setting of trace buffer memory allocation
Date: Thu, 24 May 2018 11:34:38 +0200
Message-ID: <9152600.1bIX9UMnel@aspire.rjw.lan>
References: <1525441582-23855-1-git-send-email-dsmythies@telus.net> <23851272.hyr4RImLsD@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23851272.hyr4RImLsD@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>
Cc: srinivas.pandruvada@linux.intel.com, dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, May 13, 2018 10:43:02 AM CEST Rafael J. Wysocki wrote:
> On Friday, May 4, 2018 3:46:22 PM CEST Doug Smythies wrote:
> > Allow the user to override the default trace buffer memory allocation
> > by adding a command line option to override the default.
> > 
> > The patch also:
> > 
> > Adds a SIGINT (i.e. CTRL C exit) handler,
> > so that things can be cleaned up before exit.
> > 
> > Moves the postion of some other cleanup from after to
> > before the potential "No valid data to plot" exit.
> > 
> > Replaces all quit() calls with sys.exit, because
> > quit() is not supposed to be used in scripts.
> > 
> > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> 
> Srinivas, any comments here?

No concerns, so applied.  Thanks!
