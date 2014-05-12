From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: powernv: make local function static
Date: Mon, 12 May 2014 11:24:06 +0530
Message-ID: <20140512055406.GA3804@in.ibm.com>
References: <1399794680-22210-1-git-send-email-computersforpeace@gmail.com>
 <536FC254.2000702@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <536FC254.2000702@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, May 12, 2014 at 12:02:52AM +0530, Srivatsa S. Bhat wrote:
> On 05/11/2014 01:21 PM, Brian Norris wrote:
> > powernv_cpufreq_get() is only referenced in this file.
> > 
> > Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: cpufreq@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> 
> Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Thanks for this fix Brian.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

--
Thanks and Regards
gautham.

> 
> Regards,
> Srivatsa S. Bhat
> 
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> > index af4968813e76..bb1d08dc8cc8 100644
> > --- a/drivers/cpufreq/powernv-cpufreq.c
> > +++ b/drivers/cpufreq/powernv-cpufreq.c
> > @@ -235,7 +235,7 @@ static void powernv_read_cpu_freq(void *arg)
> >   * firmware for CPU 'cpu'. This value is reported through the sysfs
> >   * file cpuinfo_cur_freq.
> >   */
> > -unsigned int powernv_cpufreq_get(unsigned int cpu)
> > +static unsigned int powernv_cpufreq_get(unsigned int cpu)
> >  {
> >  	struct powernv_smp_call_data freq_data;
> > 

