Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821A47A860
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626403; cv=none; b=jG5ukGEOVMV0W+yqr9shambF9M7SMZulFnip0wM/pR5P9vcRb9szOsKrnhWqds7WnX1Vjs/a+h/CinfuPTh4W95CV3qPM/NMyxawPi/BgjWogXHx/tKdrSSFNy5l3fK9OGlQSitiqiyG6tNk90G2MoRwcYtlYTx8DRkdIji1+Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626403; c=relaxed/simple;
	bh=RAl0NVbjiiOs/VyeCemRv0TwYR+tlbA9P9uIHNsY6dg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWR3dsfe7H8UyBBqhnD4Ub+UyDQZhKuHw5q4DY7bg5ueXDErVU5/mLjxQ+8RuZG0dEfNoYwMJarcgA2ezizmgiA+aRg/z6fV3oxVNCurZDsZtICTNSysxcRON8axLc1Ko/yC/RnfprfPtFVrizbYLzG86b8lalSd0Ne3+1y/8+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXZVJtg/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXZVJtg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291BE1F00A3F
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786626401;
	bh=yQWzU2idhtJFEfGoc824MA5NHjwICFqfWvq6sgVbqeQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=UXZVJtg/2Rx9ZJDFRk0rV1flaUPuLIwsFB15lmMdTdhvITsZVwhmJRtAnjke2dcPM
	 EyRKKSNQ46Dic9or1D5n8yp3ruC6CRTB/JD/ODBDLgVK7E1aiovyORp16hMh26KRV0
	 vSTog3v+nnYt16PpUwy45UrNG4GHKDhwZraJe/dAxnXBz/2P+sZXENL5cs7QkxnZkm
	 L9pyu9aXIFzSOlfUJrzqIAtd4pkKh4llCsHlijG4RoUesbzNt1DjM706dqp4X6MGYv
	 Aw2HVGG/ig688WXvWgyVx0jbQPESHqofU2l5ysylFdNzHOHIx9rVqGavvn1L0wQjwM
	 npFITTaSA+U4A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b29599b81cso891111e87.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 06:06:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Roms2dYkKDHkoUkVfeww3RQJwFtU08WT/HzXfjWIf8Uzp/JXnJvcbWGUu3aXcEVVA1pgZa9OoYwbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLwIcALuHUPs4jhYlO+m4HTmI0mM0FQpghT7ZAqgl6e+xdZoZ
	4Y7NI6Hq+6w/grtxfSIhmHhgriPYu4GEb23MupeBSAeVab01v5oFzvTsbaYUK3AMbWTcqb4b/go
	4VdAnig23LR5P1KozjUiUYlMyPq5nq6Rp9+hST2zavA==
X-Received: by 2002:a05:651c:31cd:b0:39c:7859:a2d8 with SMTP id
 38308e7fff4ca-3a11a819760mr7294241fa.27.1786626399530; Thu, 13 Aug 2026
 06:06:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 13:06:38 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 13:06:38 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260813123841.GC1820248@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-4-889281373870@oss.qualcomm.com>
 <20260813123841.GC1820248@google.com>
Date: Thu, 13 Aug 2026 13:06:38 +0000
X-Gmail-Original-Message-ID: <CAMRc=MdA_zM_pHCmk7dd7kosqvNmFgA+iXvHS4qpNs9bdsUMCg@mail.gmail.com>
X-Gm-Features: AUfX_mxLcl-KphrvU6gLOMupiRghMpmm1J92bVQek0OJwjAsSLdXf3P9i5s9MC4
Message-ID: <CAMRc=MdA_zM_pHCmk7dd7kosqvNmFgA+iXvHS4qpNs9bdsUMCg@mail.gmail.com>
Subject: Re: [PATCH v24 04/12] mfd: psci-mfd: Add PSCI MFD driver for
 cpuidle-psci-domain cell
To: Lee Jones <lee@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, John Stultz <john.stultz@linaro.org>, 
	Moritz Fischer <moritz.fischer@ettus.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Christian Loehle <christian.loehle@arm.com>, 
	Ulf Hansson <ulfh@kernel.org>, Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, Andre Draszik <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Aug 2026 14:38:41 +0200, Lee Jones <lee@kernel.org> said:
> On Mon, 03 Aug 2026, Shivendra Pratap wrote:
>
>> PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
>> Currently, both the PSCI core driver and cpuidle-psci-domain bind
>> directly to the same PSCI node "arm,psci-1.0". Additional consumers, if
>> introduced, would also need to bind in the same way, leading to several
>> drivers attached to a single device node.
>>
>> Introduce a PSCI MFD driver that binds to "arm,psci-1.0" and registers
>> PSCI child cells. As the first user, register cpuidle-psci-domain as a
>> child cell.
>>
>> Update cpuidle-psci-domain to probe as an MFD child and use the parent
>> PSCI node for power-domain traversal.
>>
>> Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
>> ---
>>  MAINTAINERS                           |  1 +
>>  drivers/cpuidle/Kconfig.arm           |  1 +
>>  drivers/cpuidle/cpuidle-psci-domain.c |  9 +-------
>>  drivers/mfd/Kconfig                   | 12 ++++++++++
>>  drivers/mfd/Makefile                  |  2 ++
>>  drivers/mfd/psci-mfd.c                | 43 +++++++++++++++++++++++++++++++++++
>
> We don't usually allow the use of the term MFD in devices.
>
> What does this do?  Is it a mux?  psci-mux?
>
> If not, think about what it is and call it that instead.
>

My two cents: I'd call it drivers/mfd/arm-psci.c

Bartosz
