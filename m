From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 5/9] x86/sysctl: Add sysctl for ITMT scheduling
 feature
Date: Thu, 6 Oct 2016 13:13:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1610061307030.22338@nanos>
References: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com>  <1475322326-160112-6-git-send-email-srinivas.pandruvada@linux.intel.com>  <alpine.DEB.2.20.1610051624590.8953@nanos> <1475684673.3916.299.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-505336005-1475752388=:22338"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41177 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754586AbcJFLPk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Oct 2016 07:15:40 -0400
In-Reply-To: <1475684673.3916.299.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-505336005-1475752388=:22338
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 5 Oct 2016, Tim Chen wrote:
> On Wed, 2016-10-05 at 16:35 +0200, Thomas Gleixner wrote:
> > > +	if (itmt_supported) {
> > > +		itmt_sysctl_header =
> > > +			register_sysctl_table(itmt_root_table);
> > > +		if (!itmt_sysctl_header) {
> > > +			mutex_unlock(&itmt_update_mutex);
> > > +			return;
> > So you now have a state of capable which cannot be enabled. Whats the
> > point?
> 
> For multi-socket system where ITMT is not enabled by default, the operator
> can still decide to enable it via sysctl.

With a sysctl which failed to be installed. Good luck with that.
 
> > > +		}
> > > +		/*
> > > +		 * ITMT capability automatically enables ITMT
> > > +		 * scheduling for small systems (single node).
> > > +		 */
> > > +		if (topology_num_packages() == 1)
> > > +			sysctl_sched_itmt_enabled = 1;
> > > +	} else {
> > > +		if (itmt_sysctl_header)
> > > +			unregister_sysctl_table(itmt_sysctl_header);
> > > +	}
> > > +
> > > +	if (sysctl_sched_itmt_enabled) {
> > > +		/* disable sched_itmt if we are no longer ITMT capable */
> > > +		if (!itmt_supported)
> > 
> > How do you get here if itmt is not supported? 
> 
> If the OS decides to turn off ITMT for any reason, (i.e. invoke 
> sched_set_itmt_support(false) after it has turned on itmt_support
> before), this is the logic to do it.  We don't turn off ITMT support
> after it has been turned on today, in the future the OS may.

Then please make this two functions (set/clear) so one can actually follow
the logic. The above is just too convoluted.

Thanks,

	tglx
--8323329-505336005-1475752388=:22338--
