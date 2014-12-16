From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH v7] cpufreq: Add SFI based cpufreq driver support
Date: Tue, 16 Dec 2014 15:54:44 +0530
Message-ID: <20141216102444.GA16158@intel-desktop>
References: <20141211081438.GA2885@intel-desktop>
 <CAJvTdKmCwJTWE4t9YuWn+OLxG5EWZDXo5LZ1Bxq45ECiOvQmsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61633 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbaLPKXI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 16 Dec 2014 05:23:08 -0500
Content-Disposition: inline
In-Reply-To: <CAJvTdKmCwJTWE4t9YuWn+OLxG5EWZDXo5LZ1Bxq45ECiOvQmsA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com, srinidhi.kasagar@intel.com

On Tue, Dec 16, 2014 at 03:15:33AM -0500, Len Brown wrote:

[...]

> replace line above with...
> 
> policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;

But we know the transition latency of this system. Why should we
claim it as "unknown"? The sfi_freq_table_entry has latency
field - does it not make irrelevant then?

> 
> ondemand will compare this to TRANSITION_LATENCY_LIMIT (10 * 1000 * 1000)
> and since -1 is less than 10,000,000; it will be happy.
> 
> > +       for (i = 0; i < num_freq_table_entries; i++) {
> > +               /* detect transition latency */
> > +               if ((sfi_cpufreq_array[i].latency * 1000) >
> > +                   policy->cpuinfo.transition_latency)
> > +                       policy->cpuinfo.transition_latency =
> > +                               sfi_cpufreq_array[i].latency * 1000;
> 
> delete above 5 lines.  every SFI system will have latency
> plenty lower than that required by ondemand governor.

Srinidhi
