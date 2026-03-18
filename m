Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D615D3BED09
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858181; cv=pass; b=PBi1qxzDdPUbFWHeyjynCxgKwmdnezIkiQGG+1GEENU+F3Pq/iP+FiTKFRHzrUJqN8xcdfmhoQbLQNH35ZXJuSPxHntEZvVYcwwM0nQG+etZge/DOo4ObqeZ+oc99awIbpqLF11T0G2YJi+z5/hOB0onZrq7xtZoM+QbUI9QdSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858181; c=relaxed/simple;
	bh=nyP+gtfZxd9qCAN1bjq0tI03dKg3ytpQ2Du0Rew8xyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwQkb2lpsl0FOpYGJIOyW0J9JcLnFt0pr0g4hCyzA/TReSrfETUW8uQB1s3In4sD5Ygxho3Qtk8SIRNO8aSak7+ci1AjugpWUxwR8K7V4+ulBVGtrnsRKB+sqLv46Xr+gFRgCNNScFhRXt/ct4n5cpEMJzt7YIj4DFRjKt3oW7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZ4gdx9A; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZ4gdx9A"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59de8155501so147237e87.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 11:22:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773858178; cv=none;
        d=google.com; s=arc-20240605;
        b=Bz4HWkZOC91lTRhHoyz3u+RkOFVCtZ2CzSZ/Uwyg+CA5LZG5NTdrmTf8z+R21k/pXi
         moREPnVaFiY2JJ4MrtxAYtHzpCK6ctMdWAUCRwfbdz8qLQSRrkdIPPeFil0kyycLEYUT
         Fe13koPIFqcLl/DIU9gvFsj5BfScmI39dcvaQgruw4O6cyICo6rA/bOxt+kc2JqybPTp
         IL5h/zBkzhtGtT/UtteB1QRuQzBHP4P8cuHb0dQt0sipIiGVk4GWPKk3VnjxPN2rr9F1
         fJ8N/v26OV6ms6PaEkAKVQwiR/vgHknSlnXdY7DDvvZr3zzff2yj1nbelw2YELY6oC5T
         dUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iA23sR2q1qivlc4Reij+0B975e1ViOsO76XTHCFysUI=;
        fh=pIGoKsITR2fk/fHBHwVIRHiFW3OhJ8E8jG3fcPblFQw=;
        b=fiS2ZO7tWz6BGaJwM8owrfbdp1/s3GdwxTEzs9WF/8/5+caRT8O0hkWyGO3EPWiUxz
         THELx5NKIjMOBUrm7WBnv5pHxAJR0hH8I8nQ4bVyWRLY9xP/npNeB6UCkn1kYvF2PEOV
         kfF05iV68mpzq503bHszCJcgGwQWCkQaslobei4FapjUDkLxlJai2+MQa5KwIp0/Nklx
         UNn6JaLxA3y4dKrvHcHDtjBva8Spks9RYOBNtxFGuHav5ftzzMuLz6M+Cg7fNYIgGhuh
         sWV8dn+A+40LePseRcQ4qVNW6PO+VlfZdqDZBSyuUH9t7yHT3HUIW0shIfjcVmgDJ4KO
         yN4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773858178; x=1774462978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iA23sR2q1qivlc4Reij+0B975e1ViOsO76XTHCFysUI=;
        b=YZ4gdx9A2rbswMrwxvebnlw+8nWeyXoe1AeBlA1idbva3MG7siL7pMmsbyBwaiBC+4
         BJcVgkh7IyQi0prgOGkmyBOmS6NKLFbIqoOOCAA6YOXznotAyI1SMn6B7TdSOBUoucv5
         650d3koZP6OWJbsCIvg9XJCvE7icJ6TljFHiLCywrwxHyoQXAbp9jKiP1r5qAvSD/Pvk
         uLz9/PYLTPrODfWSvvWu8P1eppaFTb55q54GRStzNvgtvU/9ac8TB8HP1YQIfpwZRwZA
         K626q+SKnwCGGW7G9dbAywhptkJ8387SfQLd0KQi2DcHlNLglmBAFUu6grONzuHhmVck
         k/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773858178; x=1774462978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA23sR2q1qivlc4Reij+0B975e1ViOsO76XTHCFysUI=;
        b=QDWmT0rkGixPTIg6FRy1HAikl2gT3+hC0rovxykrKD+NlNISbTvpihfwuw3qw1dib3
         KdzzlPMGK9xFxfMPoKrVhy1DRqmdBY0VGnC6pEXFbH8YymCDKtJNQTh25IoIuUvCffoC
         Qcy9VK4oAEXrDzS50jOtfP1evwx3fZmymIwQdu+fDOji8xbuvwtpA0SoLBdrGNLSqGBc
         +gfWQAZGJEBkoHMPcaQf2N4laMQPVppLvkS8efnxJrUwZNG2DtYkbIOsekuo6IiCp74/
         RQnLz1fz6C0EKQ4A78bbB3LKy6tqPkaler5PZWgAZnItRm/ZAPbEGZ/Oug3KJhaKXQy4
         IFEA==
