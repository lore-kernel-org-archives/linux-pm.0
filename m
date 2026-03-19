Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51E280329
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915262; cv=pass; b=SQ6QLwEmseWPIbQCyEBPsP1OV5VGD8Grry8owFCUHnbojhhCwcecHn3quLXF91P2STgRrFfZZk7sIogiVK3O6JfQ83EEyEJ061RWAnazmV3Rz20Sq1nTntz+q2wIZzpoy0vUztgATRc+xvBfvHfwJLDo+d93Et8O5egNfwnvrLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915262; c=relaxed/simple;
	bh=v17TFrkeat0+iYNY8nfXZ5t8sCUXRNMA6XJWPzLyY4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiKol7D4Rthz2huJCcxHsE0lzR+zWDXQ6iVUyZcta4ldBlKdj8zYGmTooNY8zeo5opjjCxrrCWRw7uLhI5pAwcop/fSoFoKvRpwKoWMoxMa988TO06Y9iNwZUnGITgkH9itmA4VE/d7JmxIwfonh+4AXvLDzwBPOFSggc3Lbixk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DCrnyDXv; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCrnyDXv"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a278b4c1a5so663392e87.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 03:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773915259; cv=none;
        d=google.com; s=arc-20240605;
        b=TynJrizWZgHqFJsppwqJppA6Yzcj01B2HZAla4IuzuwMX8FTPoXp0NwYKKtAZpV9XX
         SWjyih9Nd54EIltZFzyP/Q54r2x52i0CNa5orXuJbsHQAiG/a2gO1IVqaOTkKjlSwxb5
         wyoz8Ysd7GCviZb0RfELbgOomkWHBjChUwkMtlkAXGnezLrW5fhOHNrysZ8n1dS8d/eW
         I13rItzIh5IDODb7rooN5Euq8UyR1ybHYFa4gE6WlNO+YK/N53Xltndb/pmG2Z7czNJg
         ob/Y7TN/6GE4eDUJnMxMbdXcf9+s7qPlZewd8j7cVDPPi1cKUb0N/boYvPrTtdixQ9+U
         8jLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ujZTJk7VIt/xvASexQ2VToUKfUsb3Y+OQiXRRgGyWt0=;
        fh=Y8AIUo/MiV/Wh6RmzJ5hSigZgf5oIvUmhV1nZZOrHAQ=;
        b=CqhQEZVxkspiB3p1OdMKn7o6iIn3bW+SWRsj+3gigVLn6uRF5LR5vzVVzN1QgpiV+y
         B+MVKI0UN1tPTIqbXO58Antp4Gjfcz6o7sBL564G8fiB3bkttNOYGDehwJkC0pfh6P1+
         KcFiB63ZEnNPAryqcxGonYDwKQreoCmrT9KuBuAfRnRcR896BIVnQuxW/Djjl1zrMVRR
         bYgcawwR9G+IpAi5FtsKEeQvIaWou3JsruuOwovu7sQaPSVg/LZepXdMSowDAGV4ixey
         b1mo78ER24vis2qiLPAfXZP6JO1rJWeXSgCLia2kI2NJWEG//TkbjrqhN3cvEGtlbi6p
         p4Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773915259; x=1774520059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujZTJk7VIt/xvASexQ2VToUKfUsb3Y+OQiXRRgGyWt0=;
        b=DCrnyDXvFNLAHsbEWSzR0ZXcgGPpILgzIhAOXQhwFHdxpDFriY3A+MBIY37ur4aRg6
         KRJtjDhpZ1A8zBHO1qiMsFaCL7sRHS2can6e3mLtPNbCAqeNnCMaIrXK7ipzz6wI8rF6
         JvwvZfhOoMg+NPm6QchtiFKKyuFqFdjbEKAZe/U+Cw3w+lEKPS6PTgpjUyJiqh4OigHz
         P/vKXBoh/OyNkY1JZuMLV3I8mb03EMQQMdGVC8+MCKQG3JrBR1jDqDx3FkRUcxgm32xa
         HOAhLH0cCKn2J3XaSoy0khI0Dt+0bmGY6mc+s2goEmhFiFHfXdGZS8WR013bek5S/PpL
         2Ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773915259; x=1774520059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ujZTJk7VIt/xvASexQ2VToUKfUsb3Y+OQiXRRgGyWt0=;
        b=X6KGq+VTKPbGlKIFBieMVlvICltrKppzga2ZQtHxyAzyjDwRf2dA4pg4pCbp/9XFst
         IOZqU1AGkXcvK0Ar0MRY+o04ELqYVRFGC4DgIE7vV0JNiD4MJ8tVpyW/9E8bENAMAdu4
         2nPDg8XxkWJ/A2GA4nWLpuap7+nD4OXwqNI906OdAO5P+C+nzB4ksEJ2rHXnJym6ppf8
         I+9KcjFGLwYg2eVnY88r5nosUQREaze0j1Jv/9M8Gdm8iKh9YdCzCGqrrDynsOQcZAN0
         nNMknDoNzHfNnMnnGe82UIvFs0yMz10PY1D87aqCkydJE2i0hVmY1g+jL/0hODlV8vEH
         d3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV/1QHQe0U43PMavII49kkJbsw50yWUn1yb4JwA3xnW0X9gVavyxo4KdXq4eeRw7DGrlTyMDqbDDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxePLc78cjViM9kL8e5rSbMKMQFh5hnA0041vmotHqPTscPATCu
	vtpLmDFLqSh/NqUUQDKZcf2kj+N16to0ViKnJvvI/gZJzxVhZLTvrWnkBiWnQ7/Ccf5OC5NK2T5
	wrGG3CIBMia8d/GZe1tVtq/CFKeaQzGOjef/fnDqKNA==
