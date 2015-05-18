From: Omar Sandoval <osandov@osandov.com>
Subject: Re: suspend regression in 4.1-rc1
Date: Sun, 17 May 2015 22:18:51 -0700
Message-ID: <20150518051851.GA9591@mew>
References: <20150517185041.GA5897@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36680 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbbERFSx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 01:18:53 -0400
Received: by pdfh10 with SMTP id h10so133559832pdf.3
        for <linux-pm@vger.kernel.org>; Sun, 17 May 2015 22:18:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150517185041.GA5897@dhcp22.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ulrich Obergfell <uobergfe@redhat.com>, Don Zickus <dzickus@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sun, May 17, 2015 at 08:50:41PM +0200, Michal Hocko wrote:
> Hi,
> s2ram broke after 4.1-rc1 for me. The second s2ram simply doesn't wake
> up (fans turn on but the screen is off). I have even noticed fans
> starting also while suspended in some instances (which was especially
> annoying when it happened on the way home from work).
> I've tried /sys/power/pm_test and the issue starts at processors mode.
> Nothing really interesting shows up in the netconsole but I didn't get
> to a more detailed testing there.
> 
> I've tried to bisect this as 4.0 works reliably. This was tricky though
> because the first bad commit is a merge:
> 
> commit 1dcf58d6e6e6eb7ec10e9abc56887b040205b06f
> Merge: 80dcc31fbe55 e4b0db72be24
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Apr 14 16:49:17 2015 -0700
> 
>     Merge branch 'akpm' (patches from Andrew)
> 
> The merge commit is empty and both 80dcc31fbe55 and e4b0db72be24 work
> properly but the merge is bad. So it seems like some of the commits in
> either branch has a side effect which needs other branch in order to
> reproduce.
> 
> So've tried to bisect ^80dcc31fbe55 e4b0db72be24 and merged 80dcc31fbe55
> in each step. This lead to:
> 
> commit 195daf665a6299de98a4da3843fed2dd9de19d3a
> Author: Ulrich Obergfell <uobergfe@redhat.com>
> Date:   Tue Apr 14 15:44:13 2015 -0700
> 
>     watchdog: enable the new user interface of the watchdog mechanism
> 
> The patch doesn't revert because of follow up changes so I have reverted
> all three:
> 692297d8f968 ("watchdog: introduce the hardlockup_detector_disable() function")
> b2f57c3a0df9 ("watchdog: clean up some function names and arguments")
> 195daf665a62 ("watchdog: enable the new user interface of the watchdog mechanism")
> 
> on top of my current Linus tree (4cfceaf0c087f47033f5e61a801f4136d6fb68c6)
> and the issue is gone. I have hard time to understand what these 3 could have
> to do with suspend path, though.
> 
> Then I've tried to bisect the other branch and merge 195daf665a62 during
> each step to find out which patch starts failing. This lead to an even
> weirder commit a1e12da4796a ("perf tools: Add 'I' event modifier for
> exclude_idle bit") but maybe I've just screwed something on the way.
> 
> I will continue debugging tomorrow but any hints would be helpful.
> -- 
> Michal Hocko
> SUSE Labs

The symptoms here are different, and the bisect indicates that it's
completely unrelated, but just for kicks you could also try:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=533445c6e53368569e50ab3fb712230c03d523f3
-- 
Omar
