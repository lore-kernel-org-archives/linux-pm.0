From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4] cpufreq: Add SFI based cpufreq driver support
Date: Mon, 10 Nov 2014 14:10:44 -0500
Message-ID: <CAJvTdKkHsRh1rp4FREn6R+3bOqpXqVD2q8fUG8id75kBsNEHCA@mail.gmail.com>
References: <20141104170031.GA25991@intel-desktop>
	<CAJvTdKkUR5OfdEjyhPrh3PzkvPce2aYRT59YhvOGwco-jLSZ=g@mail.gmail.com>
	<20141110105606.GA11060@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:44623 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaKJTKo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 14:10:44 -0500
Received: by mail-yh0-f54.google.com with SMTP id 29so370886yhl.27
        for <linux-pm@vger.kernel.org>; Mon, 10 Nov 2014 11:10:44 -0800 (PST)
In-Reply-To: <20141110105606.GA11060@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com, "Brown, Len" <len.brown@intel.com>

> Not sure if in understood correctly. Do you mean I should not
> even read from PERF_CTL in get_cur_freq_on_cpu, rather just
> return the cached last requested frequency? I'm not sure
> of the behavior in case if we offline and online a cpu.

Best to simply cache the last written value in software,
that way it can be read quickly w/o even switching to
a processor to do the local MSR read.

The cpufreq get-current-frequency interface is somewhat bogus.
It generally doesn't make sense on a lot of modern hardware for the
driver to actually know the current frequency -- as the driver is only making
a request and does not have total control over the frequency...
But we need to answer something b/c there are people still
using the legacy cpufreq sysfs interface, and they expect a number.

cheers,
Len Brown, Intel Open Source Technology Center
