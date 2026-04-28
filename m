Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA52E88BD
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 07:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362729; cv=none; b=YzuTiuvyqyOg/oaGeALXRwETjZxwGidlaAmdmHrtxDMXdn08/fKLPtJtkz0toC9E6SM953fRE2m5Uddz0TvvcM6+hbnajVBtm6S9DGP/IY36bq3n5EaxxDkZ9FZFsPrvLYZkfMehjqmo6mgOnZckqYV49vKoz/f5lFrEioNODRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362729; c=relaxed/simple;
	bh=vO5iuPARPBHlJ6G8aiSTUn1sOPHT2OcXMvj14NtRS+E=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUALeECfSfDJPxJXftCMeqnyMmY/tSJ2qTpAZlGt0UFGGfE8XZaNGYZYlgums8hp493vaOf1aSKrBRftP0TcyATexMuyFx4kCDjXZR02mSbm4WDjWmdBKlY3K7G7YGFhHraVYmbZjnOhPGk1zrazlCALKIbu27V/SuKakaDiBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ5bcMez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ5bcMez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC97C2BCB6
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 07:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777362729;
	bh=vO5iuPARPBHlJ6G8aiSTUn1sOPHT2OcXMvj14NtRS+E=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=nJ5bcMezxpRhVdnOQ1ZIzVJCCAs4mT1gXO2e/96+wx00hBqqGbqF8oHUyKDqraJYn
	 uq9ZhihNeBjaI6arIcL6+iUSHyL8+M0R/WUAeeIwHfKk09lmDK8P7nmNERcU8ulC2Q
	 bLvO52Nr1jQ5vVbsN24WJPHMU4Cp4P7JlWmtirbNnIhjYHL4dQVpLHeCKYaAbLf/ou
	 lzJ9Yn1JZ5o23PNm1PoxKeTkCgHHdfowJjk4vCqqLyihUlO5e6usyu9hqkaCxYP0ze
	 EPtXO9l8q2W1U+PZ9yTwjkJWN0v2IgEWQrkaITQpXEOlI5OgDvbVy8YHJReIv6pg+o
	 LFlvlqjd8peKA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59dea72099eso12423404e87.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 00:52:09 -0700 (PDT)
X-Gm-Message-State: AOJu0YzsAGPIVnz2SpSXkEg+nUXgfG3GJyTZ/XgcDbAHiYLEt5HJUJ2X
	ELsN97Y2qGgchIQ4I2hmi7+FRQE2EZ1wZgxeWSpgTh52KuxLl5GSw2WCGsK9rdw+nAE5oWI4Ss9
	ZZKZZTimRVOxJIvRCK9zHryWwj0b5P+g6S9vNeY3egg==
X-Received: by 2002:a05:6512:33c9:b0:5a2:a355:aa4e with SMTP id
 2adb3069b0e04-5a74662a809mr744576e87.31.1777362727843; Tue, 28 Apr 2026
 00:52:07 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 00:52:05 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Apr 2026 00:52:05 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260427-arm-psci-system_reset2-vendor-reboots-v21-5-dcf937775e73@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-arm-psci-system_reset2-vendor-reboots-v21-0-dcf937775e73@oss.qualcomm.com>
 <20260427-arm-psci-system_reset2-vendor-reboots-v21-5-dcf937775e73@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 00:52:05 -0700
X-Gmail-Original-Message-ID: <CAMRc=MezLiWcFvY2Qr35p0k8DU1kwo40HmLnuYqCQz848m5ZBQ@mail.gmail.com>
X-Gm-Features: AVHnY4I9O30DLFnNY2LxEIaLNfI7TLSIX2zIHmZ9_yxAyEIE-ruCmhEnjgWZz0I
Message-ID: <CAMRc=MezLiWcFvY2Qr35p0k8DU1kwo40HmLnuYqCQz848m5ZBQ@mail.gmail.com>
Subject: Re: [PATCH v21 05/13] mfd: psci-mfd: Add PSCI MFD driver for
 cpuidle-psci-domain cell
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

On Mon, 27 Apr 2026 19:34:45 +0200, Shivendra Pratap
<shivendra.pratap@oss.qualcomm.com> said:
> PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
> Currently, both the PSCI core driver and cpuidle-psci-domain bind
> directly to the same PSCI node "arm,psci-1.0". Additional consumers, if
> introduced, would also need to bind in the same way, leading to several
> drivers attached to a single device node.
>
> Introduce a PSCI MFD driver that binds to "arm,psci-1.0" and registers
> PSCI child cells. As the first user, register cpuidle-psci-domain as a
> child cell.
>
> Update cpuidle-psci-domain to probe as an MFD child and use the parent
> PSCI node for power-domain traversal.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Shamelessly taking credit for the idea. :) Looks short and sweet LGTM.

Suggested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
