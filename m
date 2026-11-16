Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787619;
	b=K+p/hAia9uM2ztf2lLllaXH6kHVb6wf/o+/WzNFRXjb623ZwnWd4rheew0cWC8VxdpCa
	 vgwP+t8U0nacuX6dNBJ6eh3KVRhgUlu9e8YcJhzJNjv74J5dbDIDQzL0DYfdR4LO7kGQ5
	 7MNnJfXeHi83/ebKTQzCR3bh9WOMCyT9PGPN5engZ5l8SM7kJOmKEbJE2jwrii2cC18qf
	 y19RH7Eh9skXYO6KprOgtX+ApPjXCQ3dRRNoKL2KQvaIq78Fggru+4I7lA8+bC0hdxtX+
	 S6VGr5478zKIoATa04mF85XP9p4nXIXfyMAf/unK7CvVL33N4VxrFFRVe7YrkIT25Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787619;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=3W3hSNLj8cpuwDHLM/OZoWqK3c4faR9sN519Sr3dBOs=;
	b=LNAF1ZmQOi/deIBKSH71pM1MpeAvrowwAT1MnMEwnmvOWoxgqnDWUErHWVckilr8DIbG
	 xy8rmwa68ogvuC2Na8vjR84Y2Qk7Ny2HK65ivaDnmXJYv64mr/anUHo2oj8twmdHviuW/
	 FYie2Exb0P+wNhN4eTfaolKBg7QYNm+jvwbheZOvWQLvqCIlHFul5MeTYsUPkvHOgdxmV
	 GixK8L8lqown1hy9uVaKfTWMdTxtDFSKecAwBczRaGsjW2AaNL+ZhfGZr2FgW1wXM+UHp
	 CginYV3r9r07TJ4/BgWfWR6fXUu8RsEuRpSongxfFszhiNVI+I970vJ43YRsf7CgvGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FC606A323;
	Mon, 16 Nov 2026 00:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1801F000C5;
	Mon, 16 Nov 2026 00:06:59 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 808B0181B3B; Mon, 16 Nov 2026 01:06:57 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: amitsd@google.com, sre@kernel.org, 
 Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <e93f0875-7350-4208-b91a-4aeda1fa7cd7@arm.com>
References: <e93f0875-7350-4208-b91a-4aeda1fa7cd7@arm.com>
Subject: Re: [PATCH] power: supply: max77759: initialize registration,
 configurations
Message-Id: <179478761750.223300.3089609829297006174.b4-ty@b4>
Date: Mon, 16 Nov 2026 01:06:57 +0100
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


On Mon, 09 Nov 2026 23:14:41 +0000, Christian Loehle wrote:
> Booting a Pixel 6 with CONFIG_INIT_STACK_NONE can oops in
> internal_create_group() while probing the MAX77759 charger. The probe
> only initializes fwnode and drv_data in its automatic power_supply_config.
> The power-supply core copies the uninitialized attr_grp into dev->groups,
> allowing sysfs to follow an invalid attribute-group pointer.
> The local regulator_config is also only partly initialized. Its unused
> init_data, regmap and ena_gpiod fields can be consumed by regulator core.
> Parsing the device tree does not initialize all of these fields.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max77759: initialize registration, configurations
      commit: f49a9afecd6d55842dab3f9b0ccb702d49db6654

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

