Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC63634E763
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937423; cv=none; b=JZnWfAE0vG62djO90x+LYEO+mJ4yxU39KUn204tdNLhIdj8nUX0jin+Kr/hj01cpmZwWGdMp+nSUn3ETuZdAEO2hlTKLJ0ApghvUJmvh51Cvg6uuqPJsiBgz+Qlq0Tl6wILLyL4WgO3q82BPGmGRV463EuwyWXhdEtqzHnpRAnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937423; c=relaxed/simple;
	bh=4lxaymcvpRvTb+P4rhHZMiRlDZAoiqemYjKpznBeLVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGX0W8fK9pARUGcgq3va1+8biUBaZ2s31yollBkUgOC/cufU3mTdaq+29FLT1v4DsM/3tQ+mPbsPrtKE3V4iWyjZiW6iPsbqUBKTPLFx1EpMVxSheV4ufZjh/Dz7i6gn9XS/lJQtHw83oJE9uYbLa24FPIInMBvaWJl/6x+4FGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT2IVy3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT2IVy3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E8C1F008A4
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780937420;
	bh=npHWDqU6yjbT+OwbndMJs/FFPuIRk81q7S8clauz25k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HT2IVy3eeze5yh4BI7BGaoBZEg44QRKJCSXMjCV+7WeIMGaddZsUGq5i2C347mYa6
	 Zic/NKR8wutbg5oU17SwIt8dxGwZcfiXaNW5IHKN7vGwsmfMwqHWGJW9wTMthN0fdA
	 7OrTlkL983bhxe1J7T3QSgIlU7CFYnuCLVoCSROXYgSk0s49Qud+HEPajg9vHmBnQV
	 KjVyHHKSj18sI1vZbdjZoOlBWg3UplvgumocHjJdA30DiX6l+BYKX4hWIvjqh7DrWe
	 xFU7reeSazzc2DrIL+/Fl7QAX81EeuoFoWwXJrz3cpFdz5B51gRErZ+qlZRwyx41v7
	 GtCpDWTgkyAIA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa69131836so3946966e87.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 09:50:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/471xh5JnO7umWUdn320fJC2vD2pG0QcWOPTRKpE/W3GMJKNzEDL6qE3r1yutLEB9jz9UaM9IRwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJPVVfru4viSjYiywIoGwl3+6Cg0x9adslJ2p0HWHK4VqK+uH1
	MuvP4sRP3dWS/nr1wxtsnjfsUgD8tyhqwg7tylRFcSZMnEJlGwwRVNJ0eKowppfrjx5asSBOEh7
	XJTsSJf7FVtVcr9+bSi/jje6OZQEUud4=
X-Received: by 2002:a05:6512:61d9:10b0:5aa:75f2:c996 with SMTP id
 2adb3069b0e04-5aa87bb9a8emr3078487e87.16.1780937418842; Mon, 08 Jun 2026
 09:50:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528090913.2759118-1-pierre.gondois@arm.com>
 <20260528090913.2759118-4-pierre.gondois@arm.com> <CAJZ5v0hwYcvYZJ1jCSo_5vpynOLBciW-4-KeracQTyUCw7fSGw@mail.gmail.com>
 <6447f46d-5a60-45a2-b585-9835c9c26893@arm.com>
