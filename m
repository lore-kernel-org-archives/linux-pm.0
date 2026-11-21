Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296831;
	b=rNdRhqUOjnfkxZH8D0oNMm2Or44rt7t6/SmhqHtk2MDl+L8sp8AAXXK1/Ps1BR5F2nf/
	 QL8PBsWxOaInzJeGi7JHTtybHe81s+0W9b0IqNsMzNKjg+BssrXyFmSy1IKxtoUBBBI1f
	 gyNj18mVT0CqlOPmcibgphMTwEYrjXX8etuD/Y2ak39tMMMOrE8TxsekMg7MqJrYCj3Yl
	 csdDBHoirkGXji5QtIUnQNH3DcXwfxMgoOQlco1nvT7yqC+NvSJ5jLE6dydhaWaflLNCb
	 A8GOHhCETTxZZfqPx8VAKHlxg9/OsO663Q/z5Ifq8Nv5k0z7TpczeU40B5Y1SpW64hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296831;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=EBKyHMfdujVL2NuvVZoYqEWIPUlfHYqOyiE6RI/ytpY=;
	b=H03kh6AOKpeqz7kXJIFPmGmjdVuTDsko7MTlye8Z2cNwNUcPuU5CA9oJOeqorRB/PRPK
	 jOd9X5J75FPC+ntK0Yboof0zEirRTZ8IiPczsvQFIwwUZLD8kfJ5qpTPYkoxYgaz7cIFn
	 Qn4HXFxf6wT8pPEz/cMtA+8aKI80BLgvjid8hQDFGZ4OQcZTaMj3y7tBO+YDCwn2NVFfq
	 pAHPHpD7ots/1qqNvb5wrvvnuRT98SiVtc6odq9VOG/ebhYbgd7tjwcoA8/9HQfCosuOR
	 EQDqMIXiGPKAZaJYnRkr128Qzj5+Ri1TJgTgHuXDmld1f+phpF/d2x/2auLTKDFyLAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=Cp0CZ275;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAF606A320;
	Sat, 21 Nov 2026 21:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14CAF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=Cp0CZ275
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88B161D870B9;
	Sat, 21 Nov 2026 22:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795296829; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EBKyHMfdujVL2NuvVZoYqEWIPUlfHYqOyiE6RI/ytpY=;
	b=Cp0CZ275GjSprFXJcs2D9SdwXdBz3q4iuvqWQAUF4YIjNacU7lDj4AGKxBz0RpM98h0Mvt
	JJQkAgNSjd59sjfsPntC0oTDbluAAKmmPcThSgoonVy386rXVAC8B/YAYmdqw29QRqMPfH
	XD2ymgRU+p3/Ly0DBObfXZBC8Ii1oPlQ0O6ZprVM+zktQaZitURvn/dwjwud/u7BCynXK7
	jB9lqeO2LmvY+S+foA5YbVcTFtOZ777B5flRImzmwbB/rB/r3Y3NEX0/2qCvvy/aevCqbx
	yfM2IZ3kuteN+OFrBUQTJn66xbH6obNO9F1+FBqrtXcKHHX5eMJLtnFREe8t/A==
From: Michael Auer <mick@yoxcu.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] power: supply: bq27xxx: report discharging at zero current without a charger
Date: Sat, 21 Nov 2026 22:33:39 +0100
Message-ID: <20261121213341.865904-1-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121204137.848173-2-mick@yoxcu.de>
References: <20261121204137.848173-1-mick@yoxcu.de> <20261121204137.848173-2-mick@yoxcu.de>
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

Hi,

A sashiko review of this series (not mailed to the list) found a
problem in this patch that I can confirm:
power_supply_is_system_supplied() also counts this battery, so on a
board whose charger is not registered in Linux it returns 0. A full
battery on such a charger at zero current would then report
Discharging instead of Not charging, the case that commit c3a6d6a1dfc8
("power: supply: bq27xxx: make status more robust") fixed.

For v2 I plan to use power_supply_am_i_supplied(di->bat) instead. It
returns -ENODEV when no supplier is linked, so those boards keep Not
charging, and it does not read this battery, so the check can also run
in the cached update. On the OnePlus 6 this needs the gauge linked to
the charger in the DT (power-supplies), which I would send as a
separate patch.

Patch 3/3 needs a fix too: its status fallback returns the status of
the cached update, which has the same zero current problem, and which
is never set on BQ27XXX_O_ZERO gauges.

If you prefer another way, please tell me before v2.

Michael
