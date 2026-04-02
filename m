Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA83E51C4
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144594; cv=pass; b=V6UyadcvZ9rdFtHMihjNo+CU/L6fHrGw5YrPHR9jDXAd5OBtsnITcAsXWFH9YSTM6M5vTfnQXUrU6uBo3GZbP/y9xV0sH64L0qWuuzi04Pe3+zIOO0AQSkNc4EfTsBUs3BKBkNdLuWnhMCESVSu5DH+ugXUpEOS7Fs0WcTZiAa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144594; c=relaxed/simple;
	bh=EwGXL/M6WL7gjbpYupA3u1R+gdFKaHgfkEtHpcgwAS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvNAfZBJy5I3bftisktuRY29QTOEsDWjuPhMxWBRqeif2TduX2l2Q+A6WQbnUMNDQg2FocLoxJ/5ME3gmJjmoijslq+gQ2+mghEjbLFuWpVfmB719mwdYg8coxDobZ0/SCIBe8sGzutLkdipAvX4IRVtsVJsGtpqE46VT4reWm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hei2sAKD; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hei2sAKD"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-41708f6aa5fso662252fac.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 08:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775144591; cv=none;
        d=google.com; s=arc-20240605;
        b=KRi/UwRaIGc9S5zteY32gl3acDBfNjSsImUhAvjwPDNCdGdYF9t71uwbqSih4BZm1V
         rRWPkCUnm2RoCYPUVd+DWX5wxK+rtL1oT3NGwwQiVsPStk4UJoKZ62lk7qQXYeEKMPFk
         TA4CqpQx08easS8gO0jUT9cKkL+WsLOXRTcgyxl/6+C9SQISS0/8HipmMruEd1sC2U1p
         gG0ZztrQPS/FBzMmwHRYdkxyeg6XdfPkM84P1m/cpFhPkjo3RnyTuFUbXzepcxC0/Vvg
         UEl5jM0sTKeitzhVmHrQCf7FXbw1zh7QpslVQMONVKz6rJU2LXZf3q/rRhRCqCCkQR1M
         vCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P4zsATtlCL3WORV1PYxmCpK4B9uC+smVrSN6VPJxaag=;
        fh=U0j9VztXeJqml5grkFW9lyjEUbUK3I7NiyBcxvhsmjE=;
        b=HKrhI0i5jklzhF8+45aAJOTGCxuGrQFkk8Y2z7roWr+PEGGLLBeh66hijm1qYI8wzx
         dB4AYEpzAvL7Ffl0zbQOZZWXBdn6rjAqPTeuFyOxOKoS58vWo5h33VLrMhHoxqBebAc0
         RNwgz8hGDA/D4u9g65TvSgH3n8his3/66K1plvRETDJshedkAUCfgdmGEwAycV95VQ9+
         OMqhHyud2cYAjXkklTFGAHuunlUddv9tr1gIMkoQ4l/ruYQMTNgCrUouiSnUEi4vnlLg
         194nNxBQ/eH+WuhActzoJJkQc4Bs3kpDHtRMKYMRdLPLtA1QohFqtbTQDVWKqN8OAFhr
         WriA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775144591; x=1775749391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4zsATtlCL3WORV1PYxmCpK4B9uC+smVrSN6VPJxaag=;
        b=hei2sAKDYYlHLh9PsDleIsqgr3byV6qMpvt2CViQWztU7DmTW9P8NbEe6mfWkHQx2u
         tSlE2aO3kVTk+1IaphSLQ0aSR+oDLYCEEkM8TbEXjGvRN3ggpCsCtCeaV21M+5Hqrv60
         Ol5K8sxCWzzAe3kN5/x2zVXY9uXb9DK0XwZi8K951azKWNTTdqShdkCcOBwEClk5/nOS
         BFdu8XW+FjcYzzn2zOzX+nv3amJpcyT7ISXyki5Y5SznAL9js5L3sCmPcH7gZudoIHnT
         tNsc8fsFloP4DPWI7YWph3e1oMNs5wClZ1+z/EgdvXxUGo6TbH3M3ogOIh95lOELtjKo
         WBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775144591; x=1775749391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P4zsATtlCL3WORV1PYxmCpK4B9uC+smVrSN6VPJxaag=;
        b=swOZE5Eq35/lodLMTmdwnhZnzw9Mj7YCFJpkN7WmwQDmocyiTgvPMBnfM90Ii2nIeH
         24jYDR+o+YDRDXbsKcHMiMyZmChDlJnTtNuOrwf5YNYZJIoTqdzmn9H5Vwot+9gCsKeT
         kl0KLHL/JSZFUoQqs7ilCzHAJxqlyGlNzt6sdYgoUnJVVwRm+KJWSS/gWGi3na7/xiod
         nldbqKkv22T0Jtn4SbrDOlFpakZnl9vdpC5Et+Lm8MqEhmjayI+3Xo7bLXe8Q/uGaLDq
         s0p6tu9qWyDPlxIyMPZxeKxQc2f9pkuhWnBbUEby7ZJHDRGQtIWg+kUhtu5+L5UEzM5K
         RjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvrM1VCzuROFcTc8Sg8+YbqDerIxQCOW2moMH+YD2yzr+k/lALXYZ2DpPLbheR7JrK8z0YERoFgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1HpjSDO8kY0NO7k8sWNcJSGMe2Sntv3C3MRsgQwIF3PD/PApV
	hcjqV15cofR/SIR3IGUsZGgI66kw5weKVVm7nHR9+wMfU+Oi4g9awqNuwdQfx0gpXrzsEu+UkA9
	9jbpWF4VgDAxJ6AT7I2nWkm1h3xjuNzc=
