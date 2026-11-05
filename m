Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881324;
	b=1uUzuZrwpG//R0UkvciyTGVDLKDtlSDp2eDiI/6JuD4SRG9ou+bLm5Sf5lZQQ4rs7dYJ
	 RQqXkYNO2EZRstdp0DbzCA6E5zFa9DMqN19N1VJiPwK2yOc/wt2Me0jncKeP6hG0PH3ed
	 84rjyBXIF9aYHZnDWvyAPgBgyW7lw5MJMThfOEmDEEdcPSoPdTpihn1bv1kDfZWxlHoFn
	 8GkaRls6ZKjRPRSm4um8EcgnnJi8JipRPYzTFqIyP3YPEHucP1vEYejdevU4aBv61mVfT
	 G9njmxsfv5nmw2iJ4/JfTbb3ErSRvKLIp9Dde0Z0PfXp1KfqljjmFLtsnxZCzUG91TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881324;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ijJ2iToW1vV9ZzguubAIBwNUbZXaAj9CKriPNkowt/E=;
	b=KWY288yfAGqIwetNRCaP2fd60sk7LRBzEW6Jse+Iiv8KzKZftPZoAwCSyptGxsT/nP2k
	 F9ZVj9gsGagzCb2Las+iJbszeeWjoJ7un8golLKRFN4Y8yLS6qUlT5ReZALu0dInkctUE
	 Co/H5a9CQEaOArUYc9Aviwk99zc7z6fx5Vn3mm1Qj86BFcrkDqx4TD/7PeSHkKxnO0rwM
	 aycqbuJ2ENeWFcxrjFk956dv9RmqFy26Ggl0xEidCkN+BmPYEhcoBHnrECRYQqX+H8Wus
	 0HOD8B55RR9pibd1+JRrNkKSKHAoDSWkJeA/G7AOHVmm4ytqwz78gmHV2LscIhoAUoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXjPwgPy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA2606A335
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RXjPwgPy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706EF1F00A20
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 12:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881323;
	bh=ijJ2iToW1vV9ZzguubAIBwNUbZXaAj9CKriPNkowt/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RXjPwgPyrp7SAvVpXG443pqp/sNrLtao2GijuVfbEp6ck0hUMSRpXDYsZC9lwi2ur
	 XGCqk2+D3tRN+YuFfKy8vfHukZj/lhF0gXbEC2qWUSxtUbVZpuaFEP/t1LO/CFugvG
	 RWqrqFdrkrbF16vqtn1FrwjNez2oA1C0FYIVoA5BvHgxJUQQs4Y1KmXkYv7kitzKId
	 bOZAHjSEQttjBYzZf45PCJ4dyaQc4nctHCvY7V/4yUGQfdmNbjG9aqTsc1L8cQ8gug
	 rqhGD64bHEqYv9wFhRBv7+h4Ek7eCeis/AfBq3aPDpAd76cRdJLsozvs2Ufb2lkR+u
	 s6IsvSU1TOQNg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be53e5fce1so1480869e87.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 04:22:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx97eAV9WIHWczABnu2rAS/lV2JvEj5w2vUyvO1tV9n1TkdrX0UYDD6hEZIR6/hn6rNkQhi5WQc2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/FG8I7CcAvcsL/Z5/ZK1E0HQgcWSgw8YOyWq+4JqtZWfUuMUEm
	ey9Fufl52YCkThDFVpNKEypsrBJkR0w0viCL7MrrJphFZPEWCvK7lo8MVwkArdo0w9jSYvhDIQz
	v8Bfzl9+fA8zIsEt07f59snK4goANKf4=
X-Received: by 2002:a05:6512:3986:b0:5bb:27df:414c with SMTP id
 2adb3069b0e04-5bfd9574e22mr6049721e87.45.1793881321795; Thu, 05 Nov 2026
 04:22:01 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022075901.3436021-1-zhangpengjie2@huawei.com>
 <d9fa8052-f562-4867-9e9f-1fd2a66fa794@arm.com> <940a9a70-71fb-491d-a1a7-1a7b4d6dc089@huawei.com>
 <f688c3fc-1375-4803-9775-9b4da78536c9@arm.com> <02dd34f0-c9fb-4dc5-bc1d-af83ae080724@huawei.com>
