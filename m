Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2873CCFA5;
	Wed, 11 Mar 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224828; cv=none; b=OFig4J7b6Ip4mfmnYh6B0RdrWsK/8odbbFsBfqjeS54rrokGzPCwbqfvD3nxGo8VxGpSoCwhRFus/UUTBOV8AODA9SmmMjXn17WzmbMexp6CseornEHs7c/pm9Nqgf6qLlORg2ALHzwTdEkQiZZjSNeCXq/vBi3NlgPmCV5fkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224828; c=relaxed/simple;
	bh=yQsgASc4GoW40PFzPYJMKdL0VJqyLuYV44EVwbYYEDE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PyZGUWqqt03wpfoYbu0RLxlzrK+CVYQGToWvgv6wevh5itCPPoat/KgY9/ly0kkr4yeCnhcOtNpq9Zi2NtV0+4xcIe7s4tpJ/imSvxeLlekEOVj9FNs04rZiMnpNmTu7B1l6ZdLjI2ylCUGqdjlW7Cyf04pC20NViY93QmzFC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46705C2BCB3;
	Wed, 11 Mar 2026 10:27:07 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 128E7180696; Wed, 11 Mar 2026 11:27:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Yassine Oudjana <y.oudjana@protonmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260304-s2mu005-fuelgauge-v3-0-e4dc4e47cde8@disroot.org>
References: <20260304-s2mu005-fuelgauge-v3-0-e4dc4e47cde8@disroot.org>
Subject: Re: [PATCH v3 0/2] Add support for Samsung S2MU005 battery fuel
 gauge device
Message-Id: <177322482005.522251.10932979807931192742.b4-ty@collabora.com>
Date: Wed, 11 Mar 2026 11:27:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 04 Mar 2026 22:33:54 +0530, Kaustabh Chakraborty wrote:
> This patch series adds supports for the battery fuel gauge device for
> Samsung S2MU005 PMIC battery chargers. It reports various metrics,
> including incoming voltage, current, battery capacity, etc.
> 
> Although this device is independent of the actual PMIC which it
> accompanies in functionality, it is used in conjunction with the PMIC's
> charger sub-device to provide complete battery status.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: supply: document Samsung S2MU005 battery fuel gauge
      commit: d74b4fcc8093f9dc84172adf15f93b858d3daaac
[2/2] power: supply: add support for S2MU005 battery fuel gauge device
      commit: aa2132799817fb052d95a87f0c23cc6af38541c0

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

