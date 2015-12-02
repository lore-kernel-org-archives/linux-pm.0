From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: use last policy after online
Date: Thu, 03 Dec 2015 00:08:25 +0100
Message-ID: <1664214.VxVTry24Vn@vostro.rjw.lan>
References: <1449017534-6127-1-git-send-email-srinivas.pandruvada@linux.intel.com> <3188790.ma3TNFyjuZ@vostro.rjw.lan> <1449093927.3240.37.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52810 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755237AbbLBWif (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 17:38:35 -0500
In-Reply-To: <1449093927.3240.37.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Wednesday, December 02, 2015 02:05:27 PM Srinivas Pandruvada wrote:
> On Wed, 2015-12-02 at 03:05 +0100, Rafael J. Wysocki wrote:
> > On Tuesday, December 01, 2015 04:52:14 PM Srinivas Pandruvada wrote:
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
> > 
> > I guess this is urgent, right?
> I don't think. I tried couple of old kernels, same issue.

OK, thanks for checking!

Rafael

