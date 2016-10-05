From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v5 5/9] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Wed, 05 Oct 2016 09:24:33 -0700
Message-ID: <1475684673.3916.299.camel@linux.intel.com>
References: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1475322326-160112-6-git-send-email-srinivas.pandruvada@linux.intel.com>
         <alpine.DEB.2.20.1610051624590.8953@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1610051624590.8953@nanos>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-10-05 at 16:35 +0200, Thomas Gleixner wrote:
> On Sat, 1 Oct 2016, Srinivas Pandruvada wrote:
> > 
> > +static int sched_itmt_update_handler(struct ctl_table *table, int write,
> > +			      void __user *buffer, size_t *lenp, loff_t *ppos)
> > +{
> > +	int ret;
> > +	unsigned int old_sysctl;
> > +
> > +	mutex_lock(&itmt_update_mutex);
> > +
> > +	if (!sched_itmt_capable) {
> > +		mutex_unlock(&itmt_update_mutex);
> > +		return 0;
> This should return a proper error code.

Okay. Will return EINVAL instead.

> 
> > 
> >  void sched_set_itmt_support(bool itmt_supported)
> >  {
> >  	mutex_lock(&itmt_update_mutex);
> >  
> > -	if (itmt_supported != sched_itmt_capable)
> > -		sched_itmt_capable = itmt_supported;
> > +	if (itmt_supported == sched_itmt_capable) {
> > +		mutex_unlock(&itmt_update_mutex);
> > +		return;
> > +	}
> > +	sched_itmt_capable = itmt_supported;
> > +
> > +	if (itmt_supported) {
> > +		itmt_sysctl_header =
> > +			register_sysctl_table(itmt_root_table);
> > +		if (!itmt_sysctl_header) {
> > +			mutex_unlock(&itmt_update_mutex);
> > +			return;
> So you now have a state of capable which cannot be enabled. Whats the
> point?

For multi-socket system where ITMT is not enabled by default, the operator
can still decide to enable it via sysctl.

> 
> > 
> > +		}
> > +		/*
> > +		 * ITMT capability automatically enables ITMT
> > +		 * scheduling for small systems (single node).
> > +		 */
> > +		if (topology_num_packages() == 1)
> > +			sysctl_sched_itmt_enabled = 1;
> > +	} else {
> > +		if (itmt_sysctl_header)
> > +			unregister_sysctl_table(itmt_sysctl_header);
> > +	}
> > +
> > +	if (sysctl_sched_itmt_enabled) {
> > +		/* disable sched_itmt if we are no longer ITMT capable */
> > +		if (!itmt_supported)
> 
> How do you get here if itmt is not supported? 

If the OS decides to turn off ITMT for any reason, (i.e. invoke 
sched_set_itmt_support(false) after it has turned on itmt_support
before), this is the logic to do it.  We don't turn off ITMT support
after it has been turned on today, in the future the OS may.

If you prefer, I can change things to sched_set_itmt_support(void) so
we can only turn on ITMT support. And once the support is on, we
don't revoke it.

Thanks.

Tim

