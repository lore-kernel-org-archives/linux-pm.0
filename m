Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F493E0250
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783678516; cv=none; b=gWlfvpXDhIFcNO6nzxqQHB3rkcnv2lDvP6p4QnyFXMAkFrb3NB90Dc7I8PP5w3nLU4ihRiwCvOx3OYNlyyc0TYehQuXsluWkf5EI72jHXGbHAnDhodwBN+83ZZTZvPBQR1vS/DHjVmTONfrWyCIRavJFWKB1NpnaJ0c0beE4Ycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783678516; c=relaxed/simple;
	bh=fkY09JmZKv4DA/dlClFK+sgmnRGhXR9B0jaApDjTccI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7E0ie6UEtE4oE2otAT4g2j5pv446HWORuNjKl0aHNPPhwNFS3jmMb7Q5Hr3i+EsXHygENaS+fwZyv1HgxM4BlqwyNZ/sOxJetzFNHaEjhE83sp+rxtVuzCYZx6/BjggVLnU8uwxqHfxWTDflgkaJ1boZEzc1laAgJrHAK0CkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYIraYuh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYIraYuh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52DD1F00A3E
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 10:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783678513;
	bh=wifolWv+k77dwMZHrvYZrFfpeCVTKhalvhqfjczN4xo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cYIraYuh7SeJMxvTfhkJYNrhMwee7T7zThXnmjzfuDOc7jF2p5SKzvMHlgoRpU3mg
	 4QjDn8vU3njyqtEpjaLWxs1bPN/5mqkkDbgj9dCbB+n/JeVELYX9U46GvtwZV9ppO9
	 68hRopDZdk/O3hQ6cVHnKqH53VrFWuvLMumhAibhVihqjfwnwPc15hwBtafCV96519
	 UeHpYKrlGEgRJOEvGidmzf/svaLdVSJ1a5yWkMzdAowl6YwgJL7chtYzgdwSDV/36l
	 z7VyN2s4tcd2nzoJniEK7PPkhp7LlIrSkIxjm/h9JrskNWPacsZuFbvTQOSDlZ2Rrn
	 8sygGqMf1Ad1w==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b018fe8318so617845e87.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 03:15:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZAev9gSg9+3sfrgHOtOLQgXi/8tyqyZrkvV+Fh67+Rrd4bIKpEaH9ftiwMtpf5kS90bBDzQXcvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YytHXARmGHDn+mIY0Y6aRybnF2jlc5wZE0kxUE1aTHz4GH8x6MD
	lB/nMHseNJdIO+ZjC4JzaLQviJNbyJdF2uRGrKFcZNXER58rFD10uwG4dPuq3rcb9oBr51/GXGK
	BZARQfzUlCL7t6/z9TJj1Jmnr8C+57hQ=
X-Received: by 2002:a05:6512:a8b:b0:5ad:5c4a:8221 with SMTP id
 2adb3069b0e04-5b011408a4amr2672040e87.0.1783678512340; Fri, 10 Jul 2026
 03:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-0-be81d6c15043@oss.qualcomm.com>
 <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-1-be81d6c15043@oss.qualcomm.com>
In-Reply-To: <20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-1-be81d6c15043@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 10 Jul 2026 12:14:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j2idK3fgdmNmT4dsAW5dqDuLon7iKtLMHfGdYRoPtq7A@mail.gmail.com>
X-Gm-Features: AUfX_mzEFvX7sYbyQjGQfbLNXLXyGl0tAJeEyZsQuLv9AOnDMi0cU5yOUDPj2h0
Message-ID: <CAJZ5v0j2idK3fgdmNmT4dsAW5dqDuLon7iKtLMHfGdYRoPtq7A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PM: runtime: Only set runtime_error on suspend
 callback failures
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Alok Chauhan <alokc@codeaurora.org>, 
	Stephen Boyd <swboyd@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
	Dilip Kota <dkota@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>, 
	bjorn.andersson@oss.qualcomm.com, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, aniket.randive@oss.qualcomm.com, 
	chandana.chiluveru@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 12:13=E2=80=AFPM Praveen Talari
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

This has been applied already.

Please provide a follow-up documentation update reflecting this change.

Thanks!
