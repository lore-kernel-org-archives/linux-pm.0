Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657DE420E6D
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338568; cv=none; b=XdDbQ+8KMRCPSEsY/7qaTl9g7XfaS3RlalVzOJkdp2K90c1ui/h7a11YpTBRH5/iHAq27V7rLmMKQZYLGtgZT+ipNoRHhG0m96piczYdSluA9uxmeKO6QUaga8R+6VX/hyOPogttHEtF1GibPCM92yV/lOs2GQPpubyzkusmFRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338568; c=relaxed/simple;
	bh=/M2f10nzKIROJwrEVAhtqsy/5vvSl3n/EkrNByf/6uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVT5YMhqLn4vnV1DtYiyG6I5s7G/KVsZTX5j3FlqJEsINhjIbxW6S2avBks1PHgaToKyZKCVJsjVqtjy0dE3AktYLx6oUHjrBEj2otBsCsDkAjVTmgFEmWKwLsxAug75VqxPhgkU9/ArUphEr6EMOqC7962JEk9yk06cNslA1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFMhl8r0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFMhl8r0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9171F0155B
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 11:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783338567;
	bh=nFvsamCbIGEHld0MIsKih6s84BXlOl69b2bdqy4PP5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QFMhl8r0FlRsj+czVMxyjdl8EbI/JiiUe+qj1RqF4CmIMfAyHxuynodqHdD3fms0x
	 dSn9ECTfnfKZ9kPygg3aSQulhSI3eM9XKifzpsoyAwv1dVbCT50qZ5Jdkqi6MF+mC2
	 EocH4nlC6KlXjpMHFcLi7V9JJH0cRBIk5Pj/yYzqYJ033vJbmAjACD1ghUkel4rbry
	 biYUpPcthU2Bavp/R1laUR+VXOL1QkluhutHRZRUIF8xcXUhQgzE7ha5d8cGnOd1F5
	 UigHt+ZcQAvYwYDxjYt5TOvXqm/3sLWsmtV96q7rn1Gqj/TYJh9+ISh9VN2yk47FT1
	 Ght0SablLxkXg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2815261e87.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 04:49:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoMkjHo9+VhbkgRMWDQUWWoxympybb7Rc2UWW37w1ChHBNICF4yQ3UBhQPwY58iEvnXHB2lMkiTrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/neuGN3wWTnfq3nQmrtzSqvjr/wRJcsJKmksdFnID8fuH7rS
	GRhrKHeMC5e/f/ZhUNQ+wdxTLmC9Zm8oPL3Siv4WzIuAHoPqT4cF0ED8VNQaEBm4YKE+f8kxMaY
	7geZWn31WodJupgWAHvsfRwwr4Tv2YzQ=
X-Received: by 2002:a05:6512:6308:b0:5b0:312:21ce with SMTP id
 2adb3069b0e04-5b007ba9521mr7636e87.45.1783338565552; Mon, 06 Jul 2026
 04:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-1-92feb5a7b926@oss.qualcomm.com>
In-Reply-To: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-1-92feb5a7b926@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 13:49:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4Zc4HNUdgJ_2=4=wv7vRDTugo71qsWnZxVRRqV+W8mw@mail.gmail.com>
X-Gm-Features: AVVi8CfbkZLNMpcfV5gxPI-oFx5ptv8WU1ggHy_Bol3Yw0b5ctCpCWdBcluNG7Y
Message-ID: <CAJZ5v0i4Zc4HNUdgJ_2=4=wv7vRDTugo71qsWnZxVRRqV+W8mw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
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
> When a runtime resume callback returns an error, rpm_callback() sets
> power.runtime_error on the device.  This causes all subsequent calls to
> rpm_resume() to return -EINVAL immediately at the top of the function
> without invoking the callback again, making the failure permanent until
> runtime PM is explicitly re-initialized.
>
> Unlike suspend failures, resume failures should be retryable.  If a
> device's resume callback fails, there is no reason to permanently block
> future resume attempts on that device and all of its consumers.
>
> Fix this by moving the power.runtime_error assignment out of the generic
> rpm_callback() and into rpm_suspend() at its fail label, where suspend
> callback failures are handled.  Resume callback failures now return the
> error to the caller but leave power.runtime_error clear, allowing the
> next resume attempt to invoke the callback normally.
>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/base/power/runtime.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 335288e8b5b3..fab38bc98113 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -469,9 +469,6 @@ static int rpm_callback(int (*cb)(struct device *), s=
truct device *dev)
>         if (retval =3D=3D -EACCES)
>                 retval =3D -EAGAIN;
>
> -       if (retval !=3D -EAGAIN && retval !=3D -EBUSY)
> -               dev->power.runtime_error =3D retval;
> -
>         return retval;
>  }
>
> @@ -751,6 +748,9 @@ static int rpm_suspend(struct device *dev, int rpmfla=
gs)
>         dev->power.deferred_resume =3D false;
>         wake_up_all(&dev->power.wait_queue);
>
> +       if (retval !=3D -EAGAIN && retval !=3D -EBUSY)
> +               dev->power.runtime_error =3D retval;
> +
>         /*
>          * On transient errors, if the callback routine failed an autosus=
pend,
>          * and if the last_busy time has been updated so that there is a =
new
>
> --

This is fine with me and I think that it's a quite significant change
for runtime PM, so I'd prefer it to go in through my tree.

I can take the other patch too if it gets ACKed for me.

Thanks!
