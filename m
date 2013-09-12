From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: "cpufreq: fix serialization issues with freq change notifiers" breaks cpufreq too
Date: Thu, 12 Sep 2013 13:01:35 +0200
Message-ID: <3488595.xbBYlylYai@vostro.rjw.lan>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange> <52310E43.1090808@intel.com> <CAKohpomuJNQmk5fg5en5usPgipj7hzXUVNMhz1MjAS-47X4Ggg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61668 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753891Ab3ILKud (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2013 06:50:33 -0400
In-Reply-To: <CAKohpomuJNQmk5fg5en5usPgipj7hzXUVNMhz1MjAS-47X4Ggg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Greg KH <greg@kroah.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Thursday, September 12, 2013 11:06:14 AM Viresh Kumar wrote:
> On 12 September 2013 06:13, Rafael J. Wysocki
> <rafael.j.wysocki@intel.com> wrote:
> > Yes, if you can point to a specific driver having this problem.
> 
> There are so many of those (I know it because I went through almost all drivers
> recently with my cleanup series): cpufreq-cpu0, omap-cpufreq,
> exynos-cpufreq, etc..
> 
> They all do this:
> 
> A. If new freq is more than old: Increase voltage
> B. Change freq
> C. If new freq is less than old: decrease voltage

Well, if there's more than one it's even simpler.  You can just pick one. :-)

Like, "for example, <driver name> does the following ... which may cause the
hardware to misbehave, because ...".

Thanks,
Rafael

