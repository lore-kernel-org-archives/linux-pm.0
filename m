From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH 2/2] turbostat, add set_base_cpu()
Date: Tue, 26 May 2015 00:32:39 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9484688EFD5@fmsmsx115.amr.corp.intel.com>
References: <1432296063-22185-1-git-send-email-prarit@redhat.com>
 <1432296063-22185-3-git-send-email-prarit@redhat.com>
 <1A7043D5F58CCB44A599DFD55ED4C9484688E5F2@fmsmsx115.amr.corp.intel.com>
 <555FADFA.609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:3528 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbbEZAcm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 20:32:42 -0400
In-Reply-To: <555FADFA.609@redhat.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Semin, Andrey" <andrey.semin@intel.com>



> -----Original Message-----
> From: Prarit Bhargava [mailto:prarit@redhat.com]
> Sent: Friday, May 22, 2015 6:30 PM
> To: Brown, Len
> Cc: linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org; Semin, Andrey
> Subject: Re: [PATCH 2/2] turbostat, add set_base_cpu()
> 
> 
> 
> On 05/22/2015 11:55 AM, Brown, Len wrote:
> >> +void set_base_cpu(void)
> >> +{
> >> +	int cpu;
> >> +
> >> +	for (cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
> >> +		if (cpu_is_not_present(cpu))
> >> +			continue;
> >> +		base_cpu = cpu;
> >> +		break;
> >> +	}
> >> +
> >> +	if (base_cpu == -1)
> >> +		err(-ENODEV, "No valid cpus found");
> >> +}
> >
> >
> > cpu0 hard-coding is indeed arbitrary.
> > However, so is this proposed replacement, base_cpu.
> > Either may not match where turbostat is currently running,
> > and thus could provoke unnecessary cross-calls to get there.
> >
> > I think it would be better to ask getcpu(2) where we are already
> running,
> > and simply use that one.  I think we can call it once and cache it,
> > as you proposed, rather than multiple system calls.
> 
> Any objection to sched_getcpu()?  That way the code is simply
> 
> 	base_cpu = sched_getcpu();
> 
> 	if (base_cpu == -1)
> 		err(-ENODEV, "No valid cpus found");

Agreed, that is better than invoking the syscall directly,
as we already are using the sched.h interface in this code.

thanks,
-Len

