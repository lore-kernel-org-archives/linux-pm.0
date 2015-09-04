From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: System will not suspend with highest numbered CPU offline [REGRESSION][BISECTED]
Date: Fri, 04 Sep 2015 16:59:50 +0200
Message-ID: <3237049.urJsZkC6Rf@vostro.rjw.lan>
References: <001401d0e691$302127b0$90637710$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55154 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750766AbbIDOcF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 10:32:05 -0400
In-Reply-To: <001401d0e691$302127b0$90637710$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

On Thursday, September 03, 2015 02:40:43 PM Doug Smythies wrote:
> As of, or about, Kernel 4.2RC1 if I take my highest numbered
> CPU offline (7 in my case), the system will not suspend.

Does "will not suspend" mean that the suspend will fail with an error
or will it crash or hang or something else?

> The issue persists through Kernel 4.2.
> This is on my test computer with an i7-2600K.
> I do not normally use suspend on this computer,
> but was doing so while working on a bug report.
> 
> The kernel was bisected, and the result was:
> 
> $ git bisect bad
> 87549141d516aee71d511138e27117c41e8aef68 is the first bad commit
> commit 87549141d516aee71d511138e27117c41e8aef68
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Wed Jun 10 02:13:21 2015 +0200
> 
> cpufreq: Stop migrating sysfs files on hotplug
> 
> See also several e-mails with the above subject line
> between June 8th and 10th.
> 
> With any other combination of taking CPUs offline,
> not including CPU 7, suspend seems to work properly.

Well, we'll need to debug it some.

Can you please check what's in the

/sys/devices/system/cpu/cpuX/cpufreq/related_cpus

files for all CPUs on your system?

Thanks,
Rafael

