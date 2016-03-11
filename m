From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq constantly keeps frequency at maximum on 4.5-rc4)
Date: Fri, 11 Mar 2016 10:22:30 -0800
Message-ID: <002401d17bc2$fad32af0$f07980d0$@net>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>	<87si087tsr.fsf@iki.fi>	<CAJvTdKmg=H2hqFd+fwu0t8Rx4PV8E3vNGc-j8zzVKLFX4nprYg@mail.gmail.com>	<87a8m74mcc.fsf@iki.fi>	<002d01d17a57$ec417030$c4c45090$@net>	<CAJZ5v0i0cx_xYUwFWDX5nE+rNgbX4TY0ATYuD3rEi86Ky5cA5A@mail.gmail.com>	<003701d17a5d$cab287a0$601796e0$@net>	<CAJZ5v0gaO3vB7Bz+URiwdXx2jypqPSJ3Pc_aJ5VGgh4wJyB9Kg@mail.gmail.com> <20160311090306.1bfe380b@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta3.telus.net ([209.171.16.76]:55808 "EHLO cmta3.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbcCKSWf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Mar 2016 13:22:35 -0500
In-Reply-To: <20160311090306.1bfe380b@annuminas.surriel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Rik van Riel' <riel@redhat.com>, "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On 2016.03.11 06:03 Rik van Riel wrote:
> On Thu, 10 Mar 2016 00:59:01 +0100 "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
>> Rik, that seems to go against the changelog of
>> a9ceb78bc75ca47972096372ff3d48648b16317a:
>> 
>> "This is not a big deal on most x86 CPUs, which have very low C1
>> latencies, and the patch should not have any effect on those CPUs."
>> 
>> The effect is actually measurable and quite substantial to my eyes.
>
> Indeed, my mistake was testing not just against the predicted
> latency, but against the predicted latency multiplied by the
> load correction factor, which can be as much as 10x the load...
>
> The patch below should fix that.
>
> It didn't for Arto, due to the other issues on his system, but
> it might resolve the issue for Doug, where cstate/pstate is
> otherwise working fine.
>
> Doug, does the patch below solve your issue?

No.

Old data restated with new data added below:
Aggregate times in each idle state for the 2000 second test:

k45rc7 (minutes)	reverted (mins)	rvr patch(mins)	State
20.1771917		2.638311483		19.11342298		0
13.02770225		21.81474838		13.55643397		1
3.428136783		3.951405		3.698494867		2
1.4540243		1.552488167		1.528558717		3
134.9057413		143.5533		138.5279812		4
			
172.9927963		173.5102531		176.4248918		total

>> Energy:
>>
>> Reverted: 56178 Joules
>> Kernel 4.5-rc7: 63269 Joules (revert saves 12.6% energy)
Kernel 4.5-rc7 + rvr patch: 62914 Joules

> If it does not, we should figure out why the idle state selection
> loop is not selecting the right mode.

For my part of it, I am struggling to understand this area of the code.
It would take me awhile, quite awhile, to be able to provide useful
input.

... Doug


