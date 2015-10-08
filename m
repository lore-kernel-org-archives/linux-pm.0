From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: PM / OPP: Add debugfs support
Date: Thu, 8 Oct 2015 14:47:00 +0530
Message-ID: <20151008091700.GB18898@linux>
References: <20150922123454.GE27407@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36740 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754965AbbJHJRF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 05:17:05 -0400
Received: by pablk4 with SMTP id lk4so49550883pab.3
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2015 02:17:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150922123454.GE27407@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-pm@vger.kernel.org

Hi Dan,

Sorry for being too late. Was in the middle of a conference earlier,
and that followed with 10 days of leave.

On 22-09-15, 15:34, Dan Carpenter wrote:
> Hello Viresh Kumar,
> 
> The patch 5cb5fdbf3877: "PM / OPP: Add debugfs support" from Sep 4,
> 2015, leads to a bunch of static checker warnings:
> 
> drivers/base/power/opp/debugfs.c:41 opp_debug_create_one() error: format string overflow. buf_size: 15 length: 24
> drivers/base/power/opp/debugfs.c:48 opp_debug_create_one() warn: passing casted pointer '&opp->available' to 'debugfs_create_bool()' 1 vs 32.
> drivers/base/power/opp/debugfs.c:52 opp_debug_create_one() warn: passing casted pointer '&opp->dynamic' to 'debugfs_create_bool()' 1 vs 32.
> drivers/base/power/opp/debugfs.c:55 opp_debug_create_one() warn: passing casted pointer '&opp->turbo' to 'debugfs_create_bool()' 1 vs 32.
> drivers/base/power/opp/debugfs.c:58 opp_debug_create_one() warn: passing casted pointer '&opp->rate' to 'debugfs_create_u32()' 64 vs 32.
> drivers/base/power/opp/debugfs.c:61 opp_debug_create_one() warn: passing casted pointer '&opp->u_volt' to 'debugfs_create_u32()' 64 vs 32.
> drivers/base/power/opp/debugfs.c:65 opp_debug_create_one() warn: passing casted pointer '&opp->u_volt_min' to 'debugfs_create_u32()' 64 vs 32.
> drivers/base/power/opp/debugfs.c:69 opp_debug_create_one() warn: passing casted pointer '&opp->u_volt_max' to 'debugfs_create_u32()' 64 vs 32.
> drivers/base/power/opp/debugfs.c:73 opp_debug_create_one() warn: passing casted pointer '&opp->u_amp' to 'debugfs_create_u32()' 64 vs 32.
> drivers/base/power/opp/debugfs.c:76 opp_debug_create_one() warn: passing casted pointer '&opp->clock_latency_ns' to 'debugfs_create_u32()' 64 vs 32.
> 
> drivers/base/power/opp/debugfs.c
>     34  int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_opp)
>     35  {
>     36          struct dentry *pdentry = dev_opp->dentry;
>     37          struct dentry *d;
>     38          char name[15];
>     39  
>     40          /* Rate is unique to each OPP, use it to give opp-name */
>     41          sprintf(name, "opp:%lu", opp->rate);
> 
> opp->rate is unsigned long so the static checker says this can overflow
> on 64 bit systems.  The static checker tries to do cross function
> analysis, but it's actually wrong.  There is a later bug which cancels
> out this bug.

I did change it to snprintf in my local repository and yes it should
be fixed. About the length, yes I missed the u64 type for 64bit
systems and so that's a bug.

> Anyway, we should make the buffer larger and or change it to use
> snprintf().
> 
>     42  
>     43          /* Create per-opp directory */
>     44          d = debugfs_create_dir(name, pdentry);
>     45          if (!d)
>     46                  return -ENOMEM;
>     47  
>     48          if (!debugfs_create_bool("available", S_IRUGO, d,
>     49                                   (u32 *)&opp->available))
> 
> debugfs_create_bool() writes 32 bits, but we only have 8 bits of space
> so this corrupts memory.

Right, so I fixed this in a different way. I have changed
debugfs_create_bool() API to accept a bool and update memory only for
a bool, instead of 8 or 32 bits. That patch is merged now and so the
cast can be dropped right away.

Over that, the $Subject patch is dropped by Rafael now, due to
conflicts with the debugfs_create_bool() series that got merged.

And so I need to resend it anyway.

>     57  
>     58          if (!debugfs_create_u32("rate_hz", S_IRUGO, d, (u32 *)&opp->rate))
>     59                  return -ENOMEM;
> 
> This only writes to the first 32 bits of the unsigned long.  Which will
> not work on big endian systems.
> 
> I don't know why is there no debugfs_create_ul() function.  It seems
> like it wouldn't be that complicated to create one.

I am fighting hard to get one, but Greg isn't liking the idea very
much :)

-- 
viresh
