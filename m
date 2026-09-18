Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB4441F342;
	Fri, 18 Sep 2026 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755589; cv=none; b=coAzDzzvd3iH9w1kSnPaGk234MRVXmyYjxON0Rhujpf1tsnoZf7aaNA4zOJckIGX4zT9a3s/oel1Yzj30JQnSIJaKtuKm8PDildsB+l8ZGnRHTV+QWO5VPEgeKlvfQGBJh3KnaV4rxwEN//Ehit/iPg5RGMq39bSYMpu6YmrGpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755589; c=relaxed/simple;
	bh=XlsoKoyOZJJOlrj90Rg9bXIKOIoQo7u2V1+5XG4lemU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXXkaVrOhMTW80l96ahumbpuetooAl5grI0tKl3wp6XP8PzMCcu8RrKwxmGInNf86xQ1O4x3ptRijKYaNaWofJrjMsMSaTky6gceAoBnDqlqnTVzrM3JymIVnbO1CztDhdmdNRl94JCSAFNUfrZ4n6EmRqpNPXQ8fKGAmYMUl3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5IUZTk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5IUZTk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9901F000FF;
	Fri, 18 Sep 2026 18:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789755588;
	bh=E4x1orVy3zQ7AGPIczdDg64oCzP4Y9taMje2rrNyhqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5IUZTk7eWuZuU7sRjP3DJAKcrfsFmeK7mXWbo2pC79yioHpLSGf7naKFDEsZaTRm
	 oT5DENCTjvjI4FyuNoaz/ACNIdMt8CDggSHuyVRQS7pMwaRXn42EAUN1IB7O9dnIPM
	 GvdoFgz4Dmqk/eXb1A6PFfVPwCIk887vWIF/P45nujLIt9HQVx6vMPmZSQFZNGwWLf
	 WjB5/C+lejXh0RPAku5kIev11ykzlldcpUA+sz3hV4marWMlcUOdxPdFti5k6i57qu
	 I6VTqWvxm3QdAF5o+1ZtBwCLNHCEnitvrbrMEInaURomdhIdpVwEccpmC/DjAXUsbb
	 LKVoB4F8haTmg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jianyong Wu <wujianyong@hygon.cn>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ray.huang@amd.com" <ray.huang@amd.com>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
 "perry.yuan@amd.com" <perry.yuan@amd.com>,
 "zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>,
 "zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>,
 "pierre.gondois@arm.com" <pierre.gondois@arm.com>,
 "sumitg@nvidia.com" <sumitg@nvidia.com>,
 "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>,
 "hongyan.xia@transsion.com" <hongyan.xia@transsion.com>,
 "zhongqiu.han@oss.qualcomm.com" <zhongqiu.han@oss.qualcomm.com>,
 Fengyu Wang <wangfengyu@hygon.cn>, Yuan Zhong <zhongyuan@hygon.cn>,
 Huangsj <huangsj@hygon.cn>
Subject:
 Re: [PATCH] cpufreq: Use a non-boost reference frequency for pressure
 calculation
Date: Fri, 18 Sep 2026 20:19:37 +0200
Message-ID: <5135696.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <B5C2AA60-4A07-45B6-AF06-3C5810E19F8C@hygon.cn>
References:
 <20260915065747.1671965-1-wujianyong@hygon.cn>
 <CAJZ5v0g2d6fY8hM0FVH8tiOUhXm0PZM+Qn7OxM9YNXm8i0pYmg@mail.gmail.com>
 <B5C2AA60-4A07-45B6-AF06-3C5810E19F8C@hygon.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, September 18, 2026 6:08:49=E2=80=AFAM Central European Summer Ti=
