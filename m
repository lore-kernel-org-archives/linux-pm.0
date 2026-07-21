Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7643C13EF
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624952; cv=none; b=c6f2eSZvjsot1xJSDdNfMbV7hNtwiDJTwKeNgSmKcaWRWKbGMX2BhFTgic3vxF+ri9jcznoQMJNYfWsCx4G6Lrnj7jAC3q22V1NyVu2woS9QK3wjulyDWpfJOaj314f94gHmNoDXnV/sSk8AABdqY80Uhm/SewuOzzZAaROEbSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624952; c=relaxed/simple;
	bh=jJAWY5I+EE7ypsQMmGeF7ePDs3+5/nc9dm1EvLwWSd8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejuEAgBCLmST1hy/LUDQNPYIXm6k93htQfXCb5BqgIX6SH1wGfFo605FTI9JR8qXZCw7Hm82lxo9nb+pQt2h2+6RYc7krIuadi99yZN/k8rCX2w6r2TVaSLRF/L4kuTVKWOk1QKtDNSMS9rOlNDAolWmY4GdA9MdS/AlPjplX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foJLZx2I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foJLZx2I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4361F00ACF
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784624951;
	bh=jJAWY5I+EE7ypsQMmGeF7ePDs3+5/nc9dm1EvLwWSd8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=foJLZx2IuPGexbJUlKxQfk3MNY2hO2lFMjD0RSceNM8RULTHr4+o/wqsxvk6DIN9y
	 5EMoJIi9qFWUvo6eCQ3RU2QKmGxty1nssDEOUVW0NBDgP0tEZqitllWU92bL+ol5j+
	 jg/daGT6XERjIfctGw1bMlNIDh9Mc/4sNP7F+qXWBlV2hVazImQqf1PsZwSGzOT9rh
	 09JLrururGcpRhAvU5e5XfPEjErnhW3JGm8U+MLPaNPzh/BcSiyUYXbB+gHnLbQsKQ
	 553dfAT1SWrjh3e506iY1pDNGi53cfxNlXn9WsG6QFJR4zwbN7BHj5beils/2Cvioj
	 x4nQMUNJBKHuQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b013084dc2so6637770e87.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 02:09:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrZQWo6CV4PHQVu6nQ7cjTF/OUszNtdVMcOEelb2IBBg2GOV+81HmY0NbSyaeNxMb3QJBNezKb49w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhwSJ/HHunORDu3GVx3KoWlXGwIl0Lgk5dJ9s+Se5Hqtu3jQKX
	NYt87/ijthP0F9enWOIt3bqupEUgKcwBVpa5dEoQ49WTQm3sRaKRuUaMTZV5zaA7NLckg6TCikv
	k+2OOFAAbVeK+wWh6DxRrGtCr9VaIWjGGsymhmFAWjg==
X-Received: by 2002:a05:6512:8054:b0:5b0:d25:fa6b with SMTP id
 2adb3069b0e04-5b28f9aa2acmr2799921e87.33.1784624950061; Tue, 21 Jul 2026
 02:09:10 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 09:09:09 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 09:09:09 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260721065413.2306137-17-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065413.2306137-1-wenst@chromium.org> <20260721065413.2306137-17-wenst@chromium.org>
Date: Tue, 21 Jul 2026 09:09:09 +0000
X-Gmail-Original-Message-ID: <CAMRc=Mfv7P74+cpvmHaF=aSYLO=RtFbxenJHMrCjgOMoHuLvQQ@mail.gmail.com>
X-Gm-Features: AUfX_myi0Upu0FA2vAaH9dLIsivFKjcILpMP1JD9Wz9GpUGoO5swX9n-_RCCXGU
Message-ID: <CAMRc=Mfv7P74+cpvmHaF=aSYLO=RtFbxenJHMrCjgOMoHuLvQQ@mail.gmail.com>
Subject: Re: [PATCH v6 16/16] arm64: dts: mediatek: mt8188-geralt: Add WiFi/BT
 as M.2 E-key slot
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Jul 2026 08:54:11 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> The MT8188 Geralt design features a chip-on-board WiFi/BT solution. This
> is a M.2 E-key WiFi/BT board layout directly inserted into the mainboard
> design. The connections to the rest of the board are almost the same as
> if it were a separate M.2 card. The only addition is the PMU_EN pin on
> the chip; on M.2 cards this would be tied to the primary power source.
>
> Model the chip-on-board WiFi/BT solution as a M.2 E-key slot with PCIe,
> USB and auxiliary signals. The PMU_EN pin, which enables the internal
> power controls and regulators, is modeled as a regulator fed by the
> pp3300_wlan regulator. Since power sequencing is now correctly modeled
> using the M.2 E-key slot, drop the "regulator-always-on" property one
> pp3300_wlan regulator. Also drop the comment in xhci2 saying "MT7921's
> power is controlled by PCIe".
>
> Also drop the voltage range on the pp3300_wlan regulator. This
> "regulator" is just a load switch and does not provide any regulation.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
