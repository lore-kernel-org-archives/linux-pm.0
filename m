Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1836F91D;
	Fri, 12 Jun 2026 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254751; cv=none; b=Iua3zSykK14N7XUBP07dB2vypLO8Val4307siqFImnDWHyDQo6eEklUta9KX9z7Nhq08onC+vkcObJ92vwFHRCqvtZJ7H3sXoGP72zIBGqfKoisW77AeuupkcXMoFh0iM02M/ZFdlHTSNgZmY6Fhtuv/9q6lcfPyampMym+htow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254751; c=relaxed/simple;
	bh=2N5flslymz7RAw/OZ9FFZ9ELuTHd7lB+fDalxpANMQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaMzeWtEJBVL7UbTboZN7l98DGxr/I+PKetSIhamCPptzqHFHIwECB6/6a/oqcp89Dvk+LhHRJlWiNu5kMhANIl7A2I1+wTlkFq6k22LhZT3QWlQXCw5MjBVMhUJp0EwudB8tusf053hf51khHbHVBaBhsAFhZp5UcKDh+w6kjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjVZEBWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjVZEBWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3871F000E9;
	Fri, 12 Jun 2026 08:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781254748;
	bh=rnKde7jvb8fbsVY8tcfCydhDZLMmYRmnejPI5g+nxu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NjVZEBWxc/7zEOGV5VWzGrHB9qPk6pHu5yc1rlcYlA/uEvO+Xa74WpWc5Dkzcco+W
	 dG7t3yO79VoE/PygF5y44BixZQTMr3MQegNU1YfnS9N0XnS1UQlCsdM0m44O6+v3+e
	 I2AXvoIekQaAfkSAlyXInGvhjfVmO79BYbB9Nff6KQFSNn1JUM1/uwOaNRLPGRgFlY
	 Bf4Usd8NwR1uFxaBeDW1hq99RxaWf5X8NwcjiY8bw/7fI1z1rmN+Xm7HUf4MILCDUm
	 p4fKuMvRus5jb7p14HeduDDCSm4dyQGVhD6RhWloUEfR38uIbIUUwwfXmgll5HWvnG
	 bVj2G1A9X5pKA==
Date: Fri, 12 Jun 2026 10:59:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Alan Stern <stern@rowland.harvard.edu>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v2 08/16] Revert "dt-bindings: usb: mediatek,mtk-xhci:
 Add port for SuperSpeed EP"
Message-ID: <20260612-light-turaco-of-patience-96eef7@quoll>
References: <20260610084053.2059858-1-wenst@chromium.org>
 <20260610084053.2059858-9-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260610084053.2059858-9-wenst@chromium.org>

On Wed, Jun 10, 2026 at 04:40:42PM +0800, Chen-Yu Tsai wrote:
> This reverts commit 454a1e3cd36c113341d7b71e8e691c6e47ab4a8a.
> 
> mtk-xhci handles both USB 2.0 High Speed (HS) and USB 3.x SuperSpeed
> (SS) host connections. And there are USB 2.0 only mtk-xhci blocks.
> The SSUSB controller handles the device or gadget mode. Saying that
> SSUSB handles the HS portion is wrong.
> 
> Fixes: 454a1e3cd36c ("dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP")
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 ----
>  1 file changed, 4 deletions(-)

Please squash both commits. Reverting just for sake of revert is
pointless. We want wrong binding to be corrected, not to be reverted.
You revert something if there is nothing to fix afterwards, IOW.

Best regards,
Krzysztof

