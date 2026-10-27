Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107886;
	b=O2maVkI09Oq2pezuTK/Thdme0j8UKC4yKZNj3xNsbxs5CqPAF/n706bNkPjdOvZpVwdt
	 OSbkGkOxQWh5MgC9smRPQQUJIEjEPw5tqvBnGKGNJA9P2YnDjuFwjAV0pZAMafBEZtN37
	 dnq52ro4VqwNy9jBfTuZ3G+Sk/mqnAvyGpnSFCWPLArALfru9Wfd8DoUm44VNTadWtvuS
	 PNMrYLj5xN9tkTQiB2Zo1llz1u6SrYr7U2ljTIyY1ZRvWSjAsBWfbWk/lQREz0f4aLuXv
	 eSykgBh2EI38V7AgxBcXrZF5cORjXOx8u13m+8L5TD5/KXgXkgvVwXtyDfHKmdzkHOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107886;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=qEC5D0LF9e/JOlM8sgTaH4qiRnn1eg0HLkg9p1QEwmU=;
	b=2MgHqbP/1oXdoJlMwtSHaEFJO2rvz23CVqE7hnr08NoN1Uw8vcnlL9ji4zvX4Wi4VfAY
	 JKxDy2ay7hQgcds/QYkE9Kzcdhz+4hcFQR1BYbaR4Jp0jmgNRln+jpAD2/OhGatwyp5xd
	 /uXxAJVf1Du/yokg4Xrg0+b9WQYa/AXuthj1Uxiv/oLPbus9R+2rxAubpbQEesyq7v8dS
	 UvEBF0y7dhY6TU800zqRM8bSIprhxnYkPv+9QOy1Bv16FwOKfL1A90Z9oAtFUNNSD3xUc
	 PmBJMxaBcftUlDOQO6V19wOEeV5u2yHhqB1jBZyzgI1KzVWhweoMszBcSi7s6bxPn7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=gVkKcdyw;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A69606A31B;
	Tue, 27 Oct 2026 13:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A69606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=gVkKcdyw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=qEC5D0LF9e/JOlM8sgTaH4qiRnn1eg0HLkg9p1QEwmU=; b=gVkKcdyw0U2MQvyLMmviOIuJ9j
	xya+zVI6IoIafmhBMUgl3dv4Jf1WA7cvIQj8ZbG7YDrZg6ObXmrdpXzez7DY0WEFxINKoU242J6an
	NJ3lmLxmcS3dB6WiX4VVy+Aedi+TLCI4QwA/yrzCKHVjXRWdk28irHuSW02PyuyBQOjJ5AXEWWXu9
	iwLNJOxU0UXmS9i6SjAtd1mv4hE1GXzWroz4zXbX90ZMt8uSBsZsLhRGrddCZ0ZQrWgOiPXWT+GA3
	D0YcsjhS3nfIlDM0pAO6yUKa3+R89BKkK7cdAcK1OfDt7Jq2GO5YyunjzF4nFoj4KSY7BLR3eFVJR
	hDp2S9Kg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: 1579567540@qq.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Elaine Zhang <zhangqing@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
 Finley Xiao <finley.xiao@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v3 2/2] pmdomain: rockchip: Add RK3572 boot peripheral domains
Date: Tue, 27 Oct 2026 14:31:10 +0100
Message-ID: <1942535.QCnGb9OGeP@diego>
In-Reply-To: <080cffd7-05e6-458d-a00a-b757b0f44aa5@rock-chips.com>
References:
 <20261026-add-board-ok3572-c-pmdomain-v3-0-70d614d3d921@qq.com>
 <3329883.fEcJ0Lxnt5@phil>
 <080cffd7-05e6-458d-a00a-b757b0f44aa5@rock-chips.com>
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

Am Dienstag, 27. Oktober 2026, 02:10:37 Mitteleurop=C3=A4ische Normalzeit s=
chrieb Finley Xiao:
>=20
> =E5=9C=A8 2026/10/26 19:53, Heiko Stuebner =E5=86=99=E9=81=93:
> > Hi Finley,
> >
> > Am Montag, 26. Oktober 2026, 12:37:06 Mitteleurop=C3=A4ische Normalzeit=
 schrieb Finley Xiao:
> >> =E5=9C=A8 2026/10/26 16:47, Finley Xiao =E5=86=99=E9=81=93:
> >>> =E5=9C=A8 2026/10/26 11:21, Cunhao Lu via B4 Relay =E5=86=99=E9=81=93:
> >>>> From: Finley Xiao <finley.xiao@rock-chips.com>
> >>>>
> >>>> Add support for the RK3572 NVM0, NVM1, PHP, and VOP power domains.
> >>>>
> >>>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> >> I have to point out that the changes (the shutdown/restore
> >> rework, pending-state tracking, etc.) were not made by me, and I have
> >> not reviewed them in detail. Therefore, I should not remain as the
> >> author (From:) of this patch, nor should my Signed-off-by be kept on
> >> it.
> > As this seemingly comes from the vendor-tree, _some_ Rockchip authorship
> > should be kept I think?
> >
> > Do you have a suggestion who that should be other than you? :-)
> We have never carried code like this, and the other parts also
> differ significantly from the Rockchip kernel. It does not appear
> to be our original code.

thanks for the clarification. In that case it should _not_ claim a
rockchip authorship obviously.

Heiko


