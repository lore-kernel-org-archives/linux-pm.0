From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Wed, 16 Dec 2015 11:25:28 +0100
Message-ID: <7636826.nXeVGhctJd@skinner>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <6686771.YYmmLREfhx@skinner> <CAJvTdKki4W2UBGQvaTxDQ8neTdmp8xADseEiA0V=2dq2q-C16A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49679 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932888AbbLPKZc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Dec 2015 05:25:32 -0500
In-Reply-To: <CAJvTdKki4W2UBGQvaTxDQ8neTdmp8xADseEiA0V=2dq2q-C16A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Philippe Longepe <philippe.longepe@linux.intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Prarit Bhargava <prarit@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Tuesday, December 15, 2015 12:59:50 PM Len Brown wrote:
> > Does this means Avaton will fall back to acpi-cpufreq?
> > This may need some fiddling with our certifcation tool which expects
> > cpupfreq to work at least a bit.
> 
> How do your certification tool handle with a system that has NO pstates?
> 
> We have low power  products that run at only 1 frequency.
> We also have several large customers that like to implement
> P-states in their out-of-band firmware and hide them
> completely from the OS.

The tests had been adopted to intel_pstate, if needed they have to be
adjusted again..
But it is nice to know in advance when such a bug drops in.

      Thomas
