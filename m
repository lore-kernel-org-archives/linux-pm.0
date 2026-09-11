Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888B549F129
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143231; cv=none; b=qL0Ny65luTV97ovJt+00NeI3uaYmU5+EOLir66UDmm/n3NN5hG9Uzm3+3jU5L4BHHZ0HXRu+UDwHqJ22gAI/WAjqV6W0IdmqLHg7Mj9c+XplDLmMieiewnj/83fCcF0fJXKUDnJUQ3G4f0d3VcoBXozKlWw+nTwXNBxdswzVwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143231; c=relaxed/simple;
	bh=nViZvjRLJAYmqpZ2v695pR86EYVgDFqOJd6KL6H4ZQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efS7/r+v1HijcpZUHtUy2Kiksdrs6kkDOBk0R3DeJxVgGWeaHNrE9JE/jiuUIr/xbTtVT+U0aXthNFdpTj1oDcizCszVl/Bc76GbTP5T7cFszx+tnFD38N9ENTtNi6ILzYLCA+bUoOx5N5M4My7sP64PE5rd8zUIFbky5opeTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+PPDFvu; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+PPDFvu"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1055968a91.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 09:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789143229; x=1789748029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DgyMvad3ooLpvm/jCLKD7Z6/JEFk0gV7nLYGOHZ1KIY=;
        b=n+PPDFvuLZtONF09Lb7OaaKopRnHv9cmXKN/QI9F0sOQKks+IQZE3Gbrm4gSawuE/U
         GHd62DiSTD7Lr6QPh2oimyACJa/fRgrxwz84LIlBUGvGtopHrGJJubVXLVLxEqU3xxki
         hzSGp6HUKYW7JqJYjGEwPofN2fw638oaiOCyZirHuJcgKtcspZVd5FpTsqSNcnHKC/cm
         0AjEHVyo7foz9NkyV3br8hAK8jOBGLmeZDGQOl+AJijFce9BEgZwIBDXT9C6w3sh6qwG
         hqUydlWr4RvZ5xRfOGJzAcUZhE04CEYktN6FlCdVV8cKsCtlFLlYl2RGnaVEKWn0P7hh
         0yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789143229; x=1789748029;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DgyMvad3ooLpvm/jCLKD7Z6/JEFk0gV7nLYGOHZ1KIY=;
        b=QzA+eACoUjoqbtK44T/LwY5z37x/lOL5/hoUnsxaK/tPEhxlb+lWzLkP7/rSpMxFh3
         XXTM0C5NBQKsqIsjlDxMk9JPhPOg4Sw6icTxKpVICdFNHay1ESnreSug48u4YBXNb4JF
         a4zAlDwYooni4whhSEO/aQNhGf+KRGtD4joJ1gjRKn5jh1Kp1mSnQKMXJ9jQwwzhBS61
         61VqqKOTJuUOp03u2cBKhcCGyujCQQfmUtXbDoP+WXCYhW37ocne21FSE+OfIdYk1R2g
         vBEpcGRivbNlLdzcKtRUJK+KFHAq5g3JzgZEmyHMd8dGNxgnftisV0mGegS7pOJeIm1P
         OfFQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8Kgj+OHJ13MrDq9VLJFi8Zmm5CbxXOtQVS2V63sk5AbFW6s5MQk9FZO7MrHi66FzWXmLzaKUgJg==@vger.kernel.org
X-Gm-Message-State: AFuF++mKozFJS3heBq4oVt5+kOKu3P19Qfn751dFIKMK8j7qXDUm+FDe
	HDmTScCt0Nt3B91lgxt1jpTjVOWnDtZbZFjU+OEnwsJzz07jk28a7SbK
X-Gm-Gg: AYBFou3N1DOhOZ+IkNOHr8U8kiZ1BjoZStOQBSdxL86rzr4EFJZcSIg9SYGcL8tJIoP
	7exCYvV/pjROGnzgwQhRzMe2OK1DQ+H8cBEQwMGo9P86witkhRiINW8a+c8jLgSH0yxrA87sPSP
	eTsegQmVk427mfSiXRYGHxyMLcWOc8xlr/C2rDigPlC9CEFgrH/WW2GV13tybfby0n0Arwxf1wk
	6ud1kMcyNfcLYQHP5E6Ns/Y9MXTC4kGDaLTZgjEe0h1getsC6aInumzgTCjh6vaKJ4GbpLLUHGt
	iX6Dbesn0HVjCNGWKGAL0IAvdPh67VMPPBJF/vTmM0VEEsSG+KTL53avDiNXy43Cg1S4n3q0LSs
	YaV1OisjJGXUSmH69QAlP+GbPqs2z1PLLEJ8oUG83Yk0gz6gcyfPu+BYIx2BAOaksEZd0w4XfPZ
	2h0hWNE6pbKO3x+Bll1xaQUT8RDdPwF2hx0L1HFo2m9n4v1ZVhfCBnnA5+7ZEvL1ZSsdLBLf6tf
	16Z+l0sMKRBBl91MrCkBCnKmKcPG+rgNf4iZzarjubaKRaRlA==
X-Received: by 2002:a17:90b:528b:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39d9c35a3ccmr8571433a91.24.1789143228656;
        Fri, 11 Sep 2026 09:13:48 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:e503:ad72:fda5:83e8:be95? ([2406:7400:56:e503:ad72:fda5:83e8:be95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e602d8sm5497522a91.3.2026.09.11.09.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 09:13:48 -0700 (PDT)
Message-ID: <daad9a84-61b1-4983-bb22-030c33cc6ec0@gmail.com>
Date: Fri, 11 Sep 2026 21:43:41 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] pmdomain: core: Add a genpd config to support
 unknown initial status
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Maulik Shah <maulik.shah@oss.qualcomm.com>,
 Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
 Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
 <20260907111659.263324-4-ulf.hansson@oss.qualcomm.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20260907111659.263324-4-ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07-09-2026 16:46, Ulf Hansson wrote:
> It's not always possible for a genpd provider to know the initial status
> for its corresponding PM domain(s). To register the PM domain in a safe
> state, the genpd provider driver may therefore have to initialize the
> genpd's status to be powered off, as a way to prevent the PM domain from
> being used when it actually could be powered off.
> 
> In these cases we may end up to power on a PM domain through the genpd
> subsystem, while from the HW point of view it may already be powered on.
> Under these circumstances, it may also be required to keep the PM domain
> powered on until all the consumer devices have been probed. In other words,
> until the ->sync_state() callback for the genpd provider in question have
> been called.
> 
> To support this behaviour for a genpd provider, let's introduce a new genpd
> configuration, GENPD_FLAG_POWER_UNKNOWN.
> 
> Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> ---

Reviewed-by: Dhruva Gole <goledhruva@gmail.com>

> 
> Changes in v3:
> 	- None.
> Changes in v2:
> 	- Rename the config to GENPD_FLAG_POWER_UNKNOWN.
> ---
>  drivers/pmdomain/core.c   | 6 +++++-
>  include/linux/pm_domain.h | 9 +++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
[...]
