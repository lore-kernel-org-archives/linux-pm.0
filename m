From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: PROBLEM: Cpufreq constantly keeps frequency at maximum on
 4.5-rc4
Date: Sat, 20 Feb 2016 18:03:34 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286C6253@shsmsx102.ccr.corp.intel.com>
References: <87egc7ahqn.fsf@iki.fi> <000401d16bfc$21338450$639a8cf0$@net>
 <87a8mv9ujm.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45526 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754012AbcBTTXL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 20 Feb 2016 14:23:11 -0500
In-Reply-To: <87a8mv9ujm.fsf@iki.fi>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arto Jantunen <viiru@iki.fi>, Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Arto Jantunen
> Sent: Sunday, February 21, 2016 1:11 AM
> To: Doug Smythies
> Cc: 'Rafael J. Wysocki'; 'Viresh Kumar'; linux-pm@vger.kernel.org; 'Srinivas
> Pandruvada'
> Subject: Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on
> 4.5-rc4
> 
> "Doug Smythies" <dsmythies@telus.net> writes:
> 
> > On 2106.02.20 00:50 Arto Jantunen wrote:
> >> I can force the frequency down manually with cpufreq-set, so the
> >> problem doesn't seem to be with the actual frequency changing.
 cpufreq-set modifies the value of scaling_max_freq, it looks like
your system always demands for the max freq, can you provide:
grep . /sys/devices/system/cpu/intel_pstate/*perf_pct
under powersave and performance?
And I agree with Doug,you can also file a report at Bugzilla.

