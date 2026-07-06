Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDBD3BE659
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362910; cv=none; b=pibFcjmHqa0xp5TyVnpRZ9AMpvUP/i6pBGv1r9HGi3+QtqjXedziO1SkIt7m9qbIucwzLz1exrRv4S29BbAhgRz83Ly3Xab6GUb/MApXcYciQjm/3aFHPuDMRpo+hNGJigxigG+dUEGVvC2TKI9PuzGi6zuSpLUkpMqmwAm4SOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362910; c=relaxed/simple;
	bh=2yUvsF4irByxZ9iCrQ5ZXpAQBGcY6LWmlWcUnVOYi7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3LQxSLnr4Qg/K8hzAulneAe9hpdxn/MU3/s5RsFVwAtffNCsG4QUhh1Pqnqq0dnocwLzw7I1VxylI2EjFr5nHqTmRx83Sao3dZOEoEAzolT5IDKdlEuiaoXaLHIG9MQ/4bon2deOtu6pSw7JlZispgryqm0V87ZsX3ehX7OOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTPa2+Tz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTPa2+Tz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87091F00A3D
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 18:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783362908;
	bh=+7nysLIuHvoIobBHO8Sz9i93yCzFcL14Na0iQTAeT18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RTPa2+TzlRYpD3oHY0N03iQjSarqngBQgjiwrk3zXRGxnCvhqe3cOwM5YQhCFwFY+
	 x5WH0Y1jY29c5raHRuM/eQUzwwMedzrqArck5jbSXBzE91ilXp5Yaf/CT2wCzD3UvE
	 5KFmc7UgZk8zC6461gkRbZLrf9BzstmX9sOPk+h7XwIOPxMCBMd/QyO0dAhWSrwY5p
	 8GdZl8f/EshMdEtIOb7cV0YOyY8cwVJXBGklwRY5D3ugg4FtA7Y4M1aHim9whFyHLe
	 e0t86EWqfjvFO0+/emJvittZ2AhDjm8ZwOz2bFayjCptEi/WL+uz0BSUoh9aReDXNO
	 vZOK0TNjBd9Kg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aeb2bc82ccso3160556e87.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 11:35:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpjkZjTED1DJve5zbmYEPS2SeIvYNrh7mNIXNDnHekFJvUNtWbo4dveQomhFSNbe5X0lA4KP77+5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ho+S68Y408uWZDt4mCpfRZBBeyOPYg+3GY1jci2YpS0zCdMO
	8WRlsvj3QvbypBsjFQF5DWyvGumzBfyH8aCY/Xh9qPQLbafZQEENe0cX3KA0rIg1gOOk6HmhBe5
	OZkq/csMGEigpdvvtV18OyuZWgJv/ZvE=
X-Received: by 2002:ac2:5209:0:b0:5ae:b97b:f75a with SMTP id
 2adb3069b0e04-5b007be084cmr265254e87.55.1783362907119; Mon, 06 Jul 2026
 11:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623095403.3407436-1-sumitg@nvidia.com> <CAJZ5v0jvkNfx-1XChRCsGHJAcY7W4j41P+Xug6+TpPge7tHF7Q@mail.gmail.com>
 <de03b23f-18a3-4e99-a15a-5044463ac484@nvidia.com> <CAJZ5v0h+Fhj8+xLC=TAqx43+tQCPDUj-eP9YMW=BwKzn8CPUDw@mail.gmail.com>
 <15def9ce-abbd-4ef5-bb8f-0c55b42a0181@arm.com>
In-Reply-To: <15def9ce-abbd-4ef5-bb8f-0c55b42a0181@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 20:34:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jB4kpsZn+JxhwoEviagvM7THFsWb7gQ7HnvYaOwm9-gA@mail.gmail.com>
X-Gm-Features: AVVi8CfwM4SBqR6JMl6s5K1lXrk-FioMoVxAITpKkXfASLI7v7Cnj98mMjYfusM
Message-ID: <CAJZ5v0jB4kpsZn+JxhwoEviagvM7THFsWb7gQ7HnvYaOwm9-gA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug
 and unload
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sumit Gupta <sumitg@nvidia.com>, viresh.kumar@linaro.org, 
	ionela.voinescu@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 6:25=E2=80=AFPM Pierre Gondois <pierre.gondois@arm.c=
