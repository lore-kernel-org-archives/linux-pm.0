From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: linux-next: build warning after merge of the pm tree
Date: Mon, 14 Nov 2016 14:19:33 +0530
Message-ID: <8b5d3227-b5e4-c45c-3703-aa17a1584893@linux.vnet.ibm.com>
References: <20161114104009.57b7e64b@canb.auug.org.au>
 <2357318.aIcIp7uAlP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2357318.aIcIp7uAlP@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-pm@vger.kernel.org

Hi Rafeal,

Good catch, I need to set lpstate_idx = gpstate_idx.
I will send a patch which fixes this commit.

Thanks Stephen for reporting it. :)

Regards
Akshay Adiga

On 11/14/2016 05:33 AM, Rafael J. Wysocki wrote:
> On Monday, November 14, 2016 10:40:09 AM Stephen Rothwell wrote:
> > Hi Rafael,
>
> Hi Stephen,
>
> > After merging the pm tree, today's linux-next build (powerpc
> > ppc64_defconfig) produced this warning:
> >
> > drivers/cpufreq/powernv-cpufreq.c: In function 'gpstate_timer_handler':
> > drivers/cpufreq/powernv-cpufreq.c:642:5: warning: 'lpstate_idx' may
> be used uninitialized in this function [-Wmaybe-uninitialized]
> >   if (gpstate_idx != gpstates->last_lpstate_idx)
> >      ^
> >
> > Introduced by commit
> >
> >   20b15b766354 ("cpufreq: powernv: Use PMCR to verify global and
> local pstate")
>
> Thanks for the notice!
>
> Akshay, any thoughts?
>
> Thanks,
> Rafael
>
