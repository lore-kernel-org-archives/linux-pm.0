Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968A32E13B
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063310; cv=none; b=CHA7Dsx0eJ1k00TKHrMZe7aRFYJet78Eg7f++f2COJly2IKmvqSB9lrmKOh0t3MqMhpUQcbOUZmt4v6RkCwb4HSXwU11nFvjqA500gulq2OBr3oam/tzkcP4OmZi2PpnJBPWHYLyb1Z2/zo57FKU0o7xcKo+Nh4FcLIGgfdAbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063310; c=relaxed/simple;
	bh=baHwBqrRku0dVBgM9HHXZGHdWlLRvvfzCWPsKKs9a9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEwJoamEZdvMDLJuMl/ckLdw7XTWVOiNwf9Xm9UtHgq9UQr+elKXyi5fz/lmLTVtjD1uqMRKSX9+8azqQieu7dzPx+GaceXABC0TXCt/AHFQu9Gox+FPHN0sJQ6EIP6PT+V80wATf8C2VQXmkk+fB55i0PG2SDVvl5k6M3v9EeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15d47266baso524605766b.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 07:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063307; x=1787668107;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZLIjthuIrGXlcqthi795B+F5PspdtZv0oAeSQHVFTME=;
        b=U1g9le3oEHspomdhVmShlwOHliEFjlAsf/o3n+iNj/UZcKeyL4wlPSA4//k84wbdGa
         DP0WNBH+CtK+7e0/ge7pwi2D5ExcGLDngep6hPNRm54iYVf9q3C9wzZjmMZ773Yjer10
         G6lgU4ldF/i0tKx5S/Pnj+RTPWjMoAF/tSTnRZA4ACQ+zgseiG4EBndgB0PJzP+Ev/kx
         5SjRSyfNNCCdAs7IJ72wAgMneuqhEXYXMl5mdKsInT4mobNREb/f9gABpkJ1W1rW96Er
         y9LIxY/TFDqu89RbP44essshAosGsO607i2Kxj7Q76+m7JA6YbkamNpK7daec3HXTyEY
         qsvg==
X-Forwarded-Encrypted: i=1; AHgh+RrEx8Swd1Iejhhb1ahuKk5WnLQdJTX0jMdEOHLdb0qQLTlzE4JL0SUdl1dILc6rvxVj7QSl0br/9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8PmhLRhJs9S9q5sWA8A41jKphHHwuSgj3v0qSapEM5auyS1nJ
	McoY+euzUWgfOY9+O5KRcvayWcpaF89i4CZBwEkDLxjWVA+2mF/hnayX0TuhqdMTAgA=
X-Gm-Gg: AR+sD12l21/Lx63vUlhsAhIb7zXNdrLv5rpGULzn5EWsUXnqJCT/+WUKPaMwq9hK/Dr
	SlXS2o5ps0Q3cjJ5eSYdZjiTsdVosLSAplKpyH20oZUPcEM3JAsk56WRUvOO220Zez+OIfMDl94
	x26l+NpPARu3WqLFsX0342mJ1l4bJJaA2Tj4oTseXH5gRGiI/eMUDsTmvLli9p0v6IEpXxIzCOx
	a2OCE/l+9n2nfiZMgKG/FbmfLsjAZlPG0+V77KdzDH/tB32r42L9R+YZlZoRnmwPUIaxh2WiEor
	Ki7cHbtBtV5k8/P7HD7WR6FHeu3osUhhOC23RfFm+CX9LW/0gzsfH/j6iQjW04enbq4T34itXbX
	B8yThNKwlNarq/TenkQl9fXYsT95eq7+GLDb8W3BA7JTkAh1EwSCXSvKBxRtsBTvssKE6Hmd1Tz
	BxYpqW3TDatMLuiW7B1H6bIwQWzp75BJt89jEoZAt5wUiAHOq9RCGSY4xnJ6HrzaQVYXkckmEZP
	YHCGR2B8T9oTAA8EGoCEfrsYdgHlW3qgCch
X-Received: by 2002:a17:907:97c2:b0:c12:e178:9e68 with SMTP id a640c23a62f3a-c212a1da3famr1546502966b.19.1787063306919;
        Tue, 18 Aug 2026 07:28:26 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185bc9a35sm162249666b.63.2026.08.18.07.28.26
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 07:28:26 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a17c04563fso6997918a12.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 07:28:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpdgkECeSoIASiUtlkbwXiAt/rgApSGE7eKItjfuSu2YnbJt+UEt91PuZr/Y9wlzD5khoDPynL8Og==@vger.kernel.org
X-Received: by 2002:a05:6402:4608:b0:6a3:6b8f:94c4 with SMTP id
 4fb4d7f45d1cf-6a38a9bf8ffmr14480778a12.16.1787063305828; Tue, 18 Aug 2026
 07:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_64AA3EA1C81C724ED7D0A90390E677BC5205@qq.com>
In-Reply-To: <tencent_64AA3EA1C81C724ED7D0A90390E677BC5205@qq.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Aug 2026 16:28:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXKCnC3RODV0sUyn=011pM68iQDFjC2-AB-OG-F5kw8rQ@mail.gmail.com>
X-Gm-Features: AcwNN1V1hV47wV6X-u_mwvW55lLkp61RRBplSHKa4nvu94V8GF4oXbguLAe_tb8
Message-ID: <CAMuHMdXKCnC3RODV0sUyn=011pM68iQDFjC2-AB-OG-F5kw8rQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar-thermal: fix runtime PM cleanup
To: Jiawen Liu <1298662399@qq.com>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jiawen,

Thanks for your patch!

On Tue, 18 Aug 2026 at 15:16, Jiawen Liu <1298662399@qq.com> wrote:
> Update rcar_thermal_probe() for the confirmed driver lifecycle defect.
>
> Keep the change limited to the concrete operation shown in the final
> patch.

Please write a better patch description.

>
> Signed-off-by: jiawen <1298662399@qq.com>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
