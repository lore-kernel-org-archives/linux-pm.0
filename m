Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC92D5925
	for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2026 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786819530; cv=pass; b=IYWKKFeQLDXeNIwScs0fxR1vk4Py9E1Y3MKMvE6zZlqNM4Rq+WbAPz9cqdD0JOinzvDnofpVNo9UJzm6+c3Kn4FZ5M4cwmGdz4Ab+sAufGPV9PTj7syxGaF2hTnKZX/PYD4XOFVX233ZdwDqrG+EPdF83fOhAmL5DLevojmw/TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786819530; c=relaxed/simple;
	bh=T1ABV3LY7Vo5QByevGG/tXVQufaqefL1Pxjtk7STAhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtnRF/8CwmPYNnYrxKJ3cdeC+t2v3puhIpRPoAbdoZwlpR9awNh4A9KD15QREjUIW5L4dQk91uUkTqpdnagbwQoCkYbhlxw+1PcdsznvAwYpueAc/lIYVMN4qx1Iu/s+vb45DtWAEmZTjzDm22T3QoDQrsfp3VjvM2dYgmeOZrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLtHDZUm; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLtHDZUm"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-836c8bdac50so29121277b3.0
        for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2026 11:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786819527; cv=none;
        d=google.com; s=arc-20260327;
        b=herMRMFKkXp2DNdhm4zC/drixgaJwl+8EMviI02T+hppJFwQQT3oTpdT0iSw01mqKF
         yCMGjHbkm7/0fY2gXUa/dXMZTz/mwv4AkF//ed9/eH+HOK6v1Oz6qKBHg4ozYNuNe+wv
         ZLG6JwWPfRa0g7fAwWW7zxKDGHu/BPmf6zoTlc0Ggzpfkm98Xaq0w7PDE3wI9elOFP6A
         XXQUtTZ6eOKsYqrCgvvoCd2pde92VqrgoB8KvUKfB9qyoA+53aIblC6WgJ4vlZqgKFpX
         6Cs9LCaNFYFQXtI74cq2ZY9QzKEl3rc1p+Z8Z5k2KSd8ILkWeoiB7YP9RjfbpiH9X71A
         9KQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=59CcMF2A+FOjSh/A1Rsp3pg4UuvKJmQFnU4ltvYOtKE=;
        fh=AnfH45I7I8EHqm2GTuxDNXV4ievVSzySP6d3gSCam7c=;
        b=Zk51qQIy7HYtxDx1dnKxG2HH96ppSyFTS6ITUD+YzWSJ/xeU9kpctE5z38x31rzaJB
         pClKujEjt+2XYNvtPRJgLtipms/KD+vn4QamQigw3XE/DLNVZxu822vw8yfWbBcFuNMT
         F9Whok5e8NUktSGxrI8CRQFlplnymv9yT/bvmGSdUmf1OnD3MWyeXNlgvky4hE9to/lC
         FzpMdRNs02hYHYI5rLOjguD3DAQZXtsSTK89KIVKsQnAaGR7s4+3P4se6HUpz0tDIUsk
         hFd1CGPUPp9r1ZlcXYZ4tXYhmjvqLODw6vH7Z4VfeDjtjrx/ZwsJE+Khi9mzUz/ZKZy+
         jymQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786819527; x=1787424327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=59CcMF2A+FOjSh/A1Rsp3pg4UuvKJmQFnU4ltvYOtKE=;
        b=cLtHDZUmmqQw98G+2mj+sGu+yN4C09irbOTWcEZJh2jzZGi+heggH46ccD9OF18uqU
         Z/ekDG1wWMVqVdcEDOIoAJTbTUXC7IM8EGQSTs2smsjrCyNSSNgm6JXvCoTlT6wVdXth
         941kWtLL8lhCRRo+R1Nr/G5sDgxvrI90GeprrZ0s1ZRcVPAN1U/NIUOWqbP+M+tbBmH3
         xQsTZ/7fNVUCiKPwxkWAUfHtWsSVSYZmUJ4u+P08Op3XPhHOIv3LKooK+fyaiFg89WkD
         lEhaDHs7IW/fshJBmoVtXOJlqEudLjhpCdHYtFW9AUdbN1rkG5bTO0ejDzz9gEWBPzK/
         7LTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786819527; x=1787424327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=59CcMF2A+FOjSh/A1Rsp3pg4UuvKJmQFnU4ltvYOtKE=;
        b=E1+qu7lFizjk3mUEUa6AhR20+AW1qg0zKFHtNcmblnn3r3L9+KiO7l04cq8Qyc4Eot
         A/Bv2oj2zma8jRdcbUJjiwiSMCPcZJzDfeAzUkSmVGHwoyi4oFG47MoLMYR8U0zaYXw7
         608L/iU24UlawLJGUqM3X0rHV8EiTSr3x6jLcQ71wXnBK32BRpQFXVVH6uEY4DXED9Ay
         arpSxF1rhyg1cn/WilrMyuKaexeeLNBT3nKCyhG98CZhht5/BEGx2DWsOLSIbHoW69/C
         ZFymBrB+pPtsZzJB9X/Ly+EEHhw5uvZKM4cSaIXDaC3hOuabgkD35aJSA8ZnfxFDlydO
         A6Vw==
