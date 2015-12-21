From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] blackfin-cpufreq: Change return type of cpu_set_cclk()
 to that of clk_set_rate()
Date: Mon, 21 Dec 2015 08:47:57 +0530
Message-ID: <20151221031757.GA5532@ubuntu>
References: <5674598B.6020000@users.sourceforge.net>
 <20151219015926.GJ3946@ubuntu>
 <5675141F.2090803@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35622 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbbLUDSB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Dec 2015 22:18:01 -0500
Received: by mail-pa0-f48.google.com with SMTP id jx14so63315158pad.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Dec 2015 19:18:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5675141F.2090803@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On 19-12-15, 09:23, SF Markus Elfring wrote:
> >> From: Markus Elfring <elfring@users.sourceforge.net>
> >> Date: Fri, 18 Dec 2015 19:43:27 +0100
> >>
> >> The return type "unsigned long" was used by the cpu_set_cclk() function
> >> while the type "int" is provided by the clk_set_rate() function.
> >> Let us make this usage consistent.
> >>
> >> This issue was detected by using the Coccinelle software.
> >>
> >> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> >> ---
> >>  drivers/cpufreq/blackfin-cpufreq.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
> >> index a9f8e5b..2a6f3ac 100644
> >> --- a/drivers/cpufreq/blackfin-cpufreq.c
> >> +++ b/drivers/cpufreq/blackfin-cpufreq.c
> >> @@ -112,7 +112,7 @@ static unsigned int bfin_getfreq_khz(unsigned int cpu)
> >>  }
> >>  
> >>  #ifdef CONFIG_BF60x
> >> -unsigned long cpu_set_cclk(int cpu, unsigned long new)
> >> +int cpu_set_cclk(int cpu, unsigned long new)
> >>  {
> >>  	struct clk *clk;
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Thanks for your acceptance.
> 
> I would appreciate if another implementation detail can also be clarified there.
> http://lxr.free-electrons.com/ident?v=4.3;i=cpu_set_cclk
> 
> * Do you want to reuse such a function in other modules?
> * Should it eventually marked as "static"?

This should be static, yeah.

-- 
viresh
