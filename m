From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Add scaling frequency range support
Date: Wed, 29 Jul 2015 02:18:28 +0200
Message-ID: <15808229.KgKF05ecju@vostro.rjw.lan>
References: <55B6F7C3.8040405@intel.com> <20150728042945.GE1229@linux> <55B70ACD.9010402@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41289 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750827AbbG1Xvd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 19:51:33 -0400
In-Reply-To: <55B70ACD.9010402@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pan Xinhui <xinhuix.pan@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

On Tuesday, July 28, 2015 12:53:33 PM Pan Xinhui wrote:
> hi, Viresh
> 	thanks for your reply :)
> On 2015=E5=B9=B407=E6=9C=8828=E6=97=A5 12:29, Viresh Kumar wrote:
> > On 28-07-15, 11:32, Pan Xinhui wrote:
> >> From: Pan Xinhui <xinhuix.pan@intel.com>
> >>
> >> Userspace at most time do cpufreq tests very much inconveniently.
> >> Currently they have to echo min and max cpu freq separately like b=
elow:
> >> echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_fr=
eq
> >> echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_fr=
eq
> >>
> >> Add scaling_freq_range cpufreq attr to support userspace's demand.
> >> Therefore it's easier for testers to write readable scripts like b=
elow:=20
> >> echo 480000-2240000 >
> >> /sys/devices/system/cpu/cpu0/cpufreq/scaling_freq_range
> >=20
> > I don't think this brings any good change, we already have support =
for
> > that with min/max freqs and I don't see how scripts can be less
> > readable with that.
> >=20
> yes, min/max are supported, however it is inconvenient. sometime it's=
 very easy to cause obscure bugs.
> For example, some one might write a script like below.
> echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
> echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> .....//other works
> echo 1120000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
> echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
> ...//other works
>=20
> But it did not work when we echo 112000 to min-freq, as the current m=
ax freq is smaller than it.
> It's hard to figure it out in a big script... we have many such scrip=
ts.

=46ix them, then, pretty please.

And adding this attribute is not going to magically fix them, is it?

Thanks,
Rafael

