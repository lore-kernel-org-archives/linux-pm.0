Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360779;
	b=qKPhVDog3SAzVYuuTQoQCDxIDR00p285mNIIBhMhcJ76GkVkbIQoO5kgJqdCwIzLKS3p
	 2JDO/N0cUUkP4bEq/JKBgVPlkcqe3LUcOwGyfgZ//D8q+mdzswlKUXCjerrKIheqSkVO/
	 kC5WTfrGKZQl7LV72OGzPaHeLKa0Al5BCRJ/Y0t3CPX+lpkScwQzLMq8l0Wstf1G39vVa
	 NrLeMujzg2E4A+zie/onUytYGkbHVtiqHpanQN4aV7NzVTuu8DQ5rVTBLyMSbFhjiv5s1
	 XeMOLa/RijZOXyn3+dyun3twnG4ze6+d5FI2qukrYLffm6JWi4mWsNA7jtfTtnskTQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360779;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YXve5J5rsnqYTJLKWzayn9tENd9Qyjaq81ooexAaK8U=;
	b=ORXL3bnaYVabtikgLEclLxcJQ9fs/B2tnqjsbJKresV4MxEHeM+3WB4S7QMS0dai2l0W
	 uPZkpgCZNSm58+9FVVfjnMDlBnIb5z+14oAlYT7EOJlbln6bYM8iZl6ieiQHNkBqYT/Dy
	 IQSKsDpIMhsHJJZ2Y3/ZHyeMzNJDiMbZTgetUmJUCR/hyWqhN1AUnSm170aiQb//0fdBj
	 HHFAq8GHUtQxXRKpn7C+WIIRR6yM54tPV7iSTIdKBJw7taBAilzqzYoblkAHPfFHHwoRH
	 8/LTiz9cXjJkaGQf09ydZrHdzzCD+CusEHS5+qDYW/xpZnBdKYDLdZ1fW4Ff8GPf3Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSHJZR5Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1C4606A31A;
	Fri, 30 Oct 2026 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSHJZR5Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319591F000C1;
	Fri, 30 Oct 2026 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360778;
	bh=YXve5J5rsnqYTJLKWzayn9tENd9Qyjaq81ooexAaK8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dSHJZR5Qm57R+XmDN7nseugSBUb4jFjuF5tRuJ2zPSaBRHh42g6ty20A52MeffUvL
	 AWbyGU9Cg7LPilw5pHZJXz9o5WZr/1a0gmxpCeiguDQ/Zhq6krg8TpiWQHAKJiMU40
	 oAsixTK0DvYLv+QSfV7a76FrfSTVoeEhnyz8svEDw6pD3j42BPhieW0ei10cFsuesK
	 PRJaL0IN5PGzL4x6FlokCRh0NxY/vKVMcYJtgGkJ7Vp2UUl7LNsik4BBhePTBzchx7
	 yafGfu1lMlV2/WZkaw2wkjhbqInWgzUOkEPotHg4t2h7ngk0BfhBH456KiDRZwlqV2
	 efwz6svJqBXrA==
Date: Fri, 30 Oct 2026 12:46:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Biju Das <biju.das.au@gmail.com>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
	Ulf Hansson <ulfh@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/9] dt-bindings: clock: renesas,r8a78000-cpg: Add CAN-FD
 clock
Message-ID: <20261030-automatic-marten-of-painting-f5a3d4@quoll>
References: <cover.1793278754.git.geert+renesas@glider.be>
 <843d6df21b3ed139ec71a702e57fd5b516c139a1.1793278754.git.geert+renesas@glider.be>
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
In-Reply-To: <843d6df21b3ed139ec71a702e57fd5b516c139a1.1793278754.git.geert+renesas@glider.be>

On Thu, Oct 29, 2026 at 02:11:06PM +0100, Geert Uytterhoeven wrote:
> Add a definition for the CANFD_SCP_MAIN clock, as used by the Controller
> Area Network Flexible Data Rate (CAN-FD) modules on R-Car X5H.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on "[PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg:
> Add PWM clocks"
> https://lore.kernel.org/e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be

Maybe just squash it there?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

