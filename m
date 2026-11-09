Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794187381;
	b=di1VWEM6JtOq9OxkzomgE/GWRrpvfPr3w9RFRZ3oS3hbQbRH67bWadtjGX3arZrq1I3Q
	 PYwbRP3qR/Ex8jjRXdciKMPtt9O3taemRt17b5lA21OucqMv9pS/uFeP5+vbDue0K/Fwx
	 qNyQRV78V2vhZmiRfS6uY/WDW1y7WSYNb/6QapIdgm4Aq9+/oGuE16q1iqRtWFWSAEG4x
	 IFtjRLKYu/cUlEOyIiDjnGq3vJ0DVsFl6+PJdiV2PVm71Iv5FrdNNj3Fe5Dr+FfCc6qgs
	 NVgmpuSoa68Bsnwkr9lAI6xZ3hvQYunxQEU5WsEKrds3jyXHWSlY6kJcRrGMhO7Wppw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187381;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=0kVcu/JNDWUktCuDKFwAchMbXZMnSrRaD0G8OkNqLrc=;
	b=EQVHcbjYnHakiY32Dxt4AeN78BeHnyzVtXXa57y+UOzN3sTgrPa+VOytaO8PpbmduIad
	 qTdyxwyjzIdsDUmBJ6UGcHgwezyZ6ZTRcYooROlvp/hMu6ojuVEdZsMMrxe+u43O8+Us/
	 gd0uNcRbK8Rfc33ZrLdZZLyvx/mL+KZozgoDKQEjdYTstp8BS8YSugyH3TxuI0+N6UuZ/
	 UuVmVUIxggDc8w3LFirOP3rB2tKK1cgKZ4KtUpt8ujt7d/ZHofmAh+CUCAh7ATi+yI5w5
	 tlhazHJm1yK1uADyX5HXHdZIpa+4Gc+/AbE1bsrSko0fskpuc4szaBLdJTLz2qLvEfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E76083610;
	Mon,  9 Nov 2026 01:23:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83001F00A04;
	Mon,  9 Nov 2026 01:23:00 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 1F02B182C51; Mon, 09 Nov 2026 02:23:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org, David Yang <mmyangfl@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Feng Kan <fkan@apm.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261026092049.84858-1-mmyangfl@gmail.com>
References: <20261026092049.84858-1-mmyangfl@gmail.com>
Subject: Re: [PATCH] power: reset: syscon-reboot: Use
 devm_register_sys_off_handler(RESTART)
Message-Id: <179418738011.1255445.10152041360397038577.b4-ty@b4>
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


On Mon, 26 Oct 2026 17:20:47 +0800, David Yang wrote:
> The driver registers its restart handler but never unregisters it:
> there is no remove callback and the notifier block lives in the
> devm-allocated context. After unbind the freed notifier stays on the
> handler list and the next reboot oopses on it, observed on a
> Hi3798MV100 board (PC is at 0x0, LR is at notifier_call_chain).
> 
> Use the device-managed registration, which unregisters the handler on
> driver unbind; the DT-configured priority is passed through. This
> mirrors the conversion of the syscon-poweroff sibling.
> 
> [...]

Applied, thanks!

[1/1] power: reset: syscon-reboot: Use devm_register_sys_off_handler(RESTART)
      commit: 808914f0c0141a5e0bd66e13daff7f9d2aa12155

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

