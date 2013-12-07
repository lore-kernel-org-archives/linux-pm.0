From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH V4] cpufreq: suspend governors on system suspend/hibernate
Date: Sat, 07 Dec 2013 12:01:54 +0100
Message-ID: <87vbz0j55p.fsf@nemi.mork.no>
References: <28d493f20239a242a7b26dfe1efed40d83bf1e10.1385523340.git.viresh.kumar@linaro.org>
	<3057132.zHNVNQZ8pP@vostro.rjw.lan>
	<CAKohpondYbBeObUJJqNZLe04dmN9tLMZv9KrjzqLr2NDorRtLw@mail.gmail.com>
	<1781198.iCUX9ZdW7W@vostro.rjw.lan>
	<CAKohpomA9r5a4GkfA-Huh0ectc-hXjSxcdLkJhF6DZvL22yY4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:55366 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754878Ab3LGLC1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 7 Dec 2013 06:02:27 -0500
In-Reply-To: <CAKohpomA9r5a4GkfA-Huh0ectc-hXjSxcdLkJhF6DZvL22yY4w@mail.gmail.com>
	(Viresh Kumar's message of "Fri, 29 Nov 2013 08:56:08 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Kgene Kim <kgene.kim@samsung.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-tegra@vger.kernel.org, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 29 November 2013 01:59, Rafael J. Wysocki <rjw@rjwysocki.net> wrot=
e:
>> So I'm reading this as "the version of the patch in bleeding-edge is=
 OK".
>>
>> I hope that really is the case. :-)
>
> Yeah, that's correct.

Sorry to be making noise here again, but I was eager to verify that the
fixes in v3.13-rc3 were OK on my system.  Unfortunately it seems this
patch completely broke suspend for me.  Hibernete ended up with a blank
console and no visible activity, without ever writing any image to disk=
=2E

There really weren't that many suspects between v3.13-rc2 and v3.13-rc3=
,
so I went directly to reverting 5a87182aa21d ("cpufreq: suspend
governors on system suspend/hibernate") which fixed the problem. I
didn't bother debugging it further from there. I don't think there is
anything magic about my system which should make this problem specific
to it.

I am still using the acpi-cpufreq driver on an old x86_64 laptop if tha=
t
matters.


Bj=C3=B8rn
