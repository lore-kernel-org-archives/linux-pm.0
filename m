Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64E3B14CD
	for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782659004; cv=pass; b=hgt10Xcvw6uwAzviPWQOFpDYmTdn+9NMSYnGBv04/8LuFn6cUqC/Zfp70/ixS44Um83jfXLovaIQg9meG1sgGscpYHkfiqZX1R9WfZ6cdXYGnAB8tZkR6SA9Z/rdq5xASaRnHQvei9HvdIE1Kkc9YJBYFiFBys7c7sCGDDjfoB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782659004; c=relaxed/simple;
	bh=nfvXGen1pZWN7T0sfCH2Bj3OEW1n3dNckFQBTzY8ffo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODM8bK9f3GJfu0V2EEhoNFCc5pzyEHoyQaYbtbLHWjwuC8IrzAi4Gai6VQXuRHMkiMp6zu2p78zuz1TE5p3zjyZA+l0rL9WfSrf5uPORISVZT+O56s592zcCUAknL5gveMySwCnPhFDqDtqX0BfOBVyd9fRTolb7gvUIhFCDMbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDrH3tyj; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDrH3tyj"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c0868ca8738so405220866b.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Jun 2026 08:03:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782658999; cv=none;
        d=google.com; s=arc-20260327;
        b=c7iOsAqWizCzicaoccySkMCN+aweT6EIbnTJ10BK6wI03MD2oGrI8owHCreDXsPutt
         K5D4nuylJay7Sonze7d3sbkjyKtw+FhnVNrrmItFUv5eG2Y90tejzVFTjTbW+JCaIQJ7
         uvKSrRiKkCys4BfWNCmERPjR+p8B6fOItGO4OGvXMCf07AC61Z9hbFcUpyHNHHlCzO46
         d4MTix8JVgmw0S+krQjopLPrd3WvBcxnhIkNng99oqjw7duAMRmPAUjCO419lPMjX2ts
         xBEeeLMR71ABKFGrEWVN2gQFZdrfHJan1JGiYRojKdPi/MZoiyE2TjYaiSKCChxjbIl8
         TdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m+0bTimSr7W6l+WGGk2k0BV0oIenIto2vdlN8jTh3+A=;
        fh=aEx2S2dTE3prHN/COlWUJNUo5NKU/fdiTJIAAJG8N1I=;
        b=T213QCRtJ3ceHceSIO9vDph4cnTuL+yC4sEW/3nTsHd10T8A5SGqRNRRnHa4pLkaH1
         vteSHVBY/mk/N5wGlXit/IbW9bRqS/w0MVTgRLOFqfw2XYLYjUbBOdU0unpF4AutVcX6
         aL+c43r4PPlEx5S/v71qckxc8BzLe8Kb39BBucrQMAE0UcsBxcRb7IaZ/jaGMQa3bOAi
         87lQZWT6cAiw1jrzR6qL8wcCyLjqsHh6Qc/Yw6YiNaACmlFImL1vyGgEOzqO3C/mhM+I
         Eclazzwi0AChL4PMaanNKZ8Uv1ACpNuHiw+ad6tVZE35/FQ8lha3RszD11+rMlliuwpx
         iN/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782658999; x=1783263799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+0bTimSr7W6l+WGGk2k0BV0oIenIto2vdlN8jTh3+A=;
        b=nDrH3tyjTUDEbdenmm/lUYAkB6zhmdRWcPWWzU0JfJw+M7XXKAtv9Hpky/ZbNd36Oy
         DhMaqblewSvaeyKOUfSDb+nxwKxIxsHyfT96yYKgFLP6pwnuvsj0BNCAbkwUa5JVmUfO
         DoltT0Y6GxW7r4CPOPSoKZDRkFToZTYrfJRR0mJtcDxxw0cPmkjMSAevCOgj9vkd5VeN
         xgAbSKSo87PDRnaT7njaToxlSjBYLw4xzFbwsNwmqsbshfu+nXSKQbCgh4kXZfkbgGrR
         gtfMthIDssg+UbN5kxu0z8fmVA7XTUk4PBdahQnbfNrgMRgCja00Ioac9nAfI0LT0FRR
         LXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782658999; x=1783263799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+0bTimSr7W6l+WGGk2k0BV0oIenIto2vdlN8jTh3+A=;
        b=syGLZjUooFKLtGX6r1rkHOupXy4GeU3SrmLGAy2kuQv1qmzoVxu3Vcya9Z1bWWuuHt
         YI+6N5VLM9tg17dcBtjJCvfNfojdY9O+f776XKxvGaxZpe3QGovZJ7tTCC23irykjRZl
         FZhQHDMic6paHru1YHkKBorMAAVV7ydHOl6pECp2d2oZSM2mcRTiNyrcpTCHyk5K4Ryp
         HjqXy5yfrb9nSoKYO0QYzkR2FGoZy1oxMsynONLZsMmydC6xQEu0AXkAoSfg9XhdlRtp
         4nGCUH37yZttQs8PPbLNUY+watOa87Qv3NSp6ANWbwhZ1YDzxd73lMHw72JxTnyfCPKn
         D4rw==
