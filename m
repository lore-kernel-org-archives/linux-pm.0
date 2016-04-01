From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Fri, 01 Apr 2016 10:44:34 -0700
Message-ID: <1459532674.13525.136.camel@linux.intel.com>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com>
	 <2727017.UmaUvtBLeX@vostro.rjw.lan>
	 <CADDKRnCs8vWbqOBbk0T+A5_VSzC5ENfND=NLwb3G0XjTvF9DQA@mail.gmail.com>
	 <3623107.tlAuqH4F7s@vostro.rjw.lan>
	 <CADDKRnBBuSfU4P2QsJU42_422Ebs_qJxrx7cgBJsa=LFp158mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12679 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbcDARoU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Apr 2016 13:44:20 -0400
In-Reply-To: <CADDKRnBBuSfU4P2QsJU42_422Ebs_qJxrx7cgBJsa=LFp158mw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>

On Fri, 2016-04-01 at 16:06 +0200, J=C3=B6rg Otte wrote:
> 2016-04-01 14:40 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> >=20
> > On Friday, April 01, 2016 11:20:42 AM J=C3=B6rg Otte wrote:
> > >=20
> > > 2016-03-31 17:43 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > > >=20
> > > > On Thursday, March 31, 2016 05:25:18 PM J=C3=B6rg Otte wrote:
> > > > >=20
> > > > > 2016-03-31 13:42 GMT+02:00 Rafael J. Wysocki <rjw@rjwysocki.n
> > > > > et>:
> > > > > >=20
> > > > > > On Thursday, March 31, 2016 11:05:56 AM J=C3=B6rg Otte wrot=
e:
> > > > > >=20
[Cut]
> > > > > >=20
> Done. Attached the tracer.
> For me it looks like the previous one of the failing case.
>=20
The traces show that idle task is constantly running without sleep. The
driver is processing samples for idle task for every 10ms and
aperf/mperf are showing that we are always in turbo mode for idle task.

Need to find out why idle task is not sleeping.

Thanks,
Srinivas



> Thanks, J=C3=B6rg
