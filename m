Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CBD442FB6
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548474; cv=none; b=sJKSAKM/Ia2pUs05kR3g0uSzMkessX1MTlVgPlqLsTUCHmUL7X9fQmCJGGOgICRrXdxwFt28Lvxd1PNxHoN/h5kGftj2Rqb4hHqqdQ7+Bh+uEIcgNMrbzeRtoVe5zWdqG6iUBq/CpL0RTc+26BUOH9IKnpd0sUixg2pKy+1Rq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548474; c=relaxed/simple;
	bh=1u9XXBxua+74tlAedjJORrPRKU2VSCx0ct/hu1q6dlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXo48AgisoUDOruQLKpSFBu/FsBBC4lzs+DLkyvbIWglKcYLDmIrTaFjChZ4DB4m5P+0wYYECFFvo15MtFJyjHo0/+y7Ylltv15EKl4Bw1LYbY2j2Yv3Hl/nvJFI5XeZWNSE5oPIyyEpOFj8mtjLbgKhLUH2BKF6m0KQJXSy/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/VEynWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/VEynWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB801F000FF
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 12:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548468;
	bh=1u9XXBxua+74tlAedjJORrPRKU2VSCx0ct/hu1q6dlI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=a/VEynWk9w+UWfY6ZnNfzK3s/QjUk8rzAHHYCQdMA23XMEZ0hsqJJwUSTzrzGQIJf
	 l4whTzbipM6abc6wfprOW75Uo1SZdLrtayWeMotV3zrXSQ6oMzFLq5fkXAf5m2r0Vq
	 ZWfYemS9hhHZpvo+ym8HgLjrD1FfXwJL+zqoHR6/TS0URaIpsZ4ixNm9HnVeYCXSMt
	 FU863Wj3Y57FMJwN0xmefkxuW4Me6DXIQFsT9UPWjapLZrG1cvyA11fVVKmdhhUgNt
	 k5UzB0LgeNG95cpc35e1TtV5qwRI1UZPIA7RV6HRMQwzDz1rjK5byD6tEFRlEq18yP
	 xP5601Q3wom0Q==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5bcb1f1358aso297316e87.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 05:21:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwzMxMcObD+D3oez75ghpfjXzvNIJNvKnKJRp+nxDiYoMwvHu8qn9VL/+wJDDO53E7FrYhtd11sFA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLEyDXgQiZvspMeyAHXb/cEIxkbuJxnfe0ZPFUNeJaCWRUlgIS8
	AKjVZR8Fyq/fd/A9et0LZRaPCh3y7u1T97e0gxf6VR4wUgaj8FGlRmeIMktzRIjEf5Xc57A7YPO
	ZO7L4w3Om4Hd+tbmxbnuQTI9lY0aFbCI=
X-Received: by 2002:a05:6512:2305:b0:5b8:ed66:2f64 with SMTP id
 2adb3069b0e04-5bcde356b69mr616420e87.3.1791548466889; Fri, 09 Oct 2026
 05:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009112429.33318-1-phucduc.bui@gmail.com>
In-Reply-To: <20261009112429.33318-1-phucduc.bui@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 9 Oct 2026 14:20:51 +0200
X-Gmail-Original-Message-ID: <CAD++jLky-Vq9VS82g03zJMfnbV-Uc0nXhbTryzaPPvMx+zCUVw@mail.gmail.com>
X-Gm-Features: AclHuK_rLFNrPDWthwt3VKsOyakZVh0n6GYhHq_iU3sVt74jFl79BMAyFBPIzS8
Message-ID: <CAD++jLky-Vq9VS82g03zJMfnbV-Uc0nXhbTryzaPPvMx+zCUVw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: generic-adc-battery: Propagate charged
 GPIO errors
To: phucduc.bui@gmail.com
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 1:24=E2=80=AFPM <phucduc.bui@gmail.com> wrote:

> From: bui duc phuc <phucduc.bui@gmail.com>
>
> devm_gpiod_get_optional() may return an error pointer such as
> -EPROBE_DEFER, but gab_probe() only checks for NULL. The error
> pointer is then passed to gpiod_to_irq() and the original error,
> including -EPROBE_DEFER, is lost.
>
> Check the return value and propagate errors from the charged GPIO lookup.
>
> Fixes: b0327ffb133f ("power: supply: generic-adc-battery: Use GPIO descri=
ptors")
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

That's right.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
