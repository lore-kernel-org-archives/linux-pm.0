Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991942902C
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661143; cv=pass; b=rlyD5cAWkEm8CMNCL3coCMW1V5AURu6pL9klM8WFGxr6kov1hSAcrQq5JLfe2apMo7NOhZE9CvIQ8nqPLCC1s6ZJt2+9AYS1hcaLcb5lKlFp48sWuu2NfizNqETVHHbp8UBbY4/lyMoGEsWkWfCTZpumm8REuMBTxzNjEhMYY3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661143; c=relaxed/simple;
	bh=YnBg80Q6tdwJGKBmxQ6+aA3hP7hvRLocxQztM7gBv+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VV/PPBZNPavSkxyfEss7wWzvalprqqzTOTQ7JOnjiklF87IegjRqOxHVmOZY8bT8gDgxYxPUs4hCM6OW/rwuvwdgb6s6tI3kj70T0frp6697DHvH4UJ9tNayN4n8TG5kw35c6atvhon5NSqXsJTT6R+zqmmgVUxb2notqqnn+Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJqBq0wO; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJqBq0wO"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-856c74cb7e9so14497b3.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 05:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787661138; cv=none;
        d=google.com; s=arc-20260327;
        b=C0nfBxwjNg2Vx2bm9bzv+WjYqzp1iL+YGWQ19qPPmsJ48dC8JjBAQcFCH1kl2tA1Oz
         Uyoub/BhI748K5F+H1giW1Erkm0Vv3hVyAcB0POl8Al4Ejyj/6k6i0Ko6/Sp7i1kXJBH
         ZwLsxxjK1b60uOxBPHl7mc1cqm2IfNPlpMXZHbcZMaTTTn773yjfX7NQrY6GLM+BDE0/
         A2ONp/lDeKeiho7I0BDRAJF+vA0pTvPWrcFh/Yce1saV4s+UFNbz3xtIEN+Tnppj+uoc
         kewtYkHZazg4qfv0o5IAcE7Up4TrgHIs1cLccjOVey425Jnbnhv4ztD4g3cdjp6LJMP4
         JYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yC0ABnqL3afPD/T9bA9JOpYrNE4Kd3K+0Xw3e1dg3hQ=;
        fh=55NwNotzVo+ba9n6r0Bogr6XF4FyuK62wQXNXD6CBHs=;
        b=T6onWKDd5L85lp8v8THE5MP7wk7SkP6mJIgM7G5SUAbbIwhliKALhU2sIf7HZojEAS
         5m0amsNc+ebAiospGmXJk8bqAH9jsViEt6J+OyR8EXOHjWHiyXkD7MBqqgYKas5Shf0i
         jqQCuR6K1RG+lrk2DLBePNRxKluTF9Khd7vwEMp0vsXi0M//pVyy4iOJnW7ByeXMExee
         41ylMnryqPdmhmwZ3x7zfkYClWXRPTHYAHwzu0e29vvvUghI4RzyWvWRnheprBPFXVlR
         rJvtBIM+GOBTEeNuo0Lb2UAd6oL97sHWg3l87yV2kSNgajlv8wPgFsvgLcjvkRmvnUDw
         HFfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787661138; x=1788265938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yC0ABnqL3afPD/T9bA9JOpYrNE4Kd3K+0Xw3e1dg3hQ=;
        b=XJqBq0wOVN97+04oYTaj3PoCQQFgRzxobReTf4J/5lJevqYijRb6X/xCu/QfR44m+z
         cfLoi81VOI3ug9VG+J7Z2CPcl8kHHTjzH/IeHHFCl2OOkbc5XDpS4clc2xKAqj6Omomu
         CmBlzqnPhFAE+SASzUkjxXbkKz/mHBcM5Qjm+kCWfgP/ZlnvK+Dnhgorz1gGUx8OG9pK
         3wSTTgIHvInqiwNjABECFq7cbaEGEH9VVg0zeMaSpqpbumsb2tNf3HhYlqzzWvNi/Bcz
         X9meBPpY2fD2r6M0uCE7J4foarQH380FQJuGQMhmu8dq0kA7axViTUyTFYYbBm6mxTnb
         LmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661138; x=1788265938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yC0ABnqL3afPD/T9bA9JOpYrNE4Kd3K+0Xw3e1dg3hQ=;
        b=Qbzut8wiCcQSRrSPFjG5zLHsxchkDPvvH3jjUZOAWSnEZnXIM5NWwQfyx8g2hk7ar7
         k0CUnK8lDT2nPF97nA6BJrC8V5yLeffwmV8sFVuGkmVLRkrQOSAl6emGFstxvu6zHbcq
         vTqlKmlPqTsF7btMVzpS6X05T7vZjEcTPGX+UwZpCkGBT3yIbKrepQvg+BDYrpeJ9JsX
         itFAJg28Th+Ws5isisPmpyeGxzSIvp4uetDYXNtB78Ja/3w4gksigaoU60aHlqZ1yUjD
         XKL7ECtDrgR4xolGCVU24155tua0ldSaijKqZys40H6puGaQQSN50j0A0x4ibbCL/QP7
         g4vw==
X-Forwarded-Encrypted: i=1; AHgh+RoKgF9cJ6UQet4O4T/vxz48N7ppPXF4eX5GByONPbAvwF0Mtcvv1A8BYAiVj93GRKXjfFlD953x3w==@vger.kernel.org
X-Gm-Message-State: AFuF++l4Onvh/lixJanavY43MhXY/mpAY1QLFEoqBNqJBu96slucHKDI
	ZwylXAMzgDRXVPJx0np9njIipCuPvyRK4dEsu+iUEoNK5Q2SCcToaQnUUzl9ufopVxnszAgFGyp
	edM9oypHCouY1AsuxIm1oVwFMzev8c9c=
