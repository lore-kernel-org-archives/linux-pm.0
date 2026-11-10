Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794336887;
	b=urV3rchYKmkol98Yj1KyAJaYqRAsXFLy04zP5YiuyHgB1Fu6egKIFlsA8eyb1XUgrltt
	 8GecTspgalJtHNhytA81Yi062xeSrG8P/MT+jdXhwxTNHAn5wcYWZizm54cRh0AatfPLt
	 fugcvO6kvI4MC5xJGZe732jf3Szdszg9tcKX44q++QFyZxxtXU7wbVz+5oHpRN1hNs9hF
	 FtCXWhHrOYE14EleC6HgNa//SQiY+dFLCQTtNwPe47j4hAwjG/TQlY/3GPrCcjnV1dz6A
	 YaMKmJjQDWXP/umMq2SZUftir7W34vgWLfr7kWaAdrYv4Xf7RT11K9wuUWS+nqu3pqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336887;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=52NDmUlT/C1NnGu+Dq/AZOz+hWzBvu1Wfp+thafpfXc=;
	b=zx5eNRcaBHzuw0OGC+GenmpJ52zSBr9DgCfszYCFVbVGAS1K9YYWW7Uc2EOatQyN9+BX
	 TQ2j0L7YzotYGspNyNSeH8tMFZTYjU5iirg/MDZGQXoT+IEGmIbrGLmZp5paodjV81prx
	 nMmY2aMYWNNvtjjxKaQn2EKo/YG8IhFxNqvmjT24rnrRPCfEScwU/FY4wmPTR3+y/wuPB
	 Ui46TdT0OCIAj/ZDAQmuIvPyXNHJY25GGz9wFAIP6RmtpHgEkQZt8g963+8knMGs4ocwc
	 FpRvzidadXjm+bNXLJpOGlBZZmYDXkhpAcEn7fVcb+Zv6psDkfeTB8MkcSK5udBjhJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOn77Q1Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E24E60A2620
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOn77Q1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171721F008BD
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794336886;
	bh=52NDmUlT/C1NnGu+Dq/AZOz+hWzBvu1Wfp+thafpfXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LOn77Q1Q4FdQNPQHTCyBLDRVJc2OVxlu3IQSi3abYY96Yq71PSG7F/TEVoy/NyWzb
	 6ZZ8JMgypJzK/cI+aPJQtG8QxRq27xYLoUexcHQhssamVujEko5pL2j8l9Xk5r1UDF
	 fg6EMW/hpUVwdlWj7P/7r/PpqnxM7CCUEq2B3KCS3fXmKrU0AeKB0kcNol6YvVtkWD
	 EFe51t8kzprPyw9dxOkb+SBmRlpAFlmtMn1G2VVZLzW8IioMKG9Lg58zzRg3ECHbNw
	 U2ea60g7BU9XProPMSBPhJSPrIB34HlnYgmh7yz/2ywg+yhLuIaLkQP2PocVVzj3fq
	 vxNvvUWxQIgJg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3aae7df0971so26498441fa.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:54:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGVhNR3l7XIEDtYr9qaJyrHvu9S1xQvmaJX5rb4IgVbZejKF7+Fp/G2i/ty4oOBh2a/R077+jIpPQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9cuQ3TudarAyPXXsr/m+pStklPz63SVb3+oY/i8PAbuoc1j6vl
	k3kONOzQW/xLCx3/3mVaEWvBgnyKdKqD02zFN5At4LOfi7CzFFwcbLQoex7g4AX6i8szU7PaxwO
	S01gwkaCuR/Clyg7q6gP6MHpj0ulQtuA=
X-Received: by 2002:a05:651c:1606:b0:3ac:4da3:864f with SMTP id
 38308e7fff4ca-3ae0961bddcmr8184521fa.4.1794336884424; Tue, 10 Nov 2026
 10:54:44 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110135814.621355-1-zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261110135814.621355-1-zhongqiu.han@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 19:54:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hHLdd0X-r7HG24TrALGccHNZ37JUyeu=rHg9-6YAR7gQ@mail.gmail.com>
X-Gm-Features: AclHuK9AWEuL5vf0QrXIUa41RCa4KBaWPSXD-wUP0068_a0rEgmBvhB9KueRF5I
Message-ID: <CAJZ5v0hHLdd0X-r7HG24TrALGccHNZ37JUyeu=rHg9-6YAR7gQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Skip inactive policies in cpufreq_driver_target()
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-sh.cheng@mediatek.com, 
	rex-bc.chen@mediatek.com, jia-wei.chang@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:58=E2=80=AFPM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> A policy obtained with cpufreq_cpu_get() may become inactive before
> cpufreq_driver_target() acquires its rwsem, which may lead to a NULL
> pointer dereference:
>
>   CPU X                      CPU Y (last CPU in policy)
>   cpufreq_cpu_get()
>                              cpufreq_offline()
>                                __cpufreq_offline()
>                                  ->exit()  /* frees freq_table */
>                                  policy->freq_table =3D NULL
>   cpufreq_driver_target()
>     __cpufreq_driver_target()
>       __target_index()
>         policy->freq_table[index]  /* NULL dereference */
>
> Before commit 2372784542cb ("cpufreq: Drop 'freq_table' argument of
> __target_index()"), __cpufreq_driver_target() returned an error if
> policy->freq_table was NULL. Since the offline path clears it under the
> policy rwsem, which cpufreq_driver_target() also holds, that check was
> sufficient to prevent the crash.
>
> The race has been reachable in-tree since commit c210063b40ac
> ("cpufreq: mediatek: Add opp notification support"), which added the
> first caller of cpufreq_driver_target() that can run concurrently with
> CPU offline.
>
> Address this by making cpufreq_driver_target() return -EBUSY if the
> policy is inactive after acquiring its rwsem, in analogy with the checks
> in cpufreq_get(), refresh_frequency_limits() and the sysfs show() and
> store() callbacks.
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261104153042.3987338-1-zhongqiu.=
han%40oss.qualcomm.com
> Fixes: 2372784542cb ("cpufreq: Drop 'freq_table' argument of __target_ind=
ex()")
> Fixes: c210063b40ac ("cpufreq: mediatek: Add opp notification support")
> Cc: stable@vger.kernel.org # v5.19+
> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> ---
> Fix the issue discussed at:
> https://lore.kernel.org/all/a4b320d9-ade6-4f39-9e9a-e9a82b13152e@oss.qual=
comm.com/
>
>  drivers/cpufreq/cpufreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 54dde8419bdc..352ee4a1f085 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2403,6 +2403,14 @@ int cpufreq_driver_target(struct cpufreq_policy *p=
olicy,
>  {
>         guard(cpufreq_policy_write)(policy);
>
> +       /*
> +        * The last CPU in the policy may have gone offline after the cal=
ler
> +        * obtained it, in which case the policy is inactive and must not=
 be
> +        * used for changing the frequency.
> +        */
> +       if (unlikely(policy_is_inactive(policy)))
> +               return -EBUSY;
> +
>         return __cpufreq_driver_target(policy, target_freq, relation);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_driver_target);
> --

Applied as 7.4-rc material, thanks!
