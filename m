Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE63AA9F8;
	Sun,  4 Oct 2026 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791144150; cv=none; b=sbdtM4FfqZ6v1DYUuxRb7shGLuBZG/UbZmAu33k6IHtltWJtcSEHgg6Z1RU8xiv6o89SAdopmPWFx+YdnQZsl3qikV9MSdfXPY7GVdJBv/oHb4rdO/2NgxLpajLul9sbiRV7WLO/bwwXzXIwB9AfuXnnq6GWjNrwstvWnuUYiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791144150; c=relaxed/simple;
	bh=DxpxFvysCDaBNq253YTTsWZ9LKYuKqp8urM1Cobx51A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hh1Lihxin+TvLYQvi3xHx/RHyaqwZezzXz7p5cUOShZfKikMXk77xI/1HWJc1D5jcVrFWd7i16dR5bjALkk7iaEBerQDjysrJJwNDIZQeWxWPVTI3FAYPkQXB7SPLV2WUpDq02/VeoiSL12ofV9a5oU69J1Guqujn0Hazqray3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CD41F000FF;
	Sun,  4 Oct 2026 20:02:28 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 3C20D180A51; Sun, 04 Oct 2026 22:02:27 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Reza Kurniawan <imkyufie@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260912-riva-usb-v2-0-997fe0171ee5@gmail.com>
References: <20260912-riva-usb-v2-0-997fe0171ee5@gmail.com>
Subject: Re: (subset) [PATCH v2 0/2] Enable USB support (peripheral mode)
 for Xiaomi Redmi 5A (riva)
Message-Id: <179114414722.223371.6181817407774225572.b4-ty@b4>
Date: Sun, 04 Oct 2026 22:02:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sat, 12 Sep 2026 22:18:10 +0700, Reza Kurniawan wrote:
> The purpose of this series is to enable the device to act as a USB peripheral.
> It enables USB-related DT nodes (controller and PHY) and modifies the
> charger driver (BQ256XX) to expose its VBUS state through extcon.
> 
> Driver change is required since the device has its VBUS connected to the
> charger IC, which means cable connection/disconnection events must be fed
> from the charger IC, to the controller driver to dynamically enable/disable
> the USB gadget functionality.
> 
> [...]

Applied, thanks!

[1/2] power: supply: bq256xx: Expose VBUS state through extcon
      commit: b33596a615d163372f5e7519338d860cbfc37217

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

