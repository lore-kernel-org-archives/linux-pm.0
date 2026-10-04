Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D03F9294;
	Sun,  4 Oct 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136002; cv=none; b=AhDpZjj8e7ja9/OOgZOmhTnYIJQOfDgdpIS3O103kpUuMCWk1pDgcQaKKxQveEMFIp0RJXSt5vp/UDnhExxsgdAe5iEDm6/ET84J/wIXmY+9JdFhfk/7lGI7nchrfNKs6lyS55n40XsE3CJGQ14JyrFniQWobZLBPSD5s84f/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136002; c=relaxed/simple;
	bh=WQf/Z9E3igrJ8jxS3FJ8A5L1R1Ayxf4sEgW18Uf46OM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mYPuXO8GpPUWC93lWqpyLh981ABiqHdJ9fXVVucnT7zpYHSGnr4InbOu65gxGNzvDB6xIq37xN70JlmTAul6q91zbTJACd0FO990iwa8rD3Seh4X6UXVa3Kggr4mpEjmRXen40eFJDa0q3jO3GffP8T5frG8/pkLsDqj+mtKghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2954E1F00899;
	Sun,  4 Oct 2026 17:46:41 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id E5928181E9B; Sun, 04 Oct 2026 19:46:37 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260923-rbrue-suez-upstreaming-battery-ocv-table-128-v2-1-b827406d768d@gmail.com>
References: <20260923-rbrue-suez-upstreaming-battery-ocv-table-128-v2-1-b827406d768d@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: power: supply: battery: allow 101
 ocv-capacity points
Message-Id: <179113599792.190565.4578467233714176972.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Wed, 23 Sep 2026 22:15:35 -0500, Ryan Brue wrote:
> ocv-capacity-table-N is capped at 100 points, while the capacity percent
> in each point may be anything from 0 to 100. A table with a point for
> every percent, both ends included, needs 101 and does not fit. Raise the
> cap to 101.
> 
> power_supply_get_battery_info() sizes each table from the property, so
> no kernel change is needed.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: power: supply: battery: allow 101 ocv-capacity points
      commit: ab2f870a67f547d3a6a55f5557cb7aecffb0ecde

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

