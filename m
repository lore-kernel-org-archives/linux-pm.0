Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3473DEAC5
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834427; cv=pass; b=RJSJldAQeABE0BgP0kZ84FldqobUuaQ+uXWAPtoV9xq1IQ3l4oNoKpNNllF1vbsIjB4p/uNG24DoJJ8jYqsA+ezFskAEg4HMdpV39HchMJugCLmX7SdLBzy+ye3jaPCh7XPM+eiqeucmS3ijp/OvIr0wl6VxknhMeT3nsrdy7IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834427; c=relaxed/simple;
	bh=WIZr0i8mpsqzA7BcAK9yEVk3jfJIgwCxwsW2woQAACQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggCECWWGiBmEK83YkBwh+lCW3A7W2NR+6UoG6yzLif67JocwiCDOzU3y8p4bC7YfSs7okr3d5rSW6ZH+c/xaORr/XUIayff7fU8V6Rxxk2IwZ8vA5xbAl8SiWjZaZVTUCBuSNXrY+GKvfBbCDNd/DWsSFHoA9xvW9maJ6+fp2Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SABngmWE; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SABngmWE"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38be5e86918so109918451fa.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 01:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778834424; cv=none;
        d=google.com; s=arc-20240605;
        b=IOsbG/eLJWFOm/gh/QO2clmQPc/ENKyrYv/Lil5FeguNlA3t7er/zDYLUv6dCZTeEU
         U//9yG+vHRswgS/1vJz2fe9dmaDxjegbV1O2HCgYCmzhywEbYHQvN2f6/QKAIcPfkZGb
         HozNKZqEUmYwT/jDc5238EmYenRyOJ9vxZWCfs70dx5tQJS+8sX2sP1kes2WEQ1VI1HQ
         b2BAumOHBkcJUNixcyJyV57BLTrs4dlkRsnlSoKGowDapOdAkSHX8udGwMlvu4b1JGb0
         abOTQDlEUn7hIvKdGy5DGQTBH3ILwUDlxCJbFoXczWZa5kXkKWL5OeTDU0ndoH8+qtBz
         7BfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tzGpvuZJSAv/O17RMM5TL3mVc0HCLmilw7Xrz240r+Y=;
        fh=1R9/R3thUSmrPwVEv0sCzTxqes2W4K787qJ/eG8f9vQ=;
        b=TEKNrNlJIEc/HrdVrxIBHKqzmH8bjyqH4UpG2sRW7Pq6kv1hjZT0nCWUCotViFnTGK
         rPcIdNfpb3yBn1VllBRuAnFHdsdp7JmXXUvoYbP7R/GSbTGMWSoeDpDF/mYH8AHizi3K
         kgzGlF9zvYMa4f9D7E8qUvz/Y7Fw5PajP9ojCvy26cNV8OIUAYVTVQD47laweO0bdCJi
         sdaCYtVZrDRGDESNP/veoPUdDw2AeTQYXb1dsfG38U50WGPi7mzGc07dZh3pRK2KvIS8
         eOCGGy9gvak6KqpVMzAuNiK5zb4oamwYmE3puJAyIQkpnRUp7yIJXNSy3/i3QuzQH8lx
         ZyPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778834424; x=1779439224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzGpvuZJSAv/O17RMM5TL3mVc0HCLmilw7Xrz240r+Y=;
        b=SABngmWEqo4VqeYBi8WfB3DCcrXpas3s7eYgAJlxzFl6zIICKmY5N8BdPC9LVQw7fq
         imvMczoVlfuG0XIr+ZkayKNy2MZZ7N5HKpl4cFIRGg0BryaRepzC9a0aX9wqBDvKcgdB
         kz8efvGVrhTOJtWlKike61mLfmuWXvfJTjiX5SYMm3FkCfok1GD9ZAnrHURI/SgXBodq
         elaiTr3Wahyvrd8mqcYdFaeHsCo0xo6ceUTLR6bmf7QNYKXy4YdMliKE2iDK9kQAEpd0
         7I/OVgfvuFLI1bbHqHvlLy0ZhZrc+EAHoLMB6Wahhdqgy8YaUDXoqfToTxxMOBuPQQKv
         pX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834424; x=1779439224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tzGpvuZJSAv/O17RMM5TL3mVc0HCLmilw7Xrz240r+Y=;
        b=Mnwz/BEiGvPjyo1gw0PF1WiC7gGigEikLyC2BlxmZxrPW6RBawz+Nm1GabmiuVL7EL
         qPU4raB04WPBcP8HjhvMAC6L+6lxP49+qHINgvktMxvtzXNcfNHNYxrJ6abf6Tgt7HJM
         ZGEHdSq98oNKVWFbLujENqo8bnO2TOJQLh1DwCZRExczqp4fQwXOI6yBvPW8iIiDteQu
         JLWzecTn3XnIqWs5TpJ6NddfEbAm/6IsAJmTTm+hVBy5VQcrkAAOmT/jMxumD6hqLKsX
         wwAUJCkVPhBlysTvO07MNuhTlU4hYj3oMNWLO4+tw/SLXfDx0S+U3NN43qumCm0lVJpI
         XtDQ==
