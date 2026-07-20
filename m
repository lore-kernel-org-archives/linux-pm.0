Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1939D3FC;
	Mon, 20 Jul 2026 23:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589180; cv=none; b=JkmJQF5Rd0kbhxvBRja46U74wTPe7tLN+S4FS8IRmzDWwQYkb2cV9JwS7gvVpMD7NwSDpwEHms11mNrHSdl97r11f5S6sGXS/XROb6UScwnej95WOZmjDxEKiKG+LI8URf38Fyk1XXlcNaKN898ElgYyma3m7guElB0noV6whoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589180; c=relaxed/simple;
	bh=u6J1ltItLMhgelEGn8IFT93Zx+nTgSkLBi1K3s39WU8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E+szNlITvbhB7qphocK30yoPMkXDDXtPDJOuy0i5pt4ooaxJMrtgYj8id0DXJ8kx/H+7i1cIQMcfcPLOsJ7XeBsqJdJpdgBN18gd4KJAXqwBVaTsIas77c5ZESNpVrNkgLCJz6juL2yLmIP4KhFGm0mt528zVHhULEftYMHEmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E87D1F00A3A;
	Mon, 20 Jul 2026 23:12:59 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id F2FC318081D; Tue, 21 Jul 2026 01:12:57 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260701105907.197150-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260701105907.197150-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] dt-bindings: power: reset: qcom,pon: Narrow allowed
 reboot modes
Message-Id: <178458917797.375902.13225239483719054866.b4-ty@collabora.com>
Date: Tue, 21 Jul 2026 01:12:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 01 Jul 2026 12:59:08 +0200, Krzysztof Kozlowski wrote:
> reboot-mode schema allows arbitrary "mode-.* properties but only a
> subset actually makes sense and is valid.  Provide negative look-ahead
> pattern to disallow any modes not supported by the device, which
> tightens the binding.
> 
> 

Applied, thanks!

[1/1] dt-bindings: power: reset: qcom,pon: Narrow allowed reboot modes
      commit: 792c48a7751346ea5e5069ec733f005d42a35b26

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

