From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix CPU device to be removed from OPP table in
 wrong order
Date: Fri, 25 Nov 2016 12:27:39 +0530
Message-ID: <20161125065739.GC29969@vireshk-i7>
References: <1479973761-21225-1-git-send-email-jy0922.shim@samsung.com>
 <CGME20161124084531epcas2p1f662ed5a74f2c6f3da5911f1fe38a200@epcas2p1.samsung.com>
 <20161124083403.GA29969@vireshk-i7>
 <583799EC.4060101@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35861 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbcKYG61 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Nov 2016 01:58:27 -0500
Received: by mail-pg0-f52.google.com with SMTP id f188so26526568pgc.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Nov 2016 22:57:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <583799EC.4060101@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org

On 25-11-16, 10:54, Joonyoung Shim wrote:
> I found this problem during system suspend/resume of Odroid-XU3 board.
> 
> # rtcwake -m mem -s 3
> wakeup from "mem" at Wed Apr  4 05:54:44 2001
> [   15.965996] PM: Syncing filesystems ... done.
> [   15.976333] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [   15.983287] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [   16.006951] wake enabled for irq 135
> [   16.008782] smsc95xx 1-1.1:1.0 eth0: entering SUSPEND2 mode
> [   16.094110] PM: suspend of devices complete after 95.038 msecs
> [   16.105648] PM: late suspend of devices complete after 6.903 msecs
> [   16.116356] PM: noirq suspend of devices complete after 5.912 msecs
> [   16.121213] Disabling non-boot CPUs ...
> [   16.154140] IRQ51 no longer affine to CPU1
> [   16.154709] CPU1: shutdown
> [   16.214148] IRQ52 no longer affine to CPU2
> [   16.214646] CPU2: shutdown
> [   16.273980] IRQ53 no longer affine to CPU3
> [   16.274458] CPU3: shutdown
> [   16.335093] IRQ54 no longer affine to CPU4
> [   16.336033] CPU4: shutdown
> [   16.389979] IRQ55 no longer affine to CPU5
> [   16.390823] CPU5: shutdown
> [   16.444829] IRQ56 no longer affine to CPU6
> [   16.445621] CPU6: shutdown
> [   16.509229] cpu cpu4: Failed to find opp_table: -19
> [   16.514008] IRQ57 no longer affine to CPU7
> [   16.514824] CPU7: shutdown

Hi,

Yes you have found a real bug it seems. I think that can be reproduced
by a simple rmmmod of cpufreq-dt.ko module as well.

Though the solution you provided isn't good enough.

Consider for example a case where you do this:
- offline CPU 4
- suspend the system

You are going to get stuck in the exact same problem again.

I have sent a separate patch and cc'd you. Can you please verify that
it works for you ?

-- 
viresh
