Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDBC37106A;
	Thu, 21 May 2026 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779379560; cv=none; b=O3hb+WfLolqap8CKZVCvTb3SS8XtD+WAOpwFaOrJS5lfbCzoEFCkhz8TvovTLqkyJlhA1HtcGJsCeWreAkHP7RVnSUGbo9+jm7I2CGCjL8Xyk17bULonrOiyQcVmAfeY/6n7k4qESXpI0kYIA2kLZ816gERrq5SVsPIv1cwtWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779379560; c=relaxed/simple;
	bh=Pbenxf3Ey5zVf4qNMXJhZSoSU4sBgtA2J/ZGOQM2ijE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OwxH2jNTZfb/blptReuieXgE7QSarC6iVktx+ocBIPiVOzmC3a6HerE8ATB/ynsg0BqJKkRzz+lwW7y6MwZP1Z7UQMlByPZQ61p+R+wFvY4BodLUPai/SFFZNfNNfwuBPvIRWEzPJ6yJKWHlsMM2Ig1z+kYtU21cR1sGeqhIaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA7b6da/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA7b6da/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054B11F00A3B;
	Thu, 21 May 2026 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779379558;
	bh=20Fl4u/mL31fojJIl2NW7Wr4XRGXEcX/ejosgcBCJXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mA7b6da/eXo3dh5roniM05wcW6CKgnwl6klFqkitONUY4kH31E45lrwuBHnJ3qXXj
	 GEQ7j8P2R70m9px5XTjtDQJ0zQsthY3S+tXyC9ji8/ILFrp0wU4RQ0TBdGOYtqh6lv
	 9NLZ7kDB+DcwCWgHrsTwTOSz/FD1/2vFEfhv8pyMh3DosAbCkYVZMng5yIOXWr5gPZ
	 OAJ39Ckc03fLbYrduhDhT0+94YnKivXwVltLud21TIm9Vyy/mnJWzyFHVG8XxHvAjI
	 cDWjA3nClXJuGd+q8EiYdvUgDtjJ6WLfj9L11hfvugEwH3XZ2s1kZoZD73SX3rv65O
	 vYAraTKx6XmKA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>, 
 =?utf-8?q?=C5=81ukasz_Lebiedzi=C5=84ski?= <kernel@lvkasz.us>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260516-s2mu005-pmic-v7-0-73f9702fb461@disroot.org>
References: <20260516-s2mu005-pmic-v7-0-73f9702fb461@disroot.org>
Subject: Re: (subset) [PATCH v7 00/10] Support for Samsung S2MU005 PMIC and
 its sub-devices
Message-Id: <177937955373.3709084.6254458726341394026.b4-ty@b4>
Date: Thu, 21 May 2026 17:05:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sat, 16 May 2026 03:08:32 +0530, Kaustabh Chakraborty wrote:
> S2MU005 is an MFD chip manufactured by Samsung Electronics. This is
> found in various devices manufactured by Samsung and others, including
> all Exynos 7870 devices. It is known to have the following features:
> 
> 1. Two LED channels with adjustable brightness for use as a torch, or a
>    flash strobe.
> 2. An RGB LED with 8-bit channels. Usually programmed as a notification
>    indicator.
> 3. An MUIC, which works with USB micro-B (and USB-C?). For the micro-B
>    variant though, it measures the ID-GND resistance using an internal
>    ADC.
> 4. A charger device, which reports if charger is online, voltage,
>    resistance, etc.
> 
> [...]

Applied, thanks!

[01/10] dt-bindings: leds: document Samsung S2M series PMIC flash LED device
        commit: a794673949f1aa1dd948ce3ea436af48ea83d7b2
[06/10] leds: flash: add support for Samsung S2M series PMIC flash LED device
        commit: f0878c58430c378c47aaece1b29484e4ae8d7faf
[07/10] leds: rgb: add support for Samsung S2M series PMIC RGB LED device
        commit: 366ed7a6d22e682e6dfd4d64d8f543bc70c6b58e
[08/10] Documentation: leds: document pattern behavior of Samsung S2M series PMIC RGB LEDs
        commit: 1795fd2dbe84ef4d393b69a0b2a3b371f810bde5

--
Lee Jones [李琼斯]

