From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFCv4 PATCH 22/34] sched: Calculate energy consumption of
 sched_group
Date: Thu, 21 May 2015 13:27:04 +0530
Message-ID: <20150521075702.GA20008@linux.vnet.ibm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
 <1431459549-18343-23-git-send-email-morten.rasmussen@arm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:56088 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbbEUH5R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 May 2015 03:57:17 -0400
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
	Thu, 21 May 2015 13:27:14 +0530
Content-Disposition: inline
In-Reply-To: <1431459549-18343-23-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

* Morten Rasmussen <morten.rasmussen@arm.com> [2015-05-12 20:38:57]:

[...]
> +/*
> + * cpu_norm_usage() returns the cpu usage relative to a specific cap=
acity,
> + * i.e. it's busy ratio, in the range [0..SCHED_LOAD_SCALE] which is=
 useful for
> + * energy calculations. Using the scale-invariant usage returned by
> + * get_cpu_usage() and approximating scale-invariant usage by:
> + *
> + *   usage ~ (curr_freq/max_freq)*1024 * capacity_orig/1024 * runnin=
g_time/time
> + *
> + * the normalized usage can be found using the specific capacity.
> + *
> + *   capacity =3D capacity_orig * curr_freq/max_freq
> + *
> + *   norm_usage =3D running_time/time ~ usage/capacity
> + */
> +static unsigned long cpu_norm_usage(int cpu, unsigned long capacity)
> +{
> +	int usage =3D __get_cpu_usage(cpu);

__get_cpu_usage is introduced in next patch "sched: Extend sched_group_=
energy
to test load-balancing decisions", applying the series with this patch =
as top
most patch breaks the build.

kernel/sched/fair.c: In function =E2=80=98cpu_norm_usage=E2=80=99:
kernel/sched/fair.c:4830:2: error: implicit declaration of function =E2=
=80=98__get_cpu_usage=E2=80=99 [-Werror=3Dimplicit-function-declaration=
]
  int usage =3D __get_cpu_usage(cpu);
  ^

Given that __get_cpu_usage(), take additional parameter - delta. get_cp=
u_usage()
should have been used here.

Thanks,
Kamalesh

