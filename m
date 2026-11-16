Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787742;
	b=evpELNNQtcBjpmTNWByS6NI/DRrPLVYyBcAXuLZVwinS3l21xEsObZe7DsAX+1KiEU+4
	 jByvXIm0hh3rAiElAVKY+2BbIoPD5Ol5dT8UDpUpWGIf9T2+8wymOX3PHwT0iIUnVtIPL
	 T/5A4/vDTiqY/2crClHTYxATeRkh6yCkWRV3+BKI3EtKqOTWvC3AeGHSRSZAYKnGuM/d3
	 BvsTjLphzH53eke8Dd83iuCK9ygTBzD8cTWiYasdwavCINDo8tJfmsGZrt8TT0U/NAgl1
	 y6lQ0gYaLydThI0oWT1Pdl+76uhAVH4rcPxZrBE092jnybqCuiam7u2XacZddyaM6Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787742;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=deNEZihTIaaD22fBsQcHSS6fD7kZADIUBWH9tEFhW4Q=;
	b=2Y5/5jkTyF9OEI/QVvyLVymJzClXuDO6Ma0HFnNvfyILCdYsvxH/YchfZo1xIYq/sU82
	 Du+MhvQSw0RvZLXEX8Uig6MknrFuYSh0coEKLB9TXyll0B1OtmcugMQ1vwhR23buexMht
	 12qzv+aZmo+C+htGMbw3nUtU8/h5H5o3YC2l/SDHSzUk4qlO8OFst9fAmr2yh87rT2FYm
	 WxUuU5XsAsKeByU/hDRRZ9q3Ur8cHVLWBn1NiiCQxIgVvBOb2f7NJPx3FpdsfX2hir6Hk
	 ke6Dc62wcvvmH9e1Eu7nPu9IC2U6/kJ+H8rHd9xkQIriwaI4ywznzFiXoC9glQ3kP9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F0606A335;
	Mon, 16 Nov 2026 00:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE571F000C7;
	Mon, 16 Nov 2026 00:09:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 325CB181BF9; Mon, 16 Nov 2026 01:09:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Jianing Li <m13940358460@163.com>
Cc: Iskren Chernev <me@iskren.info>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Matheus Castello <matheus@castello.eng.br>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261102105206.1587-1-m13940358460@163.com>
References: <20261102105206.1587-1-m13940358460@163.com>
Subject: Re: [PATCH v2 0/2] power: supply: max17040: fix error-path state
 handling
Message-Id: <179478774018.232281.948397651965612976.b4-ty@b4>
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


On Mon, 02 Nov 2026 18:52:04 +0800, Jianing Li wrote:
> This series fixes two independent error paths in the MAX17040 family
> driver. The first keeps the cached alert threshold unchanged when the
> register access fails. The second propagates an IRQ request failure so
> MAX17048 and MAX17049 do not bind without either SOC alerts or polling.
> 
> The second issue is specific to configurations using an alert IRQ; it does
> not affect a MAX17040 running without interrupts.
> 
> [...]

Applied, thanks!

[1/2] power: supply: max17040: preserve alert threshold on write failure
      commit: 273b45f61f346358a34274069590c7adecd1edc8
[2/2] power: supply: max17040: fail probe when requesting the alert IRQ fails
      commit: 27c9e02ff5c0418cd9885f0b56f50b99e5295a4e

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

