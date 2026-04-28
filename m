Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495C33343B
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363466; cv=none; b=XuGo5FlyZ0klaaKUJ+8eJMMxFkH9GxAjI8zNkPT49C6OCCy9DBgMP5GHFvdS3Lcy9zi0FKc0Bf81cWrY/5yhCFTFPwX6dYdZ3TCpAfOHT04+vQjoi+vF02kTcZU69QWWxDO59/6vPJsFpTrGb74KNvnptci17upQ3Iijg1NwrMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363466; c=relaxed/simple;
	bh=RU2RfIsE5wPl5KsOhJRREp+MuYdS5uZPUVCQPRYO/oI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwZi/JAE/mgBeTJkjUn6ygxz8PKN74asIGe9g79TkXq4L94LPiOFDQF5IA/HWFxCHe5bdgBVZvfI+6+da8sSViYSw1oEBTL8V47uN8K/Lf80JyYtH+2BI3fGeN4Asu4Ui2fxn0DwRK5eco2nV2mQiMplN1pemash9Y/jx2jjmxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD5Maxo6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD5Maxo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9005C2BCAF
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 08:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777363465;
	bh=RU2RfIsE5wPl5KsOhJRREp+MuYdS5uZPUVCQPRYO/oI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=kD5Maxo6wkaTr0RVqbcf5EEKZ17hYy8YJsdkAsKI6YhsVAr7ie8Ilg8SUuuRjeYP8
	 upeCjpq0fCHwFe2Ei1oKOqvMRloe8M3VIBaUOylvt8hTVXylUjvu7+bcsd+1xFFXSK
	 McMdUhOX8cF/GpOvM0SyYO+FjEO7NaZTd8SuZo47L7ViKGCJGcrzO76lme7r5NXDFq
	 IdR0Lf9jmpwv4kj72UYMF5gEkIzYInCXkC3V9vWzvulesSTWHbopbg1fq7BpKqCvTi
	 HNC5JMzXaBCSorx6mGUHlBGbuPzrnJ2+2TLx3hvNqnWU9oYG0vXN9PnAWPp55b9bkA
	 8v4c7SXrfaY2g==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a40502e63bso9922638e87.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 01:04:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YxVCBsGh+i8Z6EJdcGmSS7iPASd9A9bf13MwDOnnxcea9Lti0Yo
	5ob5tYUmaueO9D18YbGi5BM7TPdylo6iG0srgmxLC7uAS1fGzzzDwSazbPfgQt4s2ySwbiI44Uv
	pR1Bu05Mi5p2U2sOdUhiq4qcVmkAi333uyh0mLAygQw==
X-Received: by 2002:a05:6512:3b87:b0:5a4:1918:20e with SMTP id
 2adb3069b0e04-5a746611061mr910141e87.30.1777363464618; Tue, 28 Apr 2026
 01:04:24 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:04:23 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:04:22 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-13-dcf937775e73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-13-dcf937775e73@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 01:04:22 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfaTsZFrf4YoceODg3_R0-1jreNBabfsmOcuvJDnho4iQ@mail.gmail.com>
X-Gm-Features: AVHnY4Ju3RPxv-6duyvbXGIr26bogK-Xp8kGODdJYnjXZthAG5bndYhRYJFxrZQ
Message-ID: <CAMRc=MfaTsZFrf4YoceODg3_R0-1jreNBabfsmOcuvJDnho4iQ@mail.gmail.com>
Subject: Re: [PATCH v21 13/13] arm64: dts: qcom: Add psci reboot-modes for
 talos boards
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Song Xue <quic_songxue@quicinc.com>, 
	Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
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

On Mon, 27 Apr 2026 19:34:53 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> Add PSCI SYSTEM_RESET2 reboot-modes for qcs615-ride, for use by the
> psci-reboot-mode driver.
>
> The following modes are defined:
> - bootloader: reboot into fastboot mode for fastboot flashing.
> - edl: reboot into emergency download mode for image loading via the
>   Firehose protocol.
>
> Support for these modes is firmware dependent.
>
> Signed-off-by: Song Xue <quic_songxue@quicinc.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
