Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795091231;
	b=qDG7yaeAwvF4n++iwC37GmQF9YS2FzTxuQghALu1sIZLGubjQwWDK89Fw/qXMeHjxQpM
	 WMdks3zYyPE6qpqusKNCP/qCODnD03j3/W1YAwkFJVSI672RFXRZKSFbBsYooUc2T1PPX
	 nq40MEvePK7Le+TNPDrQ6+e1xD/HQiqcTOGDkBhYvv5qp/sNGQJFUPIAfrpSVga7JOTNM
	 PkAA5nIT1LTW0dLf5lewaiyn+KiK+NrzKGVCB7f+i3v1lfieArBcUwgZgqbJZZlkqn89L
	 CrWeOnscjxseRqwMe9zJlhbYB5p0jh5dkqjmWpL+wtKN5Dt42iDXCxlyz5ndBfjJ7+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091231;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=DRSIi4zL0XjElxRgpJXubKJ6vjpY3WRDRA60Q34cIVY=;
	b=Ma6ArKJuCl/aNPhiXz9TlDCXyK1KT/EcD3knP0fJYOoXEPmdSSMS+49BsjzGYrBHhim+
	 1Bg0aQ8F67FXZfcUgc6pAZyZtafJEz0b7fh2SGbRIQHH0iXhBj1kmBpKANrL5F/j5c6cV
	 rla3u4UvXBgXoRfgF5NuATYmZTpUepoZev0lXhxaCcF6qHsTlXXIgM7PnpEgiLge39B9s
	 8mbcFtc/M2YT6EP4slhRLUKv41YcrK1qoNucBUUf/a6nWPGin8xjGm6z80QuxRTTrKQ7H
	 QfehAYjFXS85FIyRBtDsdj9pcU0CTX5FAFAnZuRsuTnxmJRU1Vglz2G/lr1ewPWL1tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=BHe8q+No;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1CD606A324;
	Thu, 19 Nov 2026 12:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D1CD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=BHe8q+No
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=DRSIi4zL0XjElxRgpJXubKJ6vjpY3WRDRA60Q34cIVY=; b=BHe8q+NoqqkD67mBYpfyYBEst4
	Ox7m1p2lAIExkj4XidwoaP3+1BNIB3f+4U1kuj5F+9Q6fBc/47w3FKQCGgK9+wkWkzl+G9h9YagvY
	uq6XLaWcNnHxY67EMtAmy8YFfWNC6IAGVCDwOs/RAal135JLXmjXpxn35SRjEAc2shl8Ky1FZb6zO
	3N3ga9K3xB8MqYszfn2ylYamnFCyeOodG2yhDYVxGhWUiBFetC51aWDuKr1SBQJETFxpCy963g3qb
	50efzDz2Z3lmavzYn4rtlKbiLwUQVI/hPVNYZ1Tc6ny2JQRiqlNa6wURCSJWLzOsnzulMOCCPto9j
	Onh0o/Fg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Elaine Zhang <zhangqing@rock-chips.com>,
 Ulf Hansson <ulfh@kernel.org>, 1579567540@qq.com
Cc: Cunhao Lu <1579567540@qq.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Finley Xiao <finley.xiao@rock-chips.com>
Subject:
 Re: [PATCH v5 1/2] dt-bindings: power: rockchip: Add RK3572 power domains
Date: Thu, 19 Nov 2026 13:26:58 +0100
Message-ID: <oNmb42cjQM-T6qufTLI9Jg@sntech.de>
In-Reply-To: <20261118-add-board-ok3572-c-pmdomain-v5-1-f1af919dd434@qq.com>
References:
 <20261118-add-board-ok3572-c-pmdomain-v5-0-f1af919dd434@qq.com>
 <20261118-add-board-ok3572-c-pmdomain-v5-1-f1af919dd434@qq.com>
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

Am Mittwoch, 18. November 2026, 10:11:39 Mitteleurop=C3=A4ische Normalzeit =
schrieb Cunhao Lu via B4 Relay:
> From: Finley Xiao <finley.xiao@rock-chips.com>
>=20
> Describe the RK3572 power controller and define its 14 power-domain IDs.
> Require the system GRF phandle used to check firmware shift-ready status.
>=20
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Cunhao Lu <1579567540@qq.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


