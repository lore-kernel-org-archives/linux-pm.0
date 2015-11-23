From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: Always remove sysfs cpuX/cpufreq link on ->remove_dev()
Date: Mon, 23 Nov 2015 23:47:24 +0100
Message-ID: <2639074.3VUozvte35@vostro.rjw.lan>
References: <1448074212.3450.4.camel@linux.intel.com> <c194a71ce0a2fac9b8a2ee8d12a00ec1642f9784.1448076972.git.viresh.kumar@linaro.org> <1448116929.3069.1.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41450 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753571AbbKWWRq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2015 17:17:46 -0500
In-Reply-To: <1448116929.3069.1.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Saturday, November 21, 2015 06:42:09 AM Srinivas Pandruvada wrote:
> On Sat, 2015-11-21 at 09:06 +0530, Viresh Kumar wrote:
> > Subsys interface's ->remove_dev() is called when the cpufreq driver
> > is
> > unregistering or the CPU is getting physically removed. We keep
> > removing
> > the cpuX/cpufreq link for all CPUs except the last one, which is a
> > mistake as all CPUs contain a link now.
> > 
> > Because of this, one CPU from each policy will still contain a link
> > (to
> > an already removed policyX directory), after the cpufreq driver is
> > unregistered.
> > 
> > Fix that by removing the link first and then only see if the policy
> > is
> > required to be freed. That will make sure that no links are left out.
> > 
> > Fixes: 96bdda61f58b ("cpufreq: create cpu/cpufreq/policyX
> > directories")
> > Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com
> 
> Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com

Applied, thanks!

Rafael

