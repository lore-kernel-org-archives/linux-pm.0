From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] drivers/cpufreq: delete non-required instances of include
 <linux/init.h>
Date: Thu, 9 Jan 2014 10:26:20 -0500
Message-ID: <52CEBF9C.10604@windriver.com>
References: <1389280207-11846-1-git-send-email-paul.gortmaker@windriver.com> <CAOh2x=mfQ1qoWBW3=kwML0aLYu60v107svb4knYwTwsSXTzEaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:49808 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbaAIP0V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 10:26:21 -0500
In-Reply-To: <CAOh2x=mfQ1qoWBW3=kwML0aLYu60v107svb4knYwTwsSXTzEaQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 14-01-09 10:17 AM, Viresh Kumar wrote:
> On Thu, Jan 9, 2014 at 8:40 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
>> None of these files are actually using any __init type directives
>> and hence don't need to include <linux/init.h>.  Most are just a
>> left over from __devinit and __cpuinit removal, or simply due to
>> code getting copied from one driver to the next.
> 
> Are you sure? Its not only about devinit or cpuinit but module_init()
> and others as well. And they are pretty much used by most of them.

Yes I am sure.  I start with this:

-------------
#!/bin/bash

if [ "$1" = "" ]; then
        echo must supply path name
        exit 1
fi

for i in `git grep -l linux/init.h $1` ; do
        grep -q '__ref\|__init\|__cpuinit\|__meminit\|__MEMINIT\|__CPUINIT\|__INIT\|__REF\|__HEAD' $i
        if [ $? != 0 ] ; then
                echo $i
                sed -i '/linux\/init.h/d' $i
        fi
done
--------------

which as you can see whitelists any real users, and then I
follow up with build testing to double check.  I will note that
in this particular case, I couldn't find an ARM defconfig that
actually enabled any CONFIG_ARM_S3C24xx options though.

Paul.

