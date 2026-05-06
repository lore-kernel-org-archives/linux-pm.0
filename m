Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F2303CAE;
	Wed,  6 May 2026 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099909; cv=none; b=uEjSEcJKTiik59Taze6Z9I+7hxTMFQX/tbFdB+IuBGO7G+zWaeoSnlUTnubdYZj69lXt3wEihtA3ejtIE9v3Wl6Q2fcIX0dHb9sqqm7RyuqOA5+aoSZAweCojmtDUwQiDTg7ilgtS9qBWZ3S6bufLhH5mUbKijQCqymbI3FkBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099909; c=relaxed/simple;
	bh=r34X7Ex/GFpG7t8oyVeqrOZHrFTZOJeSz3aQocCj4v8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=piD18zMfyQ0Y6PWREs7+ktl72se28gEH6i1kWjo0DyT1v+PgmkG/QmRV+qwHtRgfXP6P0s9j3oM0ZILhYjoTgMt9Dkx2Tt2SDNZZ51SzXb93Sf46FeIkhO3XuqRZv5HHvmlKQPagOjtP+fE6BxIWh/jTHR2X/wLpuwMcFB9qYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neQzuJ+O; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neQzuJ+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778099908; x=1809635908;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=r34X7Ex/GFpG7t8oyVeqrOZHrFTZOJeSz3aQocCj4v8=;
  b=neQzuJ+OnRbQ+wfv6+KARHE2kZ/QjvkpCxbcsbROCUBI98Ar7tJCozr2
   GmLtqr5cmLApVnfEBrU+oj7yJs3bqQueoq6wu5YCJ2vBnD9tizQSZE8Mi
   ZEbZZhxcwyTLAV9uc7kkj9TbQsCC9Ybk0NtLZweB2HXdjYN2liM4kbjvh
   WPX7OyVEG6X+NMS/Ysa0Cl8aLwJjK8M12fZvpKX31g4I0zMRWg9RPhdPU
   5yUA67ZT0WH40Fi407CC0nN1HIo7ZyjJTid9L+2P4MCwlJOwStkxGpJ18
   1I6vZJEeErNlzkVXrogvap+iQqBZG/ql2sC3wpETVYSV/DQgwS01IQPk7
   w==;
X-CSE-ConnectionGUID: i03nI5F2Q2+mvvM7UMj/Ug==
X-CSE-MsgGUID: LZiYxLdmTiSGWYjYSnAkTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78935450"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78935450"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 13:38:27 -0700
X-CSE-ConnectionGUID: TgObTluZRgyHVPnPW0lHlQ==
X-CSE-MsgGUID: yaMljfQdSS2b4fGYV2RJNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="240580332"
Received: from unknown (HELO [10.241.243.39]) ([10.241.243.39])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 13:38:27 -0700
Message-ID: <2b9fd875df1f71d2c12c21938784a6c1fd38c04a.camel@linux.intel.com>
Subject: Re: [PATCH v2 RFC 08/13] sched/qos: Add a new sched-qos interface
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>,  John Stultz <jstultz@google.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, "Chen, Yu C"	 <yu.c.chen@intel.com>, Thomas
 Gleixner <tglx@kernel.org>, 	linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Date: Wed, 06 May 2026 13:38:26 -0700
In-Reply-To: <20260504020003.71306-9-qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io>
	 <20260504020003.71306-9-qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-05-04 at 02:59 +0100, Qais Yousef wrote:
