Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1375371876
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784732479; cv=none; b=RTcKebxnmjo6qpxgQtI16INfKqRx3G1uorVpID6tTHuJs7X+TZ0wyju4m05vjBzEM5Jnvh/2dU4GK5ntjTGAHD2wfBgK+2TRM2Vw8eGrDveIMWoptnuQjnC4H7BCX60LBeVyjh26Bl3cPTKDa0BsGcj8ZbDnLxgQZqEOV2DiJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784732479; c=relaxed/simple;
	bh=5RQDVREGvepP4YS9DqQ1PwGOoEcNiw8dSn8Ex6p9I20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8bNeVt/Qc51awwk9HAsz+tqxa0M2029WcMnXCWR/KRf9aE4tzG2BYQQSt2EC9URxJlL0YhC5rSCM+/2ILg9eGTdwqDr0hrKIVSZPX0Jdbm5Zv57Yi15K4HMtZrP7ojNysV0tHivMTrLPScD9+1txxRdQwLkoGTO57w3gfU9C3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEJK47Uf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEJK47Uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30451F000E9
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784732477;
	bh=SZXtpRBw//OfkYVFeWs/nNG2P6DYPIzmSe0gGNd/OcQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kEJK47UfhcMJzrvx7cNHx/wtM1gpFAbf6FbGeMn1oBxAec9xQ5ubGQDPNVZmRt4iL
	 IebV4s4ikqBBwetvDftSmFxYCrsrSGe8OA/UC6yFkBsc3iLOfHgcY6hEgkHUdkcL57
	 JrvEB4YDcWyBsyWg8IaGmifM761j7Rid9RAwsVBi7MjoKbzwo1CimPTXV+lJoZB6kF
	 CnmpU8npK91oPnqpT6Ky1AIrGQn9YfSBfEagABk5bmYP0wcIvgLR959FpE/Kx4qAtB
	 UnKbXdqYI6ObUHK4V8yVkxt2VqF+9CWpbS7IWQXtRfnH3uFQ8b0g5iD1s2eBvfTk9w
	 AZXF7NGYOMhKQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c7fd45465so103792511fa.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 08:01:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrG4KUQgpVxLAzmD+crrMcLdvWzms/5RxcyvHUHQRk/azvhSqCk+o/3KKAFaSX4N62Eig1lWrB0Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YygEsEqC5tjxy6+/FATkm7aAmNnEC+HDtZY3z2A8AUu5INtTs9+
	ltNquEf4zvpeE19z7Dv+uz3R9n4HKJ2a2OD7UfZ5pwcXiHNUqui8ugJF00+DjZPo7C0cmIynPj5
	KG3FIjJtS7EpZRF5jAPwbwrymVTSzGy8=
X-Received: by 2002:a05:6512:154b:10b0:5b0:23b4:be97 with SMTP id
 2adb3069b0e04-5b28f87cd0cmr2836434e87.6.1784732475860; Wed, 22 Jul 2026
 08:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709023048.599150-1-panchuang@vivo.com> <20260709023048.599150-12-panchuang@vivo.com>
In-Reply-To: <20260709023048.599150-12-panchuang@vivo.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 17:01:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iV-9R3j9EhyG4dvTDZQ+JUecgVwacR4N8f9vZRXBfTPg@mail.gmail.com>
X-Gm-Features: AUfX_mxGis_A22bVPwS_86_51jrxcIPs5DCaG931IxEIybWG27lr2R8VG4XlT9s
Message-ID: <CAJZ5v0iV-9R3j9EhyG4dvTDZQ+JUecgVwacR4N8f9vZRXBfTPg@mail.gmail.com>
Subject: Re: [PATCH 11/18] thermal/drivers/intel/bxt_pmic: Remove redundant dev_err()
To: Pan Chuang <panchuang@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:32=E2=80=AFAM Pan Chuang <panchuang@vivo.com> wrot=
e:
>
> The devm_request_threaded_irq() now automatically logs detailed error
> messages on failure. This eliminates the need for driver-specific
> dev_err() calls that previously printed generic messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/thermal/intel/intel_bxt_pmic_thermal.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_bxt_pmic_thermal.c b/drivers/the=
rmal/intel/intel_bxt_pmic_thermal.c
> index 6312c6ba081f..aeaefbbd5d8f 100644
> --- a/drivers/thermal/intel/intel_bxt_pmic_thermal.c
> +++ b/drivers/thermal/intel/intel_bxt_pmic_thermal.c
> @@ -245,10 +245,8 @@ static int pmic_thermal_probe(struct platform_device=
 *pdev)
>                                 NULL, pmic_thermal_irq_handler,
>                                 IRQF_ONESHOT, "pmic_thermal", pdev);
>
> -               if (ret) {
> -                       dev_err(dev, "request irq(%d) failed: %d\n", virq=
, ret);
> +               if (ret)
>                         return ret;
> -               }
>                 pmic_irq_count++;
>         }
>
> --

Applied as 7.3 material, thanks!
