Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784589;
	b=J9FKLe+ili85qX1xr97B9w3oX7GThkjE8O1u6U4r8u/7Ce7rcci9/P4HCCzdcTYG2j+7
	 JjIWAAPE3mOc3Ulv3PMeSNAD/GT3YrPcXxu6e5rwJ/7U0NiY2t8SG03EYbdNCsgSLFrt3
	 +CIwoYsMwm+zrk7LVuGis+oEhDvec1SqRPPs+EbzWN/MLR9Bs7qfIpoqDvNXGn4/Z4c4Q
	 MZVDBHXueRWlcS3GvtauaDX4QITE2lv11vniru4MEYycthnfBl2kX/pSsDoy9FYjHCre7
	 PEOYRp6aL0jkJihffLPWHLmuszcLDkLWYfmCGIyUk6TTRXtEF1WX7RfUOUelimvLl5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784589;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Jm8JkLWFTkAi7vMQBczoHP1PrABPUS83AhUkdZ/8e/k=;
	b=m+zcms8oPeq2WO+ScD6r65K8k+p5VnmctSZFYxLYoIgx4yhed9l63/H1nBVcv2/y8yre
	 7Yau6D+7Dly0gPGyjXUu99/jaxpIQtCh4fh5i4R3plM2i5MrWVUsXWs55EXOvJKC7xX3r
	 FDR/oHRUEAHIOipqMpSONJRpeGH11r+doMPmu+iPE4DV3eL1dn42YKj8a5uXeylAnI59w
	 QCp/sPWgOvip+kD3PpFFoIG6TdjwlgwCX+gXE4Jdwx7fQlY4hdq4wyhjGIHT1907Kyqon
	 GzXLW1WVHFb21aISjM922sR5+l7wtegBduhPiNzcol13YJnI3tl80rkWxCco+Yeg9nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98657606A329;
	Sun, 15 Nov 2026 23:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1834A1F000CA;
	Sun, 15 Nov 2026 23:16:29 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 9A4ED181BFC; Mon, 16 Nov 2026 00:16:27 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261112071634.154426-1-zhujun2@cmss.chinamobile.com>
References: <20261112071634.154426-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] power: supply: max77705: Propagate battery health read
 errors
Message-Id: <179478458761.205616.415554725735334409.b4-ty@b4>
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


On Thu, 12 Nov 2026 15:16:34 +0800, Zhu Jun wrote:
> max77705_get_battery_health() decodes bat_dtls even when the register
> read fails. The helper then returns success and can report a battery
> health state derived from an uninitialized value.
> 
> Check the read result before decoding the battery status. The existing
> health and property callbacks already propagate the helper's error.
> 
> [...]

Applied, thanks!

[1/1] power: supply: max77705: Propagate battery health read errors
      commit: c2f011fc1c5940920b50e6993f68a695315096cb

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

