From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: acpi_cpufreq: base frequency attribute support
Date: Wed, 24 Feb 2016 12:00:52 -0800
Message-ID: <1456344052.8680.208.camel@linux.intel.com>
References: <1443738317-4224-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20151007172343.GE4557@linux> <4807388.hTIoZIhGRk@vostro.rjw.lan>
	 <20151016054226.GQ19018@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15207 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933073AbcBXUD6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Feb 2016 15:03:58 -0500
In-Reply-To: <20151016054226.GQ19018@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On Fri, 2015-10-16 at 11:12 +0530, Viresh Kumar wrote:
> On 16-10-15, 00:45, Rafael J. Wysocki wrote:
> > We're talking about a continuous range above the base frequency
> > here.
> 
> Ick. No it can't be reused for the continuous range stuff.
> 
I know this is bit old discussion. Is there any problem in applying
this patch?

Thanks,
Srinivas
