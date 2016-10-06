From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v5 5/9] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Thu, 06 Oct 2016 10:37:46 -0700
Message-ID: <1475775466.3916.319.camel@linux.intel.com>
References: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com>
          <1475322326-160112-6-git-send-email-srinivas.pandruvada@linux.intel.com>
          <alpine.DEB.2.20.1610051624590.8953@nanos>
         <1475684673.3916.299.camel@linux.intel.com>
         <alpine.DEB.2.20.1610061307030.22338@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1610061307030.22338@nanos>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thu, 2016-10-06 at 13:13 +0200, Thomas Gleixner wrote:
> On Wed, 5 Oct 2016, Tim Chen wrote:
> > 
> > On Wed, 2016-10-05 at 16:35 +0200, Thomas Gleixner wrote:
> > > 
> > > > 
> > > > +	if (itmt_supported) {
> > > > +		itmt_sysctl_header =
> > > > +			register_sysctl_table(itmt_root_table);
> > > > +		if (!itmt_sysctl_header) {
> > > > +			mutex_unlock(&itmt_update_mutex);
> > > > +			return;
> > > So you now have a state of capable which cannot be enabled. Whats the
> > > point?
> > For multi-socket system where ITMT is not enabled by default, the operator
> > can still decide to enable it via sysctl.
> With a sysctl which failed to be installed. Good luck with that.

I misunderstood your earlier comment.
You are talking about the case where we fail to register the sysctl?

In this case, the system is in a state that indicates it is 
ITMT capable but cannot be enabled.  So we return and do not turn on ITMT
scheduling.  The system operator should always have the capability
to enable/disable ITMT via sysctl.  So we do not turn on ITMT if operator has
no control over it, even if the system is capable of ITMT.


>  
> > 
> > > 
> > > > 
> > > > +		}
> > > > +		/*
> > > > +		 * ITMT capability automatically enables ITMT
> > > > +		 * scheduling for small systems (single node).
> > > > +		 */
> > > > +		if (topology_num_packages() == 1)
> > > > +			sysctl_sched_itmt_enabled = 1;
> > > > +	} else {
> > > > +		if (itmt_sysctl_header)
> > > > +			unregister_sysctl_table(itmt_sysctl_header);
> > > > +	}
> > > > +
> > > > +	if (sysctl_sched_itmt_enabled) {
> > > > +		/* disable sched_itmt if we are no longer ITMT capable */
> > > > +		if (!itmt_supported)
> > > How do you get here if itmt is not supported? 
> > If the OS decides to turn off ITMT for any reason, (i.e. invoke 
> > sched_set_itmt_support(false) after it has turned on itmt_support
> > before), this is the logic to do it.  We don't turn off ITMT support
> > after it has been turned on today, in the future the OS may.
> Then please make this two functions (set/clear) so one can actually follow
> the logic. The above is just too convoluted.

Sure, I will add a clear function and move the clearing logic there.

Thanks.

Tim
