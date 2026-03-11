Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6F525FA05
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235284; cv=none; b=grIDimo0or8afpgpiH1Hrv3ED15FnWiaX9C78JPBg2IKCQMmAhvVKxkGhO2iE+EkV8UbjxkCUkfaBDT8RaIEOBX5pNMF+/Sye4K7lM9jbOe3c3YqqeR0rE0WqtOSZ0TMbbOdlEYYZcG+v9prPyEX+V7XiA08+xaNJPzJIXmYBVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235284; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RK573E/8bwew1tkwNC0GLdInasY2O4258kld3PHEJaZJqRheoAUIvunqF07KipKLrrQlaDJ6Cy/FTHktjAu1v68OErlNzZ4iUkhJIe/Czvk3lyeiZbWzNvm3XJrpl8bPY0/1xUqW7GsUmjawIdtKUdR+VSx8+HyMKw4QZxlIdGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5ffa277c115so4957478137.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 06:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235281; x=1773840081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=dWGZ5UBm9e0qovviRHsTcxC0eu3rMvUGgaU4C9aOqGSDiNxU79yzD3PHWHZAv7b7ML
         pu8/R66kMVYas3NMJULYG3J9Z8hcxEbKtLisTkxS+t52JdUrB1LNxLYTKPsDdv/1ObOZ
         UvGInUf8kW2kzz/ZAhZ9U2Mk0xvJHTZAoDry8QQNS2Z4W6FXvB/0H6iTCYI3pv6NHSdR
         FqriDZ2AgrPeWi4akYVKB4i3inHYVVvAM97MaYnvtGa49VrrNRY01mwsJAEzTev/Z6pW
         TTLklu+wICC0CD6zkuC3eCjpyzyaf8MCsj1e3J7dXOKTlnG+YZM/PUKcTBJDq2qVkC9t
         Sy6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtn3bSx7laQndDZ+PRKdwA5wO9OkLRiBmJadVBo74Z+IBliJq5F8YU8eninsw8vGBvXS6NSsiy1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtaD8Ojm1bbqjyyp5nf/hib7BSSDs0Fe5tH+kslC8i2/aF+3ln
	AIQJc4Bhsu9MeNhvrs20sQWMEGNAwNmuOsep8Na6kChpalv141y9K1BdjC7aI5+W/5Y=
X-Gm-Gg: ATEYQzytheVfTlGdZcDzXCs+SXiWpngOBMJSolApaDljc0r4f8o2tacYZ90pComecA6
	xNx2P7ZOMnWUwu5sdzDCRuvKSm5s6zXkwfTl5oT78UnvctwX8RJmyGODVNtlqVWbZOYlXga0R2v
	A7WgiDDzcvh9BpxE1GD2fy+t4i2ThGKHlcK+vowZuQQ7Hw8jJhx5aeV1AxCsvXAK+0JjJMXpkwZ
	ARcHh24qtSxuy7FURA9zxW8f4BR2gOJ/fqviooUE9CzDKqCI8F/JQYto9gIP3+DWWPeGvYRQHeF
	lZ86rj5JkXXNWs2I2JqxvbnR3rq0o8yXWlRxNd0jNnyLeyNldgPILEpoMTR3dEbs4GSbiXrVH3F
	N3XAKZPMLwumsWnbjpuDR4p/WXcxMdU4mkt1rfst3Ok8RP256lD1QCY3l6e2caUzMeHpsq1Yau0
	IBXDwfbkNgJEdIbuExzXy8YrldnOKl0AXtO5n+8Dlh7qBeQlRkHTEvQVUvcOSA
X-Received: by 2002:a05:6102:cc6:b0:5ff:1cc2:aa8c with SMTP id ada2fe7eead31-601df0391d4mr1068776137.36.1773235281124;
        Wed, 11 Mar 2026 06:21:21 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94ecff71a40sm529096241.13.2026.03.11.06.21.20
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:21:20 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5fff18d44fbso3420663137.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 06:21:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVd8/h/OQU+5BnaQwoMVGGKRsLQP4xj/FRvsxu763gbPa1bNHVGPqwyYSKhw+5kRJYoU+x7dcVFPQ==@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
