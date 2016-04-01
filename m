From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Fri, 1 Apr 2016 11:31:12 -0700
Message-ID: <003801d18c44$ab9134e0$02b39ea0$@net>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>	 <2727017.UmaUvtBLeX@vostro.rjw.lan>	 <CADDKRnCs8vWbqOBbk0T+A5_VSzC5ENfND=NLwb3G0XjTvF9DQA@mail.gmail.com>	 <3623107.tlAuqH4F7s@vostro.rjw.lan>	 <CADDKRnBBuSfU4P2QsJU42_422Ebs_qJxrx7cgBJsa=LFp158mw@mail.gmail.com> <1459532674.13525.136.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta7.telus.net ([209.171.16.80]:60662 "EHLO cmta7.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbcDASbO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 14:31:14 -0400
In-Reply-To: <1459532674.13525.136.camel@linux.intel.com>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, =?UTF-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>

On 2106.034.01 10:45 Srinivas Pandruvada wrote:
> On Fri, 2016-04-01 at 16:06 +0200, J=C3=B6rg Otte wrote:
> > > > > >=20
>> Done. Attached the tracer.
>> For me it looks like the previous one of the failing case.
>=20
> The traces show that idle task is constantly running without sleep.

No, they (at least the first one, I didn't look at the next one yet)
show that CPUs 2 and 3 are spending around 99% of their time not in sta=
te
C0. That the sample rate is ending up at ~10 Milliseconds, indicates so=
me
high frequency (>=3D 100Hz) events on those CPUs. Those events, apparen=
tly,
take very little CPU time to complete, hence a load of about 1% on aver=
age.

By the way, I can recreate the high sample rate with virtually no load
on my system easy, but so far have been unable to get the high CPU
frequencies observed by J=C3=B6rg. I can get my system to about a targe=
t pstate of
20 where it should have remained at 16, but that is about it.

> The driver is processing samples for idle task for every 10ms and
> aperf/mperf are showing that we are always in turbo mode for idle tas=
k.

That column pretty much always says "idle" (or swapper for my way of do=
ing
things). I have not found it to very useful as an indicator, and consid=
erably
more so since the utilization changes.

>=20
> Need to find out why idle task is not sleeping.

I contend that is it.
I don't have enough reverted data, but so far this seems very much like
that bug report I referenced earlier.

=2E.. Doug


