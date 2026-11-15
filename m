Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784591;
	b=xDI6KnHgoAd4j1fo+dH4h9I8ejxD77npgU0aTwNdG2QXi29CEOHoB03xAQF04KoZtk7+
	 RDTjVAWJO70SS/lQ/4ulIKhnUhelk8468LYVcWcVNzRWCpWxZ2EJeGfTL8KvPez4+OqWc
	 Chg2UuctXmLbVmvmdgrH/7mHA7GoDqyU0CZU7HzUEfIzxnDKasLejZdDaHb5+ReiEEMx7
	 Juwb4VagovcYZEQyHCnr/KQYDyt+7isWaqUI0eDe88oLIHdaxygNYs7dztQNxFe8qHhGT
	 Q+OiPrapaGiNA/KcqeCCs28W43boEe7WIHYDDRQXCGsqjIGhNrfhhcDDtsS6W+GRsRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784591;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=CDe7R7KOhrmnzYpgxMPa1GyIRcHKkSqfUZlxkONWxDk=;
	b=wj+ZIE2p3RlrOwO575ccHOueAS77LNs6CYEVIB8TPzqwgwYIiltCp3d95QZK10lne/Wc
	 +Iv2PQ3NFjMZ9fuQTHaaxqIWVMpFVlpvklOdYZFrJIRimSZ4iI7t26H6yktTgPmX3giPP
	 lBf5cX5EJKOCqpzfqW1XJUcGXUzKW69q1wheANI5YbOXcIJUwGp8XRPQ7Ags6o6Q0Y+yj
	 Cij8caYgim1JW3Y6s/xrbjill01D6zVyMxRDhKlaCxsV4MaGc8uD53n4a8op7Jn04M7ag
	 THyA/fIF0ZAiMiSgkjxX+R9+dXEfH8wMf6iA7QbtatgBUBAdV68vU0stRDHTf9ShtYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396B606A8A5;
	Sun, 15 Nov 2026 23:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE82A1F000D2;
	Sun, 15 Nov 2026 23:16:30 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id AF91A181BFF; Mon, 16 Nov 2026 00:16:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1793223841.git.waqar.hameed@axis.com>
References: <cover.1793223841.git.waqar.hameed@axis.com>
Subject: Re: [PATCH 0/4] power: supply: Add support for liquid detection
Message-Id: <179478458770.205616.11288775383743768883.b4-ty@b4>
Date: Mon, 16 Nov 2026 00:16:27 +0100
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


On Wed, 28 Oct 2026 22:56:13 +0100, Waqar Hameed wrote:
> During discussions of the development of a new driver [1], it was
> concluded that a new `sysfs` ABI for reporting and controlling liquid
> detection is wanted. This patchset introduces this.
> 
> Since there are currently not many devices with support for this. ABI
> for setting/getting detection threshold values has been left out (as
> discussed in [1]). Hopefully when more devices are supported, a good
> common way to specify this will be designed.
> 
> [...]

Applied, thanks!

[1/4] power: supply: Add sysfs entry for liquid detection control
      commit: bdfb59aa4feb82ebf223ecede8bf0f30e65a7d3f
[2/4] power: supply: Add liquid detection to health property enum
      commit: 422d868d08ab40518786e52468662d8378c8a32a
[3/4] power: supply: bq25630: Add macro define for IRQ cycle time
      commit: 349cebb8378ecd715a9ab0ebecaebe52927bb35d
[4/4] power: supply: bq25630: Add support for liquid detection
      commit: 37909dc2bd09e36056f78febfbc845852de2c33c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

