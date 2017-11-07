From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq:stats: Handle the case when trans_table goes
 beyond PAGE_SIZE
Date: Tue, 7 Nov 2017 13:22:07 +0530
Message-ID: <20171107075207.GA13577@in.ibm.com>
References: <1510032157-31857-1-git-send-email-ego@linux.vnet.ibm.com>
 <20171107053236.GA3297@vireshk-i7>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754746AbdKGHwO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 02:52:14 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vA77p2NQ073364
        for <linux-pm@vger.kernel.org>; Tue, 7 Nov 2017 02:52:14 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e382c234f-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 07 Nov 2017 02:52:13 -0500
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 7 Nov 2017 00:52:12 -0700
Content-Disposition: inline
In-Reply-To: <20171107053236.GA3297@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, shilpa.bhat@linux.vnet.ibm.com, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org

Hi Viresh,

On Tue, Nov 07, 2017 at 11:02:36AM +0530, Viresh Kumar wrote:
> On 07-11-17, 10:52, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > On platforms with large number of Pstates, the transition table, which
> > is a NxN matrix, can overflow beyond the PAGE_SIZE boundary.
> > 
> > This can be seen on POWER9 which has 100+ Pstates.
> > 
> > As a result, each time the trans_table is read for any of the CPUs, we
> > will get the following error.
> > 
> > ---------------------------------------------------
> > fill_read_buffer: show+0x0/0xa0 returned bad count
> > ---------------------------------------------------
> > 
> > This patch detect the overflow the first time the trans_table is read
> > and print a warning in the dmesg and return return the FILE TOO LARGE
> 
> s/return return/return/

Will fix this.

> 
> > error.  The subsequent reads also return FILE TOO LARGE error.
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  Documentation/cpu-freq/cpufreq-stats.txt |  3 +++
> >  drivers/cpufreq/cpufreq_stats.c          | 11 +++++++++--
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.txt
> > index 2bbe207..a873855 100644
> > --- a/Documentation/cpu-freq/cpufreq-stats.txt
> > +++ b/Documentation/cpu-freq/cpufreq-stats.txt
> > @@ -90,6 +90,9 @@ Freq_i to Freq_j. Freq_i is in descending order with increasing rows and
> >  Freq_j is in descending order with increasing columns. The output here also 
> >  contains the actual freq values for each row and column for better readability.
> >  
> > +If the transition table is bigger than PAGE_SIZE, reading this will
> > +return an -EFBIG error.
> > +
> >  --------------------------------------------------------------------------------
> >  <mysystem>:/sys/devices/system/cpu/cpu0/cpufreq/stats # cat trans_table
> >     From  :    To
> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index e75880e..3cb717c 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -79,6 +79,7 @@ static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
> >  	return count;
> >  }
> >  
> > +bool trans_table_overflow;
> 
> This should be marked static and would be better to move it as local to below
> function, but ...
> >  static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> >  {
> >  	struct cpufreq_stats *stats = policy->stats;
> > @@ -88,6 +89,9 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> >  	if (policy->fast_switch_enabled)
> >  		return 0;
> >  
> > +	if (unlikely(trans_table_overflow))
> > +		return -EFBIG;
> > +
> 
> Do we really need to optimize this path at all? This is debug stuff really. Over
> that a person can theoretically rmmod the driver, insmod another driver and the
> problem may go away then. And so above would be problematic then.

Sure, I see what you mean. I can change the warning below to a
pr_warn_once, so that the dmesg isn't cluttered everytime someone
reads the trans_table.

> 
> >  	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
> >  	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
> >  	for (i = 0; i < stats->state_num; i++) {
> > @@ -118,8 +122,11 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> >  			break;
> >  		len += snprintf(buf + len, PAGE_SIZE - len, "\n");
> >  	}
> > -	if (len >= PAGE_SIZE)
> > -		return PAGE_SIZE;
> > +	if (len >= PAGE_SIZE) {
> > +		trans_table_overflow = true;
> > +		pr_warn("cpufreq transition table exceeds PAGE_SIZE. Disabling\n");
> > +		return -EFBIG;
> > +	}
> 
> I would suggest making only this change and removing other optimizations
> completely.

Ok. Will resend the patch incorporating your suggestions. Thanks for
the review.

> 
> -- 
> viresh
> 
