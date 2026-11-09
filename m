Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187381;
	b=yLJfD7Z4AtCPBnHUPURPCfjSYURtnRjBJkPKMsGwu/wzRsghgeA6xaaQiBctZQZj59Z0
	 yLT1Pp808+QQmEvkpaPrzk5a69xdOqtfll9jw5R90Fkln8KBhKfRChW9w+Zkn+4Zm0csT
	 AWPvlgEaDe3ryntXuxxZncK6AtBZIL9+KIb440u2RVTtflohcvKSIk1dYYZ6Q9QxkqyGh
	 Tg34N7TgaiVp/i6gu2bcLgGA1qmmhCpvGXAWrocDK03yQI6wWafPIzsguNqCbvFcASzrT
	 dsA9AReLIUv8J2aM6YzQEknRMxzeKEZvlVaK71mk6lF4wjHYgQVmwqpxY1K7wXXx/9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187381;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=RNKy7lhZqQOgg6q6qYYGgEd+PrI1w7aXqo6NTrsxp9g=;
	b=lkcV+L3BXpxqLPR3GNR+1ST69lmYncBSbkAyiSs3DXLngZfJnIRXq2VSD+m7Z8tLOwIJ
	 HEUxbQRNrmHt6sPVG54dO6+X1mI7eP1IuvvVavq2IrE8Cw801IL8/6NgFYndsvrxC3XKD
	 j9z+O/a0WZwp1Zamx42WSu74UupJzysPRm60dKwLrsSlRtUatDZmmn1FFD9F4zGiPSck8
	 59rfOyPEJR6krc6KIp9RYDqvmb70TLcPcTQh6JDdv0qTB7soHWd3bZp+qdv1qV9EsMboT
	 6MNAJk966rl+2ES3ubJseTDfT9c1dY/MZUa6urafYmxmNno7JRaBA+wsSUTEtEDY90w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958F46083612;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1611F008A2;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 26D30182C52; Mon, 09 Nov 2026 02:23:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Tobias Schrammm <t.schramm@manjaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Thorsten Blum <blum@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261102110951.229606-2-blum@kernel.org>
References: <20261102110951.229606-2-blum@kernel.org>
Subject: Re: [PATCH] power: supply: cw2015: Use ARRAY_SIZE() to set
 n_yes_ranges
Message-Id: <179418738014.1255445.16816627750361177625.b4-ty@b4>
Date: Mon, 09 Nov 2026 02:23:00 +0100
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


On Mon, 02 Nov 2026 12:09:51 +0100, Thorsten Blum wrote:
> Use ARRAY_SIZE() to replace the hard-coded values.

Applied, thanks!

[1/1] power: supply: cw2015: Use ARRAY_SIZE() to set n_yes_ranges
      commit: bc0652e00cb16384ba72a4ba3cc13c9b57571b20

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

