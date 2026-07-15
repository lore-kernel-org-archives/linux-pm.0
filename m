Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3C44C67C
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118407; cv=none; b=Dn5B9CqjMdf/8j4SBjgdSKplQQbvcCpP7c6QvaTQxKbCsKfaXApw6EHXMlNacZfqIu2Pu3pb7xR54TUBYSIONq1MuqDZ2FFoo4Xrf+jsUK43IePeDXev3xyeJ4vjZanioVi7Pypu7WaD88T58Gzw9TxyCpSjR8E5i77wUoRRbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118407; c=relaxed/simple;
	bh=TF12o4kxmUhjvdA6ouORMbeT1BJf7UjZuwxQoUAEn0g=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaiENMS9kvaLy93zMeh6JVMNW90RvYk0cTv0+2qkDGMPMt19DRqjgCzR00gnlNl3rMFFDRrZPRTdtM68YDitKJg9UcLkQDi36EsdJ5bJVQEa3DwtU5y4xTyOcSlKyDfq4EFJjF2EoLGXR9ZK8tBOaW9uxSCT0OB6cwmINp+X/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKykeVV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKykeVV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D90B1F01562
	for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 12:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784118406;
	bh=ufSU06HSFFf/HF9xxtT6zNddSL0W/3RadTy6uo0f3pw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=QKykeVV+vjB0vBKkxzt1G8Vl5kKWhAKrI3T18ni2Hmw7Ye9vGMPmHsQOOafa6Rkz8
	 Ms0JYatvX30UIvmhmwHhmdX9yRaau4XM7UMuftPm2YrvDgVpRTT9y0EvcfS+iJMopa
	 wn5EvKEKra8RnO1k8aY6zl3W8kTP7P1IlnB4/LKGhKGxEg2xEMFyvVePT3Jcft61ug
	 gLoOZQLE17mfUgB/wOuZnmcyg2/bXhPTd+ObHBKZgp4ncS4UOBn+dwfyO9BIdDE/Ik
	 iVS87KexyX8aSDr2Cs39sUkAux0k+DNAdUQG8yS15R4tPMKJ4Ufu/ntoSvaqilpRBT
	 Qrj1mAGszI78g==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39ca0a30148so42691491fa.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2026 05:26:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YzA+ZvHpCnW/bK8PzULGI2m4skCts2jyBY3DjsA+Vfe5DumX8or
	MsZojpYqLt+FrinxrQI5w+GgCoTz+tsAL813D+c9/sqgppPM/MuoXjWdOtpNNHgQI5rzkMXgQbo
	s/uODeohs/0o4h7kDyhhXr8hwYj03xgQ4Ul8XQxPdtw==
X-Received: by 2002:a05:651c:23db:20b0:39c:6e2c:23c3 with SMTP id
 38308e7fff4ca-39db6ba5ea7mr4965071fa.5.1784118404814; Wed, 15 Jul 2026
 05:26:44 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 05:26:43 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Jul 2026 05:26:42 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260714-arm-psci-system_reset2-vendor-reboots-v23-2-e7453c548c21@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-2-e7453c548c21@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 05:26:42 -0700
X-Gmail-Original-Message-ID: <CAMRc=McKp4WsOY-EQ21n2wbqCp5V0Lr1Cbub5geEhz-LZvVkZw@mail.gmail.com>
X-Gm-Features: AUfX_mylt-DYfwtCtULeZMicFYpxh50vEHg7XonNMSy71MZwRMycF3EtBgUVrSQ
Message-ID: <CAMRc=McKp4WsOY-EQ21n2wbqCp5V0Lr1Cbub5geEhz-LZvVkZw@mail.gmail.com>
Subject: Re: [PATCH v23 02/13] power: reset: reboot-mode: Support up to 3
 magic values per mode
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, mfd@lists.linux.dev, 
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

On Tue, 14 Jul 2026 19:16:30 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> ARM PSCI vendor-specific resets, require a 32-bit reset_type and a 64-bit
> cookie as arguments. This cannot be implemented via the reboot-mode
> framework, which supports a single 32-bit argument as magic value.
>
> Extend the reboot-mode framework to support up to three 32-bit arguments
> as magic, per reboot-mode.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/nvmem-reboot-mode.c  | 10 ++++----
>  drivers/power/reset/qcom-pon.c           |  8 ++++---
>  drivers/power/reset/reboot-mode.c        | 41 +++++++++++++++++++++-----------
>  drivers/power/reset/syscon-reboot-mode.c |  8 ++++---
>  include/linux/reboot-mode.h              |  4 +++-

Could we avoid having to modify multiple files here by just providing a new
function:

    nvmem_reboot_mode_write_full()

with the prototype you proposed and making the existing
nvmem_reboot_mode_write() a thin wrapper around it?

Bart
