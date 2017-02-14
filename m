From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] tools/power/x86: Debug utility for intel_pstate
 driver
Date: Tue, 14 Feb 2017 06:36:22 -0800
Message-ID: <1487082982.21310.0.camel@linux.intel.com>
References: <1487027947-14306-1-git-send-email-dsmythies@telus.net>
         <1487045940.3025.5.camel@linux.intel.com>
         <4440842.OSZWjPAjve@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4440842.OSZWjPAjve@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Doug Smythies <doug.smythies@gmail.com>, len.brown@intel.com, dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-02-14 at 12:15 +0100, Rafael J. Wysocki wrote:
> On Monday, February 13, 2017 08:19:00 PM Srinivas Pandruvada wrote:
> > On Mon, 2017-02-13 at 15:19 -0800, Doug Smythies wrote:
> > > This utility can be used to debug and tune the performance of the
> > > intel_pstate driver.
> > > This utility can be used in two ways:
> > > - If there is Linux trace file with pstate_sample events enabled,
> > > then
> > > this utility can parse the trace file and generate performance
> > > plots.
> > > - If user has not specified a trace file as input via command
> > > line
> > > parameters, then this utility enables and collects trace data for
> > > a
> > > user
> > > specified interval and generates performance plots.
> > > 
> > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > 
> > I am fine with this version. But since Rafael may have already
> > prepared
> > for pull request, so it is up to him.
> 
> I can replace your version with this one if that's OK.
Please do that.

Thanks,
Srinivas
