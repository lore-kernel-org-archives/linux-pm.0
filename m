Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D01FF5E3
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775639463; cv=none; b=Bda6j22oqvNHBcK7Q5RbBtfBXbF2yTQcmeiGUjueTgL+5441qHzamCMoYnNQvZ8uvrXDhQYMjgOBfeF2ae7x8cS7psh3347QLONYVqljgtEFSmoLC7NzU/K+whND1odzqXMLlmJv0NO64enqSjxW4U5i2zEnawMUSDYNo6DQH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775639463; c=relaxed/simple;
	bh=6f+jnpEHgb/hkxjXUIwHPDmvMZ0/IajHJJ3bP4FLF/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQqDC9FraSYL9jl7W2IPkwHmh2T80+6l9HlsYjYkqm14IOtK7BGTiuGX4mLQialpFxoLtnqYDmO421BExjwtSekkWnamIYpbU387Y7xwhiQYZs3uPlK3gzKvdLoiSTMBHRIHpdzU0va5ImYlOKK/FviZXVfQeuEGs2vCdnWJTDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56d95bc93e3so3837630e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 02:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775639459; x=1776244259;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubu8sHm6i/hOiW9sxIWJt2iDAR71LSPf1yhT9f9dW3Y=;
        b=lHl1M+2K/+9ryR0JHEuNgHNK2c2nLD7ioTZv5mWIk34BgeNLlNFaHPj1KanpEk1apn
         tlxGGne5O1SWN8VrPq1Wjx9hDPA0C8rOV8LYgkKuqhmQvwDsv0PTUyMsNRgLvqqeZFLJ
         yaMA1yCU0nneMgkFTPINzyrVeqEWibUkU3kdQK4wcCp2LAOoMrFa4TYOmMItOj3YlYym
         PS0hlC/6vEIuGANnMwFtVFK7dSkbmlQbD+PkHb6eyTl2KNf0+RL48yyFVkeXIiGQ57D0
         5zFhTA9vpNwlnLZdsFhgEBAjLKhe6VRft4IdUS7HfMUf1pXJv4I9lsKVjeoxVT1zLDma
         ja+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsh5V2b4DfoKo1uS9f9TgaQ7WyaDrUGevV5Jj/oB4udfY1O5mWXUGtWXSfMa104/G+6HNFPFY7Wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YylauZEA2BceJAEVx46rxB9aw56tcXF5xUSudzg/7DeZCB1KKLF
	ocdcdN2qenmEOyBgtMbDNcxEmoU/ZrwyTOEMcL+HJzqGHSFCYzA9Xdf7xryVdVgm
X-Gm-Gg: AeBDiestOGOMSz9mgiux+fdm5woEzEDX+xSEgDx00ZAHeK+TBKv7vfVLYFjn5ak6o0u
	Am1BYF+CzoT7Su0pD1mCq+E9vxJ4PpujTSmSMGoYwkQqIqHX7bxXLARPME5pGQznaaM2n/zHXAy
	uOE2ASZ6LpDK3hy145SpKvVsAwAJ6J3BWbpTC69IEMPZppY8a8C154CsilYTgjrTsPuuMa3cJW9
	66F2LNFASf1+7Uz2aqxBw0MyIeHPriOLlhuPkgbPJpiaZ9gd5Whn5Q4UvfOPcIoy2vKzjWi4rlJ
	L9sxlKVo2Hd9dMlVJkLEGEhicJS/Zi38+O7+9hlj26GijnlCvoCsXLxSG8R3tTUwwq/K2qfi/o7
	CDeNNqAf5Z4L7igYdd5NNgmmGJUt34eiuSo8mGIp9f39BlT8AMidxu8jCE35+3TCwsCs0typpHo
	/jZRyaKIAXnIuLCVkuPsojT6ySMSrZkft2X1MammXp9ww/gtZz1lmwoYcJPGa/
X-Received: by 2002:a05:6122:3117:b0:56c:d862:37dd with SMTP id 71dfb90a1353d-56daba00310mr8271550e0c.14.1775639459569;
        Wed, 08 Apr 2026 02:10:59 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bab899fsm19704203e0c.5.2026.04.08.02.10.59
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 02:10:59 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-9540bb77b1aso2928752241.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 02:10:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUZ0BBM6bxlf6Msof5Qyt9Va+5d2zKZLbTlx4UenyZlZaigrP1W3GVuLM50xHRHUqdVpbuJ0Lctg==@vger.kernel.org
X-Received: by 2002:a05:6102:50a2:b0:5ff:fbe4:8a8 with SMTP id
 ada2fe7eead31-605a5050f24mr7833147137.25.1775639458863; Wed, 08 Apr 2026
 02:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222173225.1105572-1-visitorckw@gmail.com>
 <20260222173225.1105572-2-visitorckw@gmail.com> <ac7kP64nbhZzwbJV@venus> <CAMuHMdUSTdrv9Dswez-QrcFTPwnnFy7m5gc-ScMwBfQLDayQZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUSTdrv9Dswez-QrcFTPwnnFy7m5gc-ScMwBfQLDayQZQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 11:10:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU3mkoq-u8wfTFZLUsr5m4zhydz6F0SCYousB2sGh1Kvw@mail.gmail.com>
X-Gm-Features: AQROBzB4597n0SM7aHpi6opYDxhH0NOyPaIyIfwdGHz1aqfUQiTn2K-ymQ4LNtA
Message-ID: <CAMuHMdU3mkoq-u8wfTFZLUsr5m4zhydz6F0SCYousB2sGh1Kvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] power: reset: Add QEMU virt-ctrl driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	daniel@0x0f.com, laurent@vivier.eu, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Apr 2026 at 11:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, 2 Apr 2026 at 23:52, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > On Sun, Feb 22, 2026 at 05:32:24PM +0000, Kuan-Wei Chiu wrote:
> > > Add a new driver for the 'virt-ctrl' device found on QEMU virt machines
> > > (e.g. m68k). This device provides a simple interface for system reset
> > > and power off [1].
> > >
> > > This driver utilizes the modern system-off API to register callbacks
> > > for both system restart and power off. It also registers a reboot
> > > notifier to catch SYS_HALT events, ensuring that LINUX_REBOOT_CMD_HALT
> > > is properly handled. It is designed to be generic and can be reused by
> > > other architectures utilizing this QEMU device.
> > >
> > > Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > ---
> >
> > I think this should be merged with the second patch via the m68k
> > tree:
> >
> > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> Thanks, will queue in the m68k tree for v7.2.

Oops, v7.1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
