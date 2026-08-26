Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08053CEBB8
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740109; cv=none; b=uD7OMoP+g6aRyHTdg5GQ0hKgsZlI/If7rVvtMeImZ2k7cMbc9pplmPxUqX9PBIWsualnG/m8I6bXmLpcWhxl16oyMET5xxfCEZIaQLfB0h0mWqIHzMXUbbSUVDKNoARkH1/0dpVCkXFHhNywPuvSD4EgLqH9mrO8y+TjCMoD5ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740109; c=relaxed/simple;
	bh=wL5hc3LpyT3SWMGIxNFjPrz1dCnPAqt0M9tE+ySsTFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KLrElSibzG2g8WMZruHF0D+FeQjy15MAAy5uaMTe7nxh8IjyD8Y6gYKZ8wQINY2OiFRjSQZi3hLX5xxki6QP9poObi8m3Im3PqTuarUokOCWYqOl2nZpGETBJFWVTdKdo+yzj58BU26k8agSZ2wrjimrN+TxWKg0Pf9AAcXh5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez6/Kr+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez6/Kr+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F201F0155A
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787740107;
	bh=t4LB0ynimvmu7IDX+F7ZHjm0CNIAuGM932GF2KntDbE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ez6/Kr+qZR/Ocy5aSFcPdPsbdH/0FP89fskhHThhM3BBpbHCZ9VsGp+8htG2sqwnX
	 pjNgnTzO5YudXR4vHeNTNdmYk7TMMHqvT77BL1vQ8Z2MqY5JOi05ZnBhVAroVau/hz
	 uyFPrvbRv56IXSx/ZQLJFWzlfyUkpHXrlYPRsZX4UozW39+2EysSf/uzgapvAjubX8
	 e27Fp4rRs6ufE38jwSK4TwijNGufi6jsz2Jlxg1u5GcQmHTUZJWnZam9JK1y/Cq1Pa
	 ivEn6k2Gb4xZi+YgiKxKLZYTNjc3ZCPktWX63NLytrp2f0PWl0RIE6solC5O9EWuYy
	 Fie+3QpVFJzzw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso6974351fa.3
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 03:28:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq8oX6VpWlQXaDKdw0L7rJqq6PvldNBEoEdlx5tKuThRPY0iSOMrGD50L3QlRYaXA5ScJtIh3Bo9Q==@vger.kernel.org
X-Gm-Message-State: AFuF++nF1JQJbQP0c9jVLLwiZAxCrKLTNtq6PPL8VmhYobEP7SY12fOT
	oqdRR4+7G6i2MfiXWJU6GlLrC4Ns1guF4GUxPbvQ5kTh4525b01Rnmyr/cFC0B/scmUH2mWER4S
	/b5AflCVvdOlCfhHGmZe1y+86roSzfzo=
X-Received: by 2002:a05:651c:1443:b0:3a2:522:c75 with SMTP id
 38308e7fff4ca-3a205221193mr5570921fa.4.1787740105816; Wed, 26 Aug 2026
 03:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806200857.601152-1-sumitg@nvidia.com> <46d81167-1548-4b6a-b6cc-38542b2d093e@nvidia.com>
 <146a49c4-5b2a-41db-90fd-6dd2028d2d53@arm.com>
In-Reply-To: <146a49c4-5b2a-41db-90fd-6dd2028d2d53@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 26 Aug 2026 12:27:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hMRNTZbhb1tR7rf5+65Oes-7K__b1dLg5kGkm7NqKvWw@mail.gmail.com>
X-Gm-Features: AcwNN1Vq8ojxPy8S0E7lgKbAolH28ywilxtnQLjWXsCL5FdsGTBnAjbB9hFBo08
Message-ID: <CAJZ5v0hMRNTZbhb1tR7rf5+65Oes-7K__b1dLg5kGkm7NqKvWw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Christian Loehle <christian.loehle@arm.com>, Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com, 
	zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, saket.dumbre@intel.com, 
	ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org, treding@nvidia.com, 
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com, 
	sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:07=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/25/26 22:20, Sumit Gupta wrote:
> >
> > On 07/08/26 01:38, Sumit Gupta wrote:
> >> This series keeps the CPPC cpufreq policy alive across CPU hotplug and
> >> preserves the OSPM-set CPPC registers (Energy Performance Preference,
> >> Autonomous Activity Window, Autonomous Selection - set via sysfs).
> >>
> >> Without online()/offline() callbacks, the core tears a policy down whe=
n
> >> its last CPU goes offline and rebuilds it on the way back, re-reading =
the
> >> CPPC capabilities each time. The values written to these registers can
> >> be lost:
> >>
> >>   - Across CPU hotplug or suspend/resume: the platform may reset them
> >>     while the CPU is offline.
> >>   - On driver unload: the driver-written value is left in the register
> >>     instead of returning to its pre-driver state.
> >>
> >> Handle these with:
> >>
> >>   - Patch 1: adds online()/offline() callbacks so the core keeps polic=
y
> >>     alive across CPU hotplug instead of tearing it down and rebuilding=
 it.
> >>   - Patch 2: makes the autonomous selection register helpers take a u6=
4.
> >>   - Patch 3: adds a table-driven mechanism that captures each register=
's
> >>     firmware value at init(), restores it from offline(), and reapplie=
s
> >>     the OSPM-set value from online().
> >>   - Patch 4: extends the same save/restore to system suspend/resume.
> >
> > Gentle reminder.
> > Could this be considered for queuing if nothing further needs addressin=
g.
>
> FWIW both sashiko findings look legit to me, the feedback counters one I
> wouldn't consider that drastic, given that these counters are expected to
> have 'fuzzy' readings anyhow, the second one is worse (losing sysfs setti=
ngs
> on cpu_online())

I agree.

Besides, as I said elsewhere, I want this series to go in before any
other pending changes related to CPPC:

https://lore.kernel.org/linux-acpi/20260826063019.670240-1-christian.loehle=
@arm.com/

and I really would like to get some tags on it before it goes in.  It
clearly is not ready for 7.3, but it may be applicable early for 7.4
if people care to respond to it.

Thanks!
