From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv4 PATCH 22/34] sched: Calculate energy consumption of
 sched_group
Date: Fri, 22 May 2015 16:38:04 +0100
Message-ID: <20150522153804.GF26396@e105550-lin.cambridge.arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
 <1431459549-18343-23-git-send-email-morten.rasmussen@arm.com>
 <20150521075702.GA20008@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44175 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757563AbbEVPgX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 May 2015 11:36:23 -0400
Content-Disposition: inline
In-Reply-To: <20150521075702.GA20008@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, May 21, 2015 at 08:57:04AM +0100, Kamalesh Babulal wrote:
> * Morten Rasmussen <morten.rasmussen@arm.com> [2015-05-12 20:38:57]:
>=20
> [...]
> > +/*
> > + * cpu_norm_usage() returns the cpu usage relative to a specific c=
apacity,
> > + * i.e. it's busy ratio, in the range [0..SCHED_LOAD_SCALE] which =
is useful for
> > + * energy calculations. Using the scale-invariant usage returned b=
y
> > + * get_cpu_usage() and approximating scale-invariant usage by:
> > + *
> > + *   usage ~ (curr_freq/max_freq)*1024 * capacity_orig/1024 * runn=
ing_time/time
> > + *
> > + * the normalized usage can be found using the specific capacity.
> > + *
> > + *   capacity =3D capacity_orig * curr_freq/max_freq
> > + *
> > + *   norm_usage =3D running_time/time ~ usage/capacity
> > + */
> > +static unsigned long cpu_norm_usage(int cpu, unsigned long capacit=
y)
> > +{
> > +	int usage =3D __get_cpu_usage(cpu);
>=20
> __get_cpu_usage is introduced in next patch "sched: Extend sched_grou=
p_energy
> to test load-balancing decisions", applying the series with this patc=
h as top
> most patch breaks the build.
>=20
> kernel/sched/fair.c: In function =C3=A2=E2=82=AC=CB=9Ccpu_norm_usage=C3=
=A2=E2=82=AC=E2=84=A2:
> kernel/sched/fair.c:4830:2: error: implicit declaration of function =C3=
=A2=E2=82=AC=CB=9C__get_cpu_usage=C3=A2=E2=82=AC=E2=84=A2 [-Werror=3Dim=
plicit-function-declaration]
>   int usage =3D __get_cpu_usage(cpu);
>   ^
>=20
> Given that __get_cpu_usage(), take additional parameter - delta. get_=
cpu_usage()
> should have been used here.

Yes, you are right. Using get_cpu_usage() here instead should be
correct. I think it was right in RFCv3, I must have messed it up when I
moved around some of the patches :(

I will make sure to test the patch set is bisectable next time :)

Thanks,
Morten
