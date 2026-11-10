Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294273;
	b=NZ3L9/yLbgLzYFHAt6nXpBFiK8zFs99ooYdoycRwXt17+31zd8kL4HXdIZqIwyjAdutz
	 7/refzgJAV38OMJSI8a+8uGM0Bb1ba+HqeYNxNlJf2WG5plbIPMyVifUC3d87BDEQe4gy
	 aFskiyEm9a+OJIGWdP21KjDRwcQF+NoIZ1uA2p5CyKbbxLkBNCGz6t5kxjbgPbWssb7Qi
	 viPBN11jzpdt0ynlXImZxqeZJojXaIizgD65t6mH2kgo/GCbTI+lPUqzsJoBH6zwHPpAr
	 IAU/oyRmdpWxYBNBEe4wRDKR72MU3VvKSAY3dWgS9ipeLAZqHdbi/flmg+zg49z2C1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=puumqnRyy+PGoQeNJSBFInFW8kilwjgEZfgjatHik58=;
	b=TQOZHas14bQmWQyP9DMOwXlCQpyDiAVuxToE06a5Lz1JKAyxcvHl4RNfvuBw0uOdMyCG
	 qFZrx78BTUvhP3V9MpziPVoetQKQxPDKVyNaYVfo6xmVaF71SlrrHv71E61fLHj5acR8C
	 vj/UTvSRsbSdhga9d4wh5Fo5d9s192uOimdJwmXVo3zMZR7zDYY2vAAuzEmX2xjocP3Pv
	 cQcFnuHc3IPk6A5T/vDriQXsYsHnfMP3OWnQb5SAF8A7Jmh+iPaEA+VHLyRPo+Oqnk3uD
	 YCTx1WQfRbmT0VerzKbnLg6Ink/jqbujwwCAjAGKtYdt5Tj/yJ/2BpDlBsh81h/rMow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8Fz+pUk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7C4606A326
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 07:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D7C4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g8Fz+pUk
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so2048130a12.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 23:04:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794294272; cv=none;
        d=google.com; s=arc-20260327;
        b=QGpe0hhnOKETiwzjyIsyWwXVNQw5ALEuW/o8OclI+yfV4jGFbO5POJ4AVgv4QS3Ppp
         ANSDKPWT8RzAH/9iSd6byf/rObb1nlQpcTjHcysmoPIZVTJ4t7+dTzU1HbDipqwlethZ
         vCrbxFIAxwswP27VBDqORaxLoxAp1iPzaaeKYj9/OK5neEEnZCdQ+biJqCntl4SxjXON
         SAVMMrIQ+o9fvX5OsCQMugnUPTLxncQYL77qg42D3g9Jh0ATkGOHrby4UvJQknkeWvVw
         4+vS2IbUkolFB80jqX1aoyuGKfHzndMqQSxK63D5DJ0qxM+PzSRsuRHwkDtMJAbWIOWr
         sTCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=puumqnRyy+PGoQeNJSBFInFW8kilwjgEZfgjatHik58=;
        fh=b3r4d8nvHkiEkgVsRWt9LUzqfzV6RH8Yl4+wfyckXMA=;
        b=nHYaED3zdTz7QeancMuqCgzkE/3og4GNh85RHwq6AcDVVgJY8gBlngb9a/Y8mE/b9h
         1A1XiijeHyshCh93VGVT4E6s4D2jcCLM7YGdzVUF/f4ENm3C667szeB9uqIUXxRAB0+m
         k6WhMuKZTWmhCuV5N+GyW3br7CigUriYDb459lYv57CIqvzglPLBzBkT0DLhHxSdJvdt
         rs3XT4CWmXQYSlaWPyOKTZDnn1NN99ka0jkKjTzgTFCRZdJbMK0nw9AStAN0XVJnLOO1
         Wu/304jDnpxc7/ImZdTYnjHvNoAl6jlMxiTPNXHHXMZiIS50lswQ7y8thEWOQZIYdlRo
         e3gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794294272; x=1794899072; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puumqnRyy+PGoQeNJSBFInFW8kilwjgEZfgjatHik58=;
        b=g8Fz+pUkZixQzSh9e2idFtncVxS6j+NGGEZZa2lSqnzxQkB1hqczJADO9xnq+rBc6Y
         1Kh3IUy5TF1yBwURnLO/LkQGNgLQJgtHbcgRbPbtcpYwn06Ows9DONJ46b+ISSdkPney
         G+qiWAcYINW4/XIkTB5elPNc/Vd8+so2LmpijE9N1ipFlXeFkQXxlUbTFYmRqZpIoOdE
         dq6BS12Yqug49VJA+WclM2apV/bGg4XpHVix+s+wVuoVKalXRpkONgM4MurBbay3iP4M
         p+10Ahl/+pyx/fXh2SXXp2jGK4gG/wve9G07LuErTdahE0Z+wB4LxBX2fhhXC+NaSUjH
         YMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794294272; x=1794899072;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=puumqnRyy+PGoQeNJSBFInFW8kilwjgEZfgjatHik58=;
        b=O3lINTOvUQd2aNJThDkF33V1Wt+Cxfo4cEHHIx2y0DhrMX5TuOC133w3BF72VWpyOn
         HTw06YkSM0N0UVyAPMGfH2r7NkFjpAHCMMowkQDG+EFnWmhcj0N4dAnE0rxN14RF9mTz
         8I3XTVJpFU6620KNPHPB79/K898mFjM6kqxqZJbsAgCdQY3wOfOgKREDIabRYEEuJp15
         vlz3lsKDo1xr/Ih6d1p+JpScKOBNdFCp9P3/P3AmhOch/bVxBO/k+GCth+Fo0kINPzAu
         DTAwtuJdL2SxYW+nIGX7q1cBcCEgMx3eCYB4e5FfJt71tIHQVxiMZ1caqMdvZoUVDdp1
         oOMQ==
