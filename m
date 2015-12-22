From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] Documentation: cpufreq: intel_pstate: enhance
 documentation
Date: Tue, 22 Dec 2015 09:48:31 -0800
Message-ID: <1450806511.4225.1.camel@linux.intel.com>
References: <1450721117-7620-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <000001d13cdd$dc0fff90$942ffeb0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:11026 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009AbbLVRud (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Dec 2015 12:50:33 -0500
In-Reply-To: <000001d13cdd$dc0fff90$942ffeb0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: len.brown@intel.com, linux-pm@vger.kernel.org, trenn@suse.de, prarit@redhat.com, rafael@kernel.org

On Tue, 2015-12-22 at 09:26 -0800, Doug Smythies wrote:
> Hi Srinivas,
Hi Doug,

Thanks for the review. Let me know if we can make any other
improvements.

Thanks,
Srinivas

> Just two typos.
> 
> On 2015.12.21 10:05 Srinivas Pandruvada wrote:
> 
> > +scaling_governor: This displays current active policy. Since each
> > CPU has a
> > +cpufreq sysfs, it is possible to set a scaling governor to each
> > CPU. But this
> > +is not possible with Intel P-States, as there is one common policy
> > for all
> > +CPUs. Here, the last requested policy will be applicable to all
> > CPUs. It is
> 
> > > suggested that use the cpupower utility to change policy to all
> > > CPUs at the
> 
> +suggested that one use the cpupower utility to change policy to all
> CPUs at the
> 
> > +same time.
> > +
> > +scaling_setspeed: This attribute can never be used with Intel P
> > -State.
> 
> > +      setpoint = 80
> > +
> > +If the current P-State = 0x08 and current load = 100, this will
> > result in the
> > +next P-State = 0x08 - ((80 - 100) * 0.2) = 12
> > +For the same load at setpoint = 60 this will result in the next P
> > -State
> > += 0x08 - ((60 - 100) * 0.2) = 16
> > +So by changing the setpoint from 80 to 60, there is an increase of
> > the
> 
> > > next P-State from 12 to 16. So this will make processor to
> > > execute at
> 
> + next P-State from 12 to 16. So this will make the processor execute
> at
> 
> > +higher P-State for the same CPU load.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
