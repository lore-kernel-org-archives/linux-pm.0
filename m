Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187381;
	b=5ZE8onJF7LzaalSidC6fm9cApTRzy9W4/Hk6N4SGHe+8en40M0ej2x2U5wFxi8zaNfXE
	 ck9hcqY/0zw0kHguWtpWxLIajC/n3S/3GKxAJywZtLYK9/kPILzyXFWXM5iRWXn/Alof6
	 mPOVkM45fa22kb55W563trs0/Z3WAcAVL+WSwZWOCp+CviYjfAaOY+1Z79TvlC/f1zxhY
	 JoMlkWoqb564og+QQvcNCnXi2tRQi790o4JSvfr98KfFEKsj1fOV4xqDhkW75gVR1OE++
	 xV6u2pKW1CqSkdzKGYvO3D5oLewZm25U/wuMuB0cmkiSFllBDOupE7FTRbAp4/j2CUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187381;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Of3iJqiluZkTJ9hCFu5/zhmrX5Vd/joT8s/wVUbN9Ro=;
	b=ltuUYbHd0NABgWgn697w2Ntlhu1hrfwcubLDVceuESeigsjF5aSfxwMHWHGKrETWu50M
	 Yxy+bKg1fRdQeQTv566UuqRKHJF/U8dL2YHRFYTc8nDbFsQextBF3UI3RN/aVSC5zPXUY
	 uSVTpMaAZ6KqJzAywFMrNWW/enCQQjBfKIYNoJ7JlDjl280x7ZGVesEM9TzDz/bS9nULZ
	 te8YIOsEGRv8nyAjJ1l+2fwu78sAQXRg81/Q70hKM/t0FC43fIcvEPwqncVDS6IBnkAFZ
	 +vqTVx0rgQSlTjFFQZlEKi1AA87Fj48949R06Y0B0PSYeEj3tP0LF8dnyy4NMhImgJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810BE608360F;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E961F00A07;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 00DC01828E9; Mon, 09 Nov 2026 02:23:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Aryan Sinha <sinha.aryan03@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261012154614.42203-1-sinha.aryan03@gmail.com>
References: <20261012154614.42203-1-sinha.aryan03@gmail.com>
Subject: Re: [PATCH] power: supply: sgm41542: Use secs_to_jiffies()
Message-Id: <179418737999.1255445.1832705224370639520.b4-ty@b4>
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


On Mon, 12 Oct 2026 21:16:12 +0530, Aryan Sinha wrote:
> Both watchdog kicks are a flat five seconds written the long way. Use
> secs_to_jiffies() from the same header instead.

Applied, thanks!

[1/1] power: supply: sgm41542: Use secs_to_jiffies()
      commit: f7902a97d9b968a1731d0c6573aafd1de80e9043

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

