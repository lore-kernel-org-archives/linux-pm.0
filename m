Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F871370AED
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307249; cv=none; b=ByBnaX16avJ02MKp9j+m1j5a+EBKxaWGI8afLFiK09FXrvFfVJS0BvjENvp5vuYZ2srt8lcZS/mSMQkXgzX6FFCDusMXMrCc+fQzBenHHMFrGWrrKVmctDKM7/CIk/Gqk2q9jcSy4k/YnwNEi0rrerWWxyf5k8ij5vX5jXYXY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307249; c=relaxed/simple;
	bh=8DHaxbNgIIQW1uUIJPmwfiBlnxrtvO2JWgpaOXClAms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KF1hvZMu9MDI4ZWIuc/bVDMsTYu7nVP0jqDabCErosCoOnoV8mWk73zP6WL6YdK5ELH7lflfQtCWAmeoDu9XWhW6sjvtwQWyU9j+gt/6ox5bOOyGKbYh8zpYFmIpWqkApEPVCbP8YroYpmA4VKn++o/QSZlepagD0IMnR0Y7ExU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiuew09A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiuew09A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4871F0155C
	for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 13:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307247;
	bh=6fbW+TrtaaiIQKs4Ca0srDSkiFnyZR7Y2v/8HFN2cUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jiuew09A8So+7oq9KSxnUYPCbXYS6LkejJF29Mmia/Y7+TC/kn/U2gTfb3syJp41R
	 a858bciIsq1q6lxCTtoARCs31k6Lsg+tME+v4IZhHaoBaDMj37Asg7CdC4TMYdbjo/
	 8UTaWqx0tz7A4hLpyMd8/tEiW8UKKe7dtD7rxJMNnjy0QYfUWKXTvSTwolIityC1nR
	 R3j5Kf4nr8nOANIvWUipJjoexxIqI6esEqMJpWTIRQFcRMRNcwF1tvSHqmxYhubK4a
	 VpHN3YUrJZCtzzFV1BuBgZL8ba1T9IGtHf6IwmgTp+BQumtoArVP2kldbjT4aSRY+d
	 BMr4ZfFaJpQrg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa7a7ad475so1154329e87.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2026 06:20:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoaZe9Jjg+a3uf8sYrGs8eRLBRZS5hNgdrBQb9f0PbbdW4Lk5ucO6hRWm+rh1imV9PY2yj/Wbha2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJVv0jp0fQSJIWskMT0oKe7pP1Mv2oT5sYHiShVw7oDjyJZh6
	6u94HrKPq356zi6UCb6K47qnfrQ7WAlARBelTynN0gRL+NUpq9Hp3aHZ9XeDcA7NZ/j08VEk3ir
	FDmlPEJP2Ljbz3VORD21B3EqVtdZkjAQ=
X-Received: by 2002:a05:6512:1598:b0:5ad:5017:607b with SMTP id
 2adb3069b0e04-5addb81cef5mr2114864e87.16.1782307245989; Wed, 24 Jun 2026
 06:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623095403.3407436-1-sumitg@nvidia.com> <CAJZ5v0jvkNfx-1XChRCsGHJAcY7W4j41P+Xug6+TpPge7tHF7Q@mail.gmail.com>
 <de03b23f-18a3-4e99-a15a-5044463ac484@nvidia.com>
In-Reply-To: <de03b23f-18a3-4e99-a15a-5044463ac484@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Jun 2026 15:20:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h+Fhj8+xLC=TAqx43+tQCPDUj-eP9YMW=BwKzn8CPUDw@mail.gmail.com>
X-Gm-Features: AVVi8CcfwsbEPu4KJVmHRtDZ3Ns4YbY0dbagT4ehDXRu8LtT1ctdUEYbwy9jWpQ
Message-ID: <CAJZ5v0h+Fhj8+xLC=TAqx43+tQCPDUj-eP9YMW=BwKzn8CPUDw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug
 and unload
To: Sumit Gupta <sumitg@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	ionela.voinescu@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 2:56=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> Hi Rafael,
>
>
> On 23/06/26 16:30, Rafael J. Wysocki wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Jun 23, 2026 at 11:54=E2=80=AFAM Sumit Gupta <sumitg@nvidia.com=
> wrote:
> >> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
> >> boot parameter) can be lost in two ways:
> >>
> >>    - Across CPU hotplug: the platform may reset a CPU's registers when=
 it
> >>      is offlined.
> >>    - On driver unload: the value the driver wrote is left in the regis=
ter
> >>      instead of returning to its pre-driver state.
> >>
> >> Add a small table-driven mechanism that handles both:
> >>
> >>    - Capture each register's firmware value when a CPU is first seen a=
nd
> >>      restore it on driver unload.
> >>    - Record the last value the driver set and reapply it from ->init()
> >>      when the policy is reactivated after CPU hotplug.
> > I'm not sure if this is a good idea TBH.
> >
> > The overall system state when the CPU goes online may be completely
> > different from the system state when the CPU was online last time, so
> > there is no reason to restore its settings from before offline, at
> > least in principle.
>
> These are values userspace deliberately set, more like a frequency QoS
> request that persists until userspace changes it than transient state.
> It's platform dependent though, as the platform I test on preserves them
> across hotplug, but where the platform resets the register on offline
> the value is silently lost. Should the kernel re-apply it on online,
> or is that better left to userspace? If so, I will drop the hotplug reapp=
ly
> and keep only the restore on driver unload.
>
> intel_pstate and amd-pstate already re-sync these on CPU online, as they
> keep the policy across hotplug via ->online()/->offline(). So for them
> it's re-syncing the hardware, not restoring state from before offline.
>
> cppc_cpufreq has no ->online()/->offline() today, so it fully tears the
> policy down and rebuilds it, which is why this reads as "restoring
> settings from before offline".
> Would adding ->online()/->offline() be acceptable, with policy preserved
> and ->online() just re-syncing the registers the platform reset?

That would be a better approach IMV.
