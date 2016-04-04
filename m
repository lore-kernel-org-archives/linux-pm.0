From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Sun, 3 Apr 2016 23:14:21 -0700
Message-ID: <002f01d18e39$3b1691f0$b143b5d0$@net>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>	<1459376311.13525.108.camel@linux.intel.com>	<003b01d18ad6$831941c0$894bc540$@net>	<CA+icZUXaoeQz5vMzPxjOaAzbzdQ4D1MV2dG5EvXAM54k6EOz1g@mail.gmail.com>	<002301d18b59$d208fe50$761afaf0$@net>	<CA+icZUX2ZtsO8pa7ZY0JKW3vm5veVCJ08q3p0ai3FxdMNgvKww@mail.gmail.com>	<CA+icZUVHyq7dOh457rYv+2nmNxPevY0ZcqxhQVhYG4Z1D-NaDA@mail.gmail.com>	<1459610923.5912.36.camel@linux.intel.com>	<CADDKRnC0rtxp8JapQ13s9RnRf-iySB=TdkwS1x=W7+e-vDGXuA@mail.gmail.com>	<CA+icZUUCEgs1-eeRje4zb_Lj=0=hWM8OPvoKrquMCAXAj=Gy4g@mail.gmail.com>	<001201d18ddb$0102ccd0$03086670$@net> <CA+icZUVhnH563=8zyrsvH86y0HTqeT57OJ1ETES5_ZsDOwae-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta10.telus.net ([209.171.16.83]:40970 "EHLO cmta10.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbcDDGOY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2016 02:14:24 -0400
In-Reply-To: <CA+icZUVhnH563=8zyrsvH86y0HTqeT57OJ1ETES5_ZsDOwae-w@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'LKML' <linux-kernel@vger.kernel.org>, =?UTF-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>

On 2016.03.04 22:14 Sedat Dilek wrote:
> On Sun, Apr 3, 2016 at 8:59 PM, Doug Smythies <dsmythies@telus.net> w=
rote:
>> On 2016.04.02 11:21 Sedat Dilek wrote:
>>> On Sat, Apr 2, 2016 at 7:19 PM, J=C3=B6rg Otte wrote:
>>>> 2016-04-02 17:28 GMT+02:00 Srinivas Pandruvada wrote:
>>>>

> are you involved in the Ubuntu-OS? Developer for Canonical?

I try to help with Ubuntu as a community volunteer.
I am not a developer with Canonical.

=2E.. [cut]...

>> As far as I know the /etc/init.d/ondemand is working properly. It se=
ts the acpi-cpufreq
>> driver to use the "ondemand" governor and it sets the intel_pstate d=
river to use the
>> "powersave" governor.
>>

> I haven't looked at this exactly.
> The ondemand-script is not saying to fall back to "powersave" in case
> of intel_pstate-driver (here on Ubuntu/precise).

It is likely that newer versions of /etc/init.d/ondemand script
were never backported to the older 12.04 precise release.
Why not? Well, because, as far as I know, that release never used the
intel_pstate driver by default and so never had to fall through
to the powersave alternative.

Earlier on this thread, Srinivas correctly asked J=C3=B6rg what distrib=
ution
was being used, so as to hopefully make it easier to reproduce the issu=
e.
If we want to continue this distro specific conversation, perhaps
we should move it off-list or to some Ubuntu specific forum.

=2E.. Doug