X-Gm-Message-State: AOJu0Yxet8k6aL9sKHMdzxu1q/AjwdoGLqEJof6NNOjdMsmd2Opb/CYw
	w1sGlQw1Q5w6sIMPxJu0gEK/Ib7hf2Pj7kj8gIaqSJ4/OHflunrIhXHmR/SXwIPwv+NKZj5KCkW
	uf/CJEtsUnOREgZkp7MfV6TTbMT46K+7gN0AinulY9w==
X-Gm-Gg: ATEYQzw8mE1kieITCxoKTZVs2cUE1gVEyzNbhk4zj45IZwN6SLD8ALD2qITY4x7KtJi
	yNTy954S2atZ3O9nYKEnG08cC7GCnF0MVTkS7u52G6lQPYcQAMusbTVxRE1tVyFUzBy9f1MiWW1
	xsKd4LQodDucXb0vUp1rWHGvjRco51buode+C9zyHcMnG7oztwgEyCCOCsrdm7bTH5uN1knqoMo
	Po4cK1WRkgIU0n8u0VyP+An/wNm5XrWBUakS4qPHEIv8bYe7Ow8cQ6v7yHpe30teKzfHKV7qnNp
	opz5Ts7g
X-Received: by 2002:a05:6512:39cc:b0:5a2:7c67:4b3 with SMTP id
 2adb3069b0e04-5a27c670581mr1032726e87.2.1773858177947; Wed, 18 Mar 2026
 11:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315214153.3682-1-rosenp@gmail.com>
In-Reply-To: <20260315214153.3682-1-rosenp@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Mar 2026 19:22:21 +0100
X-Gm-Features: AaiRm52kpaoiFPpZGuLu4fw_l_zJBBCJEDVi43rk0eejFBLBLds96ejXR6F-tws
Message-ID: <CAPDyKFr1C_0Eirrx62bkp63ph_y9Ly8FjGbZVjYH9iCtAZGhbw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: cpr: simplify main allocation
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	"open list:QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER" <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Mar 2026 at 22:42, Rosen Penev <rosenp@gmail.com> wrote:
>
> Remove kcalloc by using a flexible array member to combine allocations.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/qcom/cpr.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
> index 3ee8184e4be3..c30690ef6919 100644
> --- a/drivers/pmdomain/qcom/cpr.c
> +++ b/drivers/pmdomain/qcom/cpr.c
> @@ -239,7 +239,6 @@ struct cpr_drv {
>         u32                     gcnt;
>         unsigned long           flags;
>
> -       struct fuse_corner      *fuse_corners;
>         struct corner           *corners;
>
>         const struct cpr_desc *desc;
> @@ -247,6 +246,8 @@ struct cpr_drv {
>         const struct cpr_fuse *cpr_fuses;
>
>         struct dentry *debugfs;
> +
> +       struct fuse_corner      fuse_corners[];
>  };
>
>  static bool cpr_is_allowed(struct cpr_drv *drv)
> @@ -1600,19 +1601,15 @@ static int cpr_probe(struct platform_device *pdev)
>         if (!data || !data->cpr_desc || !data->acc_desc)
>                 return -EINVAL;
>
> -       drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +       drv = devm_kzalloc(dev,
> +                       struct_size(drv, fuse_corners, data->cpr_desc->num_fuse_corners),
> +                       GFP_KERNEL);
>         if (!drv)
>                 return -ENOMEM;
>         drv->dev = dev;
>         drv->desc = data->cpr_desc;
>         drv->acc_desc = data->acc_desc;
>
> -       drv->fuse_corners = devm_kcalloc(dev, drv->desc->num_fuse_corners,
> -                                        sizeof(*drv->fuse_corners),
> -                                        GFP_KERNEL);
> -       if (!drv->fuse_corners)
> -               return -ENOMEM;
> -
>         np = of_parse_phandle(dev->of_node, "acc-syscon", 0);
>         if (!np)
>                 return -ENODEV;
> --
> 2.53.0
>
