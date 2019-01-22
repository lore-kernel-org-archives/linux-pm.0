From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PM / EM: Expose the Energy Model in debugfs
Date: Tue, 22 Jan 2019 16:54:55 +0100
Message-ID: <20190122155455.GA20697@kroah.com>
References: <20190107122608.21913-1-quentin.perret@arm.com>
 <20190122153412.zuehulqwb7ung43u@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122153412.zuehulqwb7ung43u@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rafael@kernel.org, peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 22, 2019 at 03:34:14PM +0000, Quentin Perret wrote:
> On Monday 07 Jan 2019 at 12:26:08 (+0000), Quentin Perret wrote:
> > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > index d9dc2c38764a..8ef48daa62ff 100644
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -10,6 +10,7 @@
> >  
> >  #include <linux/cpu.h>
> >  #include <linux/cpumask.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/energy_model.h>
> >  #include <linux/sched/topology.h>
> >  #include <linux/slab.h>
> > @@ -23,6 +24,88 @@ static DEFINE_PER_CPU(struct em_perf_domain *, em_data);
> >   */
> >  static DEFINE_MUTEX(em_pd_mutex);
> >  
> > +#ifdef CONFIG_DEBUG_FS
> > +static struct dentry *rootdir;
> > +
> > +static int em_debug_create_cs(struct em_cap_state *cs, struct dentry *pd)
> > +{
> > +	struct dentry *d;
> > +	char name[24];
> > +
> > +	snprintf(name, sizeof(name), "cs:%lu", cs->frequency);
> > +
> > +	d = debugfs_create_dir(name, pd);
> > +	if (!d)
> > +		return -ENOMEM;
> > +
> > +	if (!debugfs_create_ulong("frequency", 0444, d, &cs->frequency))
> > +		return -ENOMEM;
> 
> Looking at the patches Greg just sent I assume all this is wrong.

Yes it is :)

> I'll send a v2 without the 'if' all over.

That would be wonderful, thanks.

greg k-h
