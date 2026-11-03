Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745592;
	b=32vjN3b2VqtEa+N5eWDAHk+euE3QKnf09mpNiTYN+Eiv97O7LCZjNhUQfH6PyV4gz0pL
	 1efOU46Jjh19y6yeaCpJLEZ6wtc1mKcjwtYvKsgk8MBsAa4ZMQJF2wm6V1MGCiSi/NkrL
	 WuuROKhh1bE4bIs+Na6sP4gWdQFLmpXYz1rzSfSBqpCRfrvZQPNC/ffiTfyw00s3Fo4qR
	 V/nVcJ5oDpWXpAeQ3zSJi1L5IZTq+MHi/0Izu2XhmNXZlPiP0/xARD7WmGjwAu+xvwNOB
	 3YDSCoK49R9sFHASqqYSJUj9N0KFf5u3l/SxqeGWXO9Om4IZL662u1+FgxRXRQy/lmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745592;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=YhUmBPOp0GBHjBhGSwhDdx5NqcNjkjGI8oHDjK3Q308=;
	b=zsZ4HDeSLZNmAxc+hjnixxKv4oqtvgbqNFcUfbs1IRJlVMW2sLu+S8MmiSPL6qFLYzGC
	 QdDbEFL1SI2Iwdr3NgihvJyC2ygVaE2LuDNlNZ5kUrvLZBvGdniYQgqMKP8N9/Hl3i3b6
	 ax757k/CLOWFjb61F8TMmhBzT1hylZiQxpkbBXU5jak/vrEzGyJB+znbLGI0Iw+qn6ho2
	 I31HmnCxdgxD/0CSL4GO3bLIDwVlPogO5eD4lbJCI13S8wGwMO4LZRBjTm6DuCN5HaUPz
	 DwHpAf5Je2ofygYDtibE+jMcmy95tQTN21nBekH1k44WYGnx/HUhOVi/2/h6fKWLssg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=nY8SYePo;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A0606A31B;
	Tue,  3 Nov 2026 22:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 175A0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=nY8SYePo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=YhUmBPOp0GBHjBhGSwhDdx5NqcNjkjGI8oHDjK3Q308=; b=nY8SYePoicizj/jHg7XYL8Mn5y
	89+t36FA99T+XZOPMhkxJpXuTEB13wWAosEXYtbnUL1/npVFl0rpVGGlFwjGviA5DiNQzJuiWzkw9
	RI9l46qtoETA0kRiAxUwXB4+cIXI3IIilrXPxZHZPCzQAORctl2bALKKGmliaPiTno21jfbnsc7S4
	S5s6jJZJkpPGexawT1UhIA3nSgmA+Zb5L1fFSLVKvtwqL/NOTWUfbp8Gm+iOwaB7ucAA/ZFNeYdau
	uDoiKVN7h/ZC55pcItQi6KMhsScyBKDZWect39tOd+U7xhKIwvuGz143SD+HbHsiGw4RhnXGcA35m
	z/qVMn6A==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: tomeu@tomeuvizoso.net, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 ulfh@kernel.org, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com, Jiaxing Hu <gahing@gahingwoo.com>
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net, leonard@lausen.nl,
 jeff.hugo@oss.qualcomm.com, rfoss@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Tue, 03 Nov 2026 23:39:28 +0100
Message-ID: <6777074.j6PcuT4dK6@diego>
In-Reply-To: <20261101082307.151957-1-gahing@gahingwoo.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Ulf,

Am Sonntag, 1. November 2026, 09:22:52 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> Ulf offered to take 7, 9 and 10.

I've now looked at the patches in question and they do look good to go.
So it would be nice, if you could pick those up, when you have a minute :-)

Thanks a lot
Heiko


