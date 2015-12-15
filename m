From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to
 get target pstate
Date: Tue, 15 Dec 2015 12:59:50 -0500
Message-ID: <CAJvTdKki4W2UBGQvaTxDQ8neTdmp8xADseEiA0V=2dq2q-C16A@mail.gmail.com>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com>
	<3489702.fdaYLucDTN@skinner>
	<1450117227.2912.17.camel@spandruv-desk3.jf.intel.com>
	<6686771.YYmmLREfhx@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34393 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbbLOR7w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 12:59:52 -0500
Received: by mail-lf0-f49.google.com with SMTP id y184so12534736lfc.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Dec 2015 09:59:52 -0800 (PST)
In-Reply-To: <6686771.YYmmLREfhx@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Philippe Longepe <philippe.longepe@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Prarit Bhargava <prarit@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>

> Does this means Avaton will fall back to acpi-cpufreq?

Yes.
Though if we find that we can make it run better by supporting it via
intel_pstate,
then we reserve the right to add that support:-)

> Would it make sense to initalize with intel_pstate and then switch to
> performance governor per default?

I don't understand this question.

> This may need some fiddling with our certifcation tool which expects
> cpupfreq to work at least a bit.

How do your certification tool handle with a system that has NO pstates?

We have low power  products that run at only 1 frequency.
We also have several large customers that like to implement
P-states in their out-of-band firmware and hide them
completely from the OS.

> The "ondemand" compatiblity patch(es) are not that important, right?
> I would hold them off and evaluate whether it will make sense to get back
> to governors. Even if not, I am not sure it is a good idea to introduce a
> fake ondemand governor which is still doing things totally different than
> the orignal one...

I agree, ondemand is a file in Linux, and the word should be used
to describe only what that file does.

thanks,
Len Brown, Intel Open Source Technology Center
