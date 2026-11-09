Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187381;
	b=QWXtFoMg5VIhydMLH/9GOyHv17r1JVWpaTc1Kbi0pUA4DYYH98zuh04OpmxQmNUVfnrx
	 O8SOlkks8KETV+0N7yIN7Ddy316gqm6MJBbadk2s2BsXSr6N8QjULglDwVg+REMk9+G2d
	 SsM12wOTdONEvRJO50yjO036AQKIvdQgRHHgZEohCdaLZvwHaHEyu9615jptxjZ6l96u+
	 XrlduYHWafj6kDsoULtwdazIE11yBlG18jonQy21iyUt94poHUxZUgmVGfRDvg9m98lAK
	 8r9umBwlCtwf0jRBVflLvFs5gHHjZLE/V9hwb14Yl6ve6GFI4YZGZwz7bHA9hXHZhXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187381;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=tYFHuW5UvuNC0ONlTXXPRjZq07/VduE0A5i/H8fhboc=;
	b=0mdS33pjkatQlaZ8PV1iCHyMyi3FFmCKNwH6x9OH6+SStVVbwmkpB3F9KqqedW9+e67J
	 AKmlBE56rZH86JyEBIe3GtlIPgpO0L7Lz+bcSqL0oBhHFjuXQjrt/Q95co3HhEwjrg9Lb
	 AA/RtsQ2u6PyyRbLzQcX5fS+hzoC5WMksVPJtS12AR0wNGRF15tPpfcqdgajCwnEiOQdR
	 /N4GIfznKdXLvwujQiAnouITK52Sf98PrQXZxYu18yu02WKu3cyHti9DA2tW4+lNz7T8E
	 7VLaUyPgswKl8bjmoblWURkp+SFQDIA27pqoMH51YK/82+uqh6nYY4Eur+Ba62YNRLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960E6083613;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284691F00A08;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 17379182C50; Mon, 09 Nov 2026 02:23:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Myeonghun Pak <mhun512@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>, Wenyou Yang <wenyou.yang@atmel.com>
In-Reply-To: <20261024020012.77608-1-mhun512@gmail.com>
References: <20261024020012.77608-1-mhun512@gmail.com>
Subject: Re: [PATCH v3] power: supply: act8945a: Handle status changes in
 threaded IRQs
Message-Id: <179418738008.1255445.10636111840813594736.b4-ty@b4>
Date: Mon, 09 Nov 2026 02:23:00 +0100
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


On Fri, 23 Oct 2026 22:00:12 -0400, Myeonghun Pak wrote:
> Clearing init_done cannot prevent status IRQs from queueing work after
> cancel_work_sync(), risking access to an unregistered power supply.
> 
> Use threaded IRQs with IRQF_ONESHOT and a shared mutex to preserve
> serialized status updates. Request the LBO IRQ after power supply
> registration so managed cleanup drains both IRQs before the supply is
> unregistered. Remove the work item, init_done and remove callback.
> 
> [...]

Applied, thanks!

[1/1] power: supply: act8945a: Handle status changes in threaded IRQs
      commit: 3d911afa8153d590b17ffd691998327e5d675a90

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

