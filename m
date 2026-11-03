Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731710;
	b=FDGa7K0Yu5gIAtvAwWAZQR1dTT67xolZGrGKYAk9hJgWWF0XmDh0plFDLzEY+GXiGDOC
	 aX6bKIuo1a8LMayDhOIw0pf7wXM0f05VNV8+GH3jagVSqwnjRXk5gUaSWEMuwWSRuZQ9Z
	 aG3X5vKKCFWeJp/H70iPUi4pgThOsh5FlN4Ns45doV/tySOjg/qlipCocZwuPJb07Tyff
	 DZar8xgPjbil83U4g81cbzb0NC6ZwvzTkLyz+mAiPbouXrw+QRoRNgFXQYF7a5I1vU7V9
	 a3R/a0sYx+HW9uZiE1Vj91bJyRA3uP0iiof0sVcwO9LI9xNJ/pwdhrndMFAFQn33haA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731710;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zYzKUo8I7hQ360UTcDEoe2J2pbxyPaIjHYeY1PW54UE=;
	b=fN8wz45NNmf3mwcGpbLib4inUeUMGMJCOlLKJys9nTlayHyVXeOl5kAowrIdKnfH0/bc
	 4hHfQpGWoRpWb5107acsN6Qv1VpjdQgWzMN3B0DX7stjFErHOFeBiProIGgV+TMg1TNah
	 BDAD0O+HTRdaP85WjIv0TrcQMHAO9e3tBR2cPKRvqd9abux877y+j/lCJNbPxZtkq7AKW
	 CC462pe0FvPVaA1+k4GAuLhQLGwvcsUSJOR8AMaAKRUusX8R/o0zcO7WBcJDEog4e4V2A
	 HcC9g682GZxPH66JGRuQZ2bgbjk3/VVi5uo0I8yKCuQl75Fy2ganClvATY4TZSxhQ4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuZvIFpE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A4606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuZvIFpE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F91E1F00A1A
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731709;
	bh=zYzKUo8I7hQ360UTcDEoe2J2pbxyPaIjHYeY1PW54UE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GuZvIFpEsJEG5cempsuhux7eXElMyYr+x7Krj8aGdVvydnIROcjFthaHh2V8XynQw
	 lM5Hn32hEo2H0m/g/6HN0sN10CBuLogujJ3Y3SHJpk+VCbeUoSaUZGwT/uPVpuULKN
	 iLLw3qG0mm4OJ10ooRZVwL0eC92I9tdHv6299P5s/9+8sooGBRVnnJNBdRDom8sq0U
	 GPdbmwQkrZLm2pQ/Zim8bbae4XLoJDHUr0rTDPlNV9QiUmEdGK/37mRmYfefO7yrIk
	 TbBBeGZ7GOR7RQc0fIGZFgAA1USclb4JlGphrNlfinW9VeI+ob4wBnz6bvETadGlgt
	 cA8aMhLrpwrwg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be42ae8eadso2842521e87.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 10:48:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwobsK8EbrI3u7PeepQNRRUONFDvuEZ+D2QKz48ZVlwJ+2nFXuVQyJGCXqljkyD/1V6xE8eC8eswg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/G3j0pV+ceMGkkdWJFsxh+FSHQXfEilouq7ovoDyMKP45g/R+M
	X8vnXoM5uz/4fG0GD9FyXFe91lALydiOyMtTf0eVIsL+LCJbnjWJpb04XQcUHR1A0QaWxEYcVxd
	ik3Oy2yjIo5G4r8SzkRfzLwSscFn4XM4=
X-Received: by 2002:a05:6512:1106:b0:5bf:d127:b83c with SMTP id
 2adb3069b0e04-5bfd95620f4mr4622652e87.10.1793731707475; Tue, 03 Nov 2026
 10:48:27 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <be3739f8-e668-4711-912c-91459d77ed35@arm.com>
In-Reply-To: <be3739f8-e668-4711-912c-91459d77ed35@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 3 Nov 2026 19:48:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0haTqW+2t8C=b2oQQe4_3=HEHn-dgsMTWUNf-9mb33uqg@mail.gmail.com>
X-Gm-Features: AclHuK9tW9Ft1zPpw0vX-JKr6OrbrLqHyY1YmjHLwBm9NVABET22Nf4m43jETLY
Message-ID: <CAJZ5v0haTqW+2t8C=b2oQQe4_3=HEHn-dgsMTWUNf-9mb33uqg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Hold the policy write lock when changing boost state
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Mario Limonciello <superm1@kernel.org>, Sumit Gupta <sumitg@nvidia.com>, 
	Jie Zhan <zhanjie9@hisilicon.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 7:19=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> The per-policy boost sysfs handler calls policy_set_boost() under
> policy->rwsem, but the global boost handler and cpufreq_online() do not.
> Consequently, global and per-policy boost changes can concurrently
> update policy->boost_enabled, invoke the driver callback and update the
> boost frequency QoS request. The driver callbacks also access policy
> state, e.g. CPPC updates cpuinfo.max_freq that assumes policy->rw_sem
> held.
>
> Take policy->rwsem around policy_set_boost() in both unlocked
> callers. Keep locking at the call sites because the per-policy sysfs
> handler already holds the lock.
>
> Fixes: 218a06a79d9a ("cpufreq: Support per-policy performance boost")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..015962e6c1fe 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -576,6 +576,8 @@ static int policy_set_boost(struct cpufreq_policy *po=
licy, bool enable)
>  {
>         int ret;
>
> +       lockdep_assert_held_write(&policy->rwsem);
> +
>         if (policy->boost_enabled =3D=3D enable)
>                 return 0;
>
> @@ -1629,6 +1631,8 @@ static int cpufreq_online(unsigned int cpu)
>          */
>         if (cpufreq_driver->set_boost && policy->boost_supported &&
>             (new_policy || !cpufreq_boost_enabled())) {
> +               guard(cpufreq_policy_write)(policy);
> +
>                 ret =3D policy_set_boost(policy, cpufreq_boost_enabled())=
;
>                 if (ret) {
>                         /* If the set_boost fails, the online operation i=
s not affected */
> @@ -2830,6 +2834,8 @@ static int cpufreq_boost_trigger_state(int state)
>                 if (!policy->boost_supported)
>                         continue;
>
> +               guard(cpufreq_policy_write)(policy);
> +
>                 ret =3D policy_set_boost(policy, state);
>                 if (unlikely(ret))
>                         break;
> --

Applied as 7.4-rc material, thanks!