X-Forwarded-Encrypted: i=1; AHgh+RpVbvJ6h1A3uE9hDK9LPaF8TRTtsUXghL3KlOZ5hZx0AGdtMDCHaXv20zqNrtSzpezwJ0ARzQWNag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrTULM7c+bHoG7Z45N8eLudtnwo5ClW5BYfAPB7F5EiIvQHhJB
	ov73HFX9GqY3LmtFJiEQIUiVlSGPeHnuWVL8Kq2/SHd1KjKyHgUmHNjzLSw73oG2ftcLV+RQDzq
	Om5q2gK91yHnAeZsvIrK0RLGyEHGweuQtBw==
X-Gm-Gg: AR+sD12Kv3CHju59emXG0NL0WZ7OiIwp0TVK9sDJ14onoEXicOKZ2/0rKAIieaOHwPD
	r+M7VXf2+zIvKXZsWGOniOBS2S3fb4VnpfvCFJRm44d/ZVCFs6IAkKBjkM4GsWdXAgUzwHmvanc
	gHCseGu6rhqik/71TYInEdZzvXI+RIdD11s6KsEHJuYmGCfd1YnTSs50J30KCx+m1avwXtaYGoR
	3X9kD3+7ZvAMH1DpKi/8rnpHOgJk8aiTCe70dM43C9PCG2paLRIXNe7qpqNHPlUcgd31NBnL04X
	zeDBUUwUUM/OmwG9KMQSZ6r5PSt8mTLsaN/WIbB+m9bs2Q==
X-Received: by 2002:a05:690c:e1c1:10b0:81f:2825:dfe with SMTP id
 00721157ae682-83714123b9emr41742057b3.36.1786819527485; Sat, 15 Aug 2026
 11:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726040303.280299-1-sumeet4linux@gmail.com>
In-Reply-To: <20260726040303.280299-1-sumeet4linux@gmail.com>
From: "Sumeet R.P." <sumeet4linux@gmail.com>
Date: Sun, 16 Aug 2026 00:15:15 +0530
X-Gm-Features: AUfX_mwyGuH3zXJz4OAdmhT4QErbacJJFvLEBiP5Ul9vrVa05HzAs2gfvh3uUEM
Message-ID: <CAJ9orWRp=zKJBHm1sS_ZiXuA8nhi-Cddi+s2JxWcfmsRdC7SwA@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Fix kernel panic during PMU unbind
To: rafael@kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 9:33=E2=80=AFAM Sumeet Pawnikar <sumeet4linux@gmail=
.com> wrote:
>
> rapl_package_add_pmu() fails internally at perf_pmu_register(),
> and rapl_pmu_update() leaves the global rapl_pmu.pmu structure
> zero-initialized via memset and returns an error. But any
> previously probed packages retain has_pmu =3D true.
>
> When the driver is subsequently unbound or removed,
> rapl_package_remove_pmu_locked() sees has_pmu =3D=3D true and
> unconditionally calls perf_pmu_unregister(&rapl_pmu.pmu) on the
> zeroed-out structure. This attempts a list_del_rcu() on a NULL
> list head, immediately causing a kernel panic.
>
> Fix this by checking if the PMU is actually registered before
> attempting to unregister it.
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>

Hi Rafael,

Gentle ping.
Any chance for this to go into next rc ?

Thanks & Regards,
Sumeet Pawnikar.

> ---
>  drivers/powercap/intel_rapl_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index 1006d183d508..22100f1ca222 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1652,7 +1652,8 @@ void rapl_package_remove_pmu_locked(struct rapl_pac=
kage *rp)
>                         return;
>         }
>
> -       perf_pmu_unregister(&rapl_pmu.pmu);
> +       if (rapl_pmu.registered)
> +               perf_pmu_unregister(&rapl_pmu.pmu);
>         memset(&rapl_pmu, 0, sizeof(struct rapl_pmu));
>  }
>  EXPORT_SYMBOL_NS_GPL(rapl_package_remove_pmu_locked, "INTEL_RAPL");
> --
> 2.43.0
>