X-Forwarded-Encrypted: i=1; AHgh+Rq+GNiNlJwAMDpzBf0T2pbXl/APjhSw5cxGOf1OGCuKEFo511CZZtAZ/YfmJPYvzZXVLN79wVlwxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQDAf7+OerOf074JwGYpOfpYEgY+A+qq5VQ7v9emHeL0bm1kFW
	WoNsVyN5s1rF2Y2rFHt7eRtld0EAkphH/6JCKV7wDPjMHuonDdtUVV8/jsqygDcoP4IJIxb0GrW
	WMki89tGt/ARnM1f8Puw36ZeCTHaP1w==
X-Gm-Gg: AfdE7clRcp+7YFBc7TkFc/i3+cHRlvQanEt/fOiI51OkGao4ueJERCL8Gup6ltRpESW
	gjbRJoyJfEFn+nI2PVw7LjmjYnvrkhAqr2YZZgyUAVWSgv/Hwxq0XMV5f/VGAi98tjzi9tvQpVu
	pCpqGH4/NamPY0DLTRQx4iXuNc9byJmtxrPA5445RgSddU6/d1hQe7Ru/A653HwBnLJ1gCEaUbV
	6wdyCp4dRD4FLbXnoQWD7eIUSLEDpfyHpamHqM9ue4q7xNd6pI0/nH6+f5saukR1SJk16FsHR4i
	PSBRw8dfQESGR1NKoDjpsyOEUPhyI250ikVDNvDZZaYyrRQb66TYc585q+5O/eE9obwPglrzREi
	7zQ/WWSzL9b7v57M9
X-Received: by 2002:a17:907:9407:b0:c12:3e8e:2ac1 with SMTP id
 a640c23a62f3a-c123e8e2e83mr222127866b.51.1782658998764; Sun, 28 Jun 2026
 08:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626093014.66092-1-mhun512@gmail.com> <aadb5ad9-a2b8-42fb-bd3e-e0f0e641ce3e@nvidia.com>
In-Reply-To: <aadb5ad9-a2b8-42fb-bd3e-e0f0e641ce3e@nvidia.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 29 Jun 2026 00:03:06 +0900
X-Gm-Features: AVVi8CdOluK8GIc6jFjoiZojQQNPt67eF_wXUtJyFP-gdl5VluS7X3Hp9t5TuQo
Message-ID: <CAGEsz8ETT9W6Wu-+BLK3GoL+M-2X+iHamhxYB==4j7biNGFC8w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: tegra124: Disable DFLL clock on removal
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for reviewing.

Yes, after tegra124_cpu_switch_to_dfll() succeeds, the CPU clock is
parented to DFLL. The intended cleanup path is not to disable DFLL while
the CPU is still using it, but to first reparent the CPU clock back to
PLLP and only then disable DFLL.

That is why the helper does:

    clk_set_parent(priv->cpu_clk, priv->pllp_clk);
    clk_disable_unprepare(priv->dfll_clk);

This follows the same ordering as the suspend path, where the driver also
switches the CPU clock source to PLLP before disabling DFLL.

2026=EB=85=84 6=EC=9B=94 27=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 2:18, J=
on Hunter <jonathanh@nvidia.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
>
> On 26/06/2026 10:30, Myeonghun Pak wrote:
> > tegra124_cpu_switch_to_dfll() enables the DFLL clock before switching
> > the CPU clock parent to it. If cpufreq_dt_pdev_register() fails after
> > that point, or when the driver is removed, the driver only drops clock
> > references and never disables the enabled DFLL clock.
>
> So after this change, if we successful switch to the DFLL, but we fail
> to register the device, we disable the DFLL. That does not sound good
> because the CPU will be using that clock at the time. I am not sure what
> the value in this change really is.
>
> Jon
>
> --
> nvpublic
>
