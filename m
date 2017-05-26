From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v4 8/8] arm,arm64,drivers: add a prefix to drivers
 arch_topology interfaces
Date: Fri, 26 May 2017 20:36:10 +0200
Message-ID: <20170526183610.GB16490@kroah.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170420144316.15632-9-juri.lelli@arm.com>
 <20170525131802.GE16244@kroah.com>
 <20170526101032.2t2xn5wrfenimu5w@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170526101032.2t2xn5wrfenimu5w@e106622-lin>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, May 26, 2017 at 11:10:32AM +0100, Juri Lelli wrote:
> Hi,
> 
> On 25/05/17 15:18, Greg KH wrote:
> > On Thu, Apr 20, 2017 at 03:43:16PM +0100, Juri Lelli wrote:
> > > Now that some functions that deal with arch topology information live
> > > under drivers, there is a clash of naming that might create confusion.
> > > 
> > > Tidy things up by creating a drivers namespace for interfaces used by
> > > arch code; achieve this by prepending a 'atd_' (arch topology driver)
> > > prefix to driver interfaces.
> > 
> > No one knows, nor will they ever remember, what "atd_" means :(
> > 
> > Naming is hard, I know, here's my suggestion:
> > 
> > > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > > index 4edae9fe8cdd..e25458d7ee9a 100644
> > > --- a/include/linux/arch_topology.h
> > > +++ b/include/linux/arch_topology.h
> > > @@ -4,14 +4,14 @@
> > >  #ifndef _LINUX_ARCH_TOPOLOGY_H_
> > >  #define _LINUX_ARCH_TOPOLOGY_H_
> > >  
> > > -void normalize_cpu_capacity(void);
> > > +void atd_normalize_cpu_capacity(void);
> > 
> > arch_cpu_normalize_capacity();
> > or
> > cpu_normalize_capacity();
> > 
> > Why do you care if this is "arch" or not, of course it's arch-specific
> > in a way, right?
> > 
> > >  
> > >  struct device_node;
> > > -int parse_cpu_capacity(struct device_node *cpu_node, int cpu);
> > > +int atd_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
> > 
> > cpu_parse_capacity();
> > 
> > >  struct sched_domain;
> > > -unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
> > > +unsigned long atd_scale_cpu_capacity(struct sched_domain *sd, int cpu);
> > 
> > cpu_scale_capacity();
> > 
> > > -void set_capacity_scale(unsigned int cpu, unsigned long capacity);
> > > +void atd_set_capacity_scale(unsigned int cpu, unsigned long capacity);
> > 
> > wait, where did the cpu go?  This doesn't make much sense, these are all
> > "capacity" issues, right?  If so, then these should be:
> > 	capacity_normalize_cpu()
> > 	capacity_parse_cpu()
> > 	capacity_scale_cpu()
> > 	capacity_set_scale()
> > 
> > But this is all really topology stuff, right?  Why use "capacity" at
> > all:
> > 	topology_normalize_cpu()
> > 	topology_parse_cpu()
> > 	topology_scale_cpu()
> > 	topology_set_scale()
> > ?
> > 
> > It's always best to put the "subsystem" name first, we have a bad
> > history of getting this wrong in the past by putting the verb first, not
> > the noun.
> > 
> 
> topology_ works for me. However, I'd keep "capacity" in the names, as we
> might need to topology_normalize_cpu_somethingelse() (etc.) in the
> future?

Worry about the future, in the future.  Change the names then, _IF_ it
becomes an issue.  Try to be short and simple please.

> Updated patch follows. I kept Catalin and Russell's acks as I only
> renamed the functions, please shout if that's not OK.
> 
> Greg, if you are fine with this approach, do you still want a complete
> v5 of the set or can you pick this up?

Am I the one who is supposed to take all of these arm-specific patches?
If so, that's fine, but I need to have acks from the arm maintainers...

Oh, and drop "capacity" please :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
