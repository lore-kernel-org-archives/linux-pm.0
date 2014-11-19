From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH v5] cpufreq: Add SFI based cpufreq driver support
Date: Wed, 19 Nov 2014 15:15:36 +0530
Message-ID: <20141119094536.GA24181@intel-desktop>
References: <20141118054537.GA28516@intel-desktop>
 <CAKohpokVi-6+mwhm6qqWCbjnNmm0L-3=6hezYBNg2zoE=ov=5Q@mail.gmail.com>
 <20141118172130.GA29590@intel-desktop>
 <CAKohpo=hveN_pcmNHz4G2dGRM4u+ZSZEUTBgOTUzTqK-SPW-wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32411 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753542AbaKSJpV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Nov 2014 04:45:21 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpo=hveN_pcmNHz4G2dGRM4u+ZSZEUTBgOTUzTqK-SPW-wQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>, Len Brown <lenb@kernel.org>

On Wed, Nov 19, 2014 at 01:03:38PM +0530, Viresh Kumar wrote:
> On 18 November 2014 22:51, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> > Not anymore now..I have fixed it in my earlier version.
> >
> > $ cat /sys/devices/system/cpu/cpu*/cpufreq/affected_cpus
> > 0
> > 1
> > 2
> > 3
> >
> > $  cat /sys/devices/system/cpu/cpu*/cpufreq/related_cpus
> > 0
> > 1
> > 2
> > 3
> 
> What do you mean by you have fixed it? Weren't the CPUs sharing clock lines?
> I hope cpu 0 and 1 should be sharing their clock lines, i.e. they
> change freq together.
> Also same for cpu 2 and 3.
The architecture supports both, and the current code allows me
to change the freq independently and that's why the above
output lines.

Srinidhi
