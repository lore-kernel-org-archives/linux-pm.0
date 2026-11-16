Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787742;
	b=Eefc9g++quz2AZI7vHTcJtILBBSUogAhV8v3aP3XHzBH2wd1FZSBbs45BLQOg/zaPlfK
	 xQwK6YpDjiB4E9xlksUeednVpnGn9Zttc/D7xNMVWSzXcWaWFIrDs7fiU5ifqQfh5FyLi
	 IR07zOLscnwe2lgfginpqvddKH2qUgGzEnukJH3uI78y7U4x9w5/hkbFgWGecU5wGwyyy
	 ANHeJAJ6i5gdjbs1lSdb44GEG1/VHgxdOZD+FgTMuxWs5bCw/XCrb8wIKqkEljHM2lZrA
	 IuLNokQYMg6+thnMy033nZEgdxYEilOEVfbIm3fgT+PSw22ppuLUTCh8U0cCD9EWY+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787742;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=QMXQ0J1dfSE8nIvAFypB4Gh+MixjlC/fyg2Q6f38e4c=;
	b=EuWdA00O3PmWaBWDNALUEceeB1ceGoHJYaQlipnHdz63b18my9dCSElRpDVSYlBwwVOx
	 sBUfGpEVBEH4bUyahDgIIj/APOi9QMzEMJMmggWD6Lhlu0esExo+8SnBUn7V+JX5Fdk3a
	 un6igT4ZAsWpnl5xox+B2bFUqxJUooTuX9ZY5B5djQxdi5dR1soGm4OvStVFt3LaMmggp
	 CI5wyRgLDx29LC5ATsglb9FBthvgiZp2EPbtMJu12xw1m0M3iF92oOyaimS6sPZNRoNQE
	 whCqvPN9EYImdBnfRxLURAm7/0rHr7fSi9Odye+cPG1cnGZQSNG3nHCgDdYBRN2eH7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84745606A334;
	Mon, 16 Nov 2026 00:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015FC1F000C6;
	Mon, 16 Nov 2026 00:09:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 50D9D181BFD; Mon, 16 Nov 2026 01:09:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 hyunjungg <hj351016@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261109044212.1157357-1-hj351016@gmail.com>
References: <20261109044212.1157357-1-hj351016@gmail.com>
Subject: Re: [PATCH v2 0/3] power: supply: fix work-vs-devres teardown
 use-after-free
Message-Id: <179478774031.232281.13674582077494519216.b4-ty@b4>
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


On Mon, 09 Nov 2026 13:42:09 +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> Three power-supply drivers register a poll/detect work for devm
> cancellation before devm_power_supply_register(). devres unwinds in
> reverse, so on unbind the power supply is freed before the work is
> cancelled, and the work's power_supply_changed() then dereferences the
> freed supply. Each patch moves the devm work-cancel registration to after
> devm_power_supply_register() so teardown drains the work first. No
> functional change.
> 
> [...]

Applied, thanks!

[1/3] power: supply: ltc2941: drain poll work before unregistering the supply
      commit: 001fc38da1802cfc4b54fd1141594e5c8dc83893
[2/3] power: supply: axp20x_usb_power: drain vbus_detect work before unregistering the supply
      commit: 4dbc2b7a52a6023508cd424e83487588ed5138f3
[3/3] power: supply: mt6360_charger: drain chrdet_work before unregistering the supply
      commit: 6a40d8459e2385b5d0bdb8832c0bce7f87a55823

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

