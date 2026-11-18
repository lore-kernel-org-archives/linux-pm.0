Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795045974;
	b=caYNrT71q0d9fUoM2q+c0g0rDMagymdJjoHbLCQ5++uoyHYqWNWyDJwoazs1YQxZ4WFy
	 C2bEJ82jUDNmibeK/I53rwMz1WdSX19Q9IZqLV2/bBet2s5LpMHX4GF8vPgIxd9la+Lva
	 skitRibVU7RpDd+6vFEh+DwelloOer4HOo7bv68vSheAGxkcDly92RLRTbuQGyxCa7I00
	 hGjYZlOWVuBGqD5Sv6Gm7MXfLr3cOaBH3I+B9PYF01k+/VN/qvQRE2wHZQf2c0KSCeByV
	 /2+WD1DQID3Bo91M0gDpi11dpmbQSifgPSpoovZx6V/7Wmh5lBxB7i9w/jOSh5Tu/Zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045974;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Gk+ft86EjK6nrzTfG2Zrmq8o0cCmcb2geBqF2W1l5Ug=;
	b=d2xmnRNQjOE8ZIeisBQeGaF0YwzEkPKXZQ4JrBEVcufR0ZuFXB7J1SqoTBtMB3fNJH+Q
	 oPyK1QhS0o5hUy5caXGF7APIXXJ3MLaA2CMAfZdtAUcY4OXG/HhVxBw3kV2y8/+JbDJxA
	 uTuOTReEEFdbaf2hhMj5SmWIToSmyrw9DnQU/6nH8SFJVJ5FO5ndrXmKzutPqjaoNR6MC
	 7OkqQhP30Qq6eMqHpNlg8y1SCsSmWku9WqfBs9M2QWiq+ogAqxXF63jA++TsY17UG4YZ8
	 7YrulUGqB0Dns+uMdPMsmMpq9tj5ceJcT4mRhqdCoaQIvuecWWhrBN2a8btFcVtqJQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dA5pLlXn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D86606A320;
	Wed, 18 Nov 2026 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dA5pLlXn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0251F000C5;
	Wed, 18 Nov 2026 23:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795045973;
	bh=Gk+ft86EjK6nrzTfG2Zrmq8o0cCmcb2geBqF2W1l5Ug=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dA5pLlXnQp5LbOI4HWLxN22BrktQ9BxyoBoHiVToDB7qIkJWOZMKtn7EcQW52kq5D
	 RAcB4Mx1M5y4rxMg6d/BfuipEiCEcb5meONntTzXt+rojxF++xQUg+cm5xG/FQssMV
	 DQJUGaJxE/UCCPD578iqWGmcVqWgKYRCm3TZUaaUmsI1qAv7DjHNJdvP4MaqRrXC3M
	 V0NByjow012lgS2Vn3UHEYF3D0Mf+dszuK/JqV1wD7kXBGs2LA9onpcnSVMpjuUWr1
	 FPfdd4IdoiMc6bzx/XN/gX7f8s0Rh4SIz8H7QF87iCKzQJil0WWWEBYyq8kpCpLuEr
	 1I7xoDSfP+34Q==
From: Brian Masney <masneyb@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Linus Walleij <linusw@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20261116-ux500-u8500-clocks-bindings-v1-1-0beed440c3f1@kernel.org>
References: <20261116-ux500-u8500-clocks-bindings-v1-1-0beed440c3f1@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: stericsson,u8500-clks: Allow power
 domains
Message-Id: <179504596334.179745.15793782707727588380.b4-ty@b4>
Date: Wed, 18 Nov 2026 18:52:43 -0500
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
X-Mailer: b4 0.17-dev-8145e
X-Developer-Signature: v=1; a=openpgp-sha256; l=328; i=masneyb@kernel.org;
 s=20250903; h=from:subject:message-id;
 bh=RU93UEPha1BUNhT1V2A6dAMJiRlMdb5BCirrS2xyBeY=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL+WfneWLRLrli+Ydnt2LQFP70ktQPEHi/wvLUj90DZx
 i/VV7SmdZSyMIhxMciKKbIsyTUqiEhdZXvvjiYLzBxWJpAhDFycAjCR2a2MDPdcWU+uVnjs7X3u
 XqrJataZt3jyFD8nLOJPSpW9uOV85E1GhlP2bTph8sr5QdZ3zif5Z/HUqbI2H+B2VxFjKte4ezC
 CBQA=
X-Developer-Key: i=masneyb@kernel.org; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087


On Mon, 16 Nov 2026 10:49:19 +0100, Linus Walleij wrote:
> dt-bindings: clock: stericsson,u8500-clks: Allow power domains

Applied, thanks!

[1/1] dt-bindings: clock: stericsson,u8500-clks: Allow power domains
      https://git.kernel.org/clk/linux/c/80aa3c17a394

Best regards,
-- 
Brian Masney <masneyb@kernel.org>

