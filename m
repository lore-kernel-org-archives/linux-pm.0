From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH v7] cpufreq: Add SFI based cpufreq driver support
Date: Thu, 18 Dec 2014 12:14:14 +0530
Message-ID: <20141218064414.GA18689@intel-desktop>
References: <20141211081438.GA2885@intel-desktop>
 <CAJvTdKmCwJTWE4t9YuWn+OLxG5EWZDXo5LZ1Bxq45ECiOvQmsA@mail.gmail.com>
 <20141216102444.GA16158@intel-desktop>
 <CAJvTdKn71M8edzdereUnDTESxJTpgdLXZjFAULO=aQTA0wnpdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56823 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbaLRGmt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Dec 2014 01:42:49 -0500
Content-Disposition: inline
In-Reply-To: <CAJvTdKn71M8edzdereUnDTESxJTpgdLXZjFAULO=aQTA0wnpdA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com, srinidhi.kasagar@intel.com

On Wed, Dec 17, 2014 at 05:12:43PM -0500, Len Brown wrote:
> >> policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> >
> > But we know the transition latency of this system. Why should we
> > claim it as "unknown"? The sfi_freq_table_entry has latency
> > field - does it not make irrelevant then?
> 
> I wrote the SFI spec.
> If I did it again, I would not include the latency field in the FREQ table,
> because Linux does not need it.
> 
> >> ondemand will compare this to TRANSITION_LATENCY_LIMIT (10 * 1000 * 1000)
> >> and since -1 is less than 10,000,000; it will be happy.
> >>
> >> > +       for (i = 0; i < num_freq_table_entries; i++) {
> >> > +               /* detect transition latency */
> >> > +               if ((sfi_cpufreq_array[i].latency * 1000) >
> >> > +                   policy->cpuinfo.transition_latency)
> >> > +                       policy->cpuinfo.transition_latency =
> >> > +                               sfi_cpufreq_array[i].latency * 1000;
> >>
> >> delete above 5 lines.  every SFI system will have latency
> >> plenty lower than that required by ondemand governor.
> 
> There is effectively no customer for the information being provided,
> as there are only two possible outcomes:
> 
> 1. The largest value in the table is < 10ms, and ondemand loads
> 2. The largest value in the table is > 10ms and ondemand fails to load.
> #1 is how it should always work on all known SFI platforms.
> #2 is a firmware bug.
> 
> Well, we can do #1 with 1 line, and at the same time eliminate
> exposure to firmware bugs in #2.

Ok, as we know the latency of this system (as 100 us), I will hardcode this
with 1 line and remove the rest of detection stuff..

Srinidhi
