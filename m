Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254735F60F
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 06:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784873847; cv=pass; b=p/HaLtPn0rACQ0tWdowDDvKWNeNuvz3EKGbDZeeuh4MIgjHu/u9MsOEv+JSp60PNktiyHyLNRVzulWzw1iGxI5YAX/rhGUg6WbtcsbosL3rpXzkW2imshRey3ek7QKz9ZgvRJgEWj/ftRwg1rOk1S8apSJU8Nj++xHS4K7kaXlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784873847; c=relaxed/simple;
	bh=rfB18QkequAMi7q527ExqBIt6L8KePBeYTedPVnEYxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJVSWtceybmYn+4nMvUCVVWQHWokm3ZF1dmesRhfRIBa4hyMTvucehllbiewN0VhzknUzpmx70KDB+Ji4fE3GbGFBP5ggH2Y0gE0TnvOlAQiv/PfIC75AkH1MAwtBi5F4hO54KypgVJWqoXKv7ZTTOFHxSRN0r2/osg5RwXvTlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGx7RgOM; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGx7RgOM"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15dd4b9132so13442666b.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 23:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784873844; cv=none;
        d=google.com; s=arc-20260327;
        b=HJanrLUmPwy8ZO1THnAgEqnlXXrcvkmtwoPW7skuH1OV3crSv9yu3mQrTYgkkxag4D
         Qk+Vh+h/mD8w47hMSS/ySN4xMz2GRfZ5ERSSyaNqt8Pq9sxFMf5CYnvBcf4iVWVDcZBA
         RYMkx+YBxA91rctGX93FtbfwrqilpTofH9+Nm1LVomy0KiRenieybyrrNFLx3riostwT
         y0hiYRzyeXap+tAJ+06gN2AStdvKPdTTb/R9NdpGCYmUltRF5Q5GbedU+ALqNMamsCPs
         DZp6/foWWN7Ui3QAWetM0Lb0enlEGNZ6gNEfTmK9ul2Et+lmmbiLc0iW1iqd9LkDAKee
         ghjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9dvx2Xg4Kep8o+g6NfZeUbYsB/V217osUaYBiTunb4=;
        fh=9tG75GyjUownw0I+L4eI/8/Ua3cIN09Uu7NqFsfT1Bc=;
        b=JOVztbp3DsNmXfe4tJtkm4pi8yNXtsAUjUPsbbTlnkyrJF89sbJxeD3ABs0Iwj7PAZ
         B4LU1iN+YvLO5LCLqBxxQAQU9eXonlA1FVqS27y99/badK4ZJkDXD9jViVaJfGMySxT8
         5OnITR9gYMzNUyeiaWfmdboehIVR94CPEkzdUEo7LDJUqujB9r7XI66SPMx5qWEPof1W
         jEJd/8GZMqlWyLV3dlHPBMj5W1dVzInay6GFaZxCCde4o37eogPxrLyJ/9aj/PMQ+YmF
         IxJDfrUV3OuwwmNddgew8TMLxPBvAYJ2tJzwr8L51U/iD4XuoqtzWGIH+hwma6zjSye6
         vmLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784873844; x=1785478644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9dvx2Xg4Kep8o+g6NfZeUbYsB/V217osUaYBiTunb4=;
        b=mGx7RgOMx2H39eWd8iGpCjbk3Sb5R7Pau4ZMS6mpM+nw0nBA53xVuORPaX5yU+9/6K
         EHkAu97u0fozl6cQoNmNVzwhiyzI0ufVOb3u+QaJKx+MbAS8uI/Vbcgbs95tgvgD2Bjp
         4noUhkb2E4caOuN3HS5iMLKenumBbhBscA1PMVjgqCvTLz1LzpXzfeY8EGGYeKHjzOrc
         B5A3yZswBt6S0C6y1KwlSGQWFN+8qFaz1MwhFsFpVNVM4uJwy5tTSApOsxAtRZTJkY91
         ClNw6a1nQcY7L2ihNURoEAPYkVlHBlYPUHDi2J+v6ft5DF3zTMb4FbXaHIAvAVrHS7nM
         rMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784873844; x=1785478644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9dvx2Xg4Kep8o+g6NfZeUbYsB/V217osUaYBiTunb4=;
        b=P+4uVYXknsef3usHIIOIxLEfamc6cIgF3VNIhWyCagL14Y6YHSFYuna8FkMX5AVRat
         vkNSwcjlmXKuJHxP47fEiTe9Ps1056zABCxwcBnmVtweWcrAJYiMqYN04cAJLDxeSeWJ
         t4mziUslDvPDBHDiD37AOFfsSok5iGzVF8PbKn4K2lcBINKLv1qipIWzPgUDKGM0sZFi
         6hp+KVgolsDjC5a9BQgBIkIHHdSc1yLkKZGTZ+aCXYkCY+PIJIyeYtqhgVtetvER4Z0f
         8vdsp7aOJsEZnLseJ98JiYsk0pYV6TMxebsZWLk60Ex9eaSo8OyU4RgDlacgja7IhxYq
         qWxw==