X-Gm-Gg: ATEYQzzZD2YkTp9aQ4pbEHQjrKIUjmpNVliejzTsRzJQpfS0ytI2zxZYkmlBU1QjBIG
	DCBq3ZNxRvEKrM1N0sAZkw6CqSIBxeyZ+qelwMuGfdxeGL4zsVYibU9eYjgelpcPPzscaqKYVGp
	F2igQtEDHYFTcVZcthBbXJnyWADYjXnOTy9D6G0wYb1CLeq1Nd7wPgHVWvBPA5UCg65WNd18A28
	0I63TfLum81aPhjSEX2uuXpL9+yuoBkZ53cUZM96JJatlVE48VtkqsfjUKfzE0s5LrNazCgy9C0
	U0j3c5j5
X-Received: by 2002:a05:6512:31d2:b0:5a1:db06:764c with SMTP id
 2adb3069b0e04-5a2796b6074mr2602865e87.40.1773915258920; Thu, 19 Mar 2026
 03:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org> <20260318-gs101-pd-v8-5-241523460b10@linaro.org>
In-Reply-To: <20260318-gs101-pd-v8-5-241523460b10@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Mar 2026 11:13:40 +0100
X-Gm-Features: AaiRm53xTSuLVdH9AhqcT-kXTsfPbIEbom5uTjkqz8fSS91buviGLW-90zzWxN8
Message-ID: <CAPDyKFrprMSLOBMB_BHbi=j6UXV4dXBn-H8M1BsqDWNSCJwvuA@mail.gmail.com>
Subject: Re: [PATCH v8 05/10] pmdomain: samsung: convert to using regmap
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Mar 2026 at 16:28, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> On platforms such as Google gs101, direct mmio register access to the
> PMU registers doesn't necessarily work and access must happen via a
> regmap created by the PMU driver instead.
>
> In preparation for supporting such SoCs convert the existing mmio
> accesses to using a regmap wrapper.
>
> With this change in place, a follow-up patch can update the driver to
> optionally acquire the PMU-created regmap without having to change the
> rest of the code.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

[...]

> @@ -36,31 +35,42 @@ struct exynos_pm_domain {
>  static int exynos_pd_power(struct generic_pm_domain *domain, bool power_=
on)
>  {
>         struct exynos_pm_domain *pd;
> -       void __iomem *base;
>         u32 timeout, pwr;
> -       char *op;
> +       int err;
>
>         pd =3D container_of(domain, struct exynos_pm_domain, pd);
> -       base =3D pd->base;
>
>         pwr =3D power_on ? pd->local_pwr_cfg : 0;
> -       writel_relaxed(pwr, base);
> +       err =3D regmap_write(pd->regmap, 0, pwr);
> +       if (err) {
> +               pr_err("Regmap write for power domain %s %sable failed: %=
d\n",
> +                      domain->name, power_on ? "en" : "dis", err);
> +               return err;
> +       }
>
>         /* Wait max 1ms */
>         timeout =3D 10;
> -
> -       while ((readl_relaxed(base + 0x4) & pd->local_pwr_cfg) !=3D pwr) =
{
> -               if (!timeout) {
> -                       op =3D (power_on) ? "enable" : "disable";
> -                       pr_err("Power domain %s %s failed\n", domain->nam=
e, op);
> -                       return -ETIMEDOUT;
> +       while (timeout-- > 0) {
> +               unsigned int val;
> +
> +               err =3D regmap_read(pd->regmap, 0x4, &val);
> +               if (err || ((val & pd->local_pwr_cfg) !=3D pwr)) {
> +                       cpu_relax();
> +                       usleep_range(80, 100);
> +                       continue;
>                 }
> -               timeout--;
> -               cpu_relax();
> -               usleep_range(80, 100);
> +
> +               break;
>         }
>

[...]

As a follow-up patch on top, please consider converting the open-coded
polling loop above into a readx_poll_timeout_atomic().

That said, the series looks ready to me, but I am awaiting an ack from
a DT maintainer on patch4 before applying.

Kind regards
Uffe