X-Gm-Gg: AR+sD11lTOlX7CYthwaHGfJVQMFekHoR0STaxa6XlhBvruVWRJSOFdOYxoS1Tf/6kIU
	wfmfw7XXfa3sKLH9IozuU3hyX5WXhspxx9Y3tZX7HEn7JoykGWjM3BFcniAyOBZbatJuuLXZC0k
	uFmcrFalGglYYvkbPBSafdfZ6Jdf01Pr+vgsFFHrd4uhzAQqINc1dTNEpPky++SfNitk6aFJBD+
	ZMOCH8swj5oLkWx8BioGKG51H84F79IRwp7WZRCn/dIAFtVbIevcl6X2MOvhFJ9YbhvAoZpXUF4
	qY/+DZ7URb7yjnJMDE9zbK+Alq9OpY6KHHTKHymDcZ3OFRv+7Tqg9pDp
X-Received: by 2002:a05:690c:6e01:b0:80b:d006:6436 with SMTP id
 00721157ae682-854c6f01138mr19294437b3.4.1787661138041; Tue, 25 Aug 2026
 05:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
 <b5265e47492897d0ada844c2ff7f477bb715cd07.1787568944.git.gahing@gahingwoo.com>
In-Reply-To: <b5265e47492897d0ada844c2ff7f477bb715cd07.1787568944.git.gahing@gahingwoo.com>
From: Igor Paunovic <royalnet026@gmail.com>
Date: Tue, 25 Aug 2026 14:32:06 +0200
X-Gm-Features: AcwNN1V1tG9pfMaEZxfyNcf1kB3QFf3O-ye-4Ztbjbyn2rv0eJ21NSEcDStkJdA
Message-ID: <CAEWPSH5MVzoQMaFOEQ93+1pOPmcXCDNfuXsv5j-X8Lb1fy_hrg@mail.gmail.com>
Subject: Re: [PATCH v9 03/13] accel/rocket: let the core suspend after a reset
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	ogabbay@kernel.org, zhangqing@rock-chips.com, u.kleine-koenig@baylibre.com, 
	chaoyi.chen@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

On top of the as-is protocol re-run I reported on 2/13, I ran
one more arm with this patch added on top of 1/13 and 2/13,
same machine, same tree, same config, same JOB_TIMEOUT_MS=3D2.

Two passes (console_loglevel 8 and 4), 13 and 13 induced
resets, all recovered, oracle 48/48 throughout, including after
a forced autosuspend and resume.

The behavioural change is visible on RK3588. On the 1+2 arm, a
round that ends in a timeout leaves the affected core
runtime-active even through a forced autosuspend - the leak
from my earlier report. With this patch applied the same
sequence leaves all three cores suspended, and the next
inference still scores 48/48.

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three
cores, induced reset, JOB_TIMEOUT_MS=3D2

Regards,
Igor

On Mon, Aug 24, 2026 at 1:09=E2=80=AFPM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> rocket_reset() drops the in-flight job's runtime PM reference with
> pm_runtime_put_noidle(), a bare decrement that requests nothing. The core
> is left at usage_count 0 but still runtime-active with no idle request
> pending, so it does not suspend until something else asks, and on a
> platform whose power domain does work on power-on that work never happens=
.
>
> On RK3576 that work is a bus interface reset the domain cycles when it
> comes up. Without it the NPU's IOMMU stops answering, and the job after a
> timeout returns a surface of the output zero point with rk_iommu reportin=
g
> that MMU_DTE_ADDR is not functioning.
>
> Measured on a ROCK 4D in one boot, three runs, one variable between them.
> With the bare put the core reads runtime-active with its rail still up
> after the reset, the IOMMU reports the failure on the next attach and the
> inference returns 0 of 128 channels. With the reference put back through
> pm_runtime_put_autosuspend() the core reads suspended with the rail down,
> there is no IOMMU message, and the same inference returns 128 of 128. A
> third run repeating the first failed the same way.
>
> It also matches the put in the completion path a few lines away, so the
> reset path no longer leaves the device in a state the rest of the driver
> never produces. The remaining put, on the error path in rocket_job_run(),
> is a plain pm_runtime_put() and is left alone here: it unwinds a
> get_sync() that never reached the hardware, and changing it belongs in
> its own patch.
>
> Igor Paunovic ran the differential on RK3588: 45 induced resets across
> three cores, with and without the two preceding patches, and the domain
> dropped every single time with no MMU message on either kernel. So this
> is not rocket-wide. His conditions cross a healthy block with a lowered
> timeout rather than a hung one, which he was careful to say his protocol
> cannot settle, but it is what scopes the change to RK3576.
>
> Link: https://lore.kernel.org/all/20260819073530.6087-1-royalnet026@gmail=
.com/
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_job.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 3c0ed4605..a89ab49e1 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -406,12 +406,12 @@ rocket_reset(struct rocket_core *core, struct drm_s=
ched_job *bad)
>
>         /*
>          * No handler is running now, but we might still have stuck jobs.=
 Let's
> -        * make sure the PM counters stay balanced by manually calling
> -        * pm_runtime_put_noidle().
> +        * make sure the PM counters stay balanced by putting the referen=
ce the
> +        * job took, and request idle while doing it so the core can susp=
end.
>          */
>         scoped_guard(mutex, &core->job_lock) {
>                 if (core->in_flight_job)
> -                       pm_runtime_put_noidle(core->dev);
> +                       pm_runtime_put_autosuspend(core->dev);
>
>                 iommu_detach_group(NULL, core->iommu_group);
>
> --
> 2.43.0
>
