Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971865;
	b=RCqPSZL257wD3S86u3WbMsHdQwXBy/lmVU/crFtC+PaGhn9t83P8Rb2SPBUKJWPOBD6e
	 HtTBsDSH20ZkIgPR+SJcbQq+RhBk4H/JJx5pBe2QpWxiILsUn6iU5uyXUgp7DD+t8udUt
	 brEn+Sw0FdLWSRJB00LYL9AhyZtsT0Av/julc4eN407hqvDbFxsFf3vjumT0aoLAbHN/R
	 yWSydHe/PfoWYpH32L1F+oB36FVHZm0R+bIYA8kjptBOB8WD5xoX/goroA2PlNH2syjA9
	 VRtM15JVhtpq4fj0HyaglzijQmjwHEvuIeYRU2L2WNVcgVl9diy1dhd7/Bj0b6m6Svw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971865;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KsEtLjgYfHMgMWTCV9j/iE09UpigS3xHL/2sEbWoVtg=;
	b=cQL/wpQ/Wm/sze1+I053xsxgZHLYDnKdqW6Gqir4rs05xmjzJmtAS9M6MYdKmupFMJFA
	 sZTe4HuhDB+ZFxE/Y9YtGvr6yZyQ1usMiZB94Shoyv03KfRXhc28EGpR757aLa98ZFG8+
	 OtKODC4DA8FcvemsxFy+enu0qpNHWbMxb9TlM5mSiEU1rwh/c3SZ6rDvn2kyxr2ffC0dv
	 E3AVgwRsiTD2FzQEan808huEkGZzqcpx2Uc7woNWhAfIqFLaNg4MfJue1bLw/mKKwtLev
	 l//xWRPn2m4QWUCCJjbpxv9q61lImEh+iGMMOLMhekBHJ5K0ZFTqXF5yzLdMQfvGM9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8AwD77Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB804606A32E
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8AwD77Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC601F0089F
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793971864;
	bh=KsEtLjgYfHMgMWTCV9j/iE09UpigS3xHL/2sEbWoVtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E8AwD77QNW1LVtfxAPc3MJzq50s/Zis9Wz94E8jJyMgAITfGeZzscXxrg62dfO2Sv
	 7qSK6G3Sc1jJYb/N+VFWeVxaXHZpoUyeIwdN2Gos5qmAqDNn+5Mtj7r6Ct5f9IdByL
	 FaMyHh0OmqA/oLxRQ6gNFpu6+i+Vo4Hq+66oZ3NUYFsxEZ0gF96jT0nTUlKIUnSDt/
	 0JWU9OGEMzibsfZLBnD70X6AzKpZtgQhqn9tqNpbem7E5ik0OsP0sHvv+BLud9jk5X
	 VdlCVo4n5R0FL30E6FphIQ4cLOlAkmNUfFhoRmrluqWtJibnyEBz4S76T4kJdhbf2y
	 vhLCRZ/wiNn7A==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bfa686881fso491962e87.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 05:31:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBw/dFYtaEpJhILeamb2SAIcRIOFE2cnhZGc4Dqmmkz7Rz0MlCdgXxN2LN+g2wHmnKrrBbDbquEFDg==@vger.kernel.org
X-Gm-Message-State: APuU4Z98xr0XwPAmLuNAWfErDDZ3Tfd1JjaacJ+DEplnbYHRBg4kShEx
	LEJ4LaLMGuPBZssRN50cX1vllhMK533W/Y2NV8BdSZRebTVXzRm6zBhxT9zb7TIpg76FzQ2/uXO
	Z8kzbvMTvaodsWkvHBy+lzESw9aV9jXg=
X-Received: by 2002:a05:6512:6603:b0:5c0:8dc:f2de with SMTP id
 2adb3069b0e04-5c008dcf56dmr236139e87.23.1793971862818; Fri, 06 Nov 2026
 05:31:02 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105215223.1263415-1-christian.loehle@arm.com>
In-Reply-To: <20261105215223.1263415-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 6 Nov 2026 14:30:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g2R3DwuUCH2Ai8W+RgY2XBbbn2XULLmypx7-k70KxeUw@mail.gmail.com>
X-Gm-Features: AclHuK_yidvwwHstWNok0ryrQll26jqE7wFulYzd_5mzbyfaI6z7kXdudgvr6hQ
Message-ID: <CAJZ5v0g2R3DwuUCH2Ai8W+RgY2XBbbn2XULLmypx7-k70KxeUw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] cpufreq: Fix global boost state updates
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sumitg@nvidia.com, zhanjie9@hisilicon.com, 
	superm1@kernel.org, zhangpengjie2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 10:52=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> Preserve the global boost state on failure and serialize concurrent
> global boost writes.
>
> Changes in v3:
> - Explain the concurrent-writer race in patch 2 (Zhongqiu Han, Rafael).
> - Add Reviewed-by tags from Zhongqiu Han and Sumit Gupta.
> - No code changes.
>
> Changes in v2:
> - Split rollback and serialization into separate patches, with the
>   corresponding Fixes tags (Zhongqiu Han)
> - Carry Pengjie Zhang's Reviewed-by onto both patches since code
>   is unchanged.
>
> v2: https://lore.kernel.org/r/20261105090311.1026648-1-christian.loehle@a=
rm.com
> v1: https://lore.kernel.org/r/20261104161657.546370-1-christian.loehle@ar=
m.com
>
> Christian Loehle (2):
>   cpufreq: Preserve global boost state on failed updates
>   cpufreq: Serialize global boost updates

Both patches applied as 7.4-rc material, thanks!
