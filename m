From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Fri, 16 Oct 2015 00:45:21 +0200
Message-ID: <4807388.hTIoZIhGRk@vostro.rjw.lan>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com> <20151007172343.GE4557@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63384 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751401AbbJOWQi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 18:16:38 -0400
In-Reply-To: <20151007172343.GE4557@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On Wednesday, October 07, 2015 10:53:43 PM Viresh Kumar wrote:
> On 01-10-15, 15:25, Srinivas Pandruvada wrote:
> > Currently scaling_available_frequencies displays list of available
> > frequencies which can be used to set max/min or current scaling frequency.
> > 
> > >cat scaling_available_frequencies
> > 2301000 2300000 2200000 2000000 1900000 1800000 1700000 1500000 1400000
> > 1300000 1100000 1000000 900000 800000 600000 500000
> > 
> > Here traditionally it is assumed that only 2301000 is a turbo frequency,
> > which is purely opportunistic, anything else user can request and may
> > get it.
> > But because of configurable thermal design power implementation in several
> > Intel CPUs, the opportunistic frequency start can be any frequency in this
> > range. For example it can be 2300000 or any lower value.
> > This change adds an optional new attribute called "base_frequency",
> > which displays the max non-turbo frequency (base frequency). For example:
> > >cat base_frequency
> > 2200000
> > This will allow user to choose a certain frequency which is not
> > opportunistic.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> 
> Look for scaling_boost_frequencies_show() and see if you can reuse it.

Are you sure that would match the use case?

We're talking about a continuous range above the base frequency here.

Thanks,
Rafael

