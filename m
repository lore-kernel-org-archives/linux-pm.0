Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114722;
	b=L2+AGksc2sQgzhwQ2jJdiF5G6tMy8aS8HFn6q2vHnwu3jf076cyC5qIwMayfWvTrIdaU
	 xBG1kP0OVvEFCTObGmvufp5iRwoMEtndvsgRo4GnlVfRUzyRsTp1hOadpjM7J1GGd9z4b
	 skDxyqP2Y80Zx6h37QvkQHvE3AToKnK9kYGREPLY1VSsMjnzqvG7eXdxSX5v523Rsq6VC
	 jV1fy7LUj74az2+8eqs1h866KB+//jcCqa27tiZM5QqUrkcd0VInbgshciIjhx4LX6ZRQ
	 lsrdg2zDY4zkhHJ7SlwWwplGf0zWQU1jq3aNJVOk7PPuIsuLnGb08Fu/bqFy1ca0F8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114722;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w5PlWJhqcarmlnMRAQqZHAfCSqF+gNap/bMlSG0j+9k=;
	b=AHhW5gJT3njYdKh9LLnoVNeqjeiKYhuPo6BRHc1DUD5JLHV52zRb3qbXPWwESqurZaZi
	 9XOmhSlpuBj86RjuEGhO+brBz2xZy5kkXAD5fuVr7aut1hRoJkgVflZFMby21cG2R74aq
	 AA+N9dChxNJaQ5w2VUprhIYOudSjsw/Ps1S8jXY7PWTXu9SDBHia9HJgKSxzxZBmQpIQ5
	 ZfDzFE01SGwMyssRFqyefteKr6bIVSbJmzUpPwVLaqsdefH+61bhzcjIWem7miXOZnA05
	 YQWNiaJ2onsyh4EakTzgBMK0pBZV2rP05h8Nh6EwC+5j4rKUus847xG8bnrqz3WAFmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fb/UBvMv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96777606A31F
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fb/UBvMv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328B21F01828
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 15:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793114722;
	bh=w5PlWJhqcarmlnMRAQqZHAfCSqF+gNap/bMlSG0j+9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Fb/UBvMvyk3+6QOaGhQngfsyYCdiBTHu30xU5jz/zxFOrb8Je7X36sfjPr7eepYDv
	 HcBiARPabDm5zgr0QvJZs2fNNAyCHl3kH2IAhxmMGFd+uMDF3YJvRwo40p/V5+L8ca
	 Sr1gXB5WuqM0w6re6sMb1DJHcV4h04bZZsFAqWV9GtpG4PFI7cx37SrP6zQxWMSmfI
	 60cU9JXqIOfydPX7n7ekBfH5xJwQByGdcsV35/Ik6t97K1W5vz4gGnFd4Cj2actc4R
	 EfHoAa7iMlNlnY2rq7E7BKUi0ek2fO1WdlBrIGhGTcHF32k1Q1M3HKQIa2pHEyTnyY
	 w47hcccQA5y9A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso90953e87.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 08:25:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByTKuNTaZuseuBFDHlJITM5h3nvqPlP0ZFrIaAQodhcLOVeRepeosiNmy+Jxm8io5twIVDw3F5rYQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJFqlM/l4CbUbVGliW3HrUyDhUJbzAVPMPbHYHXsFPulWNu8wlt
	64k5cOQb/0q4nvey+ZACpSOIQb3KlnNquBfUahsyxJCKRlmHqJYwdc1a8156+nmxjYME47qs96g
	+jXPZO8sPEQvIwQZ67PABaro6yjXWSck=
X-Received: by 2002:a05:6512:32c6:b0:5bf:c808:2f1d with SMTP id
 2adb3069b0e04-5bfc8083438mr955628e87.63.1793114720656; Tue, 27 Oct 2026
 08:25:20 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027133332.377546-1-zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261027133332.377546-1-zhongqiu.han@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 27 Oct 2026 16:25:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jmgKN+wSp=CvWTtuQb+qc60uHFh5s2kYaeNy8AAE6q3g@mail.gmail.com>
X-Gm-Features: AclHuK_NfYSIy63NzTRJva7e11zsIfmFFqNBjCB-mOCaEjwxVTT3_pkFdDujzsY
Message-ID: <CAJZ5v0jmgKN+wSp=CvWTtuQb+qc60uHFh5s2kYaeNy8AAE6q3g@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: stats: Fix potential out-of-bounds access in
 deferred reset
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:33=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> cpufreq_stats_create_table() sets stats->last_index to -1 if policy->cur
> is not in the frequency table. It then stays at -1, because
> cpufreq_stats_record_transition() returns early on old_index =3D=3D -1 be=
fore
> it gets to update last_index.
>
> Commit 46a310b80bc2 ("[CPUFREQ] Don't set stat->last_index to -1 if
> the pol->cur has incorrect value.") added that check. However, since
> commit 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to
> cpufreq_stats_record_transition()"), the stats reset is deferred to the
> beginning of cpufreq_stats_record_transition(), before that check, and
> cpufreq_stats_reset_table() ends with an unconditional
> cpufreq_stats_update(). So if the "reset" attribute is written while
> last_index is -1, the next frequency transition accesses
> time_in_state[-1].
>
> Fix it by also returning early on last_index =3D=3D -1 in
> cpufreq_stats_reset_table().
>
> Fixes: 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to cpufreq_stats=
_record_transition()")
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_st=
ats.c
> index 670a10c3ecfa..e7ec16bcb67e 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -52,6 +52,10 @@ static void cpufreq_stats_reset_table(struct cpufreq_s=
tats *stats)
>          * reset_pending accesses in cpufreq_stats_record_transition().
>          */
>         smp_rmb();
> +
> +       if (stats->last_index =3D=3D -1)
> +               return;
> +
>         cpufreq_stats_update(stats, READ_ONCE(stats->reset_time));
>  }
>
> --

Applied as 7.4 material, thanks!
