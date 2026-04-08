Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFB29B799
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775639557; cv=none; b=HCt63nist2yzNaEN+DGVlhIH0vk4a9KvMchTsEHNv58JBz2+FeOFeX1WWIA7/ATtV+vHBvQHKRpVkVMGs1TGCI5uBfY0dIPd6S6rBMCG01vtv5UrtYYAcqtrwNSUqD5SGsePhi+/OKbyfXSTzQgoRwoyq+BpWx4HQjLCFgg6nxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775639557; c=relaxed/simple;
	bh=Q2G7W1Or0owdtI91ZRcx6VNbMUQ8in8tYFieOZJhux0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GU3B9x4vkgDAe0e7WbYU/ov1+CqRFFFUdX4xxMYsMHT5NkgMjmWgInGzIlyQUktSfbiTeGdJZpqNmTaHgDXyE81iuAnkKsUq9vRFbaH8s4n65Hz6hGmGkoaBfp366n2YRA6xErBGST/XiHWWkhSu9HKErADJmFpcVztHdgLBiAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56adf76631cso2302043e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 02:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775639555; x=1776244355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1RXcXFvV97L6lA8OeKNobEBQHOghflyQaM3zAQGEVw=;
        b=ovVTgRap1JxFOzC6JEeePO+J8RHm1hzxJwhwC5Ea37jXcd7E5dGKvcwSCnRBYpKsxd
         HBMbzOZBjMFqXgGvGrV+me1Ze+ZQZqCGF+UcnNacLyFl+W2A9T57P7511Hd+62ONlG98
         b3XnMD0Y+Zqwi9gjLJNL6RyxG7xjn987UTnwOp6qIDCPpBzXmXkY0P2JyZQV4MStJ3Su
         B9tHg483ObSeL4HInap5kSlAYeq5jnoGOVpn0Hph9fguB8Jd6DnqsM7Xgntdj6tJiH8U
         D9AEIHSX+Esp4GX/pihd6Fx0is3LWwDwhVqSSXAlHUbQnRieWY6yGKUbl+ZVXZWfyWH7
         s/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX+ZQxWca9uUw59CI1AP2hzyVG5CqR8ez2Bn0gtXs9f5JL3ZsunAL4UkAkKIpXBgSpU2HJbXIxZbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyol8tOB2ASmziZcMmVvmG1FW9fMN8brbZdmjKyeMS8qdfvUJtC
	bSjbDVyMtIEELaJEEZuTJS/Yuz/8s98yw/HQd/xclrq8lqhSO4yKPu4SGvtOp9Tk
X-Gm-Gg: AeBDiesAJ2Ml6IUKTRtm/wQT1mAqAdcTBC4XeyCq4RhSa0EgBrkczSQVVcARRvJRTFP
	oNYUt1wsEMPxZMR3uaJmjJfUruo9eoCptunuqD3oxJTDBynocrdaWIqTczLSV1+pbh/QDNJs0lJ
	mraV7ex6oii7F9CH5hf+zRw3xdtH+9a1DByUEr6fLfCqHxdRcuXvIjyk6W3DzwhapcsZuxu1peO
	OnkYXpqSdA9uyNj7GV/K35wwqe8/RtI3fAbfpZQlV5u7JvrlB5M30no06c5W1y7QEMy4VqpfBxK
	yj6+OOhC93H+tue8Fk85wEMhb0mfmvUiTELrIPkl36xt7JBeQwN51xABnaEdV5DgaYqYFEfJBke
	8v02AvWEraeI68ZhKvU0a1cJwT0xHC7SBXAGXrp2rnpAAib+nCB/yIFBDk1ujslOyPFkXrmPU7U
	LtvGozhmX277HVKFthEBJXiWBOAcYyAinsrfFffoBNfa3MLcVZ17POqT3rwAIdNDFRQjgJ80A=
X-Received: by 2002:a05:6122:3701:b0:56a:fff5:b4d6 with SMTP id 71dfb90a1353d-56dab855a94mr7577369e0c.4.1775639554624;
        Wed, 08 Apr 2026 02:12:34 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9b8d22b4sm20013927e0c.0.2026.04.08.02.12.34
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 02:12:34 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94dcf70af41so1466777241.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 02:12:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeS9N6xBICHZ8R4usGpp9Kwj3Xn1iu6WlWh5FOR8x33rGGhrMl9REJFi72nruj7ngsMsXB5cx7Uw==@vger.kernel.org
X-Received: by 2002:a05:6102:6443:b0:602:8c16:b24c with SMTP id
 ada2fe7eead31-605a4fa88f4mr7481687137.19.1775639554157; Wed, 08 Apr 2026
 02:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222173225.1105572-1-visitorckw@gmail.com> <20260222173225.1105572-3-visitorckw@gmail.com>
In-Reply-To: <20260222173225.1105572-3-visitorckw@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 11:12:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW11i=un_A=JPas1k-jROJg9rhgSPVwbuvpZUBUsc4mVA@mail.gmail.com>
X-Gm-Features: AQROBzAaKops8_lV7H3mM8_tpi90ZdHT60MZINI8ktN2lE8IabpY_mK044Ym5uc
Message-ID: <CAMuHMdW11i=un_A=JPas1k-jROJg9rhgSPVwbuvpZUBUsc4mVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] m68k: virt: Switch to qemu-virt-ctrl driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: sre@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	daniel@0x0f.com, laurent@vivier.eu, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Feb 2026 at 18:32, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> Register the "qemu-virt-ctrl" platform device during board
> initialization to utilize the new generic power/reset driver.
>
> Consequently, remove the legacy reset and power-off implementations
> specific to the virt machine. The platform's mach_reset callback is
> updated to call do_kernel_restart(), bridging the legacy m68k reboot
> path to the generic kernel restart handler framework for this machine.
>
> To prevent any regressions in reboot or power-off functionality when
> the driver is not built-in, explicitly select POWER_RESET and
> POWER_RESET_QEMU_VIRT_CTRL for the VIRT machine in Kconfig.machine.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v3:
> - Add 'select POWER_RESET' and 'select POWER_RESET_QEMU_VIRT_CTRL' in
>   Kconfig.machine to avoid restart/power-off regressions.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