om> wrote:
>
> Hello Rafael, Sumit,
>
> On 6/24/26 15:20, Rafael J. Wysocki wrote:
> > On Wed, Jun 24, 2026 at 2:56=E2=80=AFPM Sumit Gupta<sumitg@nvidia.com> =
wrote:
> >> Hi Rafael,
> >>
> >>
> >> On 23/06/26 16:30, Rafael J. Wysocki wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> On Tue, Jun 23, 2026 at 11:54=E2=80=AFAM Sumit Gupta<sumitg@nvidia.co=
m> wrote:
> >>>> Values written to OSPM-set CPPC registers (via sysfs or the autonomo=
us
> >>>> boot parameter) can be lost in two ways:
> >>>>
> >>>>     - Across CPU hotplug: the platform may reset a CPU's registers w=
hen it
> >>>>       is offlined.
> >>>>     - On driver unload: the value the driver wrote is left in the re=
gister
> >>>>       instead of returning to its pre-driver state.
> >>>>
> >>>> Add a small table-driven mechanism that handles both:
> >>>>
> >>>>     - Capture each register's firmware value when a CPU is first see=
n and
> >>>>       restore it on driver unload.
> >>>>     - Record the last value the driver set and reapply it from ->ini=
t()
> >>>>       when the policy is reactivated after CPU hotplug.
> >>> I'm not sure if this is a good idea TBH.
> >>>
> >>> The overall system state when the CPU goes online may be completely
> >>> different from the system state when the CPU was online last time, so
> >>> there is no reason to restore its settings from before offline, at
> >>> least in principle.
> >> These are values userspace deliberately set, more like a frequency QoS
> >> request that persists until userspace changes it than transient state.
> >> It's platform dependent though, as the platform I test on preserves th=
em
> >> across hotplug, but where the platform resets the register on offline
> >> the value is silently lost. Should the kernel re-apply it on online,
> >> or is that better left to userspace? If so, I will drop the hotplug re=
apply
> >> and keep only the restore on driver unload.
> >>
> >> intel_pstate and amd-pstate already re-sync these on CPU online, as th=
ey
> >> keep the policy across hotplug via ->online()/->offline(). So for them
> >> it's re-syncing the hardware, not restoring state from before offline.
> >>
> >> cppc_cpufreq has no ->online()/->offline() today, so it fully tears th=
e
> >> policy down and rebuilds it, which is why this reads as "restoring
> >> settings from before offline".
> >> Would adding ->online()/->offline() be acceptable, with policy preserv=
ed
> >> and ->online() just re-syncing the registers the platform reset?
> > That would be a better approach IMV.
> Just an example to be sure I understand correctly.
>
> 1. on a platform, auto_sel=3D0 by default
> 2. cppc_cpufreq driver is loaded + we set auto_sel=3D1
> 3. all the CPUs of a policy are unplugged
> 4. cppc_cpufreq driver is unloaded
>
> To be sure we let the platform in the default state,
> we should set auto_sel=3D0 in step A.3, i.e. in the
> .offline() callback.
> Doing it at A.4 (i.e. in the .exit()) would not be possible:
> the CPU's registers might not be available anymore once offline.
>
> IoW, we should only need:
> .init()
> \-cppc_cpufreq_save_firmware_regs()
> firmware_captured=3D0, save the firmware regs.
>
> .online()
> \-cppc_cpufreq_save_firmware_regs()
> firmware_captured=3D1, restore the user (or previous)
> values that were saved in the previous .offline() call
> (as .online() is not called for new policies).
>
> .offline()
> \-cppc_cpufreq_restore_firmware_regs()
> Save the user/current regs values
> + Restore the firmware registers.
>
> And it should be ok to remove:
> - cppc_cpufreq_reapply_requested_regs()
> - the firmware_captured field.
> If during .init(), we init requested_val to the firmware
> values aswell, firmware_captured should be useless

This sounds about right to me.
