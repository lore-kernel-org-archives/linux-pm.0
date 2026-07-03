Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120830D3F8
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783102193; cv=none; b=Fo+NcMvFRfs9WznncrDgyCPl46Yk6zuIHovLKcij7gLQjBLNiNGoWNggexXeowpn9Gq+lK3kA6L2q6M2l48H1uGlXXDn+Uq/IqJ9hdSXVVmqQv6vKAwY4k92KYJxS5ieCy+Ou5H9PpL2n8gcvv7zWpWZskC4cQWax7jKKWFZkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783102193; c=relaxed/simple;
	bh=tgraSq/9gwcx1TlvQJClsEB9nYR8gJqZ8hIiRgK1PwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/lOPeDhQqIz8Z5+tHu5xICEBGE2jxcOylxfg1fxU102KzqmhlDmBn9pq69Hk6T7tqPKC3dwbUQP97qsmhDSQonfpotAuIt8nVRmnK2nTDTXaHuL1FKaTs95IiIpTSi5/ciGHs0y1BJk/3fWUAskvLWYj9Qj70Gft/PcOcvAqMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ra4xy5wv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ra4xy5wv"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c733f15aso7877495e9.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783102190; x=1783706990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v0DdjgoNvkE0UKI8hOQQ2MWCAbcQBGlfDeboRpCm0gA=;
        b=ra4xy5wvOi/TPR2Z34MK32O/ruNxzV+1v6h5iMDy1P1Fn3UGUdPZM2687Pony5MH/s
         WLLI7YRHTn4SPDcZsIu7rwolyAPhKocKplLXYQIeCbqypXDo9Bgn9zyBZg+AYgdPS3c1
         aC0uv6QHm9h7b6sKySLAA0Ho1VbwhCEAwnI9dTQ4gsjtlUt+MTijdQasxwuPvJmyQaOV
         k9IObRwH0OUTZ17q3WKTOsLRgxAQMxGvzdvs/u9wU4so5i/GhP1eYPxkJggBq5exxNCC
         umrd9HSyTHQypGHWdLak08XO0Qr3hi3XOCH5195z4JS1UN6UInIl2mW0V978DqbgDTOT
         D3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783102190; x=1783706990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0DdjgoNvkE0UKI8hOQQ2MWCAbcQBGlfDeboRpCm0gA=;
        b=D+3bKgmHCr0IBWxp8gEoE1F2chlNIdn3fvGTKdl2R0CVUy/IZL9Q98tVWFVKjP4t8z
         qy7T7MTCI3f6YzcYefKPiGzZwBMcZLwabUk2VjklnCCFw88rMAMlkAJpUGlPMFBfLLfz
         /LS/cuzvWFBSZJxsSZnF8kRkxcccsFqgdaOCfctK99QlckebCl0EC0mGa2iZOEuV+7Va
         YuVrHIt7BSnx6GDVhppr2iBlYVd/Lt/PX+FbUaOMsSVRpB1sca1/DJBqSdY9yIr0RlMm
         PJXCuED19k2OtEmEnF+UaZ0NoSsjcLOkcsQGhgVF4hK9UcnCYtvkJK7mffW0tHNgtafR
         +a2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/PkyNVj/oLZMAVUYugIDpnW7fWPDe980RRVkN2HqC5SX1htj+eSuxQ3pWkMg2acuGlxe5GHzY+6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm7j8bKKNkwOqSjUG4WeEF/Wtsi++cXRw5hXePyp2p90EOh3fo
	yK8ctKf+WdhZu4D/Y0S68tbK7P6DyMU4oyiKK0QtYrvx39SZHMHufaU2
X-Gm-Gg: AfdE7ckGOap3MK7dk8vrVUMfZ62RdHE/hbyTcH2sNdOnHrv/tApPK5KLvZRbX7ZPkLl
	8r5pMqc1A8hp7d71UvDeTvTN64g7Gl8y3c6HU8PLU2nWL8UAW4kiBTnu+Fc2rxo9k4C5kuZWK8C
	strz0iL9BmWDsELG3ut0lXRXPomxnGk6hsT6pBjThHMNdIERoCaI1xuABZMU7XwRRr33hEQ2LfK
	qb63MxE4s+muGmqEgn7l6vOaAEx37sxhyJMKu+WV1BFh9ziVGEKxGEEeOghPdV7X5/fGldqHUIa
	ItgKljEWz75+CVR+Dt9WvlcJO8F2mk6kBXo88g6XFAS/QB+kMx89Et9k0i+o48T0g8ytd1Sy7ig
	WnZJQUH8HU2hfJjvNBCIFKIb8pKKFtFs5fEmSExxS1p2+4DYkN4eRhIY54Y/gu80NQhq4DJNylp
	YHRODIG1F5w5wq+13K48HIx48Z4VA8Uxe02vvL1zx+4BGE5iLniuUhiqtrnSwjWVhMu3sWLH2k/
	SPCswn0
X-Received: by 2002:a05:600c:314f:b0:493:b2c1:b2f9 with SMTP id 5b1f17b1804b1-493d11cf274mr4122605e9.8.1783102190297;
        Fri, 03 Jul 2026 11:09:50 -0700 (PDT)
Received: from [10.128.11.240] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm1044214f8f.33.2026.07.03.11.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 11:09:49 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <8a418031-4bfc-4212-a7e7-0d88aa4621c7@gmail.com>
Date: Fri, 3 Jul 2026 19:09:48 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] soc: qcom: Add QMI TMD support for remote
 thermal mitigation
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-3-3882189c1f83@oss.qualcomm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <20260703-qmi-tmd-v4-3-3882189c1f83@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 7/3/26 06:03, Gaurav Kohli wrote:
> +config QCOM_QMI_TMD
> +	bool "Qualcomm remote subsystem TMD" if COMPILE_TEST
> +	depends on ARCH_QCOM
> +	select QCOM_QMI_HELPERS
> +	help
> +	  This enables Qualcomm Messaging Interface (QMI) based Thermal Mitigation
> +	  Device (TMD) support for Qualcomm remote subsystems. It manages
> +	  TMD messaging and handles QMI communication with remote processors
> +	  to exchange mitigation state and apply thermal mitigation requests.
> +

QCOM_QMI_TMD can trigger an unmet dependency and build failure due to
selecting QCOM_QMI_HELPERS, without ensuring NET is enabled:

WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
  Depends on [n]: NET [=n]
  Selected by [y]:
  - QCOM_QMI_TMD [=y] && ARCH_QCOM [=y]

- Julian Braha
