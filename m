From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH v4] cpufreq: Add SFI based cpufreq driver support
Date: Tue, 18 Nov 2014 11:09:58 +0530
Message-ID: <20141118053958.GA28487@intel-desktop>
References: <20141104170031.GA25991@intel-desktop>
 <CAJvTdKkUR5OfdEjyhPrh3PzkvPce2aYRT59YhvOGwco-jLSZ=g@mail.gmail.com>
 <20141110105606.GA11060@intel-desktop>
 <CAJvTdKkHsRh1rp4FREn6R+3bOqpXqVD2q8fUG8id75kBsNEHCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48377 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbaKRFjE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 18 Nov 2014 00:39:04 -0500
Content-Disposition: inline
In-Reply-To: <CAJvTdKkHsRh1rp4FREn6R+3bOqpXqVD2q8fUG8id75kBsNEHCA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com, "Brown, Len" <len.brown@intel.com>, srinidhi.kasagar@intel.com

On Mon, Nov 10, 2014 at 02:10:44PM -0500, Len Brown wrote:
> > Not sure if in understood correctly. Do you mean I should not
> > even read from PERF_CTL in get_cur_freq_on_cpu, rather just
> > return the cached last requested frequency? I'm not sure
> > of the behavior in case if we offline and online a cpu.
> 
> Best to simply cache the last written value in software,
> that way it can be read quickly w/o even switching to
> a processor to do the local MSR read.
But it will be wrong after offline-online sequence. I have
sent v5 version of the patch. Please check.

> 
> The cpufreq get-current-frequency interface is somewhat bogus.
> It generally doesn't make sense on a lot of modern hardware for the
> driver to actually know the current frequency -- as the driver is only making
> a request and does not have total control over the frequency...
> But we need to answer something b/c there are people still
> using the legacy cpufreq sysfs interface, and they expect a number.

Agree.

Srinidhi
