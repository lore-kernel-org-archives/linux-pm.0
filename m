Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6DC49F101
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436837; cv=none; b=TZn90Lt5DoHbCXM0wWvfvRKzw4WumwI8N3rYi7Petq7pSz7Kv/XoKNFX16UuIOPLiqcH3CuPwfiq/LOruK6GlgLUTbPDx4DmdXKqXQMR4QHlwSk3goaVrDFUUPl7Mm7pnPYbWzhOaHIbJicwfzW8hEQWGbbo4Kr4PE0FPFWY+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436837; c=relaxed/simple;
	bh=hYv0Tjkpm329P9k+TQgqKAPpwtzq68X7vpyHeYE1jHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3KapNVs2rT3trqbfinSXgAokpBFdXOxCO2z3AxgDxoCZqH0btVqrjxjvdPYmzh6NJ0lkU50zDBEAqnm+I6eUZoWpMtKtPNoOwQo1YeX0JLTgCxdzZEahoPnDLb1Yww7XZQmm3mIs1CcNWh4+juyf61efgJGw3dnhgRLpZAFz3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvjv7mTH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvjv7mTH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d9b60c652aso22769605ad.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 05:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788436836; x=1789041636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x84L8D3771uX1JRAz3DeEhkLMS/d3fFl7+pMbK1JIwc=;
        b=kvjv7mTHOi7YcvKmPL+bqdpCLBoTNMQ+EGYilMjh0sbYviv2xQSSAjf8/vy6wQTHit
         h7w7donsSKHUetTy+NaahPfjrD+YmvkwV2tLftrqmVAaj7zfIJeBPV8CuIayacxYFQb/
         JUeVX8l2OYiQDhj5x6qw16Bq1SJCv8jGfmrm9q6pxc2DB48BUR1egTlQ6NfZmoLIvul8
         GPa9ckqgbB6Dq7rYw1cM64qIQopLdoUWOFMNrTxMPAjytPcMobHcUJrR+bNKutlyjsq5
         aRqhP6Na+o90p7jYTJISu0qojHjueQAhSaT2bub9JDDttDxPMj9lqKOuqnbdObDSMoEV
         JP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788436836; x=1789041636;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x84L8D3771uX1JRAz3DeEhkLMS/d3fFl7+pMbK1JIwc=;
        b=g+dmPCrbLAsyCOf0r9y987DmpJawQnz95Can8PCald21uSUOIAurhy8i1vuLnXIqnH
         fDVaS6lbX94x29F64z/pAPHRcuXPvK/g9H5FEMa9+0OvMH/zoH0KpcHE4h4PfVyJXpdf
         d5E4necf28TXhYxrgxeYAioQgbFB+kc+VLudlwG83fuyIU0vX52NzX9GToL+g98OG7k4
         35s6zv4AeAryigDt5laWeQ76p7lpowZupu5ozdwM84A/6UxlVMluMvf/4y60Une3PgeM
         /4QEqzduSzvs1BYQcAHdfqdq8B06IMGj/ScfnishL0cH7syt4zcmpZ+ff9ZIJaxN9kxY
         MsRQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7WmMJ/u7aT95oHBWj5fXR8EfxtU/KR3neopCbTMtZZINL5rku2Aiknq2r8vAwrYE+vrQmlplpyw==@vger.kernel.org
X-Gm-Message-State: AFuF++lhNVz0rsYZIeWvSgJBrHVMqvyzcmof28+p1z4WRlHU/DX8VRGz
	kNIWjiSQptU4ckAChivonTYlCZX4/sOoLmqS4ZNKBFfpFTYXY45q/fM1
X-Gm-Gg: AYBFou3G1h7ZazOeR+n3lXQHtIYl3f5npXayBqvgmief269lxNAnauFwKwMwoKnMQ3h
	bPjoM5FhMq2U/KLznYuodbz7NrIHzHt4ZhdG/Y2fVjlp3w5ZIWIvo0ZJymFpDB9mW1zYWZQ2l2M
	dCOwyOEzWKS+D7U8OiGeeoJhEmrPWmF+oXm/nvf1PiJnjAxjuhXNqUKHRCU1ypb09tFonLbXbAV
	46AuCPJzszj4BGbWEmh2PhbW+W8drkxmeuYeDKi0K/Fx5tKFRTYaVH+ZdhttdW6h+vopXFRRvni
	c49sGaqedoxYhIj/bwIRpNMs5bwlYssN4enC8UaCvNueTD5BKl46KuQs6z3VWVhIoWEuLL/Eyrs
	AKBeXH324rBdxswAYcQChx1sQQouaqODD0Dn44QJG0e9DYl1kZTVCOpEhG/2oiIbNZ6yAuZNQYS
	UJeEkvzAKIbz+9pfvr2r9vUZzJOm19wpUR39Ja9z3mVCZWYm6D7BCxWeXaFdfjB0cqo56euJ3zb
	rfAM9dDOugjG1exKAfiyKjogyJgJck1TxJjxdDRly+CzUXnpA==
X-Received: by 2002:a17:903:26c6:b0:2d8:d4cc:be67 with SMTP id d9443c01a7336-2daec73f1d2mr160598335ad.20.1788436835424;
        Thu, 03 Sep 2026 05:00:35 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:e503:ad72:fda5:83e8:be95? ([2406:7400:56:e503:ad72:fda5:83e8:be95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db01c4204csm8037835ad.66.2026.09.03.05.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 05:00:35 -0700 (PDT)
Message-ID: <c00f266d-b6c3-4988-a2b9-72c5e0389317@gmail.com>
Date: Thu, 3 Sep 2026 17:30:28 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] pmdomain: core: Rename genpd_status_on()
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
References: <20260901111441.122436-1-ulf.hansson@oss.qualcomm.com>
 <20260901111441.122436-2-ulf.hansson@oss.qualcomm.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20260901111441.122436-2-ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ulf,

On 01-09-2026 16:44, Ulf Hansson wrote:
> Let's rename the internal function genpd_status_on() to
> genpd_status_on_unlocked() to clarify its use.
> 
> Suggested-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
> ---

Optional:
An additional line explaining why this otherwise unnecessary rename exists:

Rename the accessor to leave genpd_status_on() available for a lock-taking wrapper
introduced in a future commit.


> 
> Changes in v2:
> 	- New patch.
> 
> ---
>  drivers/pmdomain/core.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 842c4169e290..6ac1ce18fda3 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -173,7 +173,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
>  #define genpd_lock_interruptible(p)	p->lock_ops->lock_interruptible(p)
>  #define genpd_unlock(p)			p->lock_ops->unlock(p)
>  
> -#define genpd_status_on(genpd)		(genpd->status == GENPD_STATE_ON)
> +#define genpd_status_on_unlocked(genpd)	(genpd->status == GENPD_STATE_ON)
>  #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
>  #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
>  #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> @@ -771,7 +771,7 @@ EXPORT_SYMBOL_GPL(dev_pm_genpd_rpm_always_on);
>   * @dev: Device to get the current power status
>   *
>   * This function checks whether the generic power domain associated with the
> - * given device is on or not by verifying if genpd_status_on equals
> + * given device is on or not by verifying if genpd_status_on_unlocked equals
>   * GENPD_STATE_ON.

Since we're fixing this anyway, It should describe comparing genpd->status with GENPD_STATE_ON, not the macro
which expands to that logic ;)

Anyway, nits only, LGTM otherwise.

Reviewed-by: Dhruva Gole <goledhruva@gmail.com>


