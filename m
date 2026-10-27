Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.38.247.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105862;
	b=B9bwM3IJ8/17/xFtI6U312Ff20V78pMasia1C1AZKGw/052TMmpRWnsBfc7r7NxRTayx
	 TZXTVzAp0qQ1YEOS2pba8WIfcdLjN+ec1yJMKXx+SM1N2u1vDyR4Os7YxUfhDfyX3yfWi
	 8MpINDR8kytt1z+1rQaeON+wC3cepaagx9CFEFjOrNobDsIhlFEfnALxkPkpUMbOSurCE
	 khAtaHrdkLd2vmElViD1xBftTAgsVpvUFHstK6noZ3aAfrsdkZtuC3C0uAKuNEseZvGLS
	 HeQLbgRt4n2TG1KPFT/8aaB+n6w67e1AQEkCP6s+5ZtjZj8lgSN/4VQFtXFr38aqHuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105862;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received-SPF:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-PPP-Message-ID:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-NC-CID;
	bh=521a5KiHMV0SqLCMajvruFvZwpk1Efpz42h4U52rsZI=;
	b=Cm0zt3ayjhd7Slmq4ChWubQDV0m+ib8VZzOFmkIJw0HFk9fbvz5T7vNk/ek/cD0hPO+A
	 DlpVs2WunMvDdrIMcw2QqNnXH9c0h+8op6Vh1RZ9tRJBRrbVhXb03qsmq8C1uAii0V41f
	 nMvQPgrdwTAZthwkHGpSfCmHoLTDypDYkUirmWYyMOM73TOau2Biy45KFJZmOQiVqVg/C
	 xAI0VPOjzhjKbcdke5T/kIES1ueAm64USsmxC3lvZ840L232RpLj989UncxOaHpfLTL5V
	 5kx4X4ZVHwgE6jR61z1EnUD6genxToGNKgKtWjnOH+N9nGPG7Rnh/bBRX3uFF2rXcXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=leemhuis.info;
	spf=pass smtp.mailfrom=leemhuis.info;
	dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=PoO8LaOx;
	arc=none smtp.remote-ip=46.38.247.119
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1305606A31A;
	Tue, 27 Oct 2026 12:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1305606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256 header.s=key2 header.b=PoO8LaOx
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4jDVrf30L1z8ZWh;
	Tue, 27 Oct 2026 13:57:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1793105842;
	bh=F9UN7r5NdJQ1zWaDOKDK9sE858rSa5l4u47sjcAp0mM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PoO8LaOxz+IUHezCI5wUu3yNUk4Ok5X8lSMi5sp+qKARff4lTJEOnvLWOMeP3VqXS
	 j5ARMaoaYdgzVtoJx50xrQDkD+LZYRbVtcR64e/uu+9X7wD1YfUeL9fcZSenFeg65J
	 p//6dePZCRFuefT5Gt1KApYbfRXJpdndMvoFK9MgIU3Wm04+apwp7mpBT9VfuCeYkA
	 kBwxfkbtakuWXvlpU0Ybxs4LpmA7bkdwz2wmTEXSV9e2pUcObv4D62I+yixaXGxfDv
	 hygIDMMTosX2uqjwElmKR6ciaVV+k7Qc7230K4annS0iLZQJytAkpHERcIaD+nygy+
	 uL6uJN+rOYIOQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4jDVqD0Jmnz505Y;
	Tue, 27 Oct 2026 13:56:08 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4jDVqC0LkBz8sb7;
	Tue, 27 Oct 2026 13:56:07 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 027775F9EA;
	Tue, 27 Oct 2026 13:56:01 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <7472a96a-313c-4bf3-a1b1-5687c010f7e4@leemhuis.info>
Date: Tue, 27 Oct 2026 13:56:00 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: don't clamp gfx and gmxc before
 sync_state
To: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Oleg Keri <okerixx@gmail.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <rob.clark@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <20261021080517.2161-1-okerixx@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20261021080517.2161-1-okerixx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179310576257.1469982.4921492503478710883@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 027775F9EA
X-NC-CID: W4f2xB7Fsat1xO23TYCPIE9b90XxyjJEIuD+ilO0bRFVn8+02DE=

On 10/21/26 10:05, Oleg Keri wrote:
> Until rpmhpd's sync_state every vote is clamped to the highest corner,
> so that hardware the bootloader left running keeps the rail level it
> needs until its driver takes over.  Nothing the bootloader leaves behind
> runs on the GPU rails, but the clamp hits them anyway: the GPU clock
> controller's probe runtime-resumes and suspends its GFX and GMXC
> domains, and from then on both rails are pinned at their highest corner
> until sync_state.

Ulf, Bjorn, FYI: this is a fix for a regression that was reported in
-next some time ago and recently made it to mainline. Linus hates when
this happen. Strictly speaking the drm folks caused this and thus would
have to fix it, too -- but there iirc was some reason why a revert was a
bad option. Hence:

could you hence do us a favor and review and mainline this rather sooner
than later? Maybe even before 7.4-rc1 to prevent more people from
running into this (three people already did afaics).

Ciao, Thorsten
> On Glymur gfx.lvl has 14 levels and the clamp holds the rail at the top
> one, 0x1d0, while the GMU's own performance table ends at level 11,
> 0x1c4.  With the GPU driver and firmware built in, the GMU boots long
> before sync_state, and its CLX DCVS calibration does not survive a gfx
> rail held that high: the firmware gives up with HFI_F2H_MSG_ERROR
> 0x007306c7 (ResMgrCalibrateDcvsLvl), the first HFI_H2F_MSG_GX_BW_PERF_VOTE
> times out and the first GPU init fails.  On the Lenovo Yoga Slim 7x
> Gen 11 this means the compositor cannot start at first login.  Pinning
> gfx at level 11 or 12 instead fails the same way, level 10 and below
> boot fine, and pinning gmxc alone has no effect.
> 
> Leave gfx and gmxc out of the clamp: they have no bootloader-configured
> consumer to protect, and the GMU votes them through its own RSC.
> 
> Fixes: 93b6c8d10fad ("drm/msm/a8xx: Enable CLX feature on Adreno X2-85")
> Link: https://lore.kernel.org/r/179248663855.32151.9955864156939592299@gmail.com
> Acked-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Oleg Keri <okerixx@gmail.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index fa8fed5bd3e5..2c9d4beeffbe 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -1006,7 +1006,7 @@ static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
>  	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
>  	unsigned int peer_enabled_corner;
>  
> -	if (pd->state_synced) {
> +	if (pd->state_synced || pd == &gfx || pd == &gmxc) {
>  		to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
>  	} else {
>  		/* Clamp to highest corner if sync_state hasn't happened */
> 
> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64

