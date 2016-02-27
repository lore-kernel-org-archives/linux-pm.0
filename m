From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 1/2] cpufreq: powernv: Fix bugs in powernv_cpufreq_{init/exit}
Date: Sat, 27 Feb 2016 01:00:23 +0100
Message-ID: <3063057.dJbqXY2tKb@vostro.rjw.lan>
References: <1456483012-29466-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1456483012-29466-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <20160226104500.GH5823@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:46051 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754279AbcBZX6r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 18:58:47 -0500
In-Reply-To: <20160226104500.GH5823@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com

On Friday, February 26, 2016 04:15:00 PM Viresh Kumar wrote:
> On 26-02-16, 16:06, Shilpasri G Bhat wrote:
> > Unregister the notifiers if cpufreq_driver_register() fails in
> > powernv_cpufreq_init(). Re-arrange the unregistration and cleanup routines
> > in powernv_cpufreq_exit() to free all the resources after the driver
> > has unregistered.
> > 
> > Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 40 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for 4.6, thanks!

Rafael