X-Gm-Gg: ATEYQzz4OYeW4+kFQ9lSdDJhSgoj+QsoFtps71z1GH5Hmu2vmtPjfWZFTtQ/3DdhUen
	0AsYZ0VS4/mZXFJSPnFHiJvQtUb5yVRpVRpAlM0NVQPv/Q3RY4oCMzo4fhy0uWqFnizTMkdQtka
	2Qr2A6VsZagpnrK25PBor+sMUW+bg4WESwOqt5Mz8jE7kPwesfAyoJY8OkrT5zptrwi+8DAysGg
	gHU3lFeaXT62Abj1oF3lQjqBu1aHWmviVGo0zriHUfAQ9kCA77OZ/9jMqEbBBkGVbrxlHlwN4yG
	TQZNfZbfTZvL/9yS3fc9HHBFK2P5XtURrkW4nDV99L4CUNeMWDBRWsgt5BVu9/t3sjXU6UQK4I0
	bkYrx8ci6jQs02JZ0l22EROwttB1Wc5OK8Rg3MDk=
X-Received: by 2002:a05:6870:3d91:b0:41b:edc8:7b93 with SMTP id
 586e51a60fabf-422ec1fe733mr2212909fac.0.1775144590830; Thu, 02 Apr 2026
 08:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318024815.7655-1-hanguidong02@gmail.com>
In-Reply-To: <20260318024815.7655-1-hanguidong02@gmail.com>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Thu, 2 Apr 2026 23:42:59 +0800
X-Gm-Features: AQROBzCJEKNcf6xiUsmFT6HQSrwE5bzjLRMutJ9jivwa-GEPqA2ccV2-Z-jy8iQ
Message-ID: <CALbr=LYyNh0AwC+8ni6iS=9UiTyVz9+r_gM7M=ohacCv97ujOw@mail.gmail.com>
Subject: Re: [PATCH] interconnect: debugfs: fix devm_kstrdup and kfree mismatch
To: Georgi Djakov <djakov@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akaieurus@gmail.com, me@ziyao.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 10:48=E2=80=AFAM Gui-Dong Han <hanguidong02@gmail.c=
om> wrote:
>
> debugfs_write_file_str() uses standard kfree() to release old strings.
> Initializing src_node and dst_node with devm_kstrdup() creates a memory
> management mismatch. If a user writes to these debugfs nodes, the
> devm-allocated memory is freed via kfree(), leaving a dangling pointer
> in the device resource list that can lead to a double free.
>
> Fix this by using standard kstrdup() instead. Since the interconnect
> subsystem is strictly built-in and cannot be unloaded as a module, there
> is no exit path requiring manual cleanup of these strings. The error
> handling path is also simplified by taking advantage of the fact that
> kfree(NULL) is a safe no-op.
>
> Fixes: 8cc27f5c6dd1 ("interconnect: debugfs: initialize src_node and dst_=
node to empty strings")
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
> I noticed this memory management mismatch while working on similar
> debugfs string initialization fixes [1] recently.
>
> [1] https://lore.kernel.org/driver-core/20260317185920.43387-1-hanguidong=
02@gmail.com/

Hello Georgi,

Gentle ping on this patch.

Just wanted to note that my other related fix has already been accepted [1]=
.

Could you please let me know if this fell through the cracks, or if
you have any feedback or modification requests? I'd be very happy to
address them.

Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git/commit/?h=3Ddriver-core-testing&id=3D31de83980d37

> ---
>  drivers/interconnect/debugfs-client.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/interconnect/debugfs-client.c b/drivers/interconnect=
/debugfs-client.c
> index 5107bff53173..08df9188ef94 100644
> --- a/drivers/interconnect/debugfs-client.c
> +++ b/drivers/interconnect/debugfs-client.c
> @@ -150,10 +150,13 @@ int icc_debugfs_client_init(struct dentry *icc_dir)
>                 return ret;
>         }
>
> -       src_node =3D devm_kstrdup(&pdev->dev, "", GFP_KERNEL);
> -       dst_node =3D devm_kstrdup(&pdev->dev, "", GFP_KERNEL);
> -       if (!src_node || !dst_node)
> +       src_node =3D kstrdup("", GFP_KERNEL);
> +       dst_node =3D kstrdup("", GFP_KERNEL);
> +       if (!src_node || !dst_node) {
> +               kfree(dst_node);
> +               kfree(src_node);
>                 return -ENOMEM;
> +       }
>
>         client_dir =3D debugfs_create_dir("test_client", icc_dir);
>
> --
> 2.43.0
>
