Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794656771;
	b=3dxMoVD2Uzr42H0ddWnZ/AahuJRrC8yU4KpBECiF9MhNqkZIp3JQI+Uaepj+wWSs/T+t
	 5Q+6oDeUifOl/M1u0rT/9Lv8qE1IHqGv9uyvudl6VpzkRx2dwatIDRT5VG/vNnKzGFTLW
	 zm4s/jmGaj/HsYCMJxkc81bY4A9bQmVywqauoTOY4bjSKNJvtImEOE674o5mXCQuAG1rY
	 QPmNiMNHIrKHC6kBSEZ6Hs037uTmEBLP6paXrxEJrQq4euU+yvvtH5GSGSUGZ55sbrVFd
	 AwEa6/hvQUvYK0+SH552AOO+YSZkX8arRl4LxXGdgueuVS7lt1XL3xTYqSUTUEdS6Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794656771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=B4NU0BpLyAV5nllaLWBDbSDu81GYxf/Fluw3zwxoBZs=;
	b=qUvj+lRF55ppO+PXDQlOcM9+UPQ+Iw5adlMp/wF2xuX6HP+sOT/6xtQDKFnTwIP/7XPA
	 Bl5+jT/rGkNEKmlAwpahvEvne1T78D6YXkBrPDUrUQVTyoa8r/lh9aehIDvOAu3eskH4K
	 2RnDiavg9dlRSqB1M0516FBO5/al3G6t2MJz4y+ZCzKrSUyGdLD0G3ngbtl3YimMMDRAs
	 n4tKO8/Iit69we8XR2Jri4jcycRy2qm9m4fsPIsFiW9hGSosn3uatDBNS+P/h8RSM4YSD
	 k6ImNaad/28uRhGA+j2II7OBbiz58kVKSJs4yCouganzhwLpycC15cOxnIahZ49loSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aLx5j1yZ;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839A1606A329
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 839A1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aLx5j1yZ
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2385318eec.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 03:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794656770; x=1795261570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B4NU0BpLyAV5nllaLWBDbSDu81GYxf/Fluw3zwxoBZs=;
        b=aLx5j1yZ6yuv6BLbHMhLPmI5U2QU+S/8xnWAx70i/HAqa96IXU3/jGcZ8Bn1hBYSgM
         RKRitgQd4X2NpyE/U+ZcWHqETIs3IG9mPge/ZnYdvbBIZ0wAzQvTer6RLYs/RtIJk/pQ
         I7ZpKFJW7qN3uEQ34E9YLTdG/ZDYrohw1ROwq6rZu5/PzVtfWpX8ERkyx35U7Ya6ldYP
         3iUhdVh/OairVsJAOfO2C5UnDCOQI1FmL4hwypMTnSHpLeJbjaBe9K316ASBIPT/8nFS
         a2AhQsK9M13YpHKDdHBvE7X6wHV3mAZo0zpAxZwpgcyuOwEjhZSVUDzHwpiLDoEtML88
         EAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794656770; x=1795261570;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B4NU0BpLyAV5nllaLWBDbSDu81GYxf/Fluw3zwxoBZs=;
        b=A3KwWv/Bg/Cpnt7ioLVbWGhbvCGDb08SUjzBl/OsLi+LNJhySdQgpAaYP2ejloZ1CG
         X6u/GvRScm5CKXGqv+lBXOGWUfyDPULFmX46698VvqIVFNAjuwDg9LZEWLm87szzzbUw
         eKfY2tcsW+RTefJEsiBcjEUi8oToy4Nb2RgNX+AhybMx2+LxUVX6NablRYoNcImz6ftI
         JTEW5nbRck+Uzailw6dHtKXCMZRTjZfWliZ0iVUrsFsEi9R6yn9GTjiTrEzaz2PDey/T
         BHCyI9T29dc1+1dj2at1OV3fveYjWJg5LTUncnS/jyhuMlON92HtQlG/bkwlWhsjFSTe
         q54w==
