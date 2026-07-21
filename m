Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368B3C1413
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624968; cv=none; b=sRuTmOc4AMnmndHNGaqbirWyQWF1uI/RuYyjNwl5YmqN8QUPmtADHe9s3i7ZLyQ7vm/iBWKhFeurVrciskOcrHEpsdi1sO86V3pNEh/bVBG61SG4NrkfwbB+37E3mtqWSMTldwjLKS1TxmoFd1wsc/B0ne4L+XCf/jYmDhUokoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624968; c=relaxed/simple;
	bh=4wB31opfSJxQGOyhrpE5g1SMhfmWmHTES3FuDZOGSPA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8H27OIVUCaH5OKLgiPFyoT1pHkU9FWPx/fQFeEM4kLx8gnzOdpnr4wM/gjO0kLnC5RRCmQoOSJhLKcIf6vzMG2LOvBemMe0k3hE7FNpsl2QdyLRfbY8RIiIf6DBrLQIi4W8pMgA0WNynLWi+gYUmDP3l1UBgoYOvPoLidRtbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC701rNZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC701rNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859F31F01558
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 09:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784624965;
	bh=4wB31opfSJxQGOyhrpE5g1SMhfmWmHTES3FuDZOGSPA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=IC701rNZje+dgfTqbLnJ30zaA30NDt/Xo4YfQs5LzmrHX9HZyeYyKzyUX2HvEPF97
	 1u4VvvvWC38WaQa274nSGTyUrcyKsap2cHKcgCYFePScep8erTz1dw5qfrFDKomFZn
	 dxFq+CVi3oKPHbY7xwFOFO38JVrztihw1pXlx7pbJOzO035qZw8vWmiYdourkFBo0U
	 okYvfFTI0oetvbPPM+HdJfbKD8rfTpQplzEcPEEF6w0l4wzzNgOjYGxRifx3uNrh1B
	 l1zWF7sG1v2LTDfKq78JBivVrcm9XKWD+bI1GzHNk3frZd6RQelOQNwbDInWQy+Fsr
	 SkkgFzrv/BznQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b2a5dcd5b2so543257e87.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 02:09:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq7lVKqE0PD9eelmVXQBjKhGDFPeuSYbEmy90XN1mH8l6IkEgnwfVfDcDScysfMT/gXgSxgSOAtfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9OwW0JXDhqBDDEc9qCrYDAe6RXSXslQw5X1jkoHZs4k+GJd1d
	iJgvlEElQrai/XiLw94Q3AJBtWyINYw5uflNS2c6d1UXTY3lrnifnjVu2cvrHIHlegz0x3jdBG+
	zLosmGNpo0iZdpes7VWgx0dpA1u6psHSxzj9Ha1I0sw==
X-Received: by 2002:ac2:4846:0:b0:5b2:8ad7:93b7 with SMTP id
 2adb3069b0e04-5b28fabf50cmr2774646e87.53.1784624964271; Tue, 21 Jul 2026
 02:09:24 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 02:09:22 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 02:09:22 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260721065413.2306137-16-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721065413.2306137-1-wenst@chromium.org> <20260721065413.2306137-16-wenst@chromium.org>
Date: Tue, 21 Jul 2026 02:09:22 -0700
X-Gmail-Original-Message-ID: <CAMRc=MedLNu+xzDW=L6_EhVMQphkWEp020HC9hpmDcueN1R6_Q@mail.gmail.com>
X-Gm-Features: AUfX_mx6IxoN9pFtIb0B19rivB9mMh-kCXBeeOUX0vuwCx66Zlnj8MCY6QcZGPk
Message-ID: <CAMRc=MedLNu+xzDW=L6_EhVMQphkWEp020HC9hpmDcueN1R6_Q@mail.gmail.com>
Subject: Re: [PATCH v6 15/16] arm64: dts: mediatek: mt8195-cherry: Add M.2
 E-key slot
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

On Tue, 21 Jul 2026 08:54:10 +0200, Chen-Yu Tsai <wenst@chromium.org> said:
> The Mt8195 Cherry design features an M.2 E-key slot for WiFi/BT combo
> cards. Only PCIe and USB are wired from the SoC to the slot, along with
> some auxiliary signals.
>
> Add the proper representation for it, replacing the PCIe wifi node and
> vpcie3v3-supply property under the PCIe controller, and the vbus-supply
> property under the xhci3 node.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
