Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDE433688F
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363444; cv=none; b=KpX0wVfhAq5a7oEMuusSK7KIF3Ol4j29FeDLbKQavkf0ZGALog7Pj4MmyW1WHSvmLTeqsE8sBNnD5YeREOwsKiLjd/KH3zbbQ+3l7NaThvTvnBy3HCV1WtJw+RU9RVZJ7oWhJZb8cwLKcU/4Ofectedo1JlOus7Sh2/qdWoXUJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363444; c=relaxed/simple;
	bh=IoirFoe03mX/ctRgHP5OpPVgaiIaPeHRPHwGzkpjrfs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ITL7uX0WWWpmEIjx+7moXwR2khhCCdaEYutX2pTZpndzxAvs7UrPtFspOIFg2RW/vAvWGR2ITQL28a/bsF8cOOerWL1/QJCN/f9l9Eg2YBTqnkbMxqu4M8QMLcBlORMaJOxEY7irfzbBH0Quho5e5yf/6msS9rhOTa0HGGLRURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfFCV9k+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfFCV9k+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC03C2BCB8
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 08:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777363443;
	bh=IoirFoe03mX/ctRgHP5OpPVgaiIaPeHRPHwGzkpjrfs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=YfFCV9k+BZYhWnN0htmAA7TEblQEBIOZMmkKLT9ppkoHP+EPaAHnRPo/usK+MnIDz
	 lKQ5X+bLGt5Ktn7rSdCg9HYrEBnuxq+38G00QcQZQqPSAfg3R1l7duUFV19f3S5WLU
	 6X1Lqe01mhvmvMgdK/uHRP3K1iP4rIMIvW8lc+3V1vWSqIDgluBehZ54fKgIjqDRAC
	 +gM4bSE+MTT5LXzGQ8F0TdNcfeatwIRde4vcgwPt9PRKC7OEAq00WFqvVdXEQxzgft
	 eplmJI8bhZRIDW3WHqfXy/KcHZvMnwvH9nzaiOiGfXC/xYDpwOSOPp19xPAOLOPCzC
	 hpPaYYQhQwxeA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a01c80c34so108470291fa.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 01:04:03 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz30zNcAFoY7NlopoUxFK1drd4cu13ZoEUp4XO3yXBAdfOZhEt6
	KuCM5+A2znI+rfr+LrMUQ0xF0cm7UIIPaJrXc5dta0SlQcuS7zjUCFj6OUI5GjyUeEPsk+dSPx8
	YsMO8PVp8VHZD6CoIQqbgUvdQlIwViW8LVsM3u3GxvQ==
X-Received: by 2002:a05:6512:3b11:b0:5a2:b903:3b43 with SMTP id
 2adb3069b0e04-5a74660485amr881966e87.7.1777363442347; Tue, 28 Apr 2026
 01:04:02 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:04:01 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:04:01 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-11-dcf937775e73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-11-dcf937775e73@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 01:04:01 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc0mjrzLv9qi87nr4TAW_LYn_Ndut=H8WfJPZeSZd6+TA@mail.gmail.com>
X-Gm-Features: AVHnY4LZVg57jPaWekGSSk4DejeTI2gwQWeR0zCi-FpgzjFW0MFsND6PRyA_w6Y
Message-ID: <CAMRc=Mc0mjrzLv9qi87nr4TAW_LYn_Ndut=H8WfJPZeSZd6+TA@mail.gmail.com>
Subject: Re: [PATCH v21 11/13] arm64: dts: qcom: Add psci reboot-modes for
 lemans boards
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

On Mon, 27 Apr 2026 19:34:51 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> Add PSCI SYSTEM_RESET2 reboot-modes for lemans-evk and
> lemans-ride-common(sa8775p-ride, sa8775p-ride-r3, qcs9100-ride,
> qcs9100-ride-r3) for use by the psci-reboot-mode driver.
>
> The following modes are defined:
> - bootloader: reboot into fastboot mode for fastboot flashing.
> - edl: reboot into emergency download mode for image loading via
>   the Firehose protocol.
>
> Support for these modes is firmware dependent.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
