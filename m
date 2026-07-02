Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBAF441036
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 11:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992262; cv=none; b=oPseQzsWoiuyjEr6V7VdIimE1fIFdk+FnBglvXByXB/qRBVykwlsrmvZLdW/ou7qsuDDoSPQOp6APWefdOAoRbRquJOibRWzou1HyrzyyOvl/jCQwgVN4gfdPi0feNZNz/vKF4B8K/wi4s82FkbXAKGafNri7WdH0OycAyC+lU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992262; c=relaxed/simple;
	bh=WY9oIWlzoimYhCJKvEg6rl1OwI2uR608QGIY7aWSJ4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOSkK3SYtM/ooeoplPMuj+xx3yKr4IhxVb7GkCFbR9cMp2mqhiLqAYlZoMo/qjI/812BoxLh/0K3/obgC1jPDBdjWn3kWhHIm0eo400alykltYMDeBtB6/RVyzL67wYPBbGtub+Jom6SuFQqkYv/uEQFsKYWF8gHTndSc/OyMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1hTFGiq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1hTFGiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB1A1F00ACF
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782992260;
	bh=u7EXb1weowWTs8qmsPE7dm/b7A2l7/Sm1XmjS9B1n6E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=k1hTFGiqG4YbriyM+fxdbw/kxpiX1A9Ce6x0tm3iVPCwNBp/H0+fU8x3YanZ6Vhby
	 E1YhFE6tiD1btRWy2QbaFAcw518+hV2Bd4CyYIsN7GuxiIMOCB2XcVJU0bESObzMFt
	 o+felxhputbqHdVsvPNVciqRlj/PYkWgX90RCtmUIaf+Iat7oYCtuYumydunQXB1Ep
	 lABxQNacpI/7pbKffPc86Otp72PU0F+CZbOhgYrLHvSMxpv29AQ34QrZabpUQxIvry
	 vCXnf8Q3PaPS3apqso/xx1yRCADpxy9JtpFJ07YgXZ+RZMdXbHsbiAZFWZZ1YDpnLG
	 BYV4OBYRjIKpQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso1823275e87.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 04:37:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq1B8J5LwBXSwAaBvqL/NO3Lhe06kFuPsmxVNq9vI3GYCEKSpmsX1WlhiBz8V3HfnSyaBcWfeUchw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcH803zhjrT6XKq4xVdu7SoWEnEHM6GorUuy4OEMZtJzJvzz0P
	+gniQ5vlkr6u3rULqZ/MTBe4FEE6rwNnPeN/UFGO8seVg5izu46a/PVgZeFPvYUtmAB7Ww2k0Gl
	WMtus6UdZaUdHraMUBZDQ+/Gyu6X6O8I=
X-Received: by 2002:a05:6512:1383:b0:5ae:b25b:8a43 with SMTP id
 2adb3069b0e04-5aec67ab096mr1418021e87.23.1782992258496; Thu, 02 Jul 2026
 04:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
 <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-1-6ddc317011c0@oss.qualcomm.com>
In-Reply-To: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-1-6ddc317011c0@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 2 Jul 2026 13:37:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g6iRNUAKtDNKWa-_pshmnSCdStenNBJ91Xt=PSrhx=aQ@mail.gmail.com>
X-Gm-Features: AVVi8Cdnq5UobXyHGkMuzdH234LirYD10dZQzOXqVoakHaXA7PLVm3FHzd9rkH4
Message-ID: <CAJZ5v0g6iRNUAKtDNKWa-_pshmnSCdStenNBJ91Xt=PSrhx=aQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] PM: runtime: Clear runtime_error on supplier after
 failed get_sync
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

On Thu, Jul 2, 2026 at 8:08=E2=80=AFAM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> When pm_runtime_get_sync() fails for a supplier device in
> rpm_get_suppliers(), the supplier's power.runtime_error field is left
> set. This causes any subsequent rpm_resume() call on that supplier to
> immediately return -EINVAL at the top of the function without
> attempting an actual resume, making the failure permanent until
> runtime PM is explicitly re-enabled.
>
> Fix this by calling pm_runtime_set_suspended() on the supplier after
> pm_runtime_put_noidle() in the error path. This clears runtime_error
> and resets the runtime PM status to RPM_SUSPENDED, allowing the next
> consumer resume attempt to retry the supplier resume normally.
>
> Change-Id: Id5067d09caca464f663fc95fe745d037e9c56664
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/base/power/runtime.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 335288e8b5b3..9811d024d140 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -309,6 +309,7 @@ static int rpm_get_suppliers(struct device *dev)
>                 /* Ignore suppliers with disabled runtime PM. */
>                 if (retval < 0 && retval !=3D -EACCES) {
>                         pm_runtime_put_noidle(link->supplier);
> +                       pm_runtime_set_suspended(link->supplier);
>                         return retval;
>                 }
>                 refcount_inc(&link->rpm_active);
>
> --

I don't think that this is the way to go here.

Can you please say some more about the specific scenario in which this
happens and explain why it is OK to effectively discard runtime PM
errors occurring when suppliers are handled?
