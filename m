From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 01/70] cpufreq: interactive: New 'interactive' governor
Date: Wed, 28 Oct 2015 01:59:01 +0100
Message-ID: <4534884.dsz2GVUDrG@vostro.rjw.lan>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50720 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751558AbbJ1AaE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 20:30:04 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?B=E1lint?= Czobor <czoborbalint@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mike Chan <mike@android.com>, Todd Poynor <toddpoynor@google.com>

Hi,

On Tuesday, October 27, 2015 06:29:49 PM B=C3=A1lint Czobor wrote:
> From: Mike Chan <mike@android.com>
>=20
> This governor is designed for latency-sensitive workloads, such as
> interactive user interfaces.  The interactive governor aims to be
> significantly more responsive to ramp CPU quickly up when CPU-intensi=
ve
> activity begins.
>=20
> Existing governors sample CPU load at a particular rate, typically
> every X ms.  This can lead to under-powering UI threads for the perio=
d of
> time during which the user begins interacting with a previously-idle =
system
> until the next sample period happens.
>=20
> The 'interactive' governor uses a different approach. Instead of samp=
ling
> the CPU at a specified rate, the governor will check whether to scale=
 the
> CPU frequency up soon after coming out of idle.  When the CPU comes o=
ut of
> idle, a timer is configured to fire within 1-2 ticks.  If the CPU is =
very
> busy from exiting idle to when the timer fires then we assume the CPU=
 is
> underpowered and ramp to MAX speed.
>=20
> If the CPU was not sufficiently busy to immediately ramp to MAX speed=
, then
> the governor evaluates the CPU load since the last speed adjustment,
> choosing the highest value between that longer-term load or the short=
-term
> load since idle exit to determine the CPU speed to ramp to.
>=20
> A realtime thread is used for scaling up, giving the remaining tasks =
the
> CPU performance benefit, unlike existing governors which are more lik=
ely to
> schedule rampup work to occur after your performance starved tasks ha=
ve
> completed.
>=20
> The tuneables for this governor are:
> /sys/devices/system/cpu/cpufreq/interactive/min_sample_time:
> 	The minimum amount of time to spend at the current frequency before
> 	ramping down. This is to ensure that the governor has seen enough
> 	historic CPU load data to determine the appropriate workload.
> 	Default is 80000 uS.
> /sys/devices/system/cpu/cpufreq/interactive/go_maxspeed_load
> 	The CPU load at which to ramp to max speed.  Default is 85.
>=20
> Change-Id: Ib2b362607c62f7c56d35f44a9ef3280f98c17585
> Signed-off-by: Mike Chan <mike@android.com>
> Signed-off-by: Todd Poynor <toddpoynor@google.com>
> Bug: 3152864
> Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>

It's good to see that submitted, but it'll have to go through a detaile=
d
review which is going to take some time.

One my observation after a cursory look at it is that at least some lat=
er
patches of the series modify drivers/cpufreq/cpufreq_interactive.c whic=
h is
a new file added by the first patch.  Is there any particular reason to
avoid folding all of those patches into the first one?

Thanks,
Rafael

