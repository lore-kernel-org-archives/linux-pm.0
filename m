Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28143F8C9
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367905; cv=none; b=d2quoNJALRVadnTKVbfG6LWt4sxYmE2AnrFQC5/+pI9vwdGACwMSeM6t1yYGS8QW3peog4cJ2azZyNb9I4meO/7QlglJaith0sHTRTeAggxJP1nIEEOii2k1pjDQUyTxQYTVdEP1TXW1P8SB+qT7xnJr3w6kb2lardce8n9KeCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367905; c=relaxed/simple;
	bh=ONfzlMwZUmt9iQP0GdhJWz6HRCumIiMG2gc58uPgNpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2f3x+klh2f4RNZPphBXcOiSjYS/C/KKohZzMtrYvj02WM6YYzn+8MfPeVPxzpe9hdojBZWBJUpc5TUxJkZRfoaAuwPjgRvgd4fIGqG9AB0dj41fTnTwQVXKChLm0YAEdna8vEjwNsqOTjNq6cW+BK2A3w4CODrH+qam9y9ctT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGn3yQGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGn3yQGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2441F00893
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367903;
	bh=WNQees8/ehGot81631VV5fQVbOPJSRm59MHRcSjht10=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jGn3yQGookNeaQk/WwM3h8B906jLy4vTACkjht1SDqGucEZ9thWqH7V92mT+lsTP6
	 zHE0Ds5BpIqcfevi7utJZifH8N483Xj80nyzIOhOwwwwjWAeoCLbX20hFFxN37h+Ja
	 qqIdh6kQ0sTBREyfvNINbQGViPL44H5GUuXxjVHaBc6Eh1LVdQXcuMasbqKMsURgTc
	 LRPAx2NkvzFRS72WJ3FubNCldpt7kIheGJSp0J3l0z7ju377cn0P9iPYUvriSpW23F
	 6rzleVti+v8AptG2Q6DyRdK2v2aRSp+gflygpQ+VzN2OSxLKhCxiUM4InQmqdCNGAZ
	 ScAibf+CxO+dw==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8ef09e288so217121e87.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 13:25:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwHlTn8Ju9KeI+T00Xs2dXYKWJ1FgK20LUhW9er6G2SB96qYb2boX6h8yswXq/vM5Y1IWpf4KNExg==@vger.kernel.org
X-Gm-Message-State: AFuF++lo3NPLsQwc6z1d8LKayxO5WdXZByHyu+gbmubF/lBAtS1kF5Jl
	8UPDYSxGclChoVFX3v1DKHt3u3AgC+vamsFvEI19EwnyIRVRDOlQIkid+hVzWSgglV4PSZHfAUe
	h7aeEapXjy/50+45FfH9jCb+k0/2d8o0=
X-Received: by 2002:a05:6512:b1a:b0:5b8:ed7d:8b42 with SMTP id
 2adb3069b0e04-5b8ed7d8bc7mr577236e87.39.1790367901803; Fri, 25 Sep 2026
 13:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922124121.3426219-1-zhenglifeng1@huawei.com>
In-Reply-To: <20260922124121.3426219-1-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 22:23:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jko6SjZ2642DryhSMZyPgatvG442m7y1E8J7TcxvtOKA@mail.gmail.com>
X-Gm-Features: AclHuK9frkW9y83b_87zzoPb_5_iwomW9wqA2MKboLGqOzwuRlqnR5CdgiySfqg
Message-ID: <CAJZ5v0jko6SjZ2642DryhSMZyPgatvG442m7y1E8J7TcxvtOKA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] ACPI: CPPC: Resource Priority Register support and
 sysfs interface
To: Lifeng Zheng <zhenglifeng1@huawei.com>, Christian Loehle <christian.loehle@arm.com>
Cc: viresh.kumar@linaro.org, ionela.voinescu@arm.com, zhanjie9@hisilicon.com, 
	pierre.gondois@arm.com, sumitg@nvidia.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com, 
	linhongye@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Christian

Christian, can you have a look at this, please?

