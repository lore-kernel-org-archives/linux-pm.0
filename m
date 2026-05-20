Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8231ED81
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779269061; cv=none; b=Wg+Tc7AmEbkBlpYkK9t9/BQxvxx4pWR2kT/w7orrkp5G/4pNDNiEQIRygrUmm4uBJ0lyRhVzFrLv3u+EIkZ3BO37wLnOMAvg2XYssMMZLmML+HqcFhv6Zm+UOCacpDUcShQgbnDH10jPZa+XmLKIjm2FTqNyk2Vq0Qr5EB9IzGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779269061; c=relaxed/simple;
	bh=t0R7qCOJA+kypC4pLNsFX7y7i6Obkil8w8Yp7ar07jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlaZ6e4osro6vIvPAlhuP0uEtUmxaeA1NcqfUWIDMisZIc9XSt+z6Ctrj3vDJ8evSB7x5JISzx7Us54gg4ZCs58XFVKATzMM35wXHuzksFmAhU3vfBXGj0hg4/Z20zlpIT1I9AzPLuTUi/LNMtWKQdb93Tk8rNsmREv4FvL+ox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-575267e3398so3833033e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 02:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779269054; x=1779873854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWlK525gobXa09fkjsvfYWkLJerETe977EgEuu7dj3A=;
        b=YHRtJ9zpmAQFtsMOylxFTFuDogZ3AzNsse7XVTy3l9gAbDJEmhJKXXoGrKtg58Ft2E
         W8J1JQQbJpVsr7BUm8W/Q6jITkGLiULMWnQdlUNKeMoieTERfjkFjl43cXSLgy5WyWON
         BHyjNlru7OV/i/Vb6vhDQMoomuIVYHBkbbNXjzaixxviCMgKrATozE27CfV/Sv52CasT
         oZB9kl3WIXcDevdlVZHlcgEHxG31qNiquqFqCxGXQWM3ZdTzaUW9KJD6wfOrTv5TCrHT
         SM33w94YfVt6dLgI/xfv+vwHAox0VX6AZdjr9gkJxCIaTmWPEwiBfi7iBHNNBTpUeQtD
         XRCw==
X-Forwarded-Encrypted: i=1; AFNElJ8sbfk8Adzg1BD7XNGT+ueFapYQI5A3bCCU2xZoWuz9xnkO3EZJabG14zKkaTZzuOA3S1uW8ja8zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIh2pQhDfIO4JFeG01EbFlrRjDJvwXyrtu9xzoqyoriBpwGgA
	8xZvZrPwGMhzH37/Ec8GW9/w7+QOonzxGt+apIJHxAG7kzODmCUJOV2XDehiytgT0T0=
X-Gm-Gg: Acq92OHdPdSFVNYr7PMTBd4TVj2TnJ+UHgmLIBc5qnIYBP080IKvFOk3+Ytvnunmopl
	5ew9IGaUUZI3475Egw95ctUNFp/kPI66d5qjQy7GYoYaBFem8IpmTPgc0jx/V11HQdbuBXgxyIR
	6nmGjsczy/jVE6DJWhAS4jbClJ7/Z8tCVkzz2fG9fWWxU3XUq/1LRJjvMODr4EGdf5M60rc7KuS
	GgiUcng+/sauuckxKJAur4HbS/kxFvCzG8+bCg7BB8NLimWg9k2lc5//0KWdMNn7PHw4kp336f0
	gDu0IOojeLrViTVxm/TW8WH7d2QY+r6ltikyxsi+h3xHU+UehkBT2qCjxtZfBaqe9M/aNwqfo3x
	i0a3hN5fastBgipU3wMOzQN5Dck5zTMvZdMqxWJCQQwDLy+sJBpjFo9swoVNpaSK2FRYYdKBwDo
	a+qpZU9S8W9v2iVITojykT9rWOL/hUxvW8cyeuEM0raTmKkQ3ZjF4GuGcwmm+x
X-Received: by 2002:a05:6122:6857:10b0:56f:bb91:4861 with SMTP id 71dfb90a1353d-5760bc5ab3emr10288255e0c.0.1779269054456;
        Wed, 20 May 2026 02:24:14 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760fa5bfb6sm10350638e0c.10.2026.05.20.02.24.13
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 02:24:13 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-632e479586aso3252188137.2
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 02:24:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/qBJ0xcglmweWaDJxP5GXj4fijAjdyum2lk95gS2GgPpVoVoU94n9Gk62jBJyx7bn5r2on6VqjwQ==@vger.kernel.org
X-Received: by 2002:a05:6102:3752:b0:631:81d6:e153 with SMTP id
 ada2fe7eead31-63a3fe96d2cmr13359189137.30.1779269052807; Wed, 20 May 2026
 02:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520091638.68370-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260520091638.68370-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2026 11:24:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDdS1_69+36h=HRKGvbZQ9j8_ma_sFW=ajXy=sn1M2Cw@mail.gmail.com>
X-Gm-Features: AVHnY4JncTFJPC2vXbJQCCFkFYfP6cmRpG6koumSuxYI6KHadzsWv8rM-ius6wo
Message-ID: <CAMuHMdXDdS1_69+36h=HRKGvbZQ9j8_ma_sFW=ajXy=sn1M2Cw@mail.gmail.com>
Subject: Re: [PATCH] thermal: renesas: rzg3e: Drop stale syscon documentation
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 at 11:16, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Remove the stale kernel-doc description line for the 'syscon' member
> from struct rzg3e_thermal_priv.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fixes: c33edd8f936ccf2e ("thermal: renesas: rzg3e: make calibration
value retrieval per-chip")

If commit bf746e2a41efd986 ("thermal: renesas: rzg3e: Remove stale
@trim_offset kernel-doc entry") would have had that Fixes-tag, perhaps
it would have been noticed that that commit removed _two_ members?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
