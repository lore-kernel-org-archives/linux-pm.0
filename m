From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: cpu_cooling: fix out of bounds access in
 time_in_idle
Date: Fri, 15 Jan 2016 15:20:56 +0000
Message-ID: <20160115152055.GA2917@e104805>
References: <1450529677-23426-1-git-send-email-javi.merino@arm.com>
 <20151221031940.GB5532@ubuntu>
 <20160105191925.GD3163@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53605 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323AbcAOPVA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 Jan 2016 10:21:00 -0500
Content-Disposition: inline
In-Reply-To: <20160105191925.GD3163@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>

Eduardo, Rui,

On Tue, Jan 05, 2016 at 07:19:25PM +0000, Javi Merino wrote:
> On Mon, Dec 21, 2015 at 08:49:40AM +0530, Viresh Kumar wrote:
> > On 19-12-15, 12:54, Javi Merino wrote:
> > > In __cpufreq_cooling_register() we allocate the arrays for time_in_idle
> > > and time_in_idle_timestamp to be as big as the number of cpus in this
> > > cpufreq device.  However, in get_load() we access this array using the
> > > cpu number as index, which can result in an out of bound access.
> > > 
> > > Index time_in_idle{,_timestamp} using the index in the cpufreq_device's
> > > allowed_cpus mask, as we do for the load_cpu array in
> > > cpufreq_get_requested_power()
> > > 
> > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > > Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > Cc: Zhang Rui <rui.zhang@intel.com>
> > > Cc: Eduardo Valentin <edubezval@gmail.com>
> > > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > > ---
> > >  drivers/thermal/cpu_cooling.c | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> If there are no more objections, can you pick this up?

Another gentle ping, can this be merged?

Thanks,
Javi