On Tue, Sep 22, 2026 at 2:43=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> This series implements support for the CPPC v4 Resource Priority Register
> mechanism defined in ACPI 6.6, Section 8.4.6.1.2.7, and exposes it to
> userspace via sysfs.
>
> Resource Priority allows OSPM to control the relative priority among
> processors for shared resources. OSPM can utilize these sysfs interfaces
> to configure resource priorities, allowing resources to be preferentially
> allocated to more important tasks.
>
> The controlled resource types include processor boost, throttle, L2 cache=
,
> L3 cache, and memory bandwidth.  Each Resource Priority group consists of=
:
>
>   - CONTROLLED_RESOURCES: which resource types the group affects
>   - ENABLE_VALUE / ENABLE_REGISTER: enable/disable the group
>   - PRIORITY_COUNT / PRIORITY_REGISTER: read/write the priority level
>
> The patch series is organized in three parts:
>
>   - patches 1-4 extend the CPPC data structures and _CPC parser to handle
>     Package-type entries and parse Resource Priority sub-packages into
>     structured descriptors.
>
>   - patches 5-7 refactor existing register I/O helpers to support direct
>     register access and add accessor functions for Resource Priority
>     attributes (enable, priority count, priority value).
>
>   - patch 8 creates a "resource_priority" sysfs hierarchy under each
>     cpufreq policy to expose the Resource Priority attributes to userspac=
e.
>
> Changelog:
> v4:
>  - Patch 7: Set *num_resources to 0 when controlled resources number
>    invalid in cppc_get_resource_priority_resources(), therefore, the call=
er
>    will not read the unassigned `resources` pointer.
>  - Patch 8: Remove kfree() from the error path of
>    cppc_create_res_prio_sysfs() because cppc_res_prio_release() will do i=
t.
>
> v3:
>  - Patch 2: Add the (i - 2) =3D=3D RESOURCE_PRIORITY condition back to en=
sure
>    the new code behaves the same as the original.
>  - Patch 4: Assign -ENODATA to ret when an unexpected ACPI_TYPE_PACKAGE
>    appears.
>  - Patch 5: Initialize the `optional` field of the remaining cpc_regs to
>    true so that they are treated as unsupported.
>  - Patch 8: Call cppc_cpufreq_cpu_fie_exit() and set perf to lowest_perf
>    when cppc_create_res_prio_sysfs() fails. Call kobject_put() and kfree(=
)
>    when kobject_init_and_add() fails in cppc_create_res_prio_sysfs().
>  - Link: https://lore.kernel.org/all/20260812015217.74598-1-zhenglifeng1@=
huawei.com/
>
> v2:
>  - Patch 1: Revert changes to the CPC_SUPPORTED() macro.
>  - Link: https://lore.kernel.org/all/20260804085042.4118193-1-zhenglifeng=
1@huawei.com/
>
> v1:
>  - Link: https://lore.kernel.org/all/20260717024502.3520445-1-zhenglifeng=
1@huawei.com/
>
> ---
>
> RFC: sysfs placement
>
> The sysfs interface is currently placed under /sys/devices/system/cpu/cpu=
freq/
> (i.e. the cpufreq policy directory). I am unsure whether this is the best
> location and would appreciate reviewer feedback.
>
> The concern is that Resource Priority covers resource types beyond CPU
> frequency control:
>
>   - PROCESSOR_BOOST, PROCESSOR_THROTTLE -- clearly CPU-frequency related
>   - L2_CACHE, L3_CACHE -- cache partitioning, not frequency
>   - MEMORY_BANDWIDTH -- memory QoS, not frequency
>
> Placing the attributes under cpufreq makes sense for boost/throttle but
> feels semantically wrong for cache and memory bandwidth resources.
>
> I would appreciate feedback on whether cpufreq is the right home for
> this interface, or whether a different location would be more appropriate=
.
>
> Lifeng Zheng (8):
>   ACPI: CPPC: Prepare cpc_register_resource for Package-type entries
>   ACPI: CPPC: Refactor element parsing into parse_cpc_element()
>   ACPI: CPPC: Refactor resource cleanup into free_reg_resource()
>   ACPI: CPPC: Parse Resource Priority Register entries from _CPC package
>   ACPI: CPPC: Store optional flag in cpc_register_resource
>   ACPI: CPPC: Factor out cpc_read_reg() and cpc_write_reg()
>   ACPI: CPPC: Add Resource Priority accessors
>   cpufreq: cppc: Expose Resource Priority attributes via sysfs
>
>  drivers/acpi/cppc_acpi.c       | 719 +++++++++++++++++++++++++++------
>  drivers/cpufreq/cppc_cpufreq.c | 281 ++++++++++++-
>  include/acpi/cppc_acpi.h       |  60 +++
>  3 files changed, 930 insertions(+), 130 deletions(-)
>
> --
> 2.33.0
>
>
