Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794155070;
	b=3s0+jNCO1+rWfM2dL1w8Ch8RkiA4yCwnd27wnBm6aGgreBy8cBYduxs6ouQl8lTLLwPo
	 fbJH9ki0CCIDoOqUtyO6GqnXJ+94Ioq7ASOwKJqI4DdODLgWJmIgIS3W4UNtSGANgboJE
	 GSrzdPtYmmMPsxjWOq9WdqAUNAvcyRvLIxTLlX1FmHn6dQzgGqOE/dWfYyZ1B8fMVzZiA
	 G7P/RaZtJXatTlE2OONTfqAOVnnrTO5TSuE6fB538eEKiJd8icAzgogfNJfurUkzI0q/1
	 tVx2S4D22mc53Yfjf+meeRTAy/LLXAGvGtElN6aFjSTI0GsReJqqckv3u8ZA8Vtm/7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794155070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=827oxpvjkWkctgQ6hvzAoUN7ol+XidN1sTe8zrMicvY=;
	b=nMWJEFd8jvS8ELnfUOpdeAotl5t7by/WpIwDXKVt1n/7WiUwqkWZGaLfFs52YIAHl3t4
	 9KZdrB07MHBbm8IbbSBzHR6cGw/ye5jhrpcTXh2vQTBSHPsMZdqWeQnwvn8chlaMPSbqW
	 Kl3fYzEKETDQo4ljD9ZIE7GD7R9E+28TIs5CUpLhyloN0JwARJSZLcShOfBTx0f7w0Qo5
	 3fPAwVZxyYHcMpKXqVRJ/mlRwy4Kbz4fZAxmrQe++2xpihJ2rQQoEACXYULJcPhBKhqC2
	 Mz15+7oa0raK8fzn//AQsHSq8Js5B2YjDDKIpZ1EhxaDOIqXmVOK6hC9H0LvNxzwRKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gMXVqYdO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EAF606A31C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 16:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30EAF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gMXVqYdO
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36f8cdd30beso388092eec.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 08:24:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794155069; cv=none;
        d=google.com; s=arc-20260327;
        b=Aoh2IavmaZvrGsli02VcWBd2c3a/h4phi02K91T45brOjcstIsp7/krFRJY677wPJq
         Bpus2jZcDf6JfH7CJVmqPTgD9WqFetG8wpBgp6R756R9oAKxRWQayyx8vFIWEAxQ2VSj
         +e4cFrNDi9309mSW8EI1xGk/2KVPHzOyMxI0SqKi0Y7X9wZHQaYSZ3E7PmTo5J6kwoqt
         9ZYYdfE3ArAJpkDX0cH+ks8XH7eC6c5VSgNClr3C433fRkn9/hEuZ+XLm4H06TzLnQAw
         4miNsk16+njpusP4Z5RMUbO6O2HNVqYLdehiTUz6qeY1PLJWrydDttXYq38hCgvBUQiZ
         NilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=827oxpvjkWkctgQ6hvzAoUN7ol+XidN1sTe8zrMicvY=;
        fh=Rdli869KH/jBHn+WXhn9hr+YlLoW3wfXIXnrSHxcxW0=;
        b=Bmp8F0QiJj3S3/yWIUPO3D5rtjklFnP6/JTfLcX7CE5AFieEySlxYMTMr2/agIX+eT
         PO847Kp2qKqgqGkyy1+46xtR7Xkk9cxtIXOrAJ7g8Pp7WTAVBgdBvZ34CGGhc7+uOQSq
         vTvzhg3zpEBF+l2gnd44zWgDjNlfvfmbvPWd1K/YuQ0oxKJ/6GfLdz9Wv6zJMX4pTQ2U
         0DufVoMEE+ooAJGzbpTecQQPtxnI7/aBZ+4DbxbdwSq0af3z1Qe5hOtYswappNXXuusW
         2gQ1gl3xHbidOI+7I/oxGsBD9JgzaJyhj+Yl/hIEWjvljv6CPAmBpxFePHtjY4RDqiR/
         uUfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794155069; x=1794759869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=827oxpvjkWkctgQ6hvzAoUN7ol+XidN1sTe8zrMicvY=;
        b=gMXVqYdOKGpeE0ZyIRfHSoSl4oQjlp+rLnHHgN7y6RqM0iSXx+fcjMcTa17sWckAKN
         IIc1cyk2peWpn3tJ6uNsLR7111ZwaYftxcCBHTi0AmkZx1K6eXf4FxiYzIPg2nv9KMRI
         ZuTBY+t4zdV8xoEasqGLQ/uVOxC3yMx9DvYiwGmpUauaRNRrRlZWC+zoIrJAWM0Un3nZ
         Il66GfLmzNaB8mvc/yOavt2SpDKwR7Mp3oXmXudr6WXZGUIc/cRx8dxCbuyPE9rrtyja
         IVpGpmfSVE5UaRwcCVbnX+j6uxUTVGksb7/OyzorFiMW/Bp6Lq/zOmga7pAspVw+cJlI
         yqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794155069; x=1794759869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=827oxpvjkWkctgQ6hvzAoUN7ol+XidN1sTe8zrMicvY=;
        b=tBfrjtni7lX0iqoOtfCON/AHB/8rwdTfSmxI5NWn79bj+n0gkfrH8nMeYuJE10TDyS
         gVMC5tRe/OJdBGer2q6d+NrCLKM77O5I80M+PYGcS40K8IoRPi50cxsWvXsQjapA3tYV
         k/8au1BplkVyR9Y+Ej6JPCe6dbb5gnAFMIemI4WRC+uN6++qgbsEDR6Z+XvAxyr6O0SL
         gJ/ZhOwXCYfjm8C1pzdnQVyqSHmgpU7QM6yjCbYpI9EkzL3hjNcuDyukR+whvZaPEpMN
         QZ+FiAxSrrAeJSdAApDe9cJC1WPv9fyVSHkCWq3v3WN5kl+gDH/myc0RIDcc/K4p0ROV
         4wVg==