X-Forwarded-Encrypted: i=1; AFNElJ8R3N+3EbhAR+7KesXVM2i40EvXeHlnge5+LEJXVf/o3TqREF2LBJQzl4qhd4gCVmdiey3z+NcCYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7Tgh3n91p/rb/hTSlReWjJ8TRJ1qo2bQzSIhvn7NSMl1vZud
	J//kbauytEgkHjJpZKM+yhFD61H1SwRSWIHqsKBW4RBjmG7b7nra+7SWAB/MdsyuH25RiVXRU58
	3ZHHAjLiTbhrxrTh6Hn9HVkVOwWX24ofqhKYDkGPlprRUI3YUagLSElc=
X-Gm-Gg: Acq92OELix8as3ZTtm4r6E0Z24NiWgygyyq8eIpEt+KEmD4aovgh32Zjsb9lQ4WWguM
	Vanswx1+XoW8XKEIZ7xRZzNjYH6udQr46dXJ3DjbxKUFMAbfLSgLiWZgJkmpx59+0KaDmwSsgp2
	hrEP0IqLjjDLsYIyYzaTbVOwzi2Sj8q6nniyASiqPlKtOiYY1xqkkPsdvvk3md3ZvVDGcHj/Jjb
	SLkEIhrlpfQqoFnyaSPLKk9+idQsgUhPt+VmxnPElsJzPYHDMJ6YPpdgNuvnNvdL2B6NTOg6xW8
	lwaUi+J4GJxCG4O12VB6PgNjhiaSkFDSTn9k7VWK7tRGYf5WiU0=
X-Received: by 2002:a05:6512:3f1b:b0:5a8:eae9:a21f with SMTP id
 2adb3069b0e04-5aa0e740453mr733324e87.41.1778834424530; Fri, 15 May 2026
 01:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514142511.325446-1-marco.crivellari@suse.com>
In-Reply-To: <20260514142511.325446-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 15 May 2026 10:40:13 +0200
X-Gm-Features: AVHnY4In7gWjHvm8Qt7r0wXRpoqBI4fng3esrC5W-eOFCE0Ve77r_LP6RcmVWR0
Message-ID: <CAAofZF43bf6-EfQrSm2O9Z1ECGaMB2zp-VYZ0gWbD-Ne2LN5xg@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: core: Add WQ_UNBOUND to alloc_workqueue users
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 4:25=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 2f4e2dc46b8f..1ac4262dafbc 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1889,7 +1889,8 @@ static int __init thermal_init(void)
>         if (result)
>                 goto error;
>
> -       thermal_wq =3D alloc_workqueue("thermal_events", WQ_POWER_EFFICIE=
NT, 0);
> +       thermal_wq =3D alloc_workqueue("thermal_events",
> +                                    WQ_POWER_EFFICIENT | WQ_UNBOUND, 0);
>         if (!thermal_wq) {
>                 result =3D -ENOMEM;
>                 goto unregister_netlink;

I just realized we can drop WQ_POWER_EFFICIENT now, because the
workqueue is unbound.
I will send the v3 removing the power efficient flag. Sorry for not
noticing that before.

Thanks!

--=20

Marco Crivellari

SUSE Labs
