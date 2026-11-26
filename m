Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693559;
	b=eUAvnySkKwhi81eiLl6ft0zllNHWQIiOcVjj1giasEDMWs50jTXh2PMYnFg9YvzI/KXf
	 w9eR1tpvLAVl09lz0Xd5CA2KcN6wt2uHt7le9G2lSwwhY9aX/83zmcsvHkBcRvqj8dcly
	 2S0CCmoc5gWXdSjeSdJmSJsk8XWDVI8anvSpvyQiGVhtE0Zk4LUGrc5D6uOVQgx+QBNZ/
	 wl8bpz+TAHBuwWZfUkO4jmEkUpcnkLqCOgkW1LUEwWZJe0cIP0RU2oxsEkSl0PWNf9Psh
	 +5LnN2dlXTjFkgQy/qMDFTW1+FDwXoBfcMp3IDRYnv3/Eh+sYn7adDS0vBdBMlpbkkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KhpuoXVxsmipcY+EIJDYgZSdqvKp313n7f7r77OAm5A=;
	b=G9iIqXwmFPeL1FZoKpSr6iUQ9F+MwmTc73u2KGetMXLh9E0jbF2hnZ2ILtoGaWejRAcl
	 QIzQeGDcnXPBZtDNQnSfQEJjrOCFHvtZNV5f3XerGDIePjGo1sA6STwvtXbOevGzHfOtn
	 1+czT4ZrRi0qaS67BEDnSzDfMZ3WULFKKS9ak0xNOjmg9TOJJ/UpJzAL+RXYZU7TFLAzb
	 Gx8eviAE566ju3BfkMOaste/haSmMRZk/RExLgl0AHDOARbc55X102RokyDdxNOZ2ez87
	 5djw4frrEBZRefPyC1CXPpjdNgF1MjA3be0jY2jK/7a5Y2dXtIku0ztbgaLAZ5CPTqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MjnbXg6o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9A606A33F
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63A9A606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MjnbXg6o
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c516a1623d0so746705966b.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 03:45:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795693558; cv=none;
        d=google.com; s=arc-20260327;
        b=eBVwbmtc0vgfxd5d7kVXPB/wq4Bu98u8cmdcuU94Yie+wH+rEyDNKS4HwJ++vqMB3z
         NFL+F4NEYGVOxh5Brwe4L1gayHbgtHdN7tewzkZJK96PHB5dVRfEeirStSygBW+poGQe
         hFyWUgml+l+wq3aqax5eyQSfieOrSaWDTopPDb+9HM9SRTl2Fy+iYrSer4ff3Q8Ria3I
         vNDlW3T1WZHJFvQrjSewF8i+A+8Xq673pueX31BD7kDhKqOrpmFHct7pdU3XEFXzAR/t
         oxgKCqnOP9h+Y+W7xaYy/Y2NsCgLfbiFA5sKb20swngTOYbzbQo59bKKuQVS3CMzP1Xp
         dc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KhpuoXVxsmipcY+EIJDYgZSdqvKp313n7f7r77OAm5A=;
        fh=ATmto8Nt9swjKIVSLP36GLhUlO5Ux7fyvc/FsB/pBRE=;
        b=BOOdkpAsCO5kozW5EUWpVoXtEDzgUrL8baOWfC7sWdh8K2sgDv+6X6uYq+YYd8JLHA
         gm6Yi1JwXso9kWL9NJp+HEqYkk9zwMv8VllwAptQAWzHrwDjNMlAPpincScn1lQ1UjE3
         QasZrkV31xE+R0bdUuMorQmA5C+dtshxnGo4kMtWUGD6JkOo7rdOFu44H1mYIPSkKZ8s
         4pke+B7lZ850DJqRVGaGnm4KvBwzTey+tShiheTD1T2ZecTBd0DvigAiWAOcV688A+94
         4bdnCx+2QhFsPhdRxYY5JJnXGkmoUDeTJu8AxYzCEM8trHz7Xwv76cqaz5HBvp3SU6s6
         LN3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795693558; x=1796298358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KhpuoXVxsmipcY+EIJDYgZSdqvKp313n7f7r77OAm5A=;
        b=MjnbXg6oubXtXF4GY3n6Ri5wN3VjErZ440rJoOeW/FZXxlLziYjCa4zwOuzVOB/nM7
         kxDEQqXK5mGAAmvSrTNNMya2J9/qUJliW7Kq2H0el3Z30EEyWCXdcgpRU8TGeVQ8+68r
         RO1es397Vh73f82VTxxEh9PLH6ii2fkNzbtnp6na+zBypER3q8Mc/gruiXSmExGh+Mfy
         8ym4h9wJf0JSPuljojTsIYmmtnC7K6SLxBkJRLo5+r8KIpCXVuym419RANN7BmeNgJk4
         qUw0UepBK61we9Ih9TJMsCa1vvZ8PiPQ0wt/Q8x4NL2px1sTpsqJYpvCzsbn4BZlWK16
         B21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693558; x=1796298358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KhpuoXVxsmipcY+EIJDYgZSdqvKp313n7f7r77OAm5A=;
        b=EPKibtt9xtdmRvlact7cWZTncSvs99ssSEmtLphq8ehw4T2t91OmI9IzRSIejnMcWL
         BMu+eeSEu8dUNGmF7ge3xb/OGElDDTWbmTdB+hCde9npGe3k3+nwixGqJY1Qxl8+XO+k
         dGGeRjTE9nZB8VXjsv37lOFbFvc88ojWyjDfVFAv/HCJBng0XtPghJNmo8pXm0Rk8J78
         gDS3TPnypQLcHZ7s8YL1ZcsILe5Q4z5hIUWF3QakhuwAxs7HWjB+KxJO+V5EqpYOYAu0
         U936pI0CLxv4H4YE82FuV3uAGp8iHXnP8tKVrgSjcRdnoQZqPanKLy6gaBvoMTu9gXiV
         8JUA==
