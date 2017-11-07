From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [v2 PATCH] cpufreq:stats: Handle the case when trans_table goes
 beyond PAGE_SIZE
Date: Tue, 7 Nov 2017 14:21:48 +0530
Message-ID: <20171107085148.GD3297@vireshk-i7>
References: <1510042169-16664-1-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:54620 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdKGIvv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 03:51:51 -0500
Received: by mail-pf0-f196.google.com with SMTP id n89so9828671pfk.11
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2017 00:51:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1510042169-16664-1-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, shilpa.bhat@linux.vnet.ibm.com, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org

On 07-11-17, 13:39, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On platforms with large number of Pstates, the transition table, which
> is a NxN matrix, can overflow beyond the PAGE_SIZE boundary.
> 
> This can be seen on POWER9 which has 100+ Pstates.
> 
> As a result, each time the trans_table is read for any of the CPUs, we
> will get the following error.
> 
> ---------------------------------------------------
> fill_read_buffer: show+0x0/0xa0 returned bad count
> ---------------------------------------------------
> 
> This patch ensures that in case of an overflow, we print a warning
> once in the dmesg and return FILE TOO LARGE error for this and all
> subsequent accesses of trans_table.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  Documentation/cpu-freq/cpufreq-stats.txt | 3 +++
>  drivers/cpufreq/cpufreq_stats.c          | 7 +++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
