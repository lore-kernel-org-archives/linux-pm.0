Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357849;
	b=5A2rm99U3rOE4NrFBoZ4G4P5g2WYouKYD+rOS9lxN/I9GWX/KNgV1ccef87Lpu4UEmrI
	 HsDN3DbAZC9nniCaIDcy6O4NDAIxkYUNYZGKmSxsBRm1bk8EGEaYL5hf+5mbS8pQZcbH5
	 TWraqX6wm30QQ+OyTJFV3M1Zmpu/Qr5W9TKbpqabj+pIPqOOYbY+h2W9gJIGX7dW6ZKGm
	 8vDsITkY4MakYtq1bhAVuXCNFL6wr4zbF8jd95VRn/5cZdJPvkrkYUS6YMJ91c51H8CFX
	 APFk80pJ71TQGU6Br2+fg3R26vyBn6CpFkmQdLd5/LPQCyNA86qYsg72jy2pjk6NHiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357849;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=nd1S1qGDMFy2LjhbOYktweIqH3jY/o2wTGMnO5tRhRo=;
	b=vSOUfo0YvKiYUlXsQNtfr/Zcl90dzFw3nO0HZQHz3sU72bAJE8xgxxE2nPWRIh0Bjs0Y
	 dTLqlNtx6KQQWEHOkmn8wWap+eXM+pAY298lUUgZZR1vWTYRVwrgKq7k6WlS+zZ7CFryg
	 uEDQrBDXdna7ICpd03UCXx7RuHctpzY6CcUrpPbmBvUWXg9p9mkql426YiBIoAeEkRkxO
	 DI154PvqMAagEJQrXNq7Jc3WOdxEhU1WtLgciqS0/notbtwcwDVWo0KwpFui2vRqF38A2
	 9XGlJpUUmAa6bK90eOWtn9VciRdTdJM/3QIdRonuhDLIDRIdjy3lu4YILr4dj+F/Yew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlJ3GW5q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3A606B942;
	Fri, 30 Oct 2026 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlJ3GW5q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AAD1F0093A;
	Fri, 30 Oct 2026 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357848;
	bh=nd1S1qGDMFy2LjhbOYktweIqH3jY/o2wTGMnO5tRhRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UlJ3GW5qrWNWW07RPi/VLcWesAvpBOFFW6OwaWvRvpA66hIIy8rYGSFbXxMpB+Hpn
	 w1nCtzTTpWXSTmcqZEMznbZTC7BaJdhjlYQab3KwXn2apml/ki3QL6tMRxpLkwopak
	 ms7GVaWSeEceBZS3fAYFOrZRLuu18SDMEhKZgG/byiw3MOVog3KvwV4F6KBTypka7O
	 2EeCkUhlCzXn8eGvWnIv416PKWNf94tchQFfWN7xsRpbH7Cm7Znf0GkAaYN0hyuYav
	 oZxXki44PfbWLixyHWpf/1aog2QNSLhbhWlG9MnvrZ8lntU0XzY5eyGfYHkHDJdzyW
	 aE02ArStD3A/Q==
Date: Fri, 30 Oct 2026 11:57:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: christian.koever-draxl@student.uibk.ac.at
Cc: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Stefan =?utf-8?B?S8O2dsOpci1EcmF4bA==?= <ckoever@outlook.de>
Subject: Re: [PATCH 1/3] dt-bindings: thermal: amlogic: add the S4 CPU sensor
Message-ID: <20261030-hopping-toucanet-of-prestige-0dbcdf@quoll>
References: <20261025192244.209256-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192244.209256-2-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261025192244.209256-2-christian.koever-draxl@student.uibk.ac.at>

On Sun, Oct 25, 2026 at 08:22:42PM +0100, christian.koever-draxl@student.ui=
bk.ac.at wrote:
> From: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
>=20
> The S4 CPU temperature sensor is the G12A design, but like on T7 its
> calibration value is only available through the secure monitor: the
> ao-secure register used on G12A holds unrelated data on S4. Add a
> compatible for it; it takes a single clock and the secure monitor
> phandle with the sensor index.
>=20
> Signed-off-by: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
> ---

Feedback from Sashiko looks reasonable and I do not see it being
responded to. Dropping from DT Patchwork.

Best regards,
Krzysztof