X-Forwarded-Encrypted: i=1; AL+hErHQm2ivJAyqhwh4GiNpcJmZXgdMXK74cC2D5YO3RM6wVRj/3/7ImKXfuJpuA8+FtSyfkKUKUxRFvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/2btmtNucye0GUoo6tG8RqG5LIbdo0jLKNCxwQlS4XSnJhdGIK
	crwV8tg2KVEsK+4Xt+MzhYUdwiMoQhubXdoj2pdBFa2AlRnXNXda6e4YGbg5hyD5z5jGHNuWtRO
	A1thXcgZS7bfPOBBb9vYFuFrVygxYzn8=
X-Gm-Gg: AZFdTZdBNlCQiiFEcx/lK3thnpz3xkywTaitIY2RkKGr59u58at6uFK/FQQV++2QpsD
	PmzG+JH2HfRf8n3mtv75yEuTyaSSBvCCpGS1MZ/jBvsSk5rSoT2GE7XrgY76ol+2MY67KkMFQks
	NeaGVi1bkzMWgfLb+lxc1545ApyYOqCmJb5HlZDOnPMrki/1iECuBQmsqu2eNG4F7Gt69M1vDoE
	SAJ+eWGFC8kOVSAPj/012ZanGMsR2ULnZDHb9uXeXoPqWkkFEm/ojR8r4+aFn54RY0+YcWCBKBa
	qGcrl/pdrKAdGQk9DANLgrnV3gsVxrZOxN4w+RiWodfx8lvGIBOgE+Ih0UkNqX/vyAWVynB79et
	POkCiWbjsafYHjGBR11731zMtJdUjXaR+Xgg7SHip1c4D3r3+GD/xIKWrsBwMsMvx1LCtQt8MhM
	FD4T72/UrVQ2zcxswswcYGLmKrkHzeX/12y3oNwjhShiw4NBsebeHddKCjpg==
X-Received: by 2002:a17:907:940a:b0:c50:94be:22ab with SMTP id
 a640c23a62f3a-c513a805245mr1958182366b.18.1795693557771; Thu, 26 Nov 2026
 03:45:57 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126081155.501493-1-wenst@chromium.org> <20261126081155.501493-2-wenst@chromium.org>
In-Reply-To: <20261126081155.501493-2-wenst@chromium.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 26 Nov 2026 11:45:31 +0000
X-Gm-Features: Aa3M54ply6HBL37GF18a3MYmohyvcmh2WIoJZK4wXqF_bZ1XD2F1MsOFc3J2ofg
Message-ID: <CA+V-a8tqzDTbMu5375vub=DBHmpJWW2TvUGKfsuPf_gjpSuC=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] power: sequencing: Allow desc=NULL in
 enable/disable stub functions
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 8:12=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> The non-stub versions of pwrseq_{enable,disable}() are no-ops when
> the descriptor is NULL; however the stub versions always return -ENOSYS.
>
> This would require more code to deal with on the consumer side if the
> power sequencer is only needed for a subset of the supported devices.
> One such example is the rzt2h_adc driver. Only one of its two supported
> hardware blocks requires a power sequencer. The driver could be built
> without power sequencing support and the other supported hardware block
> would still work (provided the Kconfig dependencies are changed).
>
> Align the pwrseq_{enable,disable}() stub functions so that they also
> return success on NULL descriptors, acting as no-ops like their non-stub
> counterparts.
>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Added blank lines before return statements (Bartosz)
> - Collected Biju's Reviewed-by tag
> ---
>  include/linux/pwrseq/consumer.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consu=
mer.h
> index b69117ad3fa7..d3f5f37603d6 100644
> --- a/include/linux/pwrseq/consumer.h
> +++ b/include/linux/pwrseq/consumer.h
> @@ -47,11 +47,17 @@ devm_pwrseq_get(struct device *dev, const char *targe=
t)
>
>  static inline int pwrseq_enable(struct pwrseq_desc *desc)
>  {
> +       if (!desc)
> +               return 0;
> +
>         return -ENOSYS;
>  }
>
>  static inline int pwrseq_disable(struct pwrseq_desc *desc)
>  {
> +       if (!desc)
> +               return 0;
> +
>         return -ENOSYS;
>  }
>
> --
> 2.56.1.839.g22a8290db9-goog
>
>
