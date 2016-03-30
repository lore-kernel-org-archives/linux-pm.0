From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Wed, 30 Mar 2016 11:50:35 -0700
Message-ID: <002401d18ab5$0bf84a30$23e8de90$@net>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>	<CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>	<4187911.uaFVupaTVL@vostro.rjw.lan>	<CADDKRnCr0riAu4pjYRkuguoCoAjWxFoc+pU1NBymPr+3JnVanQ@mail.gmail.com>	<CAJZ5v0i48Xxyp880SQ1iVDzct--vhTVggCS_wHHA7bt7D+_sFg@mail.gmail.com>	<1459352017.13525.45.camel@intel.com> <CADDKRnA5x9dK=6KZWijiP_ihrUA9Afpmqw8TSzYn9oaBeaOfKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta8.telus.net ([209.171.16.81]:48194 "EHLO cmta8.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754563AbcC3Sul convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 14:50:41 -0400
In-Reply-To: <CADDKRnA5x9dK=6KZWijiP_ihrUA9Afpmqw8TSzYn9oaBeaOfKw@mail.gmail.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>, "'Pandruvada, Srinivas'" <srinivas.pandruvada@intel.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net

On 2016.03.30 08:52 J=C3=B6rg Otte wrote:
> 2016-03-30 17:33 GMT+02:00 Pandruvada, Srinivas <srinivas.pandruvada@=
intel.com>:
>> On Wed, 2016-03-30 at 13:05 +0200, Rafael J. Wysocki wrote:
>>> On Wed, Mar 30, 2016 at 12:17 PM, J=C3=B6rg Otte <jrg.otte@gmail.co=
m>

>>>>>> Now in v4.6-rc1 the characteristic has dramatically changed.
>>>>>> If in idle the processor frequency is more or less a few
>>>>>> MHz around 2500Mhz.
>>>>>> I currently use acpi_cpufreq which works as usual.
>>>>>> Processor: Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz
>>>>>> (family: 0x6, model: 0x3c, stepping: 0x3)

>> I want to reproduce this if I can. Can you give us info about your
>> setup (Linux distribution, laptop model etc.)?

I would like to try to reproduce the issue also.

> Distro: Ubuntu 14.04.4 LTS

Note that with Ubuntu 14.04, I had issues where my CPU
would lock at pstate 24 (not always 24, but usually),
regardless of load.
However, it was always after an S3 suspend, occurred 100%
of the time, and was independent of intel_pstate or
acpi-cpufreq CPU frequency scaling drivers.

Since changing my test server to Ubuntu server edition 16.04
(development version), I have not had those issues. While I have
no proof, I have assumed the issue elimination was somehow related
to the change to systemd.

It might be worth observing both what the intel_pstate is asking for
and what the processor is actually doing.

What is being asked for:
# rdmsr --bitfield 15:8 -d -a 0x199

What is being given:
# rdmsr --bitfield 15:8 -d -a 0x198

An old problematic example from an idle system (mine)
Note, my minimum pstate is 16:

What was being given:
# rdmsr --bitfield 15:8 -d -a 0x198
24
24
24
24
24
24
24
24

What was being asked for:
# rdmsr --bitfield 15:8 -d -a 0x199
16
16
16
16
16
16
16
16

To gain further insight, it might also be worth acquiring
some trace data. On an otherwise idle system, do:

# perf record -a --event=3Dpower:pstate_sample sleep 300

If pressed for time, your sleep time can be less than 5 minutes,
but try to get at least 100 seconds.

The resulting perf.data file will be too big to include as an
on-list attachment, but send it (or them) to me off-list for
post processing, and I'll report back.

=2E.. Doug


