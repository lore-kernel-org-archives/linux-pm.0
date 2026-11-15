Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784589;
	b=Bh4cCp63XvaiTISZLNykBQQmnj2Ym1SnTy0DHk42OquqjC3cQeKdYKSQ0IAeu0qsOskQ
	 PkJkXA01FreIEA9B5h8Z8effC5dD1IANGb4eK+oBmD4g27Dc1LLDMmPOwLilaB5U1YzR0
	 6toE9wfUV2eHRPdTTkdn0KeuNBeEcskuKdTbkN10dtlRNcSJ5ckIz4bce9R+DELp8w0FV
	 0penarYzZIgS1Q9sL51zKBp34B45aKVDR+qq3UjKGYc9932I5XywJdTIz/CshLDW+FVUw
	 rThEN9NI6u+PjPL1BUptWEAAA18AG+zmA2RCOiIx8HBAEW3gFmdiXorJnkrzIaNpOmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784589;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=JrTdSg4vZD7mK2oRGlVfshHa6kogWTh6d/yF+oX+7Vc=;
	b=hZsjWx9if75CLWClSXivIvkVD+KYqsoruwrCek8t9EGDqNhte/1dze2YohKnX44hGY6V
	 Vpem1dKNQAhVJ0MtC7kVtwdPh9oV04/YSaFYiA7G35/m6C3EGsxu6R1cyuCI/8VEDLNJ7
	 F4RiX+UCcWrIEyTGv0SalQSp5NHFjEuKToZBGTA72gCSdLK5MaqvJNvBLwIS0qLZoKEeA
	 9wWRHwP/PmbIpF2Wq43+ku0/qJBNr01hMN8tdo6Ng/wzZMQtjwMUhc2jr22KujYKNvZFL
	 af1mJ0drs+iJgYcqzQjkpqdbvW9ovD61hX5Z1ye6kwLc9tKh/FSg8AF6chAfuCV3BzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985AB606A31F;
	Sun, 15 Nov 2026 23:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC241F000C4;
	Sun, 15 Nov 2026 23:16:29 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id A0E85181BFD; Mon, 16 Nov 2026 00:16:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261111222124.1035303-1-colin.i.king@gmail.com>
References: <20261111222124.1035303-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] power: supply: Kconfig: Fix two spelling
 mistakes
Message-Id: <179478458764.205616.10991046626009385263.b4-ty@b4>
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


On Wed, 11 Nov 2026 22:21:24 +0000, Colin Ian King wrote:
> There are a couple of spelling mistakes in the Kconfig text, fix them.

Applied, thanks!

[1/1] power: supply: Kconfig: Fix two spelling mistakes
      commit: d44db44c15b988f20d0fc990777980899c6ef06a

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

