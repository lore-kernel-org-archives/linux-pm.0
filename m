Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E457B33710F
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726741; cv=none; b=uGoDN9dIqBieAaPJ6a5RCjuWDnlyXA2tRf9ROMXQ3ULCa94znG8OITWD/k0sSpeHNfURWGCjwMnUDvde/EGXdkyVWVWYuHb+UtB9p3uYa0+VTjiQLUX7C86xE6ud/Vi7Uo9/nPEp9aJPExoFn9M2oP1bd0OdRDNTpVshLDENVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726741; c=relaxed/simple;
	bh=5GWvB71SBTCyBWxhlZtl2pgr9GNg5qDq2xtSUWWEHHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6Y8qTRBccUphtwcr5d1/Agc68KftNzuLP6kve1Unj3vsz8m5too+W1QpLvT6UXWTcbYLUxM/IDd3INAkmZWrakb0gAvRo+aIZguKke6GBpGamRzBqylKHK8Wzj9rsAh8XzwHUsTc7jDPTqvJwVw9eZ2smG6tybwnMV+q1SMXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdKHSlBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdKHSlBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E181F00ADE
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726739;
	bh=e65zOWIfPI5a0YU5mgAD46/VVgyBC2Mf+3nQC4KWApE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LdKHSlBq9HSPoTTohpB0QxIUUXLTq3FY5ZzZ1q8yU84IR9ggIyPL+I2JE+x73wRPJ
	 Os/Bc+pqRu5whoh+yNTsYnTItc1K4eZFlWZpNpRRGW0h41F0eS7/TFa/kd1buNG4mI
	 J+2pErL3yXRNEaKz95eafM+fe17BhGbpXL4+FdLCOr7hqPevMHfYdnF1ewKb4k7Nxf
	 mzDmMWgo2c9WeEQqDUbYj+00r5tCV2eHNzutt17ks6bRGQkGXZe9pcTxUiytDuhr+t
	 MRdwtNELwiDXHr9nK2xUnw6ygWBnUoKdJih3gt96IBQnlqeHSpS3J1DzXHAeMh6DNn
	 i5n+1xjEBScaQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c86ce9e29so81437381fa.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 06:25:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqJnnsTr8GOdQiqkTsXpbeF9MP/cmD6IasHCvpwL60dSvBVRSUpwBnFQ5+4iYUHCGWlkiaE2Jsq1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLazQYZpumgD7sc0LvUc/Q+w8wRPXZVjKuQ5RQu2TgjhOj0M8
	GNjWpkUyM/SHYZPXVHUfHs/cG2WC17dUs0/gYyZgicMV0wJ9Wu2ddau3AuLN6mFX9EYmrvuc/cq
	5X4RMZlKFf5Fr3PXKZ6uhgZWa4f7zwfo=
X-Received: by 2002:a05:651c:154a:b0:396:9cbb:673e with SMTP id
 38308e7fff4ca-39eb2886470mr39855091fa.24.1784726737936; Wed, 22 Jul 2026
 06:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716131546.1159644-1-zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260716131546.1159644-1-zhongqiu.han@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 15:25:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hesSyydNpvJ9t4qx-DWGx=_yT6+E=7Ln0aAdD07LCoLQ@mail.gmail.com>
X-Gm-Features: AUfX_mxNT95O67z9SODm_-nzWfMJuqFMvirsvHy1BIee95_ETt9rPkxsPX8pVUU
Message-ID: <CAJZ5v0hesSyydNpvJ9t4qx-DWGx=_yT6+E=7Ln0aAdD07LCoLQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Replace sprintf() with sysfs_emit()
 in sysfs show
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	christian.loehle@arm.com, liaochang1@huawei.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:15=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> Use sysfs_emit() instead of sprintf() in rate_limit_us_show().
>
> sysfs_emit() is the preferred API for sysfs output as it provides
> PAGE_SIZE bounds checking and ensures proper sysfs formatting.
>
> No functional change intended.
>
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index dc0835ceee98..96651873345e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -592,7 +592,7 @@ static ssize_t rate_limit_us_show(struct gov_attr_set=
 *attr_set, char *buf)
>  {
>         struct sugov_tunables *tunables =3D to_sugov_tunables(attr_set);
>
> -       return sprintf(buf, "%u\n", tunables->rate_limit_us);
> +       return sysfs_emit(buf, "%u\n", tunables->rate_limit_us);
>  }
>
>  static ssize_t
> --

Applied as 7.3 material, thanks!
