From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Thu, 4 Jun 2015 11:41:28 +0530
Message-ID: <20150604061128.GF11325@linux>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
 <556FDEA8.6090801@linux.vnet.ibm.com>
 <556FEB4B.1010601@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34361 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbbFDGLd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 02:11:33 -0400
Received: by pdbki1 with SMTP id ki1so23713860pdb.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2015 23:11:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <556FEB4B.1010601@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 04-06-15, 11:38, Preeti U Murthy wrote:
> And a crash at the cpufreq worker thread again due to data access
> exception when I change governors in parallel on a single core.
> 
> cpu 0x3: Vector: 300 (Data Access) at [c000000fedb538f0]
>     pc: c000000000856750: od_dbs_timer+0x60/0x1e0
>     lr: c0000000000f489c: process_one_work+0x24c/0x910
>     sp: c000000fedb53b70
>    msr: 9000000100009033
>    dar: 10
>  dsisr: 40000000
>   current = 0xc000000fe3d128e0
>   paca    = 0xc000000007da1c80	 softe: 0	 irq_happened: 0x01
>     pid   = 17227, comm = kworker/3:1
> 
> With the backtrace being:
> 
> [c000000fedb53be0] c0000000000f489c process_one_work+0x24c/0x910
> [c000000fedb53c90] c0000000000f50dc worker_thread+0x17c/0x540
> [c000000fedb53d20] c0000000000fed70 kthread+0x120/0x140
> [c000000fedb53e30] c000000000009678 ret_from_kernel_thread+0x5c/0x64
> 
> But the kernel stays sane longer than before with the patchset. The
> above crash happens around 15 seconds after the test begins, while
> earlier it wouldn't survive 2 seconds even.

I haven't attempted to solve the race between the worker threads and
governor-callbacks yet. What I have tried to solve is the race between
different callbacks. And you shouldn't see a race there for now. For
example a race between INIT/EXIT/START/STOP/LIMITS.

-- 
viresh
