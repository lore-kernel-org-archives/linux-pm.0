Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197797;
	b=KeWl5ITnMVYxYTE4MAorIhsX73CITxqRtFyUEm0fWVuHQzVF+5RFLVHJLgxv5xkSuVjZ
	 oFCQ66hqs3h+UjofhQHw9hojh6Mvx1veREHuBXJ92f7XLEXqhD0w16dlDECzDO7NHNOoR
	 mtP1e9y4jd9P+ObEiAwGkDhMlTtiVa6+1ku7tSvMPV+EWnz2yfb//+QeVjMJQLdACQiQN
	 C0Hi659pSUko1fDZ0swnfGwV0YTre0fUknLbys4EDtEg5d9xoOaAXCGNhjhVccLqrBtey
	 rkuShLzd9Il4Z98fTDMBeOSjFl6Dq8YXBT1JoFXan2szBWtGR9fd7TlR1XFA9e50XUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197797;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S/uuB3bMVQf5ECbFGLUvHsboBVjan4hq6CJy7aBsci4=;
	b=Lj5LGQWlvHkOvSoxc1eUYkwhoUum4zll4T+E0KzH4tUHLCZ4v82ZUi62Fw4/S3SA4Qbn
	 u0Mgf9F082zpVMSFJb7lOi/PJNFOyq9XcVBDj0nmiffBTD6WfHIdzOm0DKR2Ed37U4/IT
	 ew9WglSe+qVyvhd6X8xhWPlaOdDum+2hIIiRMFTUMO6q9ddPwrfl4bKIcwdIuArsZ8fdG
	 d6DqmQFQIYCKbBNhNaotCCpzYpbTByn+ttu+suOzsIW2aUm8iEMfj4p98ua6ghsIvmrR8
	 e3DkJvqkl7XcGwNoaz0x4is/WCh5fAcBdZUKaEhGqyz08yZRuj96C8F4Xmlge6KFF9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMd8pIUT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C8360A262A
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMd8pIUT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B141F000F2
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795197797;
	bh=S/uuB3bMVQf5ECbFGLUvHsboBVjan4hq6CJy7aBsci4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RMd8pIUTlrCAFpiF3nteSPLKEliaInXn5+cIoz6TSFSzLaAWsGD4eb8z+hkCpemF9
	 J1J86bXDblFnC2by7lIEwRuwgMpnmDDXsJgk3pIZpJT3t7WGY+7fxmUnNS4Lti9v0c
	 bRvULEPAoOnERIIk9ZXypRZkPJbPO0IWIVVoQz3KP0SwzXOaRrvtoHehX4yLRgKAx4
	 OHCTXt7YVTXl8qEJjBpnsKL1psi4sfE6yVEpMa29HAaydKRNBQjBaAfJ+uU744jnTa
	 TPEF4EhtvTuP2wUbWm8Tf3E++M6a9ZDWwfb+U6bMYqnMhzW+6kRn0rPP2Dx9PBinKq
	 R74bvnhVC1QWA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3ae1fd4252fso11747111fa.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:03:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH6PmHqLd3JmrVJj6Z8o8WHvNM1vr1x7lbI2JcgfybDFDNDNHkAMwJP+AlHq90KpRPFl+jt6jH+Cg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9786XBv3oa5IcN54aRaZRmvK15OnEB99OstG46E+DgFT2h+DE1
	mZJAPlF8sslNpGk1rXH7Hmrk01nzmqoPJRTlaP0BP+4bN6SRrG+21hUWambDA9dXRA4NnFsbe94
	balcuqELIO8r/lc551CYlWohvCEox1KY=
X-Received: by 2002:a05:6512:23a0:b0:5c1:5d1b:9142 with SMTP id
 2adb3069b0e04-5c1bc7fb790mr1375002e87.13.1795197795693; Fri, 20 Nov 2026
 10:03:15 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117151218.731219-1-sshegde@linux.ibm.com>
In-Reply-To: <20261117151218.731219-1-sshegde@linux.ibm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 19:03:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j59uY80rXXMbqXdUmDLx2yF-CaByD-4PFu24PZZqBaGA@mail.gmail.com>
X-Gm-Features: Aa3M54oLzFYWeVC3D3V4_-41LOYWeGbsYXhrvs_IgQMCivSZZOsOmI9PVMJztXM
Message-ID: <CAJZ5v0j59uY80rXXMbqXdUmDLx2yF-CaByD-4PFu24PZZqBaGA@mail.gmail.com>
Subject: Re: [PATCH RESEND] cpuidle: Use cpumask_intersects_and where applicable
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@kernel.org, 
	christian.loehle@arm.com, Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 4:12=E2=80=AFPM Shrikanth Hegde <sshegde@linux.ibm.=
com> wrote:
>
> cpumask_first_and_and returns, usually the first CPU in the intersection
> of the three cpumasks. However, if the returned CPU is not used or
> only to check it against nr_cpu_ids, that implies to check whether the
> three cpumasks have a bit in common. I.e use cpumask_intersects_and.
>
> cpumask_first_and_and uses ffs on (addr1[idx] & addr2[idx] & addr3[idx])
> whereas cpumask_intersects_and checks only
> (addr1[idx] & addr2[idx] & addr3[idx]).
>
> So replace such an occurrence.
>
> Reviewed-by: Yury Norov <ynorov@nvidia.com>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
> This is resend of the v1 series posted as independent patch
> https://lore.kernel.org/all/20261111075945.3930230-1-sshegde@linux.ibm.co=
m/#t
>
>  drivers/cpuidle/coupled.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
> index fb91a9e0e3c2..40db5c86a466 100644
> --- a/drivers/cpuidle/coupled.c
> +++ b/drivers/cpuidle/coupled.c
> @@ -439,8 +439,8 @@ static int cpuidle_coupled_clear_pokes(int cpu)
>
>  static bool cpuidle_coupled_any_pokes_pending(struct cpuidle_coupled *co=
upled)
>  {
> -       return cpumask_first_and_and(cpu_online_mask, &coupled->coupled_c=
pus,
> -                                    &cpuidle_coupled_poke_pending) < nr_=
cpu_ids;
> +       return cpumask_intersects_and(cpu_online_mask, &coupled->coupled_=
cpus,
> +                                     &cpuidle_coupled_poke_pending);
>  }
>
>  /**
> --

Applied as 7.5 material, thanks!
