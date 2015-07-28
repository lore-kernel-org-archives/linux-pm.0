From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] cpufreq: Add scaling frequency range support
Date: Tue, 28 Jul 2015 12:53:33 +0800
Message-ID: <55B70ACD.9010402@intel.com>
References: <55B6F7C3.8040405@intel.com> <20150728042945.GE1229@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31721 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbbG1E4B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jul 2015 00:56:01 -0400
In-Reply-To: <20150728042945.GE1229@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

hi, Viresh
	thanks for your reply :)
On 2015=E5=B9=B407=E6=9C=8828=E6=97=A5 12:29, Viresh Kumar wrote:
> On 28-07-15, 11:32, Pan Xinhui wrote:
>> From: Pan Xinhui <xinhuix.pan@intel.com>
>>
>> Userspace at most time do cpufreq tests very much inconveniently.
>> Currently they have to echo min and max cpu freq separately like bel=
ow:
>> echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
>> echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>>
>> Add scaling_freq_range cpufreq attr to support userspace's demand.
>> Therefore it's easier for testers to write readable scripts like bel=
ow:=20
>> echo 480000-2240000 >
>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_freq_range
>=20
> I don't think this brings any good change, we already have support fo=
r
> that with min/max freqs and I don't see how scripts can be less
> readable with that.
>=20
yes, min/max are supported, however it is inconvenient. sometime it's v=
ery easy to cause obscure bugs.
=46or example, some one might write a script like below.
echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
=2E....//other works
echo 1120000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
=2E..//other works

But it did not work when we echo 112000 to min-freq, as the current max=
 freq is smaller than it.
It's hard to figure it out in a big script... we have many such scripts=
=2E
I admit this is a bug in script. If we can support *set freq range*, it=
's a very good option for usesapce to change the cpufreq.
People working in useespace will be thankful to us :)

> So, why to add redundant files at all? Also note that we can't remove
> the old interface as that will break the ABI.
>=20
fully agree! we can't break the ABI. So i just add this feature which i=
s very helpful. :)


thanks
xinhui
