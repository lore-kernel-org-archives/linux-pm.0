From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 1/2] intel_pstate: Use the cpu load to determine the
 PercentPerformance
Date: Fri, 06 Nov 2015 17:14:28 -0800
Message-ID: <1446858868.5023.6.camel@linux.intel.com>
References: <1446542840-14982-1-git-send-email-philippe.longepe@linux.intel.com>
	 <1546343.Y03T7q8XC6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30061 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbbKGBPy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Nov 2015 20:15:54 -0500
In-Reply-To: <1546343.Y03T7q8XC6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Philippe Longepe <philippe.longepe@linux.intel.com>
Cc: linux-pm@vger.kernel.org, Stephane Gasparini <stephane.gasparini@linux.intel.com>

On Sat, 2015-11-07 at 02:09 +0100, Rafael J. Wysocki wrote:
> On Tuesday, November 03, 2015 10:27:19 AM Philippe Longepe wrote:
> > Aperf and Mperf counter are not enough to determine the Target P
> > -state
> > because they measure performance only when the targeted processor
> > is
> > in the C0 state (active state).
> > Because of that, we were computing the average P-state during the
> > last
> > period which can be very different from the average frequency
> > (or percentage of performance).
> > 
> > As defined in the SDM (section 14.2), the PercentPerformance is
> > defined by:
> > 
> > PercentPerformance = PercentBusy * (delta_aperf / delta_mperf);
> > 
> > The PercentBusy (or load) can be estimated as the ratio of the
> > mperf
> > counter running at a constant frequency only during active periods
> > (C0)
> > and the time stamp counter running at the same frequency but also
> > during idle.
> > 
> > So, PercentBusy = 100 * (delta_mperf / delta_tsc)
> > 
> > and, PercentPerformance = 100 * (delta_mperf / delta_tsc) *
> > 				(delta_aperf / delta_mperf)
> > That can be simplified with:
> > PercentPerformance = 100 * (delta_aperf / delta_tsc)
> > 
> > Signed-off-by: Philippe Longepe <philippe.longepe@linux.intel.com>
> > Signed-off-by: Stephane Gasparini <
> > stephane.gasparini@linux.intel.com>
> 
> Srinivas, I need your ACK here and for the [2/2].
> 
These needs further validation to merge to upstream kernel.

Thanks,
Srinivas


> Thanks,
> Rafael
> 
