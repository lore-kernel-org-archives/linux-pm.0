Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585816;
	b=4ZZc/sNoTEfD8tuDUQ7f5L25HHLtPh4qCBRB3Iyfbz2SnlUUfyv1jWBHnE/KF28g3IhB
	 gHPZTuK8lZnbOv960I3qrISX2cQRvzJpBxKsu+0EeNbnKkgDj6BcmWzVeZKp5M+F5GDze
	 dlYzLzJGHbOkZEEPqyxR7Xwz/fX7fYl3yyDMudULkP1z6Vqspoba3XpO+uFUGSoVllMCL
	 1nqOvS/3EJkPQOanaGdAZ3v4MdHxMMl4UlV4FyV2KcXlzA9TZHL4g4ouSinsFtFbUhfPs
	 6jUNa99zwFGJ8czmDfK2DSOQcXQ7SrSAKOXjzHDiRKNlphglOS2icT2Z+Rn+jrKYNew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585816;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=RhI4nQ4XKSj9VLiETSpLtJTrfU+/DWOouSPKVL4WRBY=;
	b=TF/vsZBqRrC6gs5nrhkXe9VRIIvCz8o49S5i8EMweJr544MeBt5BNHTm2otNSvh6/lRe
	 r/fzQrT7GJkha13A9DJkzDugxrRsIDh6n9iEIP2Ksj/d/oGZCUH0orgk4k49KrsUaHzDv
	 Zpxwh4kDTLAH8nudqQ1gUOT1yjE2qOrzHNyeHKTNPn5MiKxrFK/fYfHKZeMhCl8t7EZ+B
	 eHRhVHRBd2AA4xaSXR2oTiWH8ji/qSkJGY89vEI6XzEeMuBj4gFthgxV/lHls5dW1psEX
	 9TqjxtOahLVZvPutlzCs/RmPU9TujdtxuOj3FZoWGJ5Z5+DeH/tVFJDyVTP95uH0ZjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDRqarTR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8598C606BA98;
	Fri, 13 Nov 2026 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDRqarTR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB711F000CA;
	Fri, 13 Nov 2026 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794585816;
	bh=RhI4nQ4XKSj9VLiETSpLtJTrfU+/DWOouSPKVL4WRBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iDRqarTR8tS7X84ceTlEzYzy475kdu/SiDER8+osdboQ5UBiVytmybe/zFavofpsQ
	 R6fpcf5/355+3FgOlLJouoK/HF+2VVp1Jv1jMSdjUIL8GzxXuGC731l9EyxCw4PaWN
	 9TrCmhxV7PMd0i2OK52pNqVmMHa678Zw2uKra8Wz1C5w1RBG/ifb39bnybbPem/qw2
	 2zL8ODaPvg+rq+vnf1VbO55lsJ5fCg0jxLzlhBn7mOzwlX3ONyKBfOCB6vpzNPHuOx
	 wMMij6gVKX+aUrXlSS4B+DsyLT3mZnEB5mARNbgGLRkWLVxgzq5tgUPtPBvt5G5HXY
	 NYu/sLFRXvdYQ==
From: Lee Jones <lee@kernel.org>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org
In-Reply-To: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-1-9758f38d7053@gmail.com>
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-1-9758f38d7053@gmail.com>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397:
 describe the RTC's 32 kHz output
Message-Id: <179458581213.82278.2659730023660991839.b4-ty@b4>
Date: Fri, 13 Nov 2026 16:03:32 +0000
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sun, 01 Nov 2026 23:33:46 -0600, Ryan Brue wrote:
> The MT6397 RTC drives its 32 kHz clock out of the PMIC, where boards
> use it as the sleep clock of a Wi-Fi/Bluetooth combo chip. The output
> is off unless something turns it on.
> 
> Let the RTC node provide it as a clock.
> 
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: mediatek: mt6397: describe the RTC's 32 kHz output
      commit: c91c3c19d56b9f1c223963eeda275a28cdeb71f9

--
Lee Jones [李琼斯]

