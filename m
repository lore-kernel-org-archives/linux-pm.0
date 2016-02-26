From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Fri, 26 Feb 2016 07:27:18 +0530
Message-ID: <20160226015718.GA2639@vireshk-i7>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20151007172343.GE4557@linux>
 <4807388.hTIoZIhGRk@vostro.rjw.lan>
 <20151016054226.GQ19018@linux>
 <1456344052.8680.208.camel@linux.intel.com>
 <CAJZ5v0hh20C3vgWfBpRmR+oOjOf7kqP6HMLKjqzYx8h0ka_dVQ@mail.gmail.com>
 <1456357073.3860.21.camel@linux.intel.com>
 <20160225032700.GA2822@vireshk-i7>
 <1456423672.17628.9.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36642 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbcBZB5U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 20:57:20 -0500
Received: by mail-pf0-f176.google.com with SMTP id e127so42919405pfe.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Feb 2016 17:57:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1456423672.17628.9.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 25-02-16, 10:07, Srinivas Pandruvada wrote:
> If I use=A0cpufreq_driver.attr, then it will create sysfs attribute f=
or
> every system using acpi-cpufreq, whether they can support it or not.
> This change is only needed for the later generation of Intel CPUs
> (IvyBridge and later).=A0
> There is no standard ACPI way to know the base frequency if we add
> attribute for all systems using acpi-cpufreq.

Why can't you set cpufreq_driver.attr selectively from probe()?

See below for reference.

commit 21c36d35711d ("cpufreq-dt: make scaling_boost_freqs sysfs attr a=
vailable
when boost is enabled")

--=20
viresh
