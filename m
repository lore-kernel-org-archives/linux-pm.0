From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: powernv: make local function static
Date: Tue, 20 May 2014 01:21:25 +0200
Message-ID: <12636388.mIvbtR4O8Q@vostro.rjw.lan>
References: <1399794680-22210-1-git-send-email-computersforpeace@gmail.com> <536FC254.2000702@linux.vnet.ibm.com> <20140512055406.GA3804@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20140512055406.GA3804@in.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: ego@linux.vnet.ibm.com
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Brian Norris <computersforpeace@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Monday, May 12, 2014 11:24:06 AM Gautham R Shenoy wrote:
> On Mon, May 12, 2014 at 12:02:52AM +0530, Srivatsa S. Bhat wrote:
> > On 05/11/2014 01:21 PM, Brian Norris wrote:
> > > powernv_cpufreq_get() is only referenced in this file.
> > > 
> > > Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Cc: cpufreq@vger.kernel.org
> > > Cc: linux-pm@vger.kernel.org
> > 
> > Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> 
> Thanks for this fix Brian.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Queued up for 3.16, thanks!

> 
> --
> Thanks and Regards
> gautham.
> 
> > 
> > Regards,
> > Srivatsa S. Bhat
> > 
> > > ---
> > >  drivers/cpufreq/powernv-cpufreq.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> > > index af4968813e76..bb1d08dc8cc8 100644
> > > --- a/drivers/cpufreq/powernv-cpufreq.c
> > > +++ b/drivers/cpufreq/powernv-cpufreq.c
> > > @@ -235,7 +235,7 @@ static void powernv_read_cpu_freq(void *arg)
> > >   * firmware for CPU 'cpu'. This value is reported through the sysfs
> > >   * file cpuinfo_cur_freq.
> > >   */
> > > -unsigned int powernv_cpufreq_get(unsigned int cpu)
> > > +static unsigned int powernv_cpufreq_get(unsigned int cpu)
> > >  {
> > >  	struct powernv_smp_call_data freq_data;
> > > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
