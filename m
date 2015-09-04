From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: System will not suspend with highest numbered CPU offline
 [REGRESSION][BISECTED]
Date: Fri, 4 Sep 2015 20:12:41 +0530
Message-ID: <20150904144241.GJ29194@linux>
References: <001401d0e691$302127b0$90637710$@net>
 <3237049.urJsZkC6Rf@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36810 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbbIDOmq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 10:42:46 -0400
Received: by pacwi10 with SMTP id wi10so26335479pac.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2015 07:42:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3237049.urJsZkC6Rf@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Doug Smythies <dsmythies@telus.net>, "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Saravana Kannan' <skannan@codeaurora.org>, linux-pm@vger.kernel.org

On 04-09-15, 16:59, Rafael J. Wysocki wrote:
> On Thursday, September 03, 2015 02:40:43 PM Doug Smythies wrote:
> > As of, or about, Kernel 4.2RC1 if I take my highest numbered
> > CPU offline (7 in my case), the system will not suspend.
> 
> Does "will not suspend" mean that the suspend will fail with an error
> or will it crash or hang or something else?
> 
> > The issue persists through Kernel 4.2.
> > This is on my test computer with an i7-2600K.
> > I do not normally use suspend on this computer,
> > but was doing so while working on a bug report.
> > 
> > The kernel was bisected, and the result was:
> > 
> > $ git bisect bad
> > 87549141d516aee71d511138e27117c41e8aef68 is the first bad commit
> > commit 87549141d516aee71d511138e27117c41e8aef68
> > Author: Viresh Kumar <viresh.kumar@linaro.org>
> > Date:   Wed Jun 10 02:13:21 2015 +0200
> > 
> > cpufreq: Stop migrating sysfs files on hotplug
> > 
> > See also several e-mails with the above subject line
> > between June 8th and 10th.
> > 
> > With any other combination of taking CPUs offline,
> > not including CPU 7, suspend seems to work properly.
> 
> Well, we'll need to debug it some.
> 
> Can you please check what's in the
> 
> /sys/devices/system/cpu/cpuX/cpufreq/related_cpus
> 
> files for all CPUs on your system?

I wanted to give him some patch to debug it a bit more, but couldn't
do that whole day.

@Doug: Can you please enable DEBUG for cpufreq with this:

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 9fde14544ead..c09945aa7f17 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -1,3 +1,4 @@
+subdir-ccflags-y  := -DDEBUG
 # CPUfreq core
 obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o


And give us the outputs of both successful and unsuccessful logs?

+ the values of both affected_cpus and related_cpus fields for all
CPUs.

-- 
viresh
