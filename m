Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187379;
	b=3jpirgt5Ot9CLyUcS6yMEIGb1KfUF+WztQpDXdk6dldVlaGxDlO1HfptDCnepMv3JiAq
	 atLOaJoGtCANjILFOFL7g4gObXXCJ9wtB6IvdS/lRgOZjbP5ed5CVBi5I+c5CNzrri/qr
	 BFRunJ/m6rr9TPRjjGEWjkT4T6prD65aJrObCGmVvpkK4BJWwJ8CTdiP9jWVrA67fKJHn
	 edm+pABcvHkQQLMWF75pQUPZaOcXpUAF80LuaP6CvdcAZF7VGMN9QyJfzyyB76N9JL+Wx
	 8OT9/g/m0K+vB3to8CyBkDU5U6EUjUkEzZyafbYBNSl9AFMHoB101wa5+mDHmPc20NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187379;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=FW55/SEokajLiqeCEeRu0WTAFhVTa2z9MYyrn5ehvxg=;
	b=vK7zjHOAhaX4sB5QUt0DfpeZ659igcifUipxzoMAhYEf+YMLExrTRSrg8+2Fvy1Ya7uy
	 fNvnKWE+3ZxTHVwQ1gUUBIAuZpAIeS8yUj/iYuef9WziYRDnSqNVD/aErhzJJFd56i54Q
	 MN6xTbc+0+xdVz+OY3+rjdWetae9NQzPoaqWP6dLD1psQ7XeS46Ke66RMeVUIAOSiHvf+
	 88F3KyuxW4a84/uIsOmLXOUVfCRufoIkWzWH4s5xkFIX1hfJ5d2s/35eIqbb/eybFk9zr
	 oSYFgAkYUG8T/nunO5+zmQZaxiJH0JRvMVNJfM3IP6EDTkgTMiFKVJjfs2qPOid7Tfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6C606D836;
	Mon,  9 Nov 2026 01:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B928B1F008BC;
	Mon,  9 Nov 2026 01:22:58 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id CFD451808EF; Mon, 09 Nov 2026 02:22:59 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260930072450.61836-2-clamor95@gmail.com>
References: <20260930072450.61836-2-clamor95@gmail.com>
Subject: Re: [PATCH v1 1/1] dt-bindings: power: supply: maxim,max8903:
 Document MAX8922L and RT9524
Message-Id: <179418737983.1255445.14225085624677725079.b4-ty@b4>
Date: Mon, 09 Nov 2026 02:22:59 +0100
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


On Wed, 30 Sep 2026 10:24:50 +0300, Svyatoslav Ryhel wrote:
> Document MAX8922L and RT9524, which use a similar charging control pattern
> to the MAX8903. The MAX8903 is set as a fallback for both chips. No driver
> changes are required.

Applied, thanks!

[1/1] dt-bindings: power: supply: maxim,max8903: Document MAX8922L and RT9524
      commit: f4c230aa0932f8713f1b2346c425a46063d16d96

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

