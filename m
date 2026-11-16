Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787742;
	b=UhAGo9zdmQ+8En7T8eH10N3gFdYzdQnWItFvEbc1YYpDaDqlRnJCSOjKhvmJ6myT4Ims
	 bfQrHlxWT5QOQUtVimafTEmJyS0ZWXhiCovKXX5Ab+PQOwZ2NYov3QpdoHBcjKPaLNw4a
	 0V1TK30+QgoYT2xSJUiyFVCZm6x8wybSD0+IGBhTUYYmwwLflqKSqt663x03hsdLCU/MW
	 wqGFgtdsCp7IEki+iPbd+ob0hfyvP2OjpWPY7N4G9P7fW+CDteOby5CbYlfYFnY4mAGSU
	 /27TSaFmewuf5B/c6Smj2JR0eZemLXuV9dSRTen2ug2MbxIY9YCBc5EYT/yUjDOQOMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787742;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Cj1CTWpXm1c7X2x8Nx89WqHJnRm+vG///VRBx79CFpI=;
	b=auvHo2PQ4lcPcYWNOPxWqzSbSSQoLkHgw7yqP8cvJI2IjH9BoT0ChGyx8aczzP9E7rp2
	 SFqxZlhgdsWIphn6hnbUN71azMN+7B+Zp1l52ScwA9fkZZ2y2xttW+AQKDleD8ZNE+Ax5
	 aOhmJMxM+9FU2mp/0hQ67PU+0pNmqjHK+2rvPSXCS8fmlRUFO/BhZq5vmwYhLA9WsdSul
	 CdmeS403cbTRP88Cr6onnuwaGCj8NH55MvYZZMKYI2Y5OmrviBNCL/Zraq9gVnjf8qtw2
	 CRtEONE6NqCVZqMqTCFuqhRwEN7AKQgH4DCRROhQh2Pbb4KHTF5Pmid2sHTMFFmBTYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E8606A31F;
	Mon, 16 Nov 2026 00:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E746F1F000C4;
	Mon, 16 Nov 2026 00:09:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 47EC3181BFC; Mon, 16 Nov 2026 01:09:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nizat Mikayilli <nacht@dxdmail.cc>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261108-b4-sm5714-fuel-gauge-v1-0-c659b6c0884a@dxdmail.cc>
References: <20261108-b4-sm5714-fuel-gauge-v1-0-c659b6c0884a@dxdmail.cc>
Subject: Re: [PATCH 0/2] power: supply: Add Silicon Mitus SM5714 fuel gauge
Message-Id: <179478774028.232281.11992235307901965999.b4-ty@b4>
Date: Mon, 16 Nov 2026 01:09:00 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sun, 08 Nov 2026 12:22:24 +0100, Nizat Mikayilli wrote:
> The Samsung Galaxy Tab S9 Wi-Fi uses the fuel gauge of the Silicon
> Mitus SM5714. This series adds a binding and a small driver for it,
> which reports the state of charge, voltage, current and status.
> 
> The fuel gauge node for the tablet will be sent with its board series:
> https://lore.kernel.org/r/20261022-gts9wifi-dts-v4-0-a361428fe59c@dxdmail.cc
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: supply: Add Silicon Mitus SM5714 fuel gauge
      commit: 459af25d38f47328a049905cab3152747b994119
[2/2] power: supply: Add Silicon Mitus SM5714 fuel gauge driver
      commit: 432b12f5e9a0fa412af36d5eb8d4f73620208f94

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

