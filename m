Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526413;
	b=Dzj8rMtXngtW6HUuoe5EzgdSJH1IDoHZNP8ELH6eQ4awK71drKMwa/HKltk+Acq8Mi3G
	 AExXVFFune+BU9C2Ry63dxAxXEGMgNFE4xoTIK1JejtveVUrcMGJ7Bo4ZfpEBIr6hErlq
	 QmEQQJRM2r9aNdD8lcecEsSpGXRV0JVuBBYMv21v4VWbjkkHX5MhaVkpAuQvEahyEnzKx
	 L33jWVMgaUrTDzGEVf+sfWp8z+MFSO4Zx/QvC7Fwk/aMXiNYPo62ePc/aVFdvYmAbLZFr
	 gwRrCbCeZrbO5MhtFnmJvAMKUKsGZBTOmEDvk180jNXl2m9t7Kgri/muTbSOrzB2Smw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526413;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lAREEnG+UPNTWplTE70Ch6zp3Nf3joLZMH6VYewslEs=;
	b=EhZxSvSJMybBYKeWlyOr+zxLSG6YXRgGkjuCCfpiuNOWOrXupR5LCPNH+onFDc9Hoh5P
	 JnQjteTvGRDA3iswiEv9wKClvBuvq9mtzqLqLx2HStaj6KXrQdk4pHKJPUMz95PR6oC4o
	 yYCj4OzUWV31PouUnosJOnY2lz58ENgM63JskoH/E85R8Esv0X9Q14ZMKVTujm2rNDLfV
	 VESOeegP9+pndKUgQORAnunhHQrLcoeMvG5NFrJ4mynZnVD55IBPq0cvnmu9MCRfVDIVj
	 pKj9OBLgqZdxoBxPWqGEQOPv/ANPiEfGEiMPAa8vjpxtNpgH2f+ZB5wRPseeZbSGydQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IsxRpIZl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 78514606A330;
	Tue, 24 Nov 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IsxRpIZl
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 346191F000C6;
	Tue, 24 Nov 2026 13:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795526412;
	bh=lAREEnG+UPNTWplTE70Ch6zp3Nf3joLZMH6VYewslEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IsxRpIZl/d+r/93/e1Qp1jn3ZU5wZjJ3L5peYClCeabYlKFQX4V+iTcgLyRyIxhKp
	 XNLOyXKv0KHdgFBltNConhZSlRUE5VejzKw8z4WJqqVxEMoikdATagxXd8hI9CEnHs
	 tyCcLy3yRptGT5I/KrpkBnVU547YO7rVxgQ7iexb8xw0aJXATPkGt2I0LuDuFToQMi
	 YKH3TX17PR+4nnP8Qah2iUGxTcPNz+X8FWI9o4+0MwUysFoW5DcIUnfMQQBQE2DnYR
	 kbQDRrhhnrt/qu08Tg42IEQGeFxW/e/PI8k9SKTYbrwmxfHSau/5uur5AhoVFnYH7l
	 Q9hhhBISB8vpw==
Date: Tue, 24 Nov 2026 14:20:09 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 0/2] iio: adc: rzt2h: Make POWER_SEQUENCING dependency
 optional
Message-ID: <rxtcphmoqtp5jv7a2pqetaj5ugt4jmh4pnnavhkh5pt6u44fnl@k5xqm4s6r2yo>
References: <20261123113755.3033436-1-wenst@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123113755.3033436-1-wenst@chromium.org>

On Mon, Nov 23, 2026 at 07:37:52PM +0800, Chen-Yu Tsai wrote:
> 
> Patch 2 relies on patch 1 at runtime when POWER_SEQUENCING=n on RZ/T2H
> and RZ/N2H, so both patches should ideally go in together via the IIO
> tree with Bartosz's Acked-by, or via an immutable branch from the
> pwrseq tree.
> 

I'd prefer to pick up patch 1/2 and provide an immutable branch to the
IIO subsystem.

Thanks,
Bartosz
