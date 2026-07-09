Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A213D3321
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629223; cv=pass; b=kBtoTc2/1oPJJjCNkrh+XhUmY592cDFcn64+TawSz/N6PDw0OERPrHGqAxTJUmkSSq+5W1m3dGCnzamiN/26OCObBXAIV13K8bJ5prfTn2++8ypO0kBome1q/CsAWhHq9QSE0qsoBb176M015p9JqmYE8E6NpNN+hXITy3PA3Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629223; c=relaxed/simple;
	bh=jMtcbdMjpbPZxFzIQEO/tWpTrxEOHPXtdEvc/wBne44=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYFmsrH7w+pcMk3EeawvmyzETxtlVQ5zQG6tRcwUJnBtoYI9CJppaoHkvU0wNN2xJMheBQmivYCD26JAhAJOsFgnEFCxkixHY6LqqiQ4k6ocrRGTmgCmrUtMdlZru+PX4S8PpVnmhA8MduttFhSZ/Km9S1sviS6+Fc85+TvFbkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=VlRCHdPy; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="VlRCHdPy"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-806449d108aso3192397b3.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 13:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783629219; cv=none;
        d=google.com; s=arc-20260327;
        b=JGGrDNSaDy60E6UiqokleTiVP2Y8sq+2ZT8p/m907/8atIeUKm2Nd/47f+lklR5KIp
         vHeB/GHqzvee8HQKDhTeJQEw+cF+kLeGsL4U8EJUF9yXIFVvos9OBY3hVRombaevTl5k
         gImCc0lSFzGq/ICtnoyWFwKlQvpDswjjHGzJzgbwfse5ceIGtaG1YTyStxnWq475jIeT
         /o6m1PbHHGoDC9T778p19qALYnI6qOE+msCnIOyJaeNZ21/psdjAlJNwJI68pVGuGTFF
         IRs2wAVOgnjBVvZA9/UNS00oa6OSb72yLkrf9srQSwDchTq17sOd5UPC5c0ulKo3rjjA
         0rHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=jMtcbdMjpbPZxFzIQEO/tWpTrxEOHPXtdEvc/wBne44=;
        fh=SQCoNYA3bvRoRwVgRWdn3G2H99ZZkjzT217veCYBcnE=;
        b=o3V7hjk1o7xqDHHk1XZN6c0iwhXYEM3vNSs/x1qo6Z/7mDqqectkxSgC4ZNpxUWjkS
         Fn7q6/2xhIF1woNeFjB87O087rTBe3Q4pMxFrFl+S7WCah0R2PgRGRKsyMzBPCpAfAv/
         lSdNQ1tX7N8vzrbPUIfgnKhVyupTay+oVUQvbj1CElt+UNtjZTCJmiVjQgoYh1TfNq18
         fNt9UYpzP06+zQEovEPpLQRZ/0k24YkUImJvque1yv63Ogtnf1D1kCdgECDY/KyqCaWR
         AJB1KGR3glfRHP/jLJYz0wBxFAHQOtyFod3JepWUXtaINJVeTNNiCQinhX+no+F8sUN3
         eHSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1783629219; x=1784234019; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMtcbdMjpbPZxFzIQEO/tWpTrxEOHPXtdEvc/wBne44=;
        b=VlRCHdPybmmI1KGrJj+aMkKKEwH0FhtUNHdc0R49LkPVSH0KLwLVF2HqBsz26sihYC
         JzGRzq+EjrXNwSGcfDoosmtiryQsP4nNjMI6VZg7n2LGrrx40G5+QwffHlxo4N9gNWzU
         05eWV/gB929ljDO2a0GF8uNXbiE//CH1nfPbQw2ZpkFmu1MH0VmMa5KmpLj4vRKkd4xr
         YXCwLzV0FNy79s47pTx9c8me4PY9Po+8CIIyoO8udqZr4VZ3lsum6NQEe7vu9S2DyYFc
         zquNBeUlPkfl8pIgqVcmmo9VJGGRgPFw+6BN4Az/iL3uTStTLO2DRKcU3NC7qCfS6UDb
         4PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783629219; x=1784234019;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jMtcbdMjpbPZxFzIQEO/tWpTrxEOHPXtdEvc/wBne44=;
        b=Y6s/1U8XaNZsZPFYqXUmBmhS4FyBPNMOO545zeX0GYvi1p+khW5HloRrOXYc9MV6sc
         8tc9Vli/2tHN6ZGkYZLWFbMLjNNI0dgftEDTKumRbEKnM7ZGwppKoIulbGM1SZN3L5ub
         YbX1JDwbEZvN34BN6Ivtf6mC450rjlQSF4obr1/ucIV3Vmv9PBy+qRU8TzJoCk3/P9U/
         g5pKsnd+myw+x0UrZWI9tPGJkidxlpPUSRIU6isMVf5vKuA4yUIuS3hGMKrBuyc1lwEB
         Wz8VQg/iHzuTmaTjGpuE4f7Hziqz5/I94JNsyRQAz7m78UrkzCLshiyNNwbQAAApek5D
         cP5A==
