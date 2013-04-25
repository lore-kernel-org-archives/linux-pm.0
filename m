From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v2 4/4] ARM:TMU:fix: Avoid lockup when first frequency
 table entry is CPUFREQ_ENTRY_INVALID
Date: Thu, 25 Apr 2013 17:22:46 +0200
Message-ID: <20130425172246.2143525e@amdc308.digital.local>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
 <1366893045-31586-1-git-send-email-l.majewski@samsung.com>
 <1366893045-31586-5-git-send-email-l.majewski@samsung.com>
 <51794785.6090406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <51794785.6090406@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> Lukasz,
> 
> On 25-04-2013 08:30, Lukasz Majewski wrote:
> > With the while loop, when i=0 and first entry in the frequency
> > table is CPUFREQ_ENTRY_INVALID, the code results in an endless loop
> > (since i is not incremented).
> >
> > To fix this problem the for loop has been chosen. Incrementing i in
> > the for end block solves the problem.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > Changes for v2:
> > - New in v2
> 
> This patch wont apply on Rui's tree.
> 
> I believe this has been already fixed on Rui's tree (next branch).
> Could you please check if the commit below fix your issue:
> git.kernel.org/cgit/linux/kernel/git/rzhang/linux.git/commit/?h=thermal&id=fc35b35cbe24ef021ea9acfba21e54da958df747
> 
> commit fc35b35cbe24ef021ea9acfba21e54da958df747
> Author: Zhang Rui <rui.zhang@intel.com>
> Date:   Fri Feb 8 13:09:32 2013 +0800
> 
>      Thermal: cpufreq cooling: fix parsing per_cpu
> cpufreq_frequency_table
> 

Thanks for pointing out. It seems, that this function fixes this
problem.

As a side note, is this problem fixed at stable kernels?

> 
> 
> > ---
> >   drivers/thermal/cpu_cooling.c |    3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/cpu_cooling.c
> > b/drivers/thermal/cpu_cooling.c index 8dc44cb..df79f5e8 100644
> > --- a/drivers/thermal/cpu_cooling.c
> > +++ b/drivers/thermal/cpu_cooling.c
> > @@ -124,7 +124,7 @@ static unsigned int get_cpu_frequency(unsigned
> > int cpu, unsigned long level) if (!table)
> >   		return ret;
> >
> > -	while (table[i].frequency != CPUFREQ_TABLE_END) {
> > +	for (; table[i].frequency != CPUFREQ_TABLE_END; i++) {
> >   		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
> >   			continue;
> >
> > @@ -138,7 +138,6 @@ static unsigned int get_cpu_frequency(unsigned
> > int cpu, unsigned long level) /*return if level matched and table
> > in descending order*/ if (descend && i == level)
> >   			return table[i].frequency;
> > -		i++;
> >   	}
> >   	i--;
> >
> >



-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
