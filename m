Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D28261B91
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362408; cv=none; b=ba/Q2z/XKL/JdAEWYR+hLBft+baYYp1PdVWX50ZWgGKPe2ymaUTkpZ1jpNl9dNDXFiIpjRB5/Z76aRFATGDAAmd6TA8RzUfP75OIZzCdLzqQ6Fd7BgHPf4+UP/LIxH86X+ACtaCuJ6rHY9K7BzixjU1EQb7zaGSQwxEH3JFBak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362408; c=relaxed/simple;
	bh=ADg1FaAaQD046f4ZXKUeNs9WMlXZmKjJ9FxWyVIqZMw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIQr6liocTThivD3O5AMDBASTVUvlTD29cM2xYoiSyoSK/4OMkiCAJI1DOTYN5xOBP7dQaXYXc8dfybjaIxnvRhieTb+/ARnZ5kwD19uueC7/enMsLb6ecDCEo81vvfxzvzbkVCt0eNSy3JKouASOhzDvuIzFaTAc609QdZ1F2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZV0JPbxN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZV0JPbxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B851C2BCF6
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 07:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777362408;
	bh=ADg1FaAaQD046f4ZXKUeNs9WMlXZmKjJ9FxWyVIqZMw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=ZV0JPbxN926AogNzlpDw8VwYRW/BKxLdzSOfm0sxwUkyI7a3Ve0WDoi6342BL4XcL
	 Li/klvurMdG5TK/JWlp1Svtgmo6hfmwTzh5pL20oK63MPSTcLKwuu2+BBTJixoIZcE
	 mPPevR9bvQ9KJvrJcIhiRDnEpcZzXW/mUCEhoKWkBituTpiduDdR1jCUdiESdNeWK/
	 bZqt81VhzdK23m7WKfv3Y94inS2YC++NNi9dtYX6im5iB6wzsu/WR++s3etlZrVZMU
	 bDlDGqiKE56qLDfnOd242tSROZcH9NsoEpKIXesowSZZdqSZd5dsp511W50lNxJF9G
	 /51TTn+HZKDNw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a402b2d102so11712706e87.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 00:46:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YzDBdIOYagiSCj8iWS5tUIv1xK8dVURucSdXQa4kg31yMYcHko8
	QLUlkQ+f28Z8gKhpgto3yjlZ3Rpyb2O044FO/e/FwO7EZwUMvC8Pxjc6U+nDnvvjaZ6jZRH6nv+
	lj5XrlNO9KTzpDEF5qYZoOV6N84pGwu0Rdb7KZV1umQ==
X-Received: by 2002:a05:6512:2381:b0:5a2:a13e:9082 with SMTP id
 2adb3069b0e04-5a74662a7a2mr863095e87.35.1777362406607; Tue, 28 Apr 2026
 00:46:46 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 00:46:45 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 00:46:45 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-3-dcf937775e73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-3-dcf937775e73@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 00:46:45 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfyCqZHYSoUKe3=c_VO61HAxydpwyHP3Ey6u08Pzx+OgQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lw8-kSbgaAsT6iClj8v0tvKXLizHPhM-T0oDDyli5y1-FS0QYWyggqmk4
Message-ID: <CAMRc=MfyCqZHYSoUKe3=c_VO61HAxydpwyHP3Ey6u08Pzx+OgQ@mail.gmail.com>
Subject: Re: [PATCH v21 03/13] power: reset: reboot-mode: Add support for
 predefined reboot modes
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Souvik Chakravarty <Souvik.Chakravarty@arm.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	John Stultz <john.stultz@linaro.org>, Moritz Fischer <moritz.fischer@ettus.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 19:34:43 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> reboot-mode based drivers can define a reboot-mode by adding it under
> the reboot-mode node in device tree. This limits such drivers, to define
> any predefined reboot-modes statically within the driver and creates a
> dependency on device-tree.
>
> Introduce a list for predefined modes in the reboot-mode framework and
> process the predefined reboot-modes along with the device-tree defined
> reboot-modes. Modify existing reboot-mode based drivers to initialize
> the predefined list-head as empty.
>
> This patch enables a reboot mode driver to define reboot-modes through a
> predefined static list, in addition to the device-tree based reboot-modes.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/nvmem-reboot-mode.c  |  1 +
>  drivers/power/reset/qcom-pon.c           |  1 +
>  drivers/power/reset/reboot-mode.c        | 66 ++++++++++++++++++++------------
>  drivers/power/reset/syscon-reboot-mode.c |  1 +
>  include/linux/reboot-mode.h              |  8 ++++
>  5 files changed, 52 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
> index bd05d660490c686b43134f82f1eadd7665403d20..83a8d80fd7d1ccb1b736aee5f2d675246a63b8f8 100644
> --- a/drivers/power/reset/nvmem-reboot-mode.c
> +++ b/drivers/power/reset/nvmem-reboot-mode.c
> @@ -53,6 +53,7 @@ static int nvmem_reboot_mode_probe(struct platform_device *pdev)
>
>  	nvmem_rbm->reboot.dev = &pdev->dev;
>  	nvmem_rbm->reboot.write = nvmem_reboot_mode_write;
> +	INIT_LIST_HEAD(&nvmem_rbm->reboot.predefined_modes);
>
>  	nvmem_rbm->cell = devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
>  	if (IS_ERR(nvmem_rbm->cell)) {
> diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
> index 57b36e6186f80aff947fd7f5aae5ce280c65dc6b..9d0e3fc621a6173438c6da4cce38394199451881 100644
> --- a/drivers/power/reset/qcom-pon.c
> +++ b/drivers/power/reset/qcom-pon.c
> @@ -73,6 +73,7 @@ static int qcom_pon_probe(struct platform_device *pdev)
>  		pon->reboot_mode.dev = &pdev->dev;
>  		pon->reason_shift = reason_shift;
>  		pon->reboot_mode.write = qcom_pon_reboot_mode_write;
> +		INIT_LIST_HEAD(&pon->reboot_mode.predefined_modes);

Maybe unrelated to this series but we could use some centralized initializer
for struct reboot_mode_driver as well as rename it to struct reboot_mode_device
which it actually is.

For now:

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Bart
