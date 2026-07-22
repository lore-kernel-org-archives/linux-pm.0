Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBD934B662
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727228; cv=none; b=bI8CfnuYJi+UmnbLrZ6d/5ZhzUCszngL8t5WZL/9KTypyfAdhdLfMGCT2qcWLhZ4oNVVp2T7tfynoEYw4vdLQgZl+avAYDtWP/LLJ7yrHiW8MfwgRUzG+Km5ysIG+OL8Yes0312VVGmzK5LF0jnE5L1cwz5XidH8pgjHjz1k5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727228; c=relaxed/simple;
	bh=19BiM3mAvwV5wNXjoCd9wdDUQb3ZS84uK6WBXbMGb9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFHnapCUAkwsg7y0CI707JCd4MVwh+V1HorA4gcl/JIxXUM3gSTJwzef8Oyaif4Sd7C9cYgUy4svlpfsGDM3XQo+XyQrbCGvDA/PJcz+KKCRd6dpcnCy6nv1RF62awxTaci1AqxXw7oQWhkoWR0GzlXbBveqqouVRsIq1ySa704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuvGpXoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuvGpXoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806201F00ADB
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784727226;
	bh=dcUi/7gGAzV146/7sNwSJOcXFVF8yDkyJAh/VnYV7ME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AuvGpXoKOpF1veUqqH8IonjrCkLW6HQ8jwQC+Ytq05DxDqP16u+9WlSXoW71Or9GT
	 ndqUPOAdo8Oca3aNy5YsfEx3ZIZszjRgGUI3rXReLYs3oAOG/jYtVlAwFnGEmqcvLL
	 2SmT+iRUHHfokpllczLrJKgHdQl4ggQLgTcOqWW4lWYOYsQBcI2FC6DAp9GkYbqfqB
	 ePCS7k6bx9BPV7EHABPLvpMKRWpUeEzMAKXibnto9XMEtonmSYaEUcWrT2HfvDrr8K
	 wrfaFDxM5ulAouMddM9tTyV068bHz8MfpNbf9Yp+SPJmc6T/RAiDW/E+mwM3qP3lNt
	 jpQPzP+/V5rVg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so7255270e87.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 06:33:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoQVlSMJnrVpeU1s9dlOtzcjFE3JzaPxNjoX69vzlNYltabSHsgp53Y6lRv2zV9EtInN9g/dvOpjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAlkBxvMqD4UR0a/eJVcfslo1ij2ssfPZosLYLmEVVbbMLb78X
	+caK0ZPEUt/1VcP2PgUVAj6mqG1rO9GI0wWQEkQqMoEcuFDmOLLkJyOAiIkJoVzyliiCE5LMd0i
	0CnDGW/biUXdI6JARmSJnvpnRozRD9K8=
X-Received: by 2002:a05:6512:3d17:b0:5b2:aaa2:1d92 with SMTP id
 2adb3069b0e04-5b2aaa220b4mr804480e87.25.1784727224950; Wed, 22 Jul 2026
 06:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615065245.84252-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260615065245.84252-1-pengpeng@iscas.ac.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 15:33:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hjNfPJrJEcdN_mTbpz3_OC0q+UUij7W5WxgrCUmFsyQA@mail.gmail.com>
X-Gm-Features: AUfX_mzAsfhtj8lXoEjVA5jqkemExFVHYZAPFOOhuAx945RZ2ancCV7lWIIw__A
Message-ID: <CAJZ5v0hjNfPJrJEcdN_mTbpz3_OC0q+UUij7W5WxgrCUmFsyQA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: clean up RFIM groups on DVFS failure
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Kaushlendra Kumar <kaushlendra.kumar@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 8:53=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> proc_thermal_rfim_add() can create the FIVR and DLVR sysfs groups
> before creating the DVFS group.
>
> If DVFS group creation fails while both earlier groups are enabled, the
> current error handling removes only one group: the FIVR branch returns
> before the DLVR cleanup branch can run.  This leaves the DLVR group
> behind even though RFIM setup fails.
>
> Use one DVFS failure path that removes all previously created RFIM
> groups before returning the error.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  .../intel/int340x_thermal/processor_thermal_rfim.c    | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim=
.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> index 1a7e134dfcf8..96279756177f 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
> @@ -491,12 +491,11 @@ int proc_thermal_rfim_add(struct pci_dev *pdev, str=
uct proc_thermal_device *proc
>
>         if (proc_priv->mmio_feature_mask & PROC_THERMAL_FEATURE_DVFS) {
>                 ret =3D sysfs_create_group(&pdev->dev.kobj, &dvfs_attribu=
te_group);
> -               if (ret && proc_priv->mmio_feature_mask & PROC_THERMAL_FE=
ATURE_FIVR) {
> -                       sysfs_remove_group(&pdev->dev.kobj, &fivr_attribu=
te_group);
> -                       return ret;
> -               }
> -               if (ret && proc_priv->mmio_feature_mask & PROC_THERMAL_FE=
ATURE_DLVR) {
> -                       sysfs_remove_group(&pdev->dev.kobj, &dlvr_attribu=
te_group);
> +               if (ret) {
> +                       if (proc_priv->mmio_feature_mask & PROC_THERMAL_F=
EATURE_DLVR)
> +                               sysfs_remove_group(&pdev->dev.kobj, &dlvr=
_attribute_group);
> +                       if (proc_priv->mmio_feature_mask & PROC_THERMAL_F=
EATURE_FIVR)
> +                               sysfs_remove_group(&pdev->dev.kobj, &fivr=
_attribute_group);
>                         return ret;
>                 }
>         }
> --

Applied as 7.3 material, thanks!
