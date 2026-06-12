Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63F93932DB
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294022; cv=none; b=Tk3jg+2dHGWHqJBoSsXXBbsGOJtYeoe59bOJRwVk0YCrqPFNTfCpL2823TdyMvv3cC+DUOGCKuzzIyGxmPdm4mQ43riTArNvFYCD/+PhGixk2kQK9YxZCJuiWFfNx3cEDkUphm/r67Ko8jAEpqCNvZwW8JzTxoG+DL3xoG9EZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294022; c=relaxed/simple;
	bh=6ycOKslm6ox7fWEYdeXlmaXfYBqt/AvVmZ/iOnK6L0k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=vCBvMnxLTtUISQN+EKWdZ6/FSyZ0x4D1E9MiDvQo2+m4XYbJZY+KpWLr1N0FvK0Q/fiPn/1Sku9Xb32sdZw6XTu9fL3rcZwL5aMxsDC7L4K2kwwTkyi8l82UkcrPqZd0SdahEtcO5Bkp+huJJ1Cx0w15CussWhCpkceVeGxg7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com; dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b=WMkHyU8d; arc=none smtp.client-ip=121.127.44.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ubuntu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.ubuntu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ubuntu.com header.i=@ubuntu.com header.b="WMkHyU8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: Cc: To: From: Subject: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1781294013;
 bh=pPU7Ldw4ipIoEcVrCmQaXXpe58uZWSTdE8XRrKsUz/U=;
 b=WMkHyU8d2J2ySI7kRHeBMgvakumTxei7u+EDmIrUp0Q4Bz4xNUOBGyjbuCW90lR0AywLcbYKk
 nS/2cxlHZKUcQa6stIovYQYMb4bpkZOgVATAtLm95NzdIXkeipeCpxMlt2CuwvnshFr8ejL2e1c
 7WrTD0Mvgeur4xOy5H7rYO7ZeAk2LPhjgNzhp6tGoM+FROBvfI1fv5PU2p8RDXcHv+WDFA9XgO/
 pssc5YdEVBEPYJZZT+ykccV7bZU2UIdpVuNXH59mFoQ1YxzbWSQDEaLK1PuU6JgY8772Xr5rgzu
 DrtA9IJFb3kvNs0Gr9ZLcjxkZflZ1Au2bkhSs1POCiAA==
X-Forward-Email-ID: 6a2c63b8edbf0df789293751
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Fri, 12 Jun 2026 15:53:27 -0400
Message-Id: <DJ7C0Y4EREJC.3ISWKDCT9I07R@ubuntu.com>
Subject: Re: [PATCH v2] power: supply: macsmc: Support macOS 27 SMC firmware
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "Sasha Finkelstein" <k@chaosmail.tech>, "Sven Peter" <sven@kernel.org>,
 "Janne Grunau" <j@jannau.net>, "Neal Gompa" <neal@gompa.dev>, "Sebastian
 Reichel" <sre@kernel.org>
Cc: <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260612-gate-power-v2-1-de76cb9bb7ef@chaosmail.tech>
In-Reply-To: <20260612-gate-power-v2-1-de76cb9bb7ef@chaosmail.tech>

On Fri Jun 12, 2026 at 2:36 PM EDT, Sasha Finkelstein wrote:
> The SMC firmware included in macOS 27 changed the size of BCF0 key from
> 4 to 1 bytes. This key is used for indicating that battery state is
> critically low.
>
> Reviewed-by: Sven Peter <sven@kernel.org>
> Signed-off-by: Sasha Finkelstein <k@chaosmail.tech>
> ---
> Changes in v2:
> - Addressing review feedback
> - Link to v1: https://patch.msgid.link/20260611-gate-power-v1-1-8a6272108=
6c7@chaosmail.tech
> ---
>  drivers/power/supply/macsmc-power.c | 35 +++++++++++++++++++++++++++++++=
+---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
