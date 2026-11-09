Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187381;
	b=rg/bnwpBqcVJuDKet7EUvbyddn7fkITWPe/3198KXtMCUNI9N7Vv6sJeiBMMabDcrzSW
	 /SefPnDVGMQqZG0kuj+sAMXbT4z1CnSr3hAleu1yZBdx2TP5Ucl0UDsegLvVUB+TGtKB8
	 nBODUYOaFDcDgW6zjMfjFH/q+GV+GMZIimxGnDz7HfTDvHCr7UMuZ0BZahFO/wjVO1Odh
	 2DECiHJ1NoVmCVRvn7BYuRRoIGAYW7X8+BEDAaB0gHqVxVpdVpQ0aIp3AG988/fxznhp+
	 jk9Tr+wBr+6R2LwU8owirmH4hEZ6cphNktXyX3RGVo6GLv7p0gwRIza6EboqUhVfNDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187381;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=yCrp5mmoOYL3ThpTjPMXombRU770Awvr6lmq6HZfLds=;
	b=YouhgkY3m2n9Myk8BiEwF5Lqd8ALni2nPgSAuALPn4trtdkNBCRZWdhUECW++nmv9Uxm
	 AcmZqSh4CjcBTtPWu3NXsphoClI1qSFTK8xVRYkhkg0YmE0USXJtQhI4LXxmI/8+Bxow4
	 bbqMUeUOmKMhjeYuoNQ4u3qI+pRqNzxTaiw9U9ns0mFF3J82Munrc7ZqOGEaPQN55Mpd+
	 5BvKrgCn+l/OAFXPd4MAE+MEeuUOvP4Rozy9n0R89lZPgq/zfaaBXsZ2aYYW2sdXW2hvR
	 qn4hdkx0ho1LQx0SidxED20xRGLsxHMcl1Gob/Nkx7oN9IrSoc/ZBs8UkDKOl98/Ccg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965F6083608;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E5D1F008BE;
	Mon,  9 Nov 2026 01:23:00 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 103FD1828F3; Mon, 09 Nov 2026 02:23:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261020-topic-usb_temp-v1-1-3dbe390f9834@oss.qualcomm.com>
References: <20261020-topic-usb_temp-v1-1-3dbe390f9834@oss.qualcomm.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Expose USB connector
 temperature
Message-Id: <179418738005.1255445.8077547264961176103.b4-ty@b4>
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


On Tue, 20 Oct 2026 15:28:08 +0200, Konrad Dybcio wrote:
> The firmware is capable of reporting the temperature of the connector.
> Expose it at the USB supply.

Applied, thanks!

[1/1] power: supply: qcom_battmgr: Expose USB connector temperature
      commit: 23404b2678f38e8d086a127f879ba02078011393

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

