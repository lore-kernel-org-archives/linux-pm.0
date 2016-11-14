From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: linux-next: build warning after merge of the pm tree
Date: Mon, 14 Nov 2016 01:03:52 +0100
Message-ID: <2357318.aIcIp7uAlP@vostro.rjw.lan>
References: <20161114104009.57b7e64b@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20161114104009.57b7e64b@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, November 14, 2016 10:40:09 AM Stephen Rothwell wrote:
> Hi Rafael,

Hi Stephen,

> After merging the pm tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> drivers/cpufreq/powernv-cpufreq.c: In function 'gpstate_timer_handler':
> drivers/cpufreq/powernv-cpufreq.c:642:5: warning: 'lpstate_idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (gpstate_idx != gpstates->last_lpstate_idx)
>      ^
> 
> Introduced by commit
> 
>   20b15b766354 ("cpufreq: powernv: Use PMCR to verify global and local pstate")

Thanks for the notice!

Akshay, any thoughts?

Thanks,
Rafael
