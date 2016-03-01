From: Len Brown <lenb@kernel.org>
Subject: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Tue, 1 Mar 2016 12:51:23 -0500
Message-ID: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36670 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbcCARvY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 12:51:24 -0500
Received: by mail-lb0-f169.google.com with SMTP id x1so103685937lbj.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2016 09:51:24 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arto Jantunen <viiru@iki.fi>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rik van Riel <riel@redhat.com>

> Since this is about cpuidle, I'll also mention that this hardware
> requires idle=nomwait on the command line, otherwise the kernel will not
> boot.

Arto,

A boot failure is even more disruptive than bad P-state and C-state choices!
Please tell us more about it.

What c-states are used when you use "idle=nomwait"?
you can see them this way:

grep . /sys/devices/system/cpu/cpu0/cpuidle/*/*

Please boot with intel_idle.max_cstate=0

If that also boots, please again show the available c-states via the grep above.

Does it happen if you use default cmdline,
but edit intel_idle.c to comment out c8 and c9 support?

Please run
# turbostat --debug | tee ts.out 2>&1
and send ts.out to show the deepest idle state that this system can
actually enter.

thanks,
Len Brown, Intel Open Source Technology Center
