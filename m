From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: pass policy to ->get() driver callback
Date: Thu, 10 Sep 2015 23:40:16 +0200
Message-ID: <1674761.EFBh0AzUve@vostro.rjw.lan>
References: <98e79b26d8250c33001c7a50378b0e288b8511db.1438339396.git.viresh.kumar@linaro.org> <11470100.cEo24Tpcgr@vostro.rjw.lan> <20150910012222.GN5266@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52069 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750877AbbIJVMX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 17:12:23 -0400
In-Reply-To: <20150910012222.GN5266@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Kristen Carlson Accardi <kristen@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>

On Thursday, September 10, 2015 06:52:22 AM Viresh Kumar wrote:
> On 10-09-15, 03:41, Rafael J. Wysocki wrote:

[cut]

> > Passing a pointer and dereferencing it is generally less efficient than passing
> > a number.  Before the patch the core has to do the dereference before calling
> > ->get, so it likely doesn't matter here, but the code churn from this change
> > is quite substantial and the benefit from it is in the noise IMO.
> 
> Hmm.. Actually almost every other callback (bios_limit() is another
> one), passes the policy to the driver, and I thought always passing
> the policy will make it more symmetrical. And the expectation that the
> cpufreq drivers wouldn't need to use policy from the ->get() callback
> would be wrong. Even if there are only few users today. One is the
> acpi-cpufreq driver and others are the ones, that are using
> cpufreq_generic_get() :)

So the whole question is whether or not this is worth the whole code churn
related to the exchange of callbacks.

At this point I really don't know.  It depends on the design discussion I'd
like to start.

Thanks,
Rafael

