Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251438399A
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608909; cv=none; b=BatPdyvEfsB6eQ8uqU0teelXUmCf2Fxtz568TyBUOVj+wP32V8oYi4cIiyeuzDQvScEr++3qQ/df03p0sGG3aOZYZ4XnD4nC2SZWXvzzPVPxZQXSrC+RgyRh1ECvViEgFw4lehbEimbzW/uUPNuPLfKa5hHdH68pChM3LEQp6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608909; c=relaxed/simple;
	bh=g+sC/QZblXYDIcB9ooulCSeC1E+X3/Fd4MPLeB2SQsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7Q43wXdevdZs3QFmyiP0jJDVkClUMXFBsUdRPVRpHaphv2pwR2fReojdES/nIqxhgOOGqAsUIVD+iRd80zcaaofwMJu2/8nD1x5/7w6PqzNpZLBdO4eTaKaIrvO/Q1Y4COpvR+WzK9EFZ1tZ5DLAhopiMqo1MDlQzj6GCbIhp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ+uRmPk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ+uRmPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799DD1F00A3A
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783608908;
	bh=+uWDUc/+B8Zcl3RjgjlcAl1XfyqZh6uKOMuQl+0chAo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CZ+uRmPkArgS05FkAxTN/g1EJcQSaRs8dsL+F4Uujnmu94htT9jKoNWjcxH0hGaAM
	 Sf1hkR2KF7IMxP8eTBaARyhpTX70W16qE4lh2fEvaK8Zeev/H+uKwIem1OhX8VkCf3
	 5y+DH/OYNcOfP4oCjE35LUFb429cJDyNDD3Ft/8DO2gaBcbQoSs5W89AIglHIf6Zow
	 RSSRot8AKZal/SBb2wkBogHeZxUlMMxWFutMvBimQbrR57brMo1OMEtNpCECFt4yHc
	 PjHTXkPIi/LmfnRmfM/qFc/FXReMbJtO5tmsp31okTdinZWUPTV+rk8IFNLHLvcqtl
	 o0y8R+Lfn6VGQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so4248191fa.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 07:55:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoduS12o3T5g7Dcv9FWgSp1FEsN4lnRitwJFX7OZI7sJG0xbwJ6TmU85QotoamxdAz9uYbU9zfwYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGB5XtNl5uftg4Kk0OPs2sBfXAr53ik6NHlB2or10EdY+wjLo
	ePt1C/5xPZa1c3EOpzztg1xt5sOzks30tQtvVlrkvAwk/nABUJlwrfbjYxiEBoX/sFd3CUHxhft
	lyRiOPDx5391iM0CEB0tkqyEwHkpXNXc=
X-Received: by 2002:ac2:5203:0:b0:5ae:c563:f611 with SMTP id
 2adb3069b0e04-5b011463233mr1492320e87.36.1783608906969; Thu, 09 Jul 2026
 07:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
In-Reply-To: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 9 Jul 2026 16:54:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jAdUDrmqdZOofD_SOybX_riGygebZg28K1+biwCUwdoA@mail.gmail.com>
X-Gm-Features: AUfX_mxObOw8riju13AyHbeASLKZvtZGFB_mGMk6sFqZ8O5AcMDNT22UDuZo1rM
Message-ID: <CAJZ5v0jAdUDrmqdZOofD_SOybX_riGygebZg28K1+biwCUwdoA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>, 
	Stephen Boyd <swboyd@chromium.org>, Girish Mahadevan <girishm@codeaurora.org>, 
	Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, aniket.randive@oss.qualcomm.com, 
	chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:53=E2=80=AFAM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> spi_geni_init() calls pm_runtime_get_sync() to power up the device
> before accessing hardware registers, but never checks the return value.
> If the runtime resume fails, the function silently proceeds to read and
> write hardware registers on a device that may not be powered up, leading
> to register access faults.
>
> Fix this by replacing pm_runtime_get_sync() with the
> PM_RUNTIME_ACQUIRE_IF_ENABLED() macro and checking the result via
> PM_RUNTIME_ACQUIRE_ERR(), propagating any error back to the caller
> immediately before any hardware access occurs.
>
> Since the macro handles its own cleanup on failure, the out_pm label and
> the corresponding pm_runtime_put() call are no longer needed. Replace
> all goto out_pm paths with direct return ret statements and remove the
> label entirely.
>
> Fixes: 561de45f72bd ("spi: spi-geni-qcom: Add SPI driver support for GENI=
 based QUP")
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

(no issues found)

> ---
>  drivers/spi/spi-geni-qcom.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 26e723cfea61..392accfd8515 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -613,25 +613,30 @@ static int spi_geni_init(struct spi_geni_master *ma=
s)
>         u32 spi_tx_cfg, fifo_disable;
>         int ret =3D -ENXIO;
>
> -       pm_runtime_get_sync(mas->dev);
> +       PM_RUNTIME_ACQUIRE_IF_ENABLED(mas->dev, pm);
> +       ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +       if (ret < 0) {
> +               dev_err(mas->dev, "Failed to resume and get %d\n", ret);
> +               return ret;
> +       }
>
>         proto =3D geni_se_read_proto(se);
>
>         if (spi->target) {
>                 if (proto !=3D GENI_SE_SPI_SLAVE) {
>                         dev_err(mas->dev, "Invalid proto %d\n", proto);
> -                       goto out_pm;
> +                       return ret;
>                 }
>                 spi_slv_setup(mas);
>         } else if (proto =3D=3D GENI_SE_INVALID_PROTO) {
>                 ret =3D geni_load_se_firmware(se, GENI_SE_SPI);
>                 if (ret) {
>                         dev_err(mas->dev, "spi master firmware load faile=
d ret: %d\n", ret);
> -                       goto out_pm;
> +                       return ret;
>                 }
>         } else if (proto !=3D GENI_SE_SPI) {
>                 dev_err(mas->dev, "Invalid proto %d\n", proto);
> -               goto out_pm;
> +               return ret;
>         }
>         mas->tx_fifo_depth =3D geni_se_get_tx_fifo_depth(se);
>
> @@ -664,7 +669,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
>                         dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n")=
;
>                         break;
>                 } else if (ret =3D=3D -EPROBE_DEFER) {
> -                       goto out_pm;
> +                       return ret;
>                 }
>                 /*
>                  * in case of failure to get gpi dma channel, we can stil=
l do the
> @@ -693,10 +698,7 @@ static int spi_geni_init(struct spi_geni_master *mas=
)
>                 writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
>         }
>
> -out_pm:
> -       pm_runtime_put(mas->dev);
>         return ret;
> -}
>
>  static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
>  {
>
> --
> 2.34.1
>
