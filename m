Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6753F44FC
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 11:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658580; cv=none; b=P2g7It3Rp8ebNI/45qMbQ0hY3XQw5DrhmT6YWeGeIeygFIbHkqk4/nO4QT+Y8aYfRBci7jBDTNGADegXMy7v7gWVtwkdT6o7xri6EN8RtI5oUvQlJvBeRPbVUZrg6UXjqbOHh4Ml0Gq+eEc1SN2jWbQJzmofk1+ZMWMLlKxE9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658580; c=relaxed/simple;
	bh=+qqn1hGF+VT/RqVtcGGCWhzq7uHr1S0yjAaeydl9dRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0+Zqk+8Miu/xGicwgG6OpSElEgU0+d2rYv9CvAcoADqqv17mNiyi1wRa9cVWl4IWLFDlgcqEpDJ+qQFagSNQJvaKWJNWrbqFRk09uKmJqzrqQlx7uT5kyenqioX7MbsYIfYDD/5rwAyHWuh/M8xEW8UdRcYAFaM4mh8So3mbqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUyoYfDV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUyoYfDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634811F0155B
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 11:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658579;
	bh=6mOfUK4gekik/50MpXg4aDqVy1ftXlxaM8kxJh7PcFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QUyoYfDV85sGMTJDcoRz6QYT7gdQGCqo8RykITI8DNslY6kBsOv//vD7B0kQTX49G
	 ZBKQabSakwP7jxzwdnYnNvOvZDm8PyOcprsto0HM27uGKSJj89qa5L31IqTpsbGcA2
	 ZC0eUdH5vo65OHeYrqKH/mH6g5sHiOoVpeCBI4rHik2btmzGC6vBgA6wti1i8WCdIJ
	 LWFmzKCFlcRDQIrgsK+7iEGa464vFeStVF/QyfSEfdWYuQ5i/Bm6vk1l8iJi3wBi8/
	 No4Ik5aro96jDDVer0sJ2/smNcjRYXshuMb/QolxinWwkrgL9g0MWWGl+A/xLWjXjI
	 twLVckj7MNitQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39fa5e3a428so5566271fa.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 04:49:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqS0Ebw9QyHfAiU2chQcjQTLCSEfu7PNCgC4TMou1zpTO65yBT1U+Ikzj8rque2oj7saLAXxW1z/A==@vger.kernel.org
X-Gm-Message-State: AFuF++n/QnxvPTChMHl6NHGEskRAqRKG/SCso1V4RrG+qyKvE1WCwPtx
	Wrr6QU2l5u5xP87VEaQ+Qt2fJ5KlpdzAr2tD7pv4BjaK/NBMafQ/QehaTSnfOmBjJl5tFUzdHqd
	6UJjmxkQd9a81SF31BDrT70XBnuhTB0U=
X-Received: by 2002:a05:651c:1541:b0:39a:c1dd:5399 with SMTP id
 38308e7fff4ca-3a1edb69206mr10119501fa.7.1787658577430; Tue, 25 Aug 2026
 04:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809062549.1415955-1-christian.loehle@arm.com>
 <15234e9c-b9a5-434d-836f-e2e2ebc036c9@arm.com> <3a23d54c-5ce6-4225-82d3-453e7133fdf1@nvidia.com>
 <ef37d738-4b25-4609-8bf0-6c2322ecbd02@arm.com>
In-Reply-To: <ef37d738-4b25-4609-8bf0-6c2322ecbd02@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 13:48:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jJOQcikMV=dbnRh_S980g+QrQyL7wdP_0p-e3PmrQ6Vw@mail.gmail.com>
X-Gm-Features: AcwNN1WxqtAqfd7Wre1CQdVNekJ3urH-b-A_fTr8W7fihMnzUsPN7dnyrY7LWXg
Message-ID: <CAJZ5v0jJOQcikMV=dbnRh_S980g+QrQyL7wdP_0p-e3PmrQ6Vw@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] ACPI: CPPC: Fix register access and lifetime bugs
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sumit Gupta <sumitg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	zhongqiu.han@oss.qualcomm.com, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, jarredwhite@linux.microsoft.com, 
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, 
	Shubhang Kaushik OS <shubhang@os.amperecomputing.com>, vanshikonda@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:25=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>

[cut]

> >>> base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
> >> Gentle ping on this in particular to the CCs not involved in the merge=
 window.
> >> Even just a Tested-by: that the new CPC validation didn't break your p=
latform would
> >> be appreciated!
> >
> > Tested the series on linux-next-20260824.
>
> Thanks for testing, can you dump the CPC descriptors for both revisions?
>
> >
> > With firmware reporting _CPC revision 3, every CPU logs:
> >   ACPI CPPC: CPU0: Performance Limited register cannot use an interlock=
ed SystemMemory access
> >   ACPI CPPC: CPU0: ignoring inaccessible Performance Limited register
>
> Assuming the detection here this is expected.
>
> >
> > cppc_cpufreq still probes and frequency scaling works, though
> > perf_limited interface reads 0 rather than reporting the
> > register as unsupported.
>
> Ack, I'll fix the getter.

This means though that it will miss the 7.3 merge window mark and it
will become 7.4 material.
