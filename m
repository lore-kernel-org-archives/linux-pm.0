Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585133A03F;
	Mon, 10 Aug 2026 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381938; cv=none; b=Fpuju0peNxRRe00+4wnAs6q4nFsnSglqvpnQlE68cqqNSWUs6wYtK9su1ul95XCXZFAG1Kg9tWhkC45hFtF9T8BK/KWkwoPpyNooUI4k6Qsil49T72b8+31J6y7S08VlBxPpnaAEdLwxnP8Bmbvj6onUXBAnTMSHZMiDfXnzPi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381938; c=relaxed/simple;
	bh=mceccNaaWmcchg9L8ED4lJf/FLN7OSM0KRweOSQ6BlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toCgr5KbcyUonHfyGJzEwIJh7rCWJYQL59uIqS7j4Pb7xOS0d1j5421EB7pnXmAajzRLgkegUAhPWneMGJ/YQ7Lrns/6LdqczfpjV3U4kzX9UHkcEB+YjGAhkJd1pYJSad6BYj2svDqNTCYbEDQCTBfbXA6rwmd1loI/vojnXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjGA/P24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjGA/P24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5881F000E9;
	Mon, 10 Aug 2026 17:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786381936;
	bh=fVrGGL5Q0nSgj2p380L09qPkXcrVRBJyN66cazrVrMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PjGA/P24nLObN/Vr0Bxq12S0QmU7205Y8TzFWVr4OpTB51Nd4GtcEPxwaNVh5NLY/
	 Hk870KboTaYos41UywIijUWP3lCPNOr3XiUbNzg2JR+WFmMUJ01xs9HHUosv/IG7HD
	 bj54JiKJBhSDlWThr6gedepNZrPRdreI5HoQdfLV/WE5NWmWa654WjYcXxrPStliRh
	 p2Zj5kFWg6+KNdbmipxEEADZGm1w8pFmFt5//PmCO7lY3AUodjHHKu/fLekg1Dtan4
	 Za+sUxmqcSAJSMiDJEfrQzAMrReqclqt8FH7is5NZlviPAdg/Rf7Vy633pOmQOqCsk
	 QhAXbL278yMcQ==
Date: Mon, 10 Aug 2026 19:12:06 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 14/16] power: sequencing: pcie-m2: Split Bluetooth
 unit based on interface
Message-ID: <ns5zexfsbin4om3klprrh4v2xfvhhg5nztbbf5neakyuwq47bc@mckelf2d5x5f>
References: <20260724084328.3943997-1-wenst@chromium.org>
 <20260724084328.3943997-15-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260724084328.3943997-15-wenst@chromium.org>

On Fri, Jul 24, 2026 at 04:43:23PM +0800, Chen-Yu Tsai wrote:
> Some UART / serdev based Bluetooth drivers need to be able to reset the
> hardware during initialization or recovery. This is not possible with
> the current power sequencing API if a unit is shared between USB and
> UART interfaces.
> 
> For now, split the Bluetooth unit into two, one for each interface.
> This allows either interface to independently toggle the power, with
> the last action prevailing, thereby unbreaking the Qualcomm Bluetooth
> serdev driver. This is also needed for the Realtek Bluetooth serdev
> driver (hci_h5).
> 
> Having independent control from either interface unfortunately means
> that userspace is able to shut down the controller from sysfs using
> the USB port's "disable" setting without the serdev driver knowing
> about it. On the USB side, independent control is also desired, as it
> allows the USB core to power cycle the port/device during faults, and
> for userspace to initiate reset and recovery using the aforementioned
> "disable" setting. However when USB is used, a serdev device is not
> created, and there is no conflicting usage, which allows the power
> sequencing to work even without the split unit.
> 
> Suggested-by: Wei Deng <wei.deng@oss.qualcomm.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v4:
> - New patch
> 
> This patch is _not_ squashed into the previous to provide clear context
> on the change, and the less than perfect nature of it.
> 
> I think what we need in this case is some sort of lockout. The serdev
> consumer would want "exclusive" access, locking out the USB consumer,
> which can tolerate "shared" access.
> 
> Something similar would be needed for the WiFi if we ever add support
> for SDIO for toggling the state of W_DISABLE#1. At least the SDIO and
> PCIe reset signals are separate.

I don't think PCIe/SDIO suffers from the same issue as USB/BT. But anyhow, I
think it is OK to have this patch as an interim solution, but we should try to
model the BT control in a proper manner. I'd fancy adding TODO instead of XXX in
the comments. But nevertheless,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

- Mani

-- 
மணிவண்ணன் சதாசிவம்