In-Reply-To: <6447f46d-5a60-45a2-b585-9835c9c26893@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 18:50:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hqjdd79J-Hi=mSLMm2Fxhia+xa6iguJwZy2-pRBSJ6gA@mail.gmail.com>
X-Gm-Features: AVVi8CeORZeGIlAC3kCCNf5xvinM_kGWNcToWxlEjA_NxQU5ebuMifvlZvQHeDc
Message-ID: <CAJZ5v0hqjdd79J-Hi=mSLMm2Fxhia+xa6iguJwZy2-pRBSJ6gA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] cpufreq: Remove driver default policy->min/max init
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 3, 2026 at 9:49=E2=80=AFAM Pierre Gondois <pierre.gondois@arm.c=
om> wrote:
>
> Hello Rafael,
>
> On 6/1/26 20:08, Rafael J. Wysocki wrote:
> > On Thu, May 28, 2026 at 11:10=E2=80=AFAM Pierre Gondois <pierre.gondois=
@arm.com> wrote:
> >> Prior to [1], drivers were setting policy->min/max and
> >> the value was used as a QoS constraint. After that change,
> >> the values were only temporarily used: cpufreq_set_policy()
> >> ultimately overriding them through:
> >> cpufreq_policy_online()
> >> \-cpufreq_init_policy()
> >>    \-cpufreq_set_policy()
> >>      \-/* Set policy->min/max */
> >>
> >> This patch reinstate the initial behaviour. This will allow
> >> drivers to request min/max QoS frequencies if desired.
> >> For instance, the cppc driver advertises a lowest non-linear
> >> frequency, which should be used as a min QoS value.
> >>
> >> To avoid having drivers setting policy->min/max to default
> >> values which are considered as QoS values (i.e. the reason
> >> why [1] was introduced), remove the initialization of
> >> policy->min/max in .init() callbacks wherever the
> >> policy->min/max values are identical to the
> >> policy->cpuinfo.min/max_freq.
> >>
> >> Indeed, the previous patch ("cpufreq: Set default
> >> policy->min/max values for all drivers") makes this initialization
> >> redundant.
> >>
> >> The only drivers where these values are different are:
> >> - gx-suspmod.c (min)
> >> - cppc-cpufreq.c (min)
> >> - longrun.c
> >>
> >> [1]
> >> commit 521223d8b3ec ("cpufreq: Fix initialization of min and
> >> max frequency QoS requests")
> >>
> >> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> >> Acked-by: Jie Zhan <zhanjie9@hisilicon.com>
> > sashiko.dev has some feedback on this patch and appears to have a point=
:
> >
> > https://sashiko.dev/#/patchset/20260528090913.2759118-1-pierre.gondois%=
40arm.com
> >
> > Can you have a look at it please?
> >
> [sashiko]
>
>  > Does removing the policy->max =3D max_freq assignment here break UAPI
>  > expectations by exposing the unlisted boost frequency in
> scaling_max_freq?
>  >
>  > Commit 538b0188da4653 intentionally allowed drivers like acpi-cpufreq
> to set
>  > policy->cpuinfo.max_freq to a higher boost frequency while relying on
>  > cpufreq_frequency_table_cpuinfo() to clamp policy->max to the frequenc=
y
>  > table's nominal maximum (max_freq). This ensured that user-space
> tools saw
>  > the nominal maximum in scaling_max_freq.
>  >
>  > Although commit 521223d8b3ec temporarily disrupted this by defaulting
> the QoS
>  > max to -1, a subsequent patch in this series changes the core to
> initialize
>  > the QoS request using policy->max.
>
> Effectively PATCH [4/4] cpufreq: Use policy->min/max init as QoS request
> now uses the policy->max value set by the .init() callback to set
> the max_freq_req QoS constraint.
>
>  >
>  > If the policy->max =3D max_freq assignment were preserved, the subsequ=
ent
>  > patch would successfully use the nominal frequency as the QoS max
> request,
>  > restoring the correct clamping behavior.
>
> IIUC this suggests to use the nominal freq. as the QoS max request.
> This was behaving like that prior to 521223d8b3ec. However doing
> that would mean that if boost is enabled and the max_freq_req sysfs
> is not updated, then the frequency would still be clamped by
> the max_freq_req. 521223d8b3ec intended to correct that.
>
> Sashiko seems to suggest modifications to come back to the
> pre-521223d8b3ec behaviour, but I think 521223d8b3ec is correct
> and we should conserve this behaviour.

So there is some confusion in the patch changelogs of this series, but
not in the code, regarding the role of the last argument of
freq_qos_add_request().  Namely, that argument is the initial request
value for the given request object which is subsequently managed by
user space.  User space may in fact change it to whatever value it
wants (either lower or higher) and it is only taken into account along
with the other requests in the given chain.  IMV it is better to
clarify that, so I have updated the changelogs when applying the
patches.

Please see

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dbleeding-edge&id=3D8c83947c5dbbd49b36d08bb99e344327c6278781

and its ancestors and let me know if there's anything missing in the
changelogs thereof.

Thanks!