X-Gm-Message-State: APuU4Z8b//waoZzTXVx9uYXD2OQQBgYT7JD6UpkqEgxIZeY2JlvZNBMm
	skPWg9wsJ66BwLbSOxoI1A/Qoera0Qb0mpaistxea/95LccLF7qdAbKh
X-Gm-Gg: AYBFou2v/7RrSMOgEchhMzF+Mnb1W2Qwd6sn48up+NCUHsuxl/RgVCGrWQw3Q/4d3dG
	uQlWKrf2uXNHCDB2ujZMUocuEB88G+pFv7gGI5OLc8JbnSIoZ3ucD31BeHYaLJKZw4COMH9Vk2S
	WU3ZMDLbUIngqHk5poVGpVAp/2n24rktQbvanmudMHi92htrc/8zkMj7xlIOJwufLHUacgTlPfn
	yNHXkcp9SfJgmbI4xb4nepIIPMV3YKhBLZhPkJC13n/0yPiIV+Z0PPJlrQsmL6n6ZJ9AZAN1TOj
	24b6PatZyOexfqp8U2I4x2VtxF91yKdWUhrBNvlndlQQ+WDfSGzZd/Vl+Yg1tLjt8Bobib9MNiQ
	hr+wZrM/zKr1oWcMO8MV+9kUDABijLg+pboOQV48S9HeWIdVtz+R2RfOkl/X4LLlSBCXJ38xhpq
	4VowkR4LmH9vCmjpMueUBzAqstHpwCtnZJ+jaeKX+OlYwweHcYhAj/NHuqXi7kNe3e6D+M83lAk
	0FzJFIQ3p02iPGx/on5ov1sCB8pGdf4NkyYiHTXQTU2tYcLJ113nuzV6WL3mF9VrmajcmSLjpB9
	15JlIvStjstJh9bO3RfBF7JXhifA0XBTtDrdgGK2r95F7hw79HUhqcLvGsdI/KxVhBs7PQmRFpx
	xPWSFbZj7omv86Q==
X-Received: by 2002:a05:693c:66d5:20b0:368:4acb:f8a with SMTP id 5a478bee46e88-37966e3b866mr4963235eec.17.1794656770411;
        Sat, 14 Nov 2026 03:46:10 -0800 (PST)
Received: from [192.168.35.40] ([218.50.238.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm14342627eec.4.2026.11.14.03.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2026 03:46:09 -0800 (PST)
Message-ID: <d478d782-38b8-492f-9821-ee3e0f7b056e@gmail.com>
Date: Sat, 14 Nov 2026 20:46:06 +0900
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
Subject: Re: [PATCH] PM / devfreq: Do not change the frequency of a suspended
 device
Content-Language: ko
To: Arun Iyengar <aiyengar1990@gmail.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20261112-devfreq-suspend-sync-v1-1-af64603ef43e@gmail.com>
 <179460206763.199714.13518791714665074913@gmail.com>
From: Choi Chanwoo <cwchoi00@gmail.com>
In-Reply-To: <179460206763.199714.13518791714665074913@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/2026 5:34 AM, Arun Iyengar wrote:
> Please don't apply this version. The Sashiko review found bugs in it:
> 
> - A limit change on a suspended passive device stores 0 in
>   pending_freq, so devfreq_resume_device() can then fail with -EINVAL.
> - After a deferred update, resume asks the governor instead of
>   restoring resume_freq, so a userspace governor without set_freq
>   stays at the suspend OPP.
> - Two error paths leave the device marked suspended or skip
>   DEVFREQ_GOV_RESUME.
> - The passive question in the cover: exynos-bus children need to
>   follow their parent to its suspend OPP, also at shutdown.
> 
> v2 will fix these.
> 
> Arun

OK. I'll wait v2.

Best Regards,
Chanwoo Choi
