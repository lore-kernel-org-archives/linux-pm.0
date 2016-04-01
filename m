From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Fri, 01 Apr 2016 11:41:44 -0700
Message-ID: <1459536104.13525.148.camel@linux.intel.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	 <2727017.UmaUvtBLeX@vostro.rjw.lan>
	 <CADDKRnCs8vWbqOBbk0T+A5_VSzC5ENfND=NLwb3G0XjTvF9DQA@mail.gmail.com>
	 <3623107.tlAuqH4F7s@vostro.rjw.lan>
	 <CADDKRnBBuSfU4P2QsJU42_422Ebs_qJxrx7cgBJsa=LFp158mw@mail.gmail.com>
	 <1459532674.13525.136.camel@linux.intel.com>
	 <003801d18c44$ab9134e0$02b39ea0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58617 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbcDASld (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Apr 2016 14:41:33 -0400
In-Reply-To: <003801d18c44$ab9134e0$02b39ea0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>, =?ISO-8859-1?Q?=27J=F6rg?= Otte' <jrg.otte@gmail.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>

On Fri, 2016-04-01 at 11:31 -0700, Doug Smythies wrote:
> On 2106.034.01 10:45 Srinivas Pandruvada wrote:
> >=20
> > On Fri, 2016-04-01 at 16:06 +0200, J=C3=B6rg Otte wrote:
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > Done. Attached the tracer.
> > > For me it looks like the previous one of the failing case.
> > The traces show that idle task is constantly running without sleep.
> No,
I mean atleast on once CPU. I am not saying they are looping, but the
wakeup time is less than 10ms, so the driver will not scale the load
for idle time.

>  they (at least the first one, I didn't look at the next one yet)
> show that CPUs 2 and 3 are spending around 99% of their time not in
> state
> C0. That the sample rate is ending up at ~10 Milliseconds, indicates
> some
> high frequency (>=3D 100Hz) events on those CPUs. Those events,
> apparently,
> take very little CPU time to complete, hence a load of about 1% on
> average.
>=20
> By the way, I can recreate the high sample rate with virtually no
> load
> on my system easy, but so far have been unable to get the high CPU
> frequencies observed by J=C3=B6rg. I can get my system to about a tar=
get
> pstate of
> 20 where it should have remained at 16, but that is about it.
>=20
> >=20
> > The driver is processing samples for idle task for every 10ms and
> > aperf/mperf are showing that we are always in turbo mode for idle
> > task.
> That column pretty much always says "idle" (or swapper for my way of
> doing
> things). I have not found it to very useful as an indicator, and
> considerably
> more so since the utilization changes.
>=20
> >=20
> >=20
> > Need to find out why idle task is not sleeping.
> I contend that is it.
> I don't have enough reverted data, but so far this seems very much
> like
> that bug report I referenced earlier.
>=20
> ... Doug
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
