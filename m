From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: PM / OPP: Add debugfs support
Date: Tue, 22 Sep 2015 15:34:54 +0300
Message-ID: <20150922123454.GE27407@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:22669 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbbIVMfE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 08:35:04 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org

Hello Viresh Kumar,

The patch 5cb5fdbf3877: "PM / OPP: Add debugfs support" from Sep 4,
2015, leads to a bunch of static checker warnings:

drivers/base/power/opp/debugfs.c:41 opp_debug_create_one() error: format string overflow. buf_size: 15 length: 24
drivers/base/power/opp/debugfs.c:48 opp_debug_create_one() warn: passing casted pointer '&opp->available' to 'debugfs_create_bool()' 1 vs 32.
drivers/base/power/opp/debugfs.c:52 opp_debug_create_one() warn: passing casted pointer '&opp->dynamic' to 'debugfs_create_bool()' 1 vs 32.
drivers/base/power/opp/debugfs.c:55 opp_debug_create_one() warn: passing casted pointer '&opp->turbo' to 'debugfs_create_bool()' 1 vs 32.
drivers/base/power/opp/debugfs.c:58 opp_debug_create_one() warn: passing casted pointer '&opp->rate' to 'debugfs_create_u32()' 64 vs 32.
drivers/base/power/opp/debugfs.c:61 opp_debug_create_one() warn: passing casted pointer '&opp->u_volt' to 'debugfs_create_u32()' 64 vs 32.
drivers/base/power/opp/debugfs.c:65 opp_debug_create_one() warn: passing casted pointer '&opp->u_volt_min' to 'debugfs_create_u32()' 64 vs 32.
drivers/base/power/opp/debugfs.c:69 opp_debug_create_one() warn: passing casted pointer '&opp->u_volt_max' to 'debugfs_create_u32()' 64 vs 32.
drivers/base/power/opp/debugfs.c:73 opp_debug_create_one() warn: passing casted pointer '&opp->u_amp' to 'debugfs_create_u32()' 64 vs 32.
drivers/base/power/opp/debugfs.c:76 opp_debug_create_one() warn: passing casted pointer '&opp->clock_latency_ns' to 'debugfs_create_u32()' 64 vs 32.

drivers/base/power/opp/debugfs.c
    34  int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_opp)
    35  {
    36          struct dentry *pdentry = dev_opp->dentry;
    37          struct dentry *d;
    38          char name[15];
    39  
    40          /* Rate is unique to each OPP, use it to give opp-name */
    41          sprintf(name, "opp:%lu", opp->rate);

opp->rate is unsigned long so the static checker says this can overflow
on 64 bit systems.  The static checker tries to do cross function
analysis, but it's actually wrong.  There is a later bug which cancels
out this bug.

Anyway, we should make the buffer larger and or change it to use
snprintf().

    42  
    43          /* Create per-opp directory */
    44          d = debugfs_create_dir(name, pdentry);
    45          if (!d)
    46                  return -ENOMEM;
    47  
    48          if (!debugfs_create_bool("available", S_IRUGO, d,
    49                                   (u32 *)&opp->available))

debugfs_create_bool() writes 32 bits, but we only have 8 bits of space
so this corrupts memory.

    50                  return -ENOMEM;
    51  
    52          if (!debugfs_create_bool("dynamic", S_IRUGO, d, (u32 *)&opp->dynamic))
    53                  return -ENOMEM;

Same.

    54  
    55          if (!debugfs_create_bool("turbo", S_IRUGO, d, (u32 *)&opp->turbo))
    56                  return -ENOMEM;

Same.

    57  
    58          if (!debugfs_create_u32("rate_hz", S_IRUGO, d, (u32 *)&opp->rate))
    59                  return -ENOMEM;

This only writes to the first 32 bits of the unsigned long.  Which will
not work on big endian systems.

I don't know why is there no debugfs_create_ul() function.  It seems
like it wouldn't be that complicated to create one.

It's the same for the rest of this funciton.

regards,
dan carpenter
