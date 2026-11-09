Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187381;
	b=SlqCd/2drQsnUmEhxfN7dURcplYmA6/2yDx5owFjDbKlgKUmXydK+oPKObcYyFoeJoZK
	 qbdj8tYND8ujIVWXaMo6h+YvsLzVVUmSzVL1H1SYM+IoNSp0Ou2+oWhGcMpsMCKN8ejWO
	 m2TA3IuGZjzDYwdv2cf7Vtfa45N1OJoKnj0enMDj8z/MEeEaYkJk8hSswZKyewXtAg5k7
	 hFvK1ma5TAOHfntivoh7mx3sF6BuOqfdDGtHShnKaPPTSSng5I/30WOXovYk8iuewbLOb
	 kaheg5DP4LuQSHj3WYStFuiIEJygmukDhK4tnZ+5/fUDgqUXXhjXso7yIEgL3ThyNnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187381;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=ne2Oqeb+HzEgV5wPcPzxiKzBHQIfSA3Hu1s6ns5DPUw=;
	b=RggiBxF41+Y+4/nZKa/En2m7v+g+Cw9h1nc0V4MSY0rtmL5w/atPm2aLvE6ZczNfqwbO
	 7jfvLI8e4w/rYnscp4z9NU7u3DYhd9rqIfZ4HaInARoECQSLV1ejf6u+gYEkrbTAvnH7K
	 ns711EOyzYZndJhsJ+nOALHTQRt5TcodIZfCyDeWMP+lMPEJ7rkUeSwToJVVrRNLb1V1H
	 6TvE41nlcwm0ffL3YhHR7bhUzYGIqyB0vVlCC/Nv3j0mrce6thIGTucKXYpVah8ZW2gtq
	 bFng4XHFP3P0wfalZkXmv7QxYo7Suehrz+gXJqG6iS3hHsBe/eBgwmVLDhDH/cafl+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109F608360D;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDBA1F0093E;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 2F73B182C53; Mon, 09 Nov 2026 02:23:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Henrik Grimler <henrik.grimler@axis.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20261102-bq27xxx-cleanup-v1-1-8810e411dac5@axis.com>
References: <20261102-bq27xxx-cleanup-v1-1-8810e411dac5@axis.com>
Subject: Re: [PATCH] power: supply: bq27xxx: drop dead data memory update
 code
Message-Id: <179418738018.1255445.6585327622861263835.b4-ty@b4>
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


On Mon, 02 Nov 2026 11:19:30 +0100, Henrik Grimler wrote:
> bq27500, bq27545 and bq27441 had some work done to enable data memory
> updates in commit 05045379b274 ("power: supply: bq27xxx: Enable data
> memory update for certain chips"), but it seems like it was never
> tested on the hardware, and the code has been in #if 0 .. #endif's
> ever since.
> 
> It has been around 9 years since this dead code was added. Let's drop
> it to give a cleaner driver, as no one has apparently needed the code.
> 
> [...]

Applied, thanks!

[1/1] power: supply: bq27xxx: drop dead data memory update code
      commit: 500dd9485bdd748d7017b9079b1dfd9826ee36db

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

