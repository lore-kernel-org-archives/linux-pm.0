From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: use last policy after online
Date: Thu, 03 Dec 2015 00:21:37 +0100
Message-ID: <1505105.R4SaFeI2CM@vostro.rjw.lan>
References: <1449017534-6127-1-git-send-email-srinivas.pandruvada@linux.intel.com> <20151202025332.GH4459@ubuntu> <1449075405.3240.28.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45193 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750755AbbLBWvq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 17:51:46 -0500
In-Reply-To: <1449075405.3240.28.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On Wednesday, December 02, 2015 08:56:45 AM Srinivas Pandruvada wrote:
> On Wed, 2015-12-02 at 08:23 +0530, Viresh Kumar wrote:
> > On 01-12-15, 16:52, Srinivas Pandruvada wrote:
> > > For cpufreq drivers which use setpolicy interface, after offline->online
> > > the policy is set to default. This can be reproduced by setting the
> > > default policy of intel_pstate or longrun to ondemand and then change to
> > > "performance". After offline and online, the setpolicy will be called with
> > > the policy=ondemand.
> > > For drivers using governors this condition is handled by storing
> > > last_governor, during offline and restoring during online. The same should
> > > be done for drivers using setpolicy interface. Storing last_policy during
> > > offline and restoring during online.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > ---
> > >  drivers/cpufreq/cpufreq.c | 14 ++++++++++----
> > >  include/linux/cpufreq.h   |  1 +
> > >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > Okay, the problem looks real. But I think it should be solved a bit
> > differently.
> > 
> > Try partly reverting the below commit, so that we can use user_policy
> > instead.
> We have to store somewhere. I can, but my approach matching what using
> governors do to store and restore policy. In this way we have consistent
> processing for has_target() and setpolicy() drivers.

Agreed, consistency matters.

OK, patch queued up for 4.4-rc, thanks!

Rafael