me Jianyong Wu wrote:
> Hi Rafael,
>=20
> >=20
> > On Sep 18, 2026, at 01:38, Rafael J. Wysocki (Intel) <rafael@kernel.org=
> wrote:
> > On Tue, Sep 15, 2026 at 9:03=E2=80=AFAM Jianyong Wu <wujianyong@hygon.c=
n> wrote:
> >>=20
> >> Commit d2d5c129d07e ("cpufreq: Make cpufreq_update_pressure() fall
> >> back to cpuinfo.max_freq") introduced cpuinfo.max_freq as the reference
> >> frequency for cpufreq pressure when arch_scale_freq_ref() returns zero.
> >>=20
> >> However, cpuinfo.max_freq may include boost frequencies and therefore
> >> does not necessarily represent the maximum sustainable frequency.
> >=20
> > And then it really matters what is sustainable and for how long.
>=20
> I think it's confusing to say "sustainable freq" in cpufreq part. I mean =
the maximum
> cpu frequency below boost here. For acpi-cpufreq, it=E2=80=99s P0. For am=
d-pstate, it=E2=80=99s
> nominal frequency. But I can't find a better word.
>=20
> >=20
> >> On some systems using acpi-cpufreq, cpuinfo.max_freq includes boost wh=
ile
> >> the frequency table only contains non-boost frequencies.
> >=20
> > In which case selecting freq_table[0] may give the processor a license
> > to go to the turbo (or boost) frequency range.
>=20
> Yeah, selecting freq_table[0] may also mean cpu can go to boost frequency=
=2E=20
> But the value doesn't denote that. freq_table[0] is assigned  to policy->=
max which
> is compared with policy->cpuinfo.max_freq. The difference between them ma=
kes
> the cpu pressure which is not intended.
> =20
> >=20
> >> Consequently, cpufreq pressure remains nonzero even without an additio=
nal
> >> frequency limit.
> >=20
> > So when and where does this matter?
>=20
> I test it on amd, intel and hygon box. Once acpi-cpufreq is used, the une=
xpected
> cpu pressure appears when there is no cpu frequency capped and boost is e=
nabled.
>=20
> The wrong cpu pressure affects load balancing. For example, Cache aware
> scheduling wants to aggregate task in a LLC using 50% of the whole LLC ca=
pacity.
> Before commit d2d5c129d07e, everything is OK. But with that commit and us=
ing
> acpi-cpufreq and with boost on, cache aware scheduling can=E2=80=99t aggr=
egate
> task to occupy 50% of the LLC by default as the cpu capacity in the LLC i=
s reduced.=20

So actually the problem is that now the pressure is applied when it is not
expected to be applied in general.

Clearly, the scheduler assumes that the pressure will be zero when
arch_scale_freq_ref() is zero and the commit in question violates that
assumption.

This actually has a little to do with boost and making it depend on boost
doesn't really help.  In fact, the reason for making the change was some
inadequate behavior when intel_pstate ran with asym capacity, so something
like the patch below (completely untested) can be used to limit the scope
of it to the case in question.

Can you please check if it helps?

Ricardo, can you please test this one too?

Thanks!


=2D--
 drivers/cpufreq/cpufreq.c      |    4 ++--
 drivers/cpufreq/intel_pstate.c |   12 ++++++++++++
 include/linux/cpufreq.h        |    3 +++
 3 files changed, 17 insertions(+), 2 deletions(-)

=2D-- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2590,8 +2590,8 @@ static void cpufreq_update_pressure(stru
=20
 	cpu =3D cpumask_first(policy->related_cpus);
 	max_freq =3D arch_scale_freq_ref(cpu);
=2D	if (!max_freq)
=2D		max_freq =3D policy->cpuinfo.max_freq;
+	if (!max_freq && cpufreq_driver->scale_freq_ref)
+		max_freq =3D cpufreq_driver->scale_freq_ref(policy);
=20
 	capped_freq =3D policy->max;
=20
=2D-- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1135,6 +1135,16 @@ static bool hybrid_clear_max_perf_cpu(vo
 	return ret;
 }
=20
+static unsigned int intel_pstate_scale_freq_ref(struct cpufreq_policy *pol=
icy)
+{
+	struct cpudata *cpu =3D all_cpu_data[policy->cpu];
+
+	if (cpu && cpu->capacity_perf)
+		return policy->cpuinfo.max_freq;
+
+	return 0;
+}
+
 static void intel_pstate_update_freq_limits(struct cpudata *cpu)
 {
 	int scaling =3D cpu->pstate.scaling;
@@ -3088,6 +3098,7 @@ static struct cpufreq_driver intel_pstat
 	.offline	=3D intel_pstate_cpu_offline,
 	.online		=3D intel_pstate_cpu_online,
 	.update_limits	=3D intel_pstate_update_limits,
+	.scale_freq_ref =3D intel_pstate_scale_freq_ref,
 	.name		=3D "intel_pstate",
 };
=20
@@ -3411,6 +3422,7 @@ static struct cpufreq_driver intel_cpufr
 	.suspend	=3D intel_cpufreq_suspend,
 	.resume		=3D intel_pstate_resume,
 	.update_limits	=3D intel_pstate_update_limits,
+	.scale_freq_ref =3D intel_pstate_scale_freq_ref,
 	.name		=3D "intel_cpufreq",
 };
=20
=2D-- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -420,6 +420,9 @@ struct cpufreq_driver {
 	/* Will be called after the driver is fully initialized */
 	void		(*ready)(struct cpufreq_policy *policy);
=20
+	/* Return the capacity reference frequency for policy. */
+	unsigned int	(*scale_freq_ref)(struct cpufreq_policy *policy);
+
 	struct freq_attr **attr;
=20
 	/* platform specific boost support code */