> Provide a generic and extensible interface to describe arbitrary QoS
> tags to tell the kernel about specific behavior that is doesn't fall
> into the existing sched_attr.
>=20
> The interface is broken into three parts:
>=20
> * Type
> * Value
> * Cookie
>=20
> Type is an enum that should be give us enough space to extend (and
> deprecate) comfortably.
>=20
> Value is a signed 64bit number to allow for arbitrary high values.
>=20
> Cookie is to help group tasks selectively so that some QoS might want to
> operate on tasks per groups. A value of 0 indicates system wide.
>=20
> There are two anticipated users being discussed on the list.
>=20
> 1. Per task rampup multiplier to allow controlling how fast util rises,
>    and by implication it can migrate between cores on HMP systems and
>    cause freqs to rise with schedutil.
>=20
> 2. Tag a group of task that are memory dependent for Cache Aware
>    Scheduling.
>=20
> The interface is anticipated to be provisioned to apps via utilities and
> libraries. schedqos [1] is an example how such interface can be used to
> provide higher level QoS abstraction to describe workloads without
> baking it into the binaries, and by implication without worrying about
> potential abuse. The interface requires privileged access since QoS is
> considered scarce resource and requires admin control to ensure it is
> set properly. Again that admin control is anticipated to be the schedqos
> utility service.
>=20
> QoS is treated as a scarce resource and the intention is for the
> a syscall to be done for each individual QoS tag. QoS tags are not
> inherited on fork by default too for the same reason.
>=20
> A reasonable point of debate is whether to make the sched_qos an array
> of 3 or 5 value to avoid potential bottleneck if this grows large and
> users do end up hitting a bottleneck of having to issue too many
> syscalls to set all QoS. Being limited as it is now helps enforce
> intentionality and scarcity of tagging.
>=20
> [1] https://github.com/qais-yousef/schedqos
>=20
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  Documentation/scheduler/index.rst             |  1 +
>  Documentation/scheduler/sched-qos.rst         | 44 ++++++++++++++++++
>  include/uapi/linux/sched.h                    |  4 ++
>  include/uapi/linux/sched/types.h              | 46 +++++++++++++++++++
>  kernel/sched/syscalls.c                       | 10 ++++
>  .../trace/beauty/include/uapi/linux/sched.h   |  4 ++
>  6 files changed, 109 insertions(+)
>  create mode 100644 Documentation/scheduler/sched-qos.rst
>=20
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/=
index.rst
> index 17ce8d76befc..6652f18e553b 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -23,5 +23,6 @@ Scheduler
>      sched-stats
>      sched-ext
>      sched-debug
> +    sched-qos
> =20
>      text_files
> diff --git a/Documentation/scheduler/sched-qos.rst b/Documentation/schedu=
ler/sched-qos.rst
> new file mode 100644
> index 000000000000..0911261cb124
> --- /dev/null
> +++ b/Documentation/scheduler/sched-qos.rst
> @@ -0,0 +1,44 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Scheduler QoS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +1. Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Different workloads have different scheduling requirements to operate
> +optimally. The same applies to tasks within the same workload.
> +
> +To enable smarter usage of system resources and to cater for the conflic=
ting
> +demands of various tasks, Scheduler QoS provides a mechanism to provide =
more
> +information about those demands so that scheduler can do best-effort to
> +honour them.
> +
> +  @sched_qos_type	what QoS hint to apply
> +  @sched_qos_value	value of the QoS hint
> +  @sched_qos_cookie	magic cookie to tag a group of tasks for which the Q=
oS
> +			applies. If 0, the hint will apply globally system
> +			wide. If not 0, the hint will be relative to tasks that
> +			has the same cookie value only.

Qais,

Thanks for your proposal. I have some follow up thoughts.

How can we query all the tasks that use a cookie?
A scenario I can think of is there may be two group of tasks, and we may
want to merge the two group of tasks into one when they start sharing
data in the context of cache aware scheduling.  In that case, we
need to get all the tasks under the second cookie and change them to
that of the first.  We may need to link together tasks sharing a cookie.

We probably need a sched_qos_cookie structure defined analogous to
the sched_core_cookie to anchor the tasks.  And sched_qos_cookie could be a=
 ptr value
to sched_qos_cookie, as in sched_core_cookie instead of it being a __u32
as in the patch below.

Tim

> +
> +QoS hints are set once and not inherited by children by design. The
> +rationale is that each task has its individual characteristics and it is
> +encouraged to describe each of these separately. Also since system resou=
rces
> +are finite, there's a limit to what can be done to honour these requests
> +before reaching a tipping point where there are too many requests for
> +a particular QoS that is impossible to service for all of them at once a=
nd
> +some will start to lose out. For example if 10 tasks require better wake
> +up latencies on a 4 CPUs SMP system, then if they all wake up at once, o=
nly
> +4 can perceive the hint honoured and the rest will have to wait. Inherit=
ance
> +can lead these 10 to become a 100 or a 1000 more easily, and then the Qo=
S
> +hint will lose its meaning and effectiveness rapidly. The chances of 10
> +tasks waking up at the same time is lower than a 100 and lower than a 10=
00.
> +
> +To set multiple QoS hints, a syscall is required for each. This is a
> +trade-off to reduce the churn on extending the interface as the hope for
> +this to evolve as workloads and hardware get more sophisticated and the
> +need for extension will arise; and when this happen the task should be
> +simpler to add the kernel extension and allow userspace to use readily b=
y
> +setting the newly added flag without having to update the whole of
> +sched_attr.
> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> index 52b69ce89368..3cdba44bc1cb 100644
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -102,6 +102,9 @@ struct clone_args {
>  	__aligned_u64 set_tid_size;
>  	__aligned_u64 cgroup;
>  };
> +
> +enum sched_qos_type {
> +};
>  #endif
> =20
>  #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
> @@ -133,6 +136,7 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +#define SCHED_FLAG_QOS			0x80
> =20
>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>  				 SCHED_FLAG_KEEP_PARAMS)
> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/=
types.h
> index bf6e9ae031c1..b65da4938f43 100644
> --- a/include/uapi/linux/sched/types.h
> +++ b/include/uapi/linux/sched/types.h
> @@ -94,6 +94,48 @@
>   * scheduled on a CPU with no more capacity than the specified value.
>   *
>   * A task utilization boundary can be reset by setting the attribute to =
-1.
> + *
> + * Scheduler QoS
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + *
> + * Different workloads have different scheduling requirements to operate
> + * optimally. The same applies to tasks within the same workload.
> + *
> + * To enable smarter usage of system resources and to cater for the conf=
licting
> + * demands of various tasks, Scheduler QoS provides a mechanism to provi=
de more
> + * information about those demands so that scheduler can do best-effort =
to
> + * honour them.
> + *
> + *  @sched_qos_type	what QoS hint to apply
> + *  @sched_qos_value	value of the QoS hint
> + *  @sched_qos_cookie	magic cookie to tag a group of tasks for which the=
 QoS
