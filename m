Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BE53A8723;
	Mon, 27 Jul 2026 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157510; cv=none; b=oc/wfTZnqMLRMN+pncd3VpSqfobD8/4BEvkiHNyjoorDCB3crD6jE+cBz7G5Va29ExGd1AvPpono1bWbGi3ItW49IRugnuB4Hm97lPCajbFNGfQp4INDpgquKr2EbrJL2+z+e1Si47StwnXMU0HyetpMlojS7/sOjspSvAEVs+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157510; c=relaxed/simple;
	bh=6CksDhHD4eKRMsWogMPUMLna+oUT8V4fEyevu0kt9uw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VYdQfKrql2Jts9eONBXn08nD6sMW3QRR17pVBM0xEMMUmyPSNlGxPmvuTSbHxH/pJuqbQM7IvAeq81NV+zerVrXkJwMGNG+F67wW1utRI0CRkkKHiVcDVnbSqwjOUGPCtrbYJZo9aixiJWE/vjFocM0CuO1SWKSr5MYBqGbSPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40071F00A3A;
	Mon, 27 Jul 2026 13:05:08 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 8796618090B; Mon, 27 Jul 2026 15:05:06 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260726072206.7-1-bbnpreetsingh@gmail.com>
References: <20260726072206.7-1-bbnpreetsingh@gmail.com>
Subject: Re: [PATCH 0/2] power: supply: sbs-battery: Fix the shared serial
 number buffer
Message-Id: <178515750651.21558.7984059994326193856.b4-ty@collabora.com>
Date: Mon, 27 Jul 2026 15:05:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 26 Jul 2026 07:22:04 +0000, Babanpreet Singh wrote:
> The serial number of every sbs-battery instance is formatted into one
> file-scope buffer, so concurrent reads on two batteries can make one
> battery report the other's serial number. Patch 1 gives each device its
> own buffer.
> 
> While rewriting that sprintf() call it became apparent that the
> conversion is also the only W=1 warning in this driver: the value is
> carried in an int and only its negative half is rejected, so gcc cannot
> prove that four hex digits fit the five-byte buffer. Patch 2 casts to
> the register's actual width. It is a separate patch because it is a
> distinct (and purely cosmetic) change - please just drop it if you would
> rather not carry it.
> 
> [...]

Applied, thanks!

[1/2] power: supply: sbs-battery: Use a per-device serial number buffer
      commit: 6027892925b8d19d2245c2d077e2ae35b49cc2b1
[2/2] power: supply: sbs-battery: Bound the serial number conversion to 16 bits
      commit: 645448becbd0b52216c6741897dd412f9ff1b925

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

