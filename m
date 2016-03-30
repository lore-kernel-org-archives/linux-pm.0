From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Wed, 30 Mar 2016 15:46:43 -0700
Message-ID: <1459378003.13525.117.camel@linux.intel.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
	 <1459376311.13525.108.camel@linux.intel.com> <56FC5277.9050906@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:20303 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbcC3Wq2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Mar 2016 18:46:28 -0400
In-Reply-To: <56FC5277.9050906@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: sedat.dilek@gmail.com, Doug Smythies <dsmythies@telus.net>, =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, Linux PM List <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>

On Thu, 2016-03-31 at 00:25 +0200, Rafael J. Wysocki wrote:
> On 3/31/2016 12:18 AM, Srinivas Pandruvada wrote:
> >=20
> > On Wed, 2016-03-30 at 23:41 +0200, Sedat Dilek wrote:
> > >=20
> > > Hi,
> > >=20
> > > I am using Intel-PState-Driver here with v4.6-rc1 and Intel-
> > > SandyBridge-CPU.
> > >=20
> > > Here are my turbostat results attached.
> > >=20
> > > $ cd $BUILD_DIR
> > > $ LC_ALL=3DC make -C tools/ turbostat
> > >=20
> > > $ sudo ./turbostat -i 1 --msr=3D0x199 --debug --out
> > > /tmp/turbostat-i-1-msr-0x199-debug.txt
> > >=20
> > > Will try <https://patchwork.kernel.org/patch/8702071/>.
> > >=20
> > > Please see attached files.
> > >=20
> > Thanks. Your logs make sense. You have config set to performance
> > mode
> > by default (Which I believe default in all kernel Ubuntu). So as
> > expected Intel P state was asking for max. So there is no issue
> > here.
> But the behavior is different from what it used to be, isn't it?
>=20
There are two turbostat output files, In both I see we are requesting
max (0x1700) in performance mode. This CPU is Sandybridge, so no config
TDP here, the other problem system reported is Haswell
=2E
=C2=A00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A00.15=C2=A0=C2=A0=C2=A0=C2=
=A02017=C2=A0=C2=A0=C2=A0=C2=A01596=C2=A0=C2=A00x00001700=C2=A0

I am not sure whether Sedat is saying that he has the same issue as
Jorg. I think Sedat will see the same turbostat output if he ran 4.5.

Sedat,=C2=A0
Please confirm whether you see difference between 4.5 and 4.6-rc1.

Thanks,
Srinivas

> So there seems to be a problem here AFAICS.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
