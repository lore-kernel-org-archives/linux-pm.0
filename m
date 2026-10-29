Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300351;
	b=j6sfw1Jo1qffBOwEYxvIiHYViN7klvnN+xjsn9PjTgJkY8968k0dJjFdxlItpn4+5Ogk
	 z3enT+UpsN/f3ibSGcKNv3OLWNISQJdRj9utaTB+0vZdDxEFehDbW6ycpt+r7aoTo795N
	 8WLocvXKsgukC7PvADGDTy4S0+gKPL4IPDC9kLy4iExgEClmUaG6Fjjzglh5fu9KWv+z5
	 1h6bNkT04zD69GZiKTPS0DmoCVg2w4WTUB3d7GfSkNFTVAJXHhzLqNHYqb2VygfYV9xif
	 L0P/7g7FpAXKJI1cZKg8E9FTebXQwhSAbrj6xKTG3z3XF4KVdZoOOO9W81i7z9J7a0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300351;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
	b=PKBMuKSz96wUzLFfCulgaTeexib056ahm+MbrCL7O47o6JbOn/fl7IHDMVCUR2jYBW1O
	 qZr1bMP0wro1dywqYzv1u2VB7O4BG6e8rahWLlvD9rugp975uE7vQcajSjR5QXw7d9J0J
	 4TXQVpvpj/Z6SP+KJb9Mms/kN3RH27KXIhJq3pKuKU/b0gkGt2hRP6t6g/umdbPpiCeZR
	 6P1jrSL6kfuBEi9n32MK49BtomnDuhHJyqK/2iYGdemdnNFSqOPPu8ps0x2W2LeKoa2YT
	 b4SRY/jammi8yX7v7+b15SdE9LfC6WbbuaDPXRMcsNck3iQ66HmsTeAaVXqAFWYYH2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wKHfFSVm;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134E606A330
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 18:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0134E606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wKHfFSVm
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so16224985e9.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793300349; x=1793905149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
        b=wKHfFSVmSHenG0U1iwKgtGSi1UOPPzW6SwGJPjDKQxqwGUCxJEvCn1DjSm7x+7dlBI
         tUKS5X1HwuZkVolpmPhJFNwbLcWP4O2Ey+tlKOMSKe5uAIMYifWViWBMbQNK0ytgnkU5
         TxpYpjDnhF0RjngKcgEl1OEsxC/rdKP63x/HzurTG3ZCmbKYurx/pMsgnAebRGdPVULt
         X6kw74+yrE1gmuUM1siaydpKy5zusToKzYM/zlLOoKSiOrcEwuwMelyy8U+A1MF4630N
         +VRIg7uYp5Eams5/R4YrzMxIRDiBSFhS3P/ldIwkkN9aFhmNkbr/qpcLWvL6VVYZuboa
         npsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300349; x=1793905149;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K0Ytmrnk1GXIgM1fqIrHZ5HsCVM2IH42icX0Nl0p4uM=;
        b=eCT+iYGQC7fm3LNtC4oCi1Dt/puz8yXPrKEU+FswrYyJhfEaG64e4YTc8Dex7yfI9n
         aD8Bp+Ved0EgeZHHgMQouw4GVjb5tO+6ulMAwhVvQNy/UEpI7vCT1ElbDMi3fuDGE69i
         psuQDDvjoQ0Lj8MHN8dBMkxRlsfY3wh1UZMqV5yiKkC2Djds4wTJ2hr/DRQ8IvFqkfRe
         Gi3Z3tfk25Vs9lsDDk+x2Mccz0tLg9udKxAhBIsRPY+LloGUh5km1MMhiQsI+reGC5zQ
         k+Oq0NSDNVmMSvSMEYax4x/rwLXz+7KvUkQEAYbfPQh7LIukP8G6jKczPw0KmU4KwoeN
         yAOg==
X-Forwarded-Encrypted: i=1; AKwUvBzcUctUC4Py8cXELYC5CCWBmSOARNucTXePVVjkdh7pkkbmOkSD6QGNTZdNYMVv9SeSwsU2SEk9gw==@vger.kernel.org
X-Gm-Message-State: AFq9FYI7D4JSLVR/5PzcB2O8jkB/zx2UsKk+mzo7PKLtSpQL7jv+mfQe
	V8TpKu/obfBfdao0DWDUoJqDjc4RjXpsj07rwagwzQdYunh0LxiWFojM