X-Gm-Message-State: AOJu0YzyelnoPeFo5Aht98gItpCWG/07KOSuqnCAQqKpFbA1zkCrCCc5
	HAvr+FM3lYmgVz2TI7hiwwRokQX3GZFj6sQCVX4+4wM5QTW0Ktd8QrXTcECHAU9TUxhBzQ4t9mF
	V4UL/ClzLwBlXDsBOJ7holYc/XlJwpvGaIIAc
X-Gm-Gg: AR+sD12EaHXtFN3PdxGGYoFf9m8ybq/gTNaGgMC9TJrZ9t1bOBBhhu13ZWvrhu++Vx4
	JcgLAzHUrwjVW9l+ib3zC0FrH7ma9Wn2kl0r3zmydE5drLnV63fBgndnIyr9pfRm6tUV3+rqpzG
	BW06J1mKsXlp+Vi0Z2JDM53IMGMUPKixfjGOFQB0P4Kjjbg4GrnQaJHIz1Rzms5FC4Kz3PT2PkC
	p3yCr19rLzS2w4LYo4FSt3zm9/roO4dwZJ13nx4JmJfoYX7AbwezKaFMuPRutI=
X-Received: by 2002:a17:907:928e:b0:c16:8ae2:b9d1 with SMTP id
 a640c23a62f3a-c1c50a3387cmr293252266b.57.1784873844003; Thu, 23 Jul 2026
 23:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704163238.115819-1-malayarout91@gmail.com>
In-Reply-To: <20260704163238.115819-1-malayarout91@gmail.com>
From: malaya kumar rout <malayarout91@gmail.com>
Date: Fri, 24 Jul 2026 11:47:11 +0530
X-Gm-Features: AUfX_mwDZb3CwUkOeGHFak8aHTksZHidAWivUXcbg_QtuZ2T-Dbj2RrGuw1s420
Message-ID: <CAE2+fR9MSXaZrvMECqCTnFqNZxGKOFXRxw614RKPy+BOwLEDdw@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: userspace: Fix memory leak in userspace_init()
To: linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Kant Fan <kant@allwinnertech.com>
Cc: mrout@redhat.com, skhan@linuxfoundation.org, me@brighamcampbell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 10:03=E2=80=AFPM Malaya Kumar Rout
<malayarout91@gmail.com> wrote:
>
> Fix a memory leak in the userspace_init() function where allocated
> memory is not freed when sysfs_create_group() fails.
>
> When sysfs_create_group() fails, the function returns without freeing
> the memory allocated for 'data', leading to a memory leak. This patch
> adds proper error handling to free the allocated memory and reset
> governor_data to NULL on failure.
>
> Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data f=
or governor")
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>  drivers/devfreq/governor_userspace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/gover=
nor_userspace.c
> index 3906ebedbae8..b9fbcacdfba1 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -97,6 +97,12 @@ static int userspace_init(struct devfreq *devfreq)
>         devfreq->governor_data =3D data;
>
>         err =3D sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
> +
> +       if (err) {
> +               kfree(data);
> +               devfreq->governor_data =3D NULL;
> +       }
> +
>  out:
>         return err;
>  }
> --
> 2.54.0
>
