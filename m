Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015651;
	b=1zbnJeQgOfpqqEBO4EugssIKdQfQf/zj1gTlA9nEaITxlUG9Y52jU+4P2dgSXmadruSZ
	 0ORDUOgggiMA03O4d9ICH9bhWHhSoj0rpVMUZXyRT884/uRhbt7BsrMOHX27Tub0nms0N
	 OuZzW45qa/LcopopBBPR5sy8r9j0boNihTV06Qy5s8NwFKVPb3LhepygPyWMVbTsoE0eh
	 fO6KIpcK3h9G2uKxmyKQA3TuDCcLXRPokEDJURZ2pyvFqXbB/f+lswQ87bxxcfUGeYtMK
	 ZRLt3ucynjajE6RF6WUAfeVNexAy3iFmAZ/A0sPIX+vyX0pNrK7yjCbVJuJRYf9BiLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015651;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=EMx0UqFgbDRUnMXk5gFL4yABiOYwefPK+nAKxnm2hdU=;
	b=dt2f20a+HkPz7Y+5IT5ROLly5+0ItkmtCm+HZIVNMUsfZc6yUp/gVM7d83ngsx6sN8jI
	 y6NkXajI4J+LWrniTtyrNm/267Ga1Qwe0347zCnzcaor4CJju9MfYpIVtn8fJjJrWmAsm
	 bvz98hyAY84jAP5AO/fKOD1CLY8yzyjK2/GLY5LpTIrsbVTrX+A/pDhLc8YKtsYKMNbwU
	 zDqxUg4V31+flNVXJEjILMDaUWG5YguTHv5hGEBQ6iZN4gnKDpMZNu9LOhArd8z0XvVj7
	 +wS0TDoobGwEC/SXXq1cIneVGhBRwWZZpTiBc+Ij9qwCFQwOmbSXUaJaLnq8Ac4aU5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=h4TPHmHX;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E3606A31B;
	Mon, 26 Oct 2026 11:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D59E3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=h4TPHmHX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=EMx0UqFgbDRUnMXk5gFL4yABiOYwefPK+nAKxnm2hdU=; b=h4TPHmHX9RJu90VSZsNimFg7ns
	3Jzhr3hQMhcxA8gLFfGhGOvIvh9+Q2ybI4SzLgDMBXhYjTHO7SBN9GVFKb7O5bNL+P5MeLK9YihQS
	34NmFOqIT3DPpvmjl9pSfM15yvxEvwiUnHGX7mGv3+pn9pzakQz4mSAcM3G24wTJIro9AL2lpL7jy
	vC5GEAGAUQMNYgwekifw9aknEzCHRzAk+ralTfDjg7xeIN/Y39py0KOf5XOlwpP0t5616O5c/G09g
	X4UCcURat8BZo1n2rnY0VOrelLvPjXgZWkZzI/DCYFuqI3vi+oUfXKIKVefK9Co3gobQw6wIQhR80
	xpIOY9AQ==;
From: Heiko Stuebner <heiko@sntech.de>
To: 1579567540@qq.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Elaine Zhang <zhangqing@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
 Finley Xiao <finley.xiao@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v3 2/2] pmdomain: rockchip: Add RK3572 boot peripheral domains
Date: Mon, 26 Oct 2026 12:53:59 +0100
Message-ID: <3329883.fEcJ0Lxnt5@phil>
In-Reply-To: <d4e92131-ceb8-4143-b8f8-21e7f9638bdb@rock-chips.com>
References:
 <20261026-add-board-ok3572-c-pmdomain-v3-0-70d614d3d921@qq.com>
 <18fcfe7a-e25a-4516-810f-d787b779914d@rock-chips.com>
 <d4e92131-ceb8-4143-b8f8-21e7f9638bdb@rock-chips.com>
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

Hi Finley,

Am Montag, 26. Oktober 2026, 12:37:06 Mitteleurop=C3=A4ische Normalzeit sch=
rieb Finley Xiao:
>=20
> =E5=9C=A8 2026/10/26 16:47, Finley Xiao =E5=86=99=E9=81=93:
> >
> > =E5=9C=A8 2026/10/26 11:21, Cunhao Lu via B4 Relay =E5=86=99=E9=81=93:
> >> From: Finley Xiao <finley.xiao@rock-chips.com>
> >>
> >> Add support for the RK3572 NVM0, NVM1, PHP, and VOP power domains.
> >>
> >> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>=20
> I have to point out that the changes (the shutdown/restore
> rework, pending-state tracking, etc.) were not made by me, and I have
> not reviewed them in detail. Therefore, I should not remain as the
> author (From:) of this patch, nor should my Signed-off-by be kept on
> it.

As this seemingly comes from the vendor-tree, _some_ Rockchip authorship
should be kept I think?

Do you have a suggestion who that should be other than you? :-)

I guess as you suggested splitting this anyway, that authorship
could also be split.


Thanks
Heiko