X-Gm-Gg: AYBFou0cK1EabJBP5TIEzqlr/tQOs6EnC2QWl9sH8oI7NU/QS4R+ICOkf983fzf4uTm
	uxM2ba8Cw9UZ/7Nobs565glZZf1exLEJQPHNsZ95au/ylTtsvU1GqWyGEkFK0pYcaQvKf98zLaX
	8xXRGVqQuEFMeowasDCl0GXI+yEC6MDoQuhCn5Jv6XM6h11pPWt3sd+2dFa2kKAkdcqHDN/qOF2
	e35sROwMtv5hnEr3/OWFsXNkxPHPk2Ho2jbEpc8y/HGoTOELWCvA7yiWL3r6zwb/S4oAn9TqhZM
	qzNPTTYAcQU0CPcJShC4alFWO/d0PTp1L+0yFNAsApqHV9z0i35mxNtH3XLPHLB5kbAZOBXnAX1
	IuMlOXjF/yhgWzZcJPrxuizllqdOLVlkv4zLybi/XfNwOwPF7elcz0lTHZfM+vgPyxrQb7TwDpw
	9xtcfWC0xddtmArrzdnX7/mYr4rN/7JzZVjQEg+a62xt2gfVloj1EiQuFzMP7cS79jlJnQRO744
	Tm+MZmf4HPtwbo26/1MCrqOQuQ3rdzZwndwC6H3ybBIot/ECcrfUjVee/oh91c8d/NNLsY4ODzV
	ln6GZN5YEOrz8kuG1rK5pn4gGD66sToFm/QOPEw9B1PdgCWcp/F9hmL/B98Qwa8TN6V95SQ4St4
	o+v1sUVi1nbeSzQbJ8FHGx5dke1C+6XuPKOEjDxpPytkCsPfv0sDbGYqkdczInc4JQJUQjisbqb
	Qjj5YULoXfhT8K
X-Received: by 2002:a05:600d:4121:b0:4a3:59c9:a758 with SMTP id 5b1f17b1804b1-4a96836988amr152798385e9.32.1793300349381;
        Thu, 29 Oct 2026 11:59:09 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c76507sm4933955e9.10.2026.10.29.11.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:59:08 -0700 (PDT)
Date: Thu, 29 Oct 2026 21:59:04 +0300
From: Dan Carpenter <error27@gmail.com>
To: Frank.Li@oss.nxp.com
Cc: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guan-Yu Lin <guanyulin@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, netdev@vger.kernel.org,
	imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
Message-ID: <auOXeGVQG0UHeoQb@stanley.mountain>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>

On Thu, Oct 29, 2026 at 12:30:37PM -0400, Frank.Li@oss.nxp.com wrote:

> Pattern C: ret > 0 / ret <= 0 / ret != 1 checks -- FIXED
>   drivers/usb/core/offload.c: checks (!= 1), old -EINVAL caused
>     -EBUSY even with !CONFIG_PM. Fixed: now returns 1, proceeds.
>   drivers/accel/ivpu/ivpu_job.c: drm_WARN_ON(<= 0), old -EINVAL
>     spuriously triggered WARN. Fixed: 1 > 0, no warn.
>   drivers/gpu/drm/i915/intel_runtime_pm.c: checks (<= 0), old
>     -EINVAL triggered error path. Fixed: 1 > 0, correct path.
>   drivers/accel/ivpu/ivpu_sysfs.c: (> 0), old skipped freq read.
>     Fixed: proceeds correctly without CONFIG_PM.
>   drivers/gpu/drm/xe/xe_pm.c: wraps (> 0), all xe callers
>     (xe_bo.c, xe_shrinker.c, xe_vsec.c, xe_ggtt.c, xe_guc_ct.c,
>     xe_pxp.c) now correctly treat !CONFIG_PM as active.
>   drivers/net/ipa/ipa_smp2p.c: power_on = (> 0), now correctly true.
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c: (> 0), now correctly
>     executes stall register update.
>   drivers/staging/media/ipu7/ipu7-buttress.c: active (<= 0) early
>     return now skipped, correctly proceeds.

Pattern C is mostly bugs so this patch should have a Fixes tag since
it fixes bugs.

regards,
dan carpenter


