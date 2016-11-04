From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: powernv: Use PMSR to verify global and
 local pstate
Date: Fri, 4 Nov 2016 12:11:32 +0530
Message-ID: <20161104064132.GB3414@vireshk-i7>
References: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1478237255-4258-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36601 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934004AbcKDGlg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Nov 2016 02:41:36 -0400
Received: by mail-pf0-f173.google.com with SMTP id 189so46231528pfz.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Nov 2016 23:41:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1478237255-4258-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 04-11-16, 10:57, Akshay Adiga wrote:
> As fast_switch may get called in interrupt disable mode, it does not

s/in interrupt disable mode/with interrupts disabled
s/it does/it may

> update the global_pstate_info data structure. Hence the global_pstate_info
> has stale data whenever pstate is updated through fast_swtich().

s/has/may have
s/swtich/switch

> 
> So the gpstate_timer can fire after a fast_switch() call has update

s/So the/The
s/a fast_swtich() call has update/the fast_switch() call has updated

> the pstates to a different value. Hence the timer handler cannot rely
> on the cached values of local and global pstate and needs to read it
> from the PMSR. 
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> 
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)

I am not the best guy to judge the code changes here. Can you please include
Shilpa and Gautham to the mail chain and get there feedback.

-- 
viresh