X-Forwarded-Encrypted: i=1; AHgh+RovGmVJTX1xwCao3AWAWiuMsj9iV1J4oUk/6sEmmqrAzGhzI0eWaZUVGyDU/eIkw9LGK0RxpLpjrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZkoHDccKUo9Z8r/7fcM1XsJ3jj3usktIMU+S8pHP3Ry1Pqhr
	L+SZKNBGMiPk2iIQcbp/IN2a3AbOlig1l7FA2AdU6+GKWb/BZIHhEj4ZFzKmb6B/ZvA/7+/rhf2
	8eBE9pbDK2jEqc0d8pziX6YriwP3oy8UlZECu/xQV
X-Gm-Gg: AfdE7ckGhVeCEcoyeVj4hcCyQPmjulCB8XQeqHIGnIlYtT/DbTN9oAzFOiRc2R5R6Vc
	ZdXp57cfVRax3X6YbHsQp0t2fY5xorb2XlsXbHpYXYdTga2pHoYlYP5MZJb8U/tx9XKqKFrbVzs
	SM4gGQ1Ccp9sBpk/gsK1466xquOMGFAgS289nzX+fRAdgm0VkttrdJsAEV1mPNM7yZSJtoGd1n0
	7WGr18f60Gb4ilFA/1yIEUlfELkX45irFYpwLaHCrGEdg1rYF0NUl1NlshzAsLYzcYSgPi/Ky8f
	KuyoE40ZB38eX2XYVqs+Yt/XpeQ=
X-Received: by 2002:a05:690e:150b:b0:664:ae6d:ad28 with SMTP id
 956f58d0204a3-6679f15451cmr5789029d50.66.1783629219309; Thu, 09 Jul 2026
 13:33:39 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 9 Jul 2026 16:33:38 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 9 Jul 2026 16:33:38 -0400
In-Reply-To: <CABtds-0AUr1jD2Sri6ViiFiqyBbjc3-6xeAOr12YLJA9ux-2BA@mail.gmail.com>
References: <CABtds-0AUr1jD2Sri6ViiFiqyBbjc3-6xeAOr12YLJA9ux-2BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 9 Jul 2026 16:33:38 -0400
X-Gm-Features: AUfX_myqQ-bWDD15nf3rkjgivCsr_EhsGHyEecNL3wwNc7IvLT4cfvzbzaUymKw
Message-ID: <CABtds-1d8uYi5YbxgbL5MwZOXTUgBmeLQWiggVhBKtqct5VC-g@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Allow hibernation opt-in when locked down
To: rafael@kernel.org
Cc: lenb@kernel.org, pavel@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com, 
	keescook@chromium.org, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please ignore this patch; the approach was wrong.

I'll follow up with a v2.

On Thu, 9 Jul 2026 12:23:11 -0700, Sean Rhodes <sean@starlabs.systems> wrote:
> Kernel lockdown disables hibernation because the resume image cannot be
> verified before it is restored. On systems where external platform or
> storage policy protects the hibernation image from offline modification,
> users may still need hibernation while lockdown is active.
>
> Add a hibernate=allow_locked_down command line option to make that opt-in
> explicit. This only bypasses the LOCKDOWN_HIBERNATION gate; nohibernate,
> secretmem and CXL memory restrictions still apply.
>
> The kernel does not validate the external policy or authenticate the image
> with this option.
>
> Build-tested with Fedora config:
> make O=../linux-lockdown-hibernate-build kernel/power/hibernate.o
>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
> Documentation/admin-guide/kernel-parameters.txt | 5 +++++
> kernel/power/hibernate.c | 6 +++++-
> 2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b5493a7f8f22..0d20ad9c7d78 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1967,6 +1967,11 @@ Kernel parameters
> protect_image Turn on image protection during restoration
> (that will set all pages holding image data
> during restoration read-only).
> + allow_locked_down
> + Allow hibernation even when kernel lockdown would
> + otherwise disable it. The kernel does not verify
> + the hibernation image; only use this when external
> + policy protects the image from offline modification.
>
> hibernate.compressor= [HIBERNATION] Compression algorithm to be
> used with hibernation.
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index d2479c69d71a..71232eece9a3 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -41,6 +41,7 @@
> static int nocompress;
> static int noresume;
> static int nohibernate;
> +static bool allow_locked_down_hibernation;
> static int resume_wait;
> static unsigned int resume_delay;
> static char resume_file[256] = CONFIG_PM_STD_PARTITION;
> @@ -109,7 +110,8 @@ bool hibernation_in_progress(void)
> bool hibernation_available(void)
> {
> return nohibernate == 0 &&
> - !security_locked_down(LOCKDOWN_HIBERNATION) &&
> + (allow_locked_down_hibernation ||
> + !security_locked_down(LOCKDOWN_HIBERNATION)) &&
> !secretmem_active() && !cxl_mem_active();
> }
>
> @@ -1433,6 +1435,8 @@ static int __init hibernate_setup(char *str)
> } else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)
> && !strncmp(str, "protect_image", 13)) {
> enable_restore_image_protection();
> + } else if (!strncmp(str, "allow_locked_down", 17)) {
> + allow_locked_down_hibernation = true;
> }
> return 1;
> }
> --
> 2.53.0
