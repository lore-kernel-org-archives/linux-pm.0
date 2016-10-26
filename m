From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v6 5/9] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Wed, 26 Oct 2016 10:59:33 -0700
Message-ID: <1477504773.2680.22.camel@linux.intel.com>
References: <cover.1477000078.git.tim.c.chen@linux.intel.com>
         <b3f648c2c4cd36b6a043239bee8437a2060c0ac4.1477000078.git.tim.c.chen@linux.intel.com>
         <alpine.DEB.2.20.1610261231250.4983@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1610261231250.4983@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-10-26 at 12:49 +0200, Thomas Gleixner wrote:
> On Thu, 20 Oct 2016, Tim Chen wrote:
> > 
> > +static int sched_itmt_update_handler(struct ctl_table *table, int write,
> > +			      void __user *buffer, size_t *lenp, loff_t *ppos)
> Please align the arguments proper
> 
> static int
> sched_itmt_update_handler(struct ctl_table *table, int write,
> 			  void __user *buffer, size_t *lenp, loff_t *ppos)
> 

Okay.

> > 
> > +{
> > +	int ret;
> > +	unsigned int old_sysctl;
> 	unsigned int old_sysctl;
> 	int ret;
> 
> Please. It's way simpler to read.

Sure.

> 
> > 
> > -void sched_set_itmt_support(void)
> > +int sched_set_itmt_support(void)
> >  {
> >  	mutex_lock(&itmt_update_mutex);
> >  
> > +	if (sched_itmt_capable) {
> > +		mutex_unlock(&itmt_update_mutex);
> > +		return 0;
> > +	}
> > +
> > +	itmt_sysctl_header = register_sysctl_table(itmt_root_table);
> > +	if (!itmt_sysctl_header) {
> > +		mutex_unlock(&itmt_update_mutex);
> > +		return -ENOMEM;
> > +	}
> > +
> >  	sched_itmt_capable = true;
> >  
> > +	/*
> > +	 * ITMT capability automatically enables ITMT
> > +	 * scheduling for small systems (single node).
> > +	 */
> > +	if (topology_num_packages() == 1)
> > +		sysctl_sched_itmt_enabled = 1;
> I really hate this. This is policy and the kernel should not impose
> policy. Why would I like to have this enforced on my single socket XEON
> server?
> 
> > 
> > +	if (sysctl_sched_itmt_enabled) {
> Why would sysctl_sched_itmt_enabled be true at this point, aside of the
> above policy imposement?

That's true, it will only be enabled for the above case.  I can merge
it into the if check above.


Tim
