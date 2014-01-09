From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] drivers/cpufreq: delete non-required instances of include <linux/init.h>
Date: Thu, 9 Jan 2014 21:09:00 +0530
Message-ID: <CAOh2x=nh5xB49toyWZOf_voEAeBjjNX5CfgyLpL+V5W+Jeo4bw@mail.gmail.com>
References: <1389280207-11846-1-git-send-email-paul.gortmaker@windriver.com>
	<CAOh2x=mfQ1qoWBW3=kwML0aLYu60v107svb4knYwTwsSXTzEaQ@mail.gmail.com>
	<52CEBF9C.10604@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:58726 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbaAIPjB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 10:39:01 -0500
In-Reply-To: <52CEBF9C.10604@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Jan 9, 2014 at 8:56 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> Yes I am sure.  I start with this:
>
> -------------
> #!/bin/bash
>
> if [ "$1" = "" ]; then
>         echo must supply path name
>         exit 1
> fi
>
> for i in `git grep -l linux/init.h $1` ; do
>         grep -q '__ref\|__init\|__cpuinit\|__meminit\|__MEMINIT\|__CPUINIT\|__INIT\|__REF\|__HEAD' $i

You missed all initcalls here.

>         if [ $? != 0 ] ; then
>                 echo $i
>                 sed -i '/linux\/init.h/d' $i
>         fi
> done
> --------------
>
> which as you can see whitelists any real users, and then I
> follow up with build testing to double check.

That might have passed because init.h is still included indirectly.

These are the usages which I can see easily, there might be
others too..

 drivers/cpufreq/powernow-k8.c: late_initcall and module_exit
 drivers/cpufreq/s3c2412-cpufreq.c: arch_initcall
 drivers/cpufreq/s3c2440-cpufreq.c: subsys_initcall
 drivers/cpufreq/spear-cpufreq.c: late_initcall

> I will note that
> in this particular case, I couldn't find an ARM defconfig that
> actually enabled any CONFIG_ARM_S3C24xx options though.

Haven't looked into this for now :(