X-Forwarded-Encrypted: i=1; AL+hErGvPLDg8a3td6lf0lWntP5LbfXx6cdsYkOiRaLobz7Oo4G57/aqSH9tBnJZPe0J8STHT43AG448sQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9dceMXs262mZIY3+sVtBY9Iel7XdI/7qVcnqPEDKifHKlvdYgx
	3bOgE4vnFvxOrLoqysFhvJRTeq5ako+o4828T1FmU3wFZ4jPT+VgwTMSUwPiAe4sMZj0VB4gPuW
	qqpMdvv2bv6gbCluSSlsTD+qbVfrOlNPTFQ==
X-Gm-Gg: AYBFou1DT/HRKhRVwa+jlx9vuSbenL1VhwYpEpif3NyEFGbl+o2KuWp0zxN/LzpkmPu
	ONv4pdt0PRmfSIxEbYaRzWc/uQrI+XwIVl7j5q/PmfsOFBs67NxB5+GHGLVdTuUhB19QaqRzGpy
	G3pug+W8KEbpOvgRdveJlhY6rXmG6/loz48mNZ0UjCTmzoxlpaBZ2+4iksoViZqDrCRlwCwSOVp
	l+toq0EAuzSUUAqrvQ6WLYxPXvOF3ydLX5XAdPYOnyglScm/ooJ5o5X/VJq51Co9ZL9MTiIio3x
	xwUVUL+f91vQ4xienPPHw0Fk0odJRgqBrQF6Qv36ggy0pt+xGAkm0hgwgxd/NGLRdpyJfVB8wnl
	WL0kuLB6GLQoks19MlvpBLM4I8B9rR7SsEMA=
X-Received: by 2002:a05:6402:239b:b0:6b7:1b62:48f5 with SMTP id
 4fb4d7f45d1cf-6b756afdd1emr945605a12.34.1794294271512; Mon, 09 Nov 2026
 23:04:31 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110061429.2036-1-linux.amoon@gmail.com> <DMRBWY2S42EN.1CNW1DNHJOKKD@linux.spacemit.com>
In-Reply-To: <DMRBWY2S42EN.1CNW1DNHJOKKD@linux.spacemit.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 10 Nov 2026 12:34:13 +0530
X-Gm-Features: AclHuK_QdgUZlVEI88uRaFYkO0SFBxHrM1OaI5F967fviYpCpm4NPd-mBXdjZBY
Message-ID: <CANAwSgRRYCjYfuW+RqpRzbWx+_Fee2xmqr-GdtWAHCsEFZF76A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset in
 atomic context
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Aurelien Jarno <aurelien@aurel32.net>, 
	"open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SYSTEM RESET/SHUTDOWN DRIVERS" <linux-pm@vger.kernel.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>, 
	"open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>, Alex Elder <elder@riscstar.com>
Content-Type: text/plain; charset="UTF-8"

Hi Troy,

On Tue, 10 Nov 2026 at 12:19, Troy Mitchell
<troy.mitchell@linux.spacemit.com> wrote:
>
> On Tue Nov 10, 2026 at 6:14 AM GMT, Anand Moon wrote:
> > The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
> > to wait after triggering a bus reset request. However, this function can
> > be invoked during atomic I2C transfers (such as power-off or restart
> > handlers running in atomic notifier chains), where sleeping is illegal.
> >
> > Replace the sleep operation with the driver's internal helper,
> > spacemit_i2c_delay(), which conditionally uses udelay() when running in
> > an atomic context, avoiding "scheduling while atomic" bugs.
> >
> > Assisted-by: LLM
> Also, please drop this tag. The same applies to patch 2.
> See commit 1e035297ffda.
>
Ok once I get positive feedback on both patches, I will drop this tag
and resubmit.
> --
> Troy Mitchell
>
Thanks
-Anand
