Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745435;
	b=wm/iw4nclRMzc6guWva465gMRx4JxmrsYx/TJiF/qdASRceIVI+7dUyged0uYgdld5CY
	 xLwp4415jF3wgEqbVNXt8OqVGbJq0vkHFKmGjf4eE4dbK83HNQ2jtNaT3CunMmBbDS2O8
	 BWMGDPWNJgRpvhT9hXa35vYCZVcHBgAezI3E7PV6RNCMmzD0d6EjL8f7lzoCYVpec1ypb
	 vM2c8XUE/79qx/WG1mM+3GXYjpNt+MLmQWnLIGAxF01aKgsgBOLraebicZKTWTAO83ydL
	 10eUy5KZUopJYAQtv+rPJODDR7gtG3pBmjLRjhn4ZcPoORzC7zOVDmiT2w0wbOeI5Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745435;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=xsK4w3jLbP3XPnppugEgOy/hVuJlXHxWXgSfS8UpOYQ=;
	b=PT6DUW0elOX67HXFUylRKqcVzYziRhmmBzprUFollItDxSe9RsWfvqcTBrryU3EAkerE
	 kmkp8cD+c4OUrXdSySDIr9jxE1HBn3rInb/kPYScMch+FVoJEjOn2FuyxFL8gGIszLii/
	 a52mf71bN5gzwdmBrM/YQJka/lYieGKDEcy6AI270PZ/bkhDqqEYr1sYuGwIJUXjZnsOM
	 cP9filhxZt18T17B3VFRMvVs4RZ7wzE4qVNWUj4pdpLAG3RmyN+GzM6zsh1lNX4I3QU+S
	 8ZrievI+Lbn7+C5fZn8tLfU9GUnRAdz+qyFJUcKWNR+UZ0pEb2CETDCTj89+dnM4FZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=1cUgVVtf;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD946606A31B;
	Tue,  3 Nov 2026 22:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD946606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=1cUgVVtf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=xsK4w3jLbP3XPnppugEgOy/hVuJlXHxWXgSfS8UpOYQ=; b=1cUgVVtfjLR8OTj9loqDdJcnxM
	4NUPW4VgzqHCdc5C+ue3DYNVoZBzBLZWHJuAHQHcQtvNh5vcTI9Z2pCCMdpjIx66hpAiQWW+iRDzL
	F1eD+vZJZSsRqCURVFCc5rPOgrRzhNlrvyxjJB0tsMUeUGiehjeiHHk+DJ8oXrVp/ol+VF44yvkEB
	x1xDE2rQn/Sb6eOQdMpgVKWuDhTqz1I6qrSz9RqpJDgXl3XDc6eIfqndVxF88WgTQRolhu6e7HvVH
	2OKj3NgFNzHpVG1L+1DUVVpELXsirdhAdiZdsjStcx1DHsbBO2FVWcU+FvQagEV3Fl4JAR76iDGWn
	uFEGY8mA==;
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
Subject:
 Re: [PATCH v15 10/15] pmdomain: rockchip: cycle an optional power-domain
 reset on power-on
Date: Tue, 03 Nov 2026 23:36:51 +0100
Message-ID: <2685454.vzjCzTo3RI@diego>
In-Reply-To: <20261101082307.151957-11-gahing@gahingwoo.com>
References:
 <20261101082307.151957-1-gahing@gahingwoo.com>
 <20261101082307.151957-11-gahing@gahingwoo.com>
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

Am Sonntag, 1. November 2026, 09:23:02 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Jiaxing Hu:
> Some Rockchip domains come out of power-on with their bus interface in an
> undefined state. On the RK3576 NPU this shows up as a hang on the first
> register access after the domain is switched on, and pulsing the domain's
> reset at this point clears it.
>=20
> Take the domain node's reset if it has one, and pulse it between
> releasing idle and restoring QoS. The reset is optional, so domains that
> do not list one are unaffected.
>=20
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


