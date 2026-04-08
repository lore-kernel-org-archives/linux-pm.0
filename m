Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334FF3859FD
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775639448; cv=none; b=S0fxljBKhTYuNlx4VABSUWn+4d6sQFSS6a5vM4ffXYFSLN0ye9mBLBkFc9xTpfaTRUft/td9i+nZf2WiiS2SAgxJJMLYgb8oxaBfkWKuu/Ligo3Jt2ZSET72Ti7UNPPNJjQjuTCeJhTMwrSsDx+tuYHsu/FhTUs9fhxHaKWq6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775639448; c=relaxed/simple;
	bh=NiZ+s0ZGVigowFCvlE2fvxIWoHBwW0PQsCbDGneThqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAH1j6XJKUVP95A94wy9vtZJw4no/or0ceps1gHzB7eVR31Pk3GavtSKXLhsAxNzQNcu/RFfGsFfrHxsSCT14mL94sldocf3T+C6sCoDWb1CXfklSlYIzAKlgV8KmD/JDALzn1TtrbREhw+vLJ+rNnrQNIf0VJNpHrjYmsAbnXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94b07fddecbso3233835241.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 02:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775639446; x=1776244246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsjJWmJuXMrykZSTReA2HwDa0URAD8kKTdB9Xt592xo=;
        b=lhJVXgwYloxygQRgt37LqkiLCVM5jqyXjFi8JU7RKWJsb1FAncYvavK0KD+KLSkx+U
         YycfWTLASLLP2mpshb/KBuwHU20jgIfV/rOrMIpLItFyRCV/pNu3FNajKrXr4SEYTAZ8
         b9Pc7U7O67toVD2nXAqEM6hmP0Fdkk5auMuXvcLGcKaOPkFLGVCRoCaYnyil+SJSEQ6E
         +00csnzPoaZavKOnoOquAridWTs8VIqBApuVQNSyPVPQC1/sfLR68c8wMaMtyFaCVV/7
         bjU4vz6Dz856KmU19QhcSadstCJm1sZBFcmt+hWfL7xP42ioqnx+eKMWhqafM2ixbn1U
         dDRA==
X-Forwarded-Encrypted: i=1; AJvYcCU4cVIUUwJNODo7C0umvBCecTYzMFdQ8e+Rfe1bXvFVIgTdD6cE4dEqz/yp1Pn8qtWWKlnKxsVlMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzohvm3e6vqhELOawcOd0PDYGMp8o4KgXrNtb4TNh5gbRwr/gur
	kcV5fagTzAgv5JvMTqS7uh0kXPAPWjYOHOyEexZ51aRJfpHTp2jpyIEd0PWlx/uk
X-Gm-Gg: AeBDievs4sEeIMFTuh1i7MQ0Bv0ijrhDfby7KwuBHAxtCDna3hCvI27gQ3VZmoBL8u+
	aePCgw5vpfebU9SfhL06Y55hlDnM7UE1tT358+VYAuFMt/sxvEjDepkUtqUN3H5eo2boyDP+Y4k
	tqANNzt363SjCYPw5MOUvIsDjuDKLI0zZ674RRj5YYPjDE+/p4aAYXhBkwxlzc0a8zf6xH2m3vq
	0KY3XuE0JlL31Kp7eiz0an1ymsGG/jW+FvHeIMTKg/KY3QtBzM0JyTEjRP0DI+zOTXwWVy8xFtB
	byC+YdZl6BmxnNf5SEDxep2y1ZSPU5WjKWYs4h/R+rNTYtMXDjX+7PA7l8YZwlE7Rt7OAzMBmlm
	xdjnRmJme+tNH3+raRQYVfDI1U30JQHA1n9K9LeVE/YbTRUg0aJsP2oOzUNjmAnJGDse79PywIi
	eE0k9ev+OOUkkatrtzLexJnPUF5zibqH3QCnY3odWjHHU40XS2xBrbcRIM8v1m
X-Received: by 2002:a05:6102:1001:b0:607:4fe2:a64d with SMTP id ada2fe7eead31-6074fe2aba4mr1512965137.6.1775639446186;
        Wed, 08 Apr 2026 02:10:46 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb4fb62esm16154039241.0.2026.04.08.02.10.45
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 02:10:45 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-6057723d553so3843581137.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 02:10:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsowJwYmz+dzvhOg0psBDiKZcUG2UWyNdXWpE7xc5iZ8aRjaSJ+cZfNvnFLj/ZGe4Cj2qdgxzwEA==@vger.kernel.org
X-Received: by 2002:a05:6102:f87:b0:604:dfe1:39a7 with SMTP id
 ada2fe7eead31-605a4e316a6mr8103614137.11.1775639445086; Wed, 08 Apr 2026
 02:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222173225.1105572-1-visitorckw@gmail.com>
 <20260222173225.1105572-2-visitorckw@gmail.com> <ac7kP64nbhZzwbJV@venus>
In-Reply-To: <ac7kP64nbhZzwbJV@venus>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 11:10:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSTdrv9Dswez-QrcFTPwnnFy7m5gc-ScMwBfQLDayQZQ@mail.gmail.com>
X-Gm-Features: AQROBzDu6siDi5HFgMNFc4b4a07emxt4ElMQSw8EVt9effobDq5P9g1f3YZFAZw
Message-ID: <CAMuHMdUSTdrv9Dswez-QrcFTPwnnFy7m5gc-ScMwBfQLDayQZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] power: reset: Add QEMU virt-ctrl driver
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	daniel@0x0f.com, laurent@vivier.eu, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 23:52, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> On Sun, Feb 22, 2026 at 05:32:24PM +0000, Kuan-Wei Chiu wrote:
> > Add a new driver for the 'virt-ctrl' device found on QEMU virt machines
> > (e.g. m68k). This device provides a simple interface for system reset
> > and power off [1].
> >
> > This driver utilizes the modern system-off API to register callbacks
> > for both system restart and power off. It also registers a reboot
> > notifier to catch SYS_HALT events, ensuring that LINUX_REBOOT_CMD_HALT
> > is properly handled. It is designed to be generic and can be reused by
> > other architectures utilizing this QEMU device.
> >
> > Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > ---
>
> I think this should be merged with the second patch via the m68k
> tree:
>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks, will queue in the m68k tree for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
