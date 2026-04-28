Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F17331230
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777363427; cv=none; b=f++Ai9tfbMHpDuL1oaNra6XBuk/tqxoG5oTEAd8U8moc/nkfOqdLvHxfolTWtIO2QKjV5kvqGuokLdpawH0oi+KGXjKuGRHzdzTWCUQm/tKX0NYY2jvvvyVD69OtNYHMfl5NFFUX6Af/Hz2Z2bc2SJSDKxqmZRG0LoeezBIQDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777363427; c=relaxed/simple;
	bh=nVhY0saX0hIlsPhBZOfgsMBCUpdbk4+El+viqARp73s=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCboCfr0T4wY4Eo14sC2xoamkkNkBxN834iwQyV+sbvXLcq6x+9OD9bF3cTQDlH8VVG885Gc3wDyJ3MmNcv0PuwHq9gHNqmtLtq5raIDzaIyer2QXQ3iJkGN9l0gUIup4W2YUi97QOXc1JaaLUYsNV05NWiYCbO7b4vwxIUUVvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNsj5G6y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNsj5G6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95192C2BCC9
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777363426;
	bh=nVhY0saX0hIlsPhBZOfgsMBCUpdbk4+El+viqARp73s=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=TNsj5G6yZNY+l0aXqUiQ4SpAcgeMKg7eakKdZd9BNO8FOWFT5SBnVRpH45GIlyFQI
	 sfu0PJqgZeterYZM/6QPpY5oDbOUsAZhyJvRr6fzhUaGPRr4Ym82QOPD2bqjsPIz/G
	 K0ct9hqiAhWCG8jZr18L4W8i7q1UOF4WfRdJANgZC82x3HMb5l5oyW5PG3hEnSZJWa
	 wGp68Ahrh8SUjDPzYpvXIioXUha6ciDq4gStvwlZzR1UKgU5lZSQsVUjQCnzHJRXMq
	 V/DAQs0ayEjtZyR4i4espP3KgoPS0nHgknrqnTK+G/WsGwHtEjh1OHTjfNX79N3cdI
	 oR1Yxn4pif/mg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so16720072e87.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 01:03:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YymMrUGxjSCmZaIkytB8qZcPpgZTC6rTDB6O+Nxqd6NVjItjOK9
	W2lwNctjOsjcdIRaEJKVSRJsWSTN6i4vy/f3yuTwh1erY4MMWd3hzbG8QPnohzAufVSnffcizpr
	NcejKuCVFa+ZBto6fyzKOhYlG+7zdL0RtStl4FDmaBw==
X-Received: by 2002:a05:6512:1194:b0:5a1:4158:ea9b with SMTP id
 2adb3069b0e04-5a7466182b4mr698217e87.22.1777363425259; Tue, 28 Apr 2026
 01:03:45 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:03:44 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 01:03:43 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-10-dcf937775e73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-10-dcf937775e73@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 01:03:43 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdC0dFadu-gyHLa2zM6fKWhBeXYpKxhcz0n+TwaEQ9XBw@mail.gmail.com>
X-Gm-Features: AVHnY4L0_XpeAfopxwETVjDoOWklya0cgmAaZoipsKTFpenV3YwDa9FcdgYB49Q
Message-ID: <CAMRc=MdC0dFadu-gyHLa2zM6fKWhBeXYpKxhcz0n+TwaEQ9XBw@mail.gmail.com>
Subject: Re: [PATCH v21 10/13] arm64: dts: qcom: Add psci reboot-modes for
 kodiak boards
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

On Mon, 27 Apr 2026 19:34:50 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> Add PSCI SYSTEM_RESET2 reboot-modes for qcm6490-idp and qcs6490-rb3gen2
> for use by the psci-reboot-mode driver.
> The following modes are defined:
> - bootloader: reboot into fastboot mode for fastboot flashing.
> - edl: reboot into emergency download mode for image loading via
>   the Firehose protocol.
>
> Support for these modes is firmware dependent and not available across
> all kodiak based boards.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
