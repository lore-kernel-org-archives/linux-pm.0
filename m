Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795378629;
	b=J86cwPhlJRCtpdSfD+nsqnghl9J8Ioz/CvJ3Bspnhy9nETWwMNf+M8x/chT9wgUX2lF3
	 Uk6XqqzsNJ7NKz/Lx8iEoeAB0Gl3obExsfIq9JbOmPGKXXrG1A9Z6E4BKVR5FiWvnDjL0
	 3FmN7KYBbkK33zWmRoqsZFLweCi2ML7kisIjSw71Q54E9+I6v//lpEnyszXIhkXWO8GQo
	 ZR5qEZB0DWbCJ3/6QcKjhzgxdndP5B9vjb1kPWbe3yUGS8epDI5aAwWTwbMvXKEZ3lDK7
	 Qd3x4duUKDR/kWLfzQ5Kzo/9Vhdm0wbyLOohk3q+cg1mkTNgjwADUb/MVWcrKOiEHiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378629;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=MO97S+4fBQqNiCPsH+O1ZpkFaaKKwzktkQsIGEO0hr4=;
	b=IbkOBqYZb90oUKnL95TjCii1pgc++9cFkHlcCSPNYnft4FdWQGxUlz9ScuohEU6zbhxw
	 +CU+auOG8Qvqc4ebeTi65QDsV6ikIchCNEHEUH1ZLXPuLzkO1TxK1xGjNaQ4ltTs//5vh
	 7s6c20XQm0ge1CPs4dQjuNtKSEhIVJd6ltCnMVKO3oGJdhSiFTMFn93AFaB6rIZTW3ktS
	 SxMLyteJReMAXC06ZIFn4ucJHkNno4Pu7aBAuDd0VIkQtYCtBuTGGWxM5lN47b1L1oEVw
	 98jVcexVSYNXgXBk4bb2E3RGnFB2FTCz0ItTsL+Cz+IoQy/lmLxax+EidnqxAB2R4fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=fmsuWwfi;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13BC606A31A;
	Sun, 22 Nov 2026 20:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A13BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=fmsuWwfi
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C5291D86D6C;
	Sun, 22 Nov 2026 21:17:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795378621; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MO97S+4fBQqNiCPsH+O1ZpkFaaKKwzktkQsIGEO0hr4=;
	b=fmsuWwfi/TRi7/1jG+i1LzgBalhAUMPIGrswpE0nlXWUhl+BWv8ngscAN+I+xwtUdDitQX
	ezLV9SyeOBtKRXeTDs25PtvuEfQLnGaxTcfAWO+BGWp1DunM3RgWaEDl9fYvMrTJnmMtQH
	Tg3hUTrq1E+2P2GyQ6q8PJLthdyhoZh86D2y2HnJ091IWJ/0jDi1+9oGDky96QJXFOdSfa
	YpNc7G2r4d5FKrA95a/FIEn1Lfv4p3AJqP6A5AuFRHeU8VB9QPSrwyVyJY8Q9fn0+ZbkQT
	Riucox8Gd2FhYjK5/GYq6OjD21otohvE+AHiIxKARfOrqoWbjO858/dheUqanw==
From: Michael Auer <mick@yoxcu.de>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] power: supply: bq27xxx: retry a failed register read once
Date: Sun, 22 Nov 2026 21:16:46 +0100
Message-ID: <20261122201650.1155371-1-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261122120341.runjq4rjjgvob5y6@pali>
References: <20261121204137.848173-1-mick@yoxcu.de> <20261121204137.848173-3-mick@yoxcu.de> <20261122120341.runjq4rjjgvob5y6@pali>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Pali,

On Sun, Nov 22, 2026 at 01:03:41PM +0100, Pali Rohár wrote:
> So... should not be there rather a resume hook in the driver which waits
> until the battery is ready (instead of adding retires on many places in
> the driver)?

Thanks for looking at it.

The read that fails is the first one after resume: the flags read of
the update that bq27xxx_battery_resume() queues without a delay. The
OnePlus vendor driver waits 1 s after resume before it reads the
gauge, so a delay there would probably avoid it too.

What I do not know is how long the gauge needs. It failed in about 1
of 350 resumes, and the NAK is the only sign, so I could not measure
it. A fixed delay would be a guess, the retry does not depend on one.
The retry is in one place, bq27xxx_read(), which all register reads go
through.

For v2 I can either delay the update queued at resume (for example by
1 s) instead of the retry, or do both. Which do you prefer? I will
also log on the phone when the retry fires, which should show how long
the gauge is not ready after resume.

Michael