In-Reply-To: <02dd34f0-c9fb-4dc5-bc1d-af83ae080724@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 5 Nov 2026 13:21:47 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j1YpOu9SnjAF4VFVOVFEr6bLzRWaqCJ3jmFP4-01s1LQ@mail.gmail.com>
X-Gm-Features: AclHuK9oMZfBryf9lbbu8I5G5dZsnK6LN0Tjd2Rx7NfvoiDwhphAy4g9-_ebdcU
Message-ID: <CAJZ5v0j1YpOu9SnjAF4VFVOVFEr6bLzRWaqCJ3jmFP4-01s1LQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: CPPC: Enable boost by default when supported
To: Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org, viresh.kumar@linaro.org, 
	linuxarm@huawei.com, zhanjie9@hisilicon.com, prime.zeng@hisilicon.com, 
	wanghuiqiang@huawei.com, xuwei5@huawei.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, pierre.gondois@arm.com, sumitg@nvidia.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mojunjun4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 8:04=E2=80=AFAM Pengjie Zhang <zhangpengjie2@huawei.=
com> wrote:
>
>
> On 11/5/2026 12:12 AM, Christian Loehle wrote:
> > On 11/4/26 07:43, Pengjie Zhang wrote:
> >> On 10/29/2026 4:51 AM, Christian Loehle wrote:
> >>> On 10/22/26 08:59, Pengjie Zhang wrote:
> >>>> The CPPC driver leaves boost disabled by default when Highest Perfor=
mance
> >>>> exceeds Nominal Performance. Userspace must explicitly enable boost
> >>>> before governors can use the full advertised performance range.
> >>>>
> >>>> Enable boost by default when at least one possible CPU reports suppo=
rt,
> >>>> while users who prefer to stay within the sustained nominal limit ca=
n
> >>>> still disable it via the boost knob without determining scaling_max_=
freq
> >>>> for each policy.
> >>>>
> >>>> Check the performance capabilities before registering the driver so =
that
> >>>> the cpufreq core enables boost for each policy that supports it.
> >>>>
> >>>> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> >>> Just to be clear I'm not blocking this per se, but continuing my comm=
ents:
> >>>
> >>> I just wonder if this is a configuration worth keeping.
> >>> You mentioned your platforms have a BIOS to set nominal=3D=3Dhighest =
or not.
> >>> If we removed interpreting highest - nominal as boost entirely that
> >>> would also make that BIOS setting obsolete. Userspace could still
> >>> query nominal and restrict cpufreq to that if it wishes to do that,
> >>> we could add that to cpupower for convenience (i.e. set all policies'
> >>> max to nominal).
> >>>
> >>> With the changes that are coming with CPCv4 we would save ourselves
> >>> some headache (like keeping track of boost status when ospm_nominal_p=
erf
> >>> is being written).
> >>>
> >>> The question is also how often the combination of "enable nominal < h=
ighest"
> >>> and then explicitly toggling boost at runtime actually happens...
> >>>
> >>>> ---
> >>>> Changes in v2:
> >>>> - Drop "even" and clarify the commit message (Christian).
> >>>> - Link to v1: https://lore.kernel.org/all/20261015015812.867988-1-zh=
angpengjie2@huawei.com/
> >>>>
> >>>>    drivers/cpufreq/cppc_cpufreq.c | 20 ++++++++++++++++++++
> >>>>    1 file changed, 20 insertions(+)
> >>>>
> >>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_c=
pufreq.c
> >>>> index 80893844353c..0a4255a36f60 100644
> >>>> --- a/drivers/cpufreq/cppc_cpufreq.c
> >>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
> >>>> @@ -1052,6 +1052,25 @@ static struct cpufreq_driver cppc_cpufreq_dri=
ver =3D {
> >>>>        .name =3D "cppc_cpufreq",
> >>>>    };
> >>>>    +static void __init cppc_cpufreq_default_boost_init(void)
> >>>> +{
> >>>> +    struct cppc_perf_caps caps;
> >>>> +    bool enable =3D false;
> >>>> +    int cpu;
> >>>> +
> >>>> +    for_each_possible_cpu(cpu) {
> >>>> +        if (cppc_get_perf_caps(cpu, &caps))
> >>>> +            continue;
> >>>> +
> >>>> +        if (caps.highest_perf > caps.nominal_perf) {
> >>>> +            enable =3D true;
> >>>> +            break;
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    cppc_cpufreq_driver.boost_enabled =3D enable;
> >>> Any reason for the scan instead of just setting
> >>> boost_enabled =3D true? Platforms without boost would
> >>> also expose the toggle, but that's mostly in line with
> >>> the other drivers? (also again the ospm_nominal_perf
> >>> angle)
> >> The reason for scanning here is to keep the initial sysfs state
> >> consistent on platforms where highest_perf =3D=3D nominal_perf on all =
CPUs
> >> (i.e. policy->boost_supported is false everywhere). If we just set
> >> boost_enabled =3D true unconditionally, the global cpufreq/boost file =
will
> >> read 1 on boot while every policyX/boost reads 0 (and rejects writes
> >> with -EINVAL).
> > FWIW, amd-pstate can already expose global boost=3D1 while all per-poli=
cy
> > boost knobs read 0 and writes to either knob then fail with -EINVAL AFA=
ICS?
> >
> > AFAIU the global sysfs knob represents permission to boost where
> > supported, rather than meaning boost is supported, too?
>
> Yes, Documentation/admin-guide/pm/cpufreq.rst also states that 1 in the
> global boost file "only means a permission to use the frequency boost
> mechanism (which still may never be used for other reasons)", while 0
> means it "is disabled and cannot be used at all".
>
> > PS:
> > Also another fun one I discovered...
> > power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost
> > 0
> > power-orion-o6-01# echo 1 > /sys/devices/system/cpu/cpufreq/boost
> > echo: write error: invalid argument
> > power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost
> > 0
> > power-orion-o6-01# echo 0 > /sys/devices/system/cpu/cpufreq/boost
> > echo: write error: invalid argument
> > power-orion-o6-01# cat /sys/devices/system/cpu/cpufreq/boost
> > 1
> >
> > I'll go and fix that...
> >
> >> Also, since ospm_nominal_perf has a valid range of [lowest_perf,
> >> nominal_perf], it actually pairs quite well with the boost knob: on
> >> platforms with highest_perf > nominal_perf, ospm_nominal_perf will
> >> always stay below highest_perf, and even on platforms with
> >> nominal_perf =3D=3D highest_perf, lowering ospm_nominal_perf could
> >> dynamically define a nominal ceiling for when boost is disabled.
> > I don't think I agree with the latter. OSPM nominal has its own (platfo=
rm)
> > semantics, but making boost=3D0 impose that value as a frequency ceilin=
g
> > is just another way of setting scaling_max_freq.
> > I don't see why these two need to be coupled?
> >
> > Also I think the fact that caps.highest_perf =3D=3D caps.nominal_perf
> > but ospm_nominal_perf can change boost supported later is a reason
> > against the boot-time scan? (which would need to exclude
> > ospm_nominal_perf platforms?)
>
> Fair enough, ospm_nominal_perf doesn't need to be coupled with boost.
>
> Viresh, Rafael, any preference here? Should we keep the boot-time check
> in v2 (so global boost stays 0 on platforms without boost support), or
> drop the scan and just set .boost_enabled =3D true statically in
> cppc_cpufreq_driver?

I have no specific opinions regarding boost support other than it's
better be made consistent across all drivers and the core.
