Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA1326945
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783110221; cv=none; b=hl2HLHZ+jK2LRP5Ya0zdT1RVEEiBWE6zAfDDjfck8JPQCCM/gdwPopwPfscfV8ZEnUw2f1JUDnvsqw25w9+B3fEfl4pD2V8rNDj8O6xZgo0JLcrLiUoMshU0Q33mwRCNNTeDwJu8EDErqYmrhQ3bD3Ch7W7SMlik+6SOd1x2xBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783110221; c=relaxed/simple;
	bh=+lLKo+hfgft3HZbL+R5Lk/WjvfQOY0bJEByCh077yok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PCOQeUnOEOsfoLzitw6NYqHVl/r2mwzYVcDdFwqDt63T+ErLPxfM2v5w5ez7c7lqN4X8IetZ1xsNe4MQH+yRdQ7pQSlvJMUq/UhPv+KMYgYs1BPH/LW+Idn389jEI4gkFSxg1LD8hw84ri7nHr8juch2gxuAomcbH12EsCb5Bs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzCKe9wM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzCKe9wM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5621F00A3D
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783110219;
	bh=K9OaFBi3ks/K/oOukwD8pGfn1NuBqlXea9Mvvp0CecQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LzCKe9wMFPr2YK93DsxQEtjnjbXVH2n3e47AlAzL0CNV+nRlNmowroDN8fl35u3Jj
	 T+PcMQwfyTWEo1iKWe7yPPvL25426DKGG6na+V8LAo2dIG7oN0WHOWlqyVBla08wLa
	 OgLAqBScnnAnli6S1p3oBcpmSC7g411NyogeTZ+iW0N8a9ggo44sGmdhZJSXotSxPL
	 aaQtjVvUAWtcfIQbHxA9NYQiMCFwD7RWkvh2G4AmPXkUS2fwDFL2oQg79tyr34srmH
	 yZU425yUkLREuLRgJiChAKK6w6ZoUj/rm6/K3gAJb3wFEgdWtFotuOxc5BgNzjRarx
	 +2u0AfchX/V1g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aebd52488cso1040527e87.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 13:23:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpkP7FnZk+s/aAjg8AA8iHGGTdczBRxLbB5wBkhmZUjEvGJZq5A2OLf8OoKdrmRXc7SzRwDDrcDAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0LN5AO5zZx1RtcK9u/K8uauJqQjShRsnrhG8dtq3n1wE/owfs
	H1O5tXw3lqA5v47EL8+cDKwHkhD1WlLc5JNGrcXiUTgPeXAHT/UJKo0yYnOIH8EoW/IlRJKOFxd
	Yq020ZAysLzAma0U2tiOLJ7gLN8DbF6g=
X-Received: by 2002:ac2:4e16:0:b0:5ae:bdaa:df02 with SMTP id
 2adb3069b0e04-5aed50b4946mr65751e87.45.1783110217735; Fri, 03 Jul 2026
 13:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com>
 <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-1-578b78a0cf46@oss.qualcomm.com>
In-Reply-To: <20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-1-578b78a0cf46@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 3 Jul 2026 22:23:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0haSHfupyfnVGX_v4K0wYrjn-83NiDPPfC22x=zwi8igg@mail.gmail.com>
X-Gm-Features: AVVi8CefGUyrFFdZwPYGZlC3wvidhE3xdDNTkOOUOg1Ptb_xKwPZ7PIeqlLivR8
Message-ID: <CAJZ5v0haSHfupyfnVGX_v4K0wYrjn-83NiDPPfC22x=zwi8igg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: runtime: Only set runtime_error on suspend
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

On Fri, Jul 3, 2026 at 5:05=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> When a runtime resume callback returns an error, rpm_callback() sets
> power.runtime_error on the device.  This causes all subsequent calls to
> rpm_resume() to return -EINVAL immediately at the top of the function
> without invoking the callback again, making the failure permanent until
> runtime PM is explicitly re-initialized.
>
> Unlike suspend failures, resume failures should be retryable.  If a
> device's resume callback fails transiently, there is no reason to
> permanently block future resume attempts on that device and all of its
> consumers.
>
> Fix this by conditioning the power.runtime_error assignment in
> rpm_callback() on the device being in the RPM_SUSPENDING state.  At the
> point rpm_callback() runs, __update_runtime_status() has already set the
> device status to either RPM_SUSPENDING or RPM_RESUMING, so the two paths
> are reliably distinguishable.  Suspend callback failures continue to set
> power.runtime_error as before.  Resume callback failures return the error
> to the caller but leave power.runtime_error clear, allowing the next
> resume attempt to invoke the callback normally.
>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/base/power/runtime.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 335288e8b5b3..70d933bcd295 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -469,7 +469,13 @@ static int rpm_callback(int (*cb)(struct device *), =
struct device *dev)
>         if (retval =3D=3D -EACCES)
>                 retval =3D -EAGAIN;
>
> -       if (retval !=3D -EAGAIN && retval !=3D -EBUSY)
> +       /*
> +        * Only stick the error on suspend failures.  Resume failures are=
 not
> +        * treated as permanent so that the next resume attempt will run =
the
> +        * callback again rather than short-circuiting on runtime_error.
> +        */
> +       if (retval !=3D -EAGAIN && retval !=3D -EBUSY &&
> +           dev->power.runtime_status =3D=3D RPM_SUSPENDING)
>                 dev->power.runtime_error =3D retval;

Why don't you move this check to rpm_suspend()?