> + *			applies. If 0, the hint will apply globally system
> + *			wide. If not 0, the hint will be relative to tasks that
> + *			has the same cookie value only.
> + *
> + * QoS hints are set once and not inherited by children by design. The
> + * rationale is that each task has its individual characteristics and it=
 is
> + * encouraged to describe each of these separately. Also since system re=
sources
> + * are finite, there's a limit to what can be done to honour these reque=
sts
> + * before reaching a tipping point where there are too many requests for
> + * a particular QoS that is impossible to service for all of them at onc=
e and
> + * some will start to lose out. For example if 10 tasks require better w=
ake
> + * up latencies on a 4 CPUs SMP system, then if they all wake up at once=
, only
> + * 4 can perceive the hint honoured and the rest will have to wait. Inhe=
ritance
> + * can lead these 10 to become a 100 or a 1000 more easily, and then the=
 QoS
> + * hint will lose its meaning and effectiveness rapidly. The chances of =
10
> + * tasks waking up at the same time is lower than a 100 and lower than a=
 1000.
> + *
> + * To set multiple QoS hints, a syscall is required for each. This is a
> + * trade-off to reduce the churn on extending the interface as the hope =
for
> + * this to evolve as workloads and hardware get more sophisticated and t=
he
> + * need for extension will arise; and when this happen the task should b=
e
> + * simpler to add the kernel extension and allow userspace to use readil=
y by
> + * setting the newly added flag without having to update the whole of
> + * sched_attr.
> + *
> + * Details about the available QoS hints can be found in:
> + * Documentation/scheduler/sched-qos.rst
>   */
>  struct sched_attr {
>  	__u32 size;
> @@ -116,6 +158,10 @@ struct sched_attr {
>  	__u32 sched_util_min;
>  	__u32 sched_util_max;
> =20
> +	__u32 sched_qos_type;
> +	__s64 sched_qos_value;
> +	__u32 sched_qos_cookie;
> +
>  };
> =20
>  #endif /* _UAPI_LINUX_SCHED_TYPES_H */
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index b215b0ead9a6..88feedd2f7c9 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -481,6 +481,13 @@ static int user_check_sched_setscheduler(struct task=
_struct *p,
>  	if (p->sched_reset_on_fork && !reset_on_fork)
>  		goto req_priv;
> =20
> +	/*
> +	 * Normal users can't set QoS on their own, must go via admin
> +	 * controlled service
> +	 */
> +	if (attr->sched_flags & SCHED_FLAG_QOS)
> +		goto req_priv;
> +
>  	return 0;
> =20
>  req_priv:
> @@ -552,6 +559,9 @@ int __sched_setscheduler(struct task_struct *p,
>  			return retval;
>  	}
> =20
> +	if (attr->sched_flags & SCHED_FLAG_QOS)
> +		return -EOPNOTSUPP;
> +
>  	/*
>  	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
>  	 * information.
> diff --git a/tools/perf/trace/beauty/include/uapi/linux/sched.h b/tools/p=
erf/trace/beauty/include/uapi/linux/sched.h
> index 359a14cc76a4..4ff525928430 100644
> --- a/tools/perf/trace/beauty/include/uapi/linux/sched.h
> +++ b/tools/perf/trace/beauty/include/uapi/linux/sched.h
> @@ -102,6 +102,9 @@ struct clone_args {
>  	__aligned_u64 set_tid_size;
>  	__aligned_u64 cgroup;
>  };
> +
> +enum sched_qos_type {
> +};
>  #endif
> =20
>  #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
> @@ -133,6 +136,7 @@ struct clone_args {
>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
> +#define SCHED_FLAG_QOS			0x80
> =20
>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>  				 SCHED_FLAG_KEEP_PARAMS)
