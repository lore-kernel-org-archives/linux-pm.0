Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22B418A52
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 13:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158535; cv=none; b=YoZhvJujMLunALZ0oHkrVFQ/3CEmMxwGirLmQXqf+zMsMaeyWlVC9UG7FpmPKL0CqW6U1bSqAUVyDI09AUK59ONxJ3ju4RazwtdALJTAJ7gr3pgA3soHBuTNv3k+RzrlrJN4lYMDkEfZlCwnmrgM3EJeAzTvqB0ma/PlO+SYAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158535; c=relaxed/simple;
	bh=MNj/qSfquGY/IJvlO35QQRUB5x/GG8PvKOI6sL4i1hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcoEJNeek46WTAkxUuqkfzQLQpO89y/AEbNPjpYtbTGvj55nWHd2BxTShDaoc2ciDOzu5rrvexFydUIpW4PrCcF37M2Hj5qWBkFfGwAtQoQzo0CVUS2pxkjCYYGo9lNDDpTE5tmLT4b7BIAhpYLw7KwF8hYuUDzi5YczIMm22+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYHwhB3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYHwhB3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B09F1F00AC4
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 13:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158531;
	bh=pyG9IetWNXw/s7lNLiGozcnJuoHs5Ya5WvVHszipDKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AYHwhB3JuqTrnd3Ic5SdU8hEdCYUAp9ui6DXJM4lybXqE7EdseT+qhhZljg5yCV+9
	 SLA7Yxm0VuCT1vCMCgt5aJ4SWBBSNo2OnFuftwMxlyyFXBeKnFmmVz/9p4DIADm2IC
	 190Kg6CxAWW+c/0mTRzVQH3cNQVyMz+OxAPiiiDqjhipFF+8NqXaeykSHXt5ZQ4d1/
	 oOFqNZJB60erRDvhhGG53y3wp5h4kk90bwHuGRFux8xb28M3TAmgjXJyW+S6I8QJpA
	 smmf7sIVzZ4IYCge6BjjSeOAQeXacqz/6/8W0pAYhiVsI43RxgAi2CJXue80iP0iFA
	 Q2iUNJh70HRxQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39ca0a30148so26286981fa.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 06:22:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rom9q5bzjfPn2K1X1+cZgejtN8MhKYJZ5SZF1IzqHdPT19ydFsbgd9lLbuOVr8Wcx56amuYGxvdSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLILYePXGwd0nzw34t78tWqMhdiDEiwV8k+3W2a+F8vrNSCOyi
	GC7dfRamp3dbeoUDf1e/FXtB0h+jwPqdMrA6W0w628JkNyN1mOQM0JKv9obCxvPkzn7Y/qC97y8
	L9/ai4UVxp8wC80WylDsLG6WB6eBzy5U=
X-Received: by 2002:a2e:a99a:0:b0:39e:e845:7f23 with SMTP id
 38308e7fff4ca-39f287721acmr15254561fa.16.1785158530030; Mon, 27 Jul 2026
 06:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724104042.1481804-1-christian.loehle@arm.com>
 <6174756a-b779-422a-a67d-d677961d99f0@huawei.com> <9fa94c64-c4ed-45b5-85ab-c6f8f04107e5@arm.com>
In-Reply-To: <9fa94c64-c4ed-45b5-85ab-c6f8f04107e5@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 27 Jul 2026 15:21:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hZbV0iNQksGqSJ3BzjFUcuYLQEf226THg5_PQo-h9TDA@mail.gmail.com>
X-Gm-Features: AUfX_myl7xANmROMqw95ZigNHuq6vzGtODbnuhbQrnpdUsZqdrFi08Aw0-ptetw
Message-ID: <CAJZ5v0hZbV0iNQksGqSJ3BzjFUcuYLQEf226THg5_PQo-h9TDA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: CPPC: Skip writes to unsupported performance controls
To: Christian Loehle <christian.loehle@arm.com>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Jie Zhan <zhanjie9@hisilicon.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 2:27=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 7/27/26 12:14, zhenglifeng (A) wrote:
> > On 7/24/2026 6:40 PM, Christian Loehle wrote:
> >> MIN_PERF and MAX_PERF are optional CPPC controls. DESIRED_PERF is also
> >> optional with CPPC2 when autonomous selection is supported.
> >>
> >> The cppc-cpufreq target callbacks populate both limits for every reque=
st
> >> without checking whether the controls are implemented. cppc_set_perf()
> >> consequently passes NULL register descriptors to cpc_write(). The writ=
es
> >> fail width validation and their return values are ignored, so the fail=
ed
> >> access paths are repeated on every target request. An autonomous-only
> >> platform can take the same path for DESIRED_PERF.
> >>
> >> Check that each performance control is supported before calling
> >> cpc_write().
> >>
> >> Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in targe=
t callbacks")
> >> Reviewed-by: Sumit Gupta <sumitg@nvidia.com>
> >> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >> ---
> >> v2: Also added desired_perf check (Sumit)
> >>
> >>  drivers/acpi/cppc_acpi.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> >> index 1d3a94100491..53d09ca98f06 100644
> >> --- a/drivers/acpi/cppc_acpi.c
> >> +++ b/drivers/acpi/cppc_acpi.c
> >> @@ -1963,16 +1963,17 @@ int cppc_set_perf(int cpu, struct cppc_perf_ct=
rls *perf_ctrls)
> >>              cpc_desc->write_cmd_status =3D 0;
> >>      }
> >>
> >> -    cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
> >> +    if (CPC_SUPPORTED(desired_reg))
> >> +            cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
> >>
> >>      /*
> >>       * Only write if min_perf and max_perf not zero. Some drivers pas=
s zero
> >>       * value to min and max perf, but they don't mean to set the zero=
 value,
> >>       * they just don't want to write to those registers.
> >>       */
> >> -    if (perf_ctrls->min_perf)
> >> +    if (perf_ctrls->min_perf && CPC_SUPPORTED(min_perf_reg))
> >>              cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
> >> -    if (perf_ctrls->max_perf)
> >> +    if (perf_ctrls->max_perf && CPC_SUPPORTED(max_perf_reg))
> >>              cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
> >>
> >>      if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN=
_PCC(max_perf_reg))
> >
> > LGTM.
> >
> > Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> >
> > Apologize for replying to v1 before seeing v2.
> >
>
> Thanks for taking a look!
> You can blame it on me for messing up the title and forgetting to put v2 =
there :/

Applied as 7.2-rc material, thanks!