X-Forwarded-Encrypted: i=1; AL+hErFPpMYGNcsZhzhiQifytoI2t+3jdPu6pgFgfmBDj3kCsGk7j1+32PdsTiFOl+QPZwtYL/AsKQ0OhA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+YxxVuZaAhH9Y3/3sjYscL1cI6z5vnv6QyrP8lflQ6KlCH1HYW
	HxHI5QROo2bJBEe2uXkrfaAkCrR5e+cp64yjZ0dTS8ejhRwlhOf7LRyzEp17yC42mlHIXHrl0KR
	rYpc2r6+g77Z06tmlOensQiJQxI5hJGXSSolo
X-Gm-Gg: AYBFou0fTnaDuvGxdXsmvfxGHQUKDJ9q4HM/pFMa0mLu1jNhwj3vOkl8JJgcxZHz3CP
	wiSx3VUoCf2pCRGrW9Lb3frTsaV+wXi9UwAjIgbkV1D7YPn+0kjVT8AefMoSouoXar+as4G3Ca1
	ZQsVahiCuxQUmGF1toLA2KFrDBEUw+y7JA68T7eiXQAftbHcj61cQWwdasxwu4nE5X90+34m52z
	B5yD1T17VFzIFlyS7A3Io5FaQvLkBdoaji0EhUQkdB90bmF4ahPd5rlWOTBGMTBq2SLgifzGewV
	xugtxpwPXlmVXcVnpzvrkSaNC44enCU5FmYPXWXas+o2zPQpZcuJ2jXmwP4qo4HDMM8MAcFE9ya
	ke7U4Q64BnuSnWfp3NtD5r0GVEMmrdDyIo3sBFId0AEayYvl3RDOv6AgdGYWio49+LSCts6BJPM
	bsSRjw1ADWrf/yCj4KNceu24etUfeywg==
X-Received: by 2002:a05:7301:fa8:b0:369:fbc1:89c2 with SMTP id
 5a478bee46e88-3725d781c18mr2866533eec.8.1794155069181; Sun, 08 Nov 2026
 08:24:29 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108154241.198160-1-huggek@klattorp.se> <20261108154241.198160-4-huggek@klattorp.se>
In-Reply-To: <20261108154241.198160-4-huggek@klattorp.se>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 8 Nov 2026 18:24:16 +0200
X-Gm-Features: AclHuK8haPGhR5EbzUiUC7sL-4qlDpHLHWGRvVtS9CSkjnJVx6gK3zrbS0hvDCw
Message-ID: <CAPVz0n2dnuiC_bkMTTtjQyQJfo5o-t10LrbR9mQ0Ew77bhqvew@mail.gmail.com>
Subject: Re: [RESEND PATCH 3/3] power: supply: max17040: clamp the reported
 capacity to 100 %
To: Hugo Karlsson <huggek@klattorp.se>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	matheus@castello.eng.br, me@iskren.info, krzk@kernel.org, 
	m.szyprowski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 8 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:43=
 Hugo Karlsson <huggek@klattorp.se> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The SOC register can read above 100 % when the cell is fully charged,
> and max17040_get_soc() passes the raw value through, so
> POWER_SUPPLY_PROP_CAPACITY reports values above 100. The ABI defines
> capacity as a percentage, and userspace that rejects values above 100
> then shows a full battery as empty.
>
> Clamp the value to 100.
>
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> Signed-off-by: Hugo Karlsson <huggek@klattorp.se>
> ---
>  drivers/power/supply/max17040_battery.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index d93c3daebb..98574dcfb5 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -14,6 +14,7 @@
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/minmax.h>
>  #include <linux/power_supply.h>
>  #include <linux/of.h>
>  #include <linux/regmap.h>
> @@ -210,7 +211,8 @@ static int max17040_get_soc(struct max17040_chip *chi=
p)
>         if (ret)
>                 return ret;
>
> -       return soc >> (chip->quirk_double_soc ? 9 : 8);
> +       /* the register overshoots 100 % when the cell is full */
> +       return min(soc >> (chip->quirk_double_soc ? 9 : 8), 100U);
>  }
>
>  static int max17040_get_version(struct max17040_chip *chip)
> --
> 2.55.0.windows.5
>

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
