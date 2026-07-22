Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AA47127B;
	Wed, 22 Jul 2026 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706969; cv=none; b=EADNip9OBLBpc7YmhBh5X5T+2KAIzJIr3IkVaoUYblZu/F2w8DbrcnLMUi3/bDpKWngXRpfpivNuahs2mXefv0by7yLlAd9rcFmdCGWTAuwIS1j/Q2OlhY2lx0ua9s9RafAqwI1likFHmyusLrqdRdTXu6qt+0u6ngJAccvPy+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706969; c=relaxed/simple;
	bh=rhR/IVeQON/e/VVaD9lRG06BmJIksqMCeWq7EoMsaQ8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=EpfLqZWvKYYarjxZ1tVUoUhqEwHX/7nrGRZIcTv++G+B0BH350hGwjsUorPCpF766N+LmwWdmsCrgoIFtz0kt0s1S2mS+TfFfFF3M/liFy1BRqs4xqtc60YCEtQbq6+S9JAAgSNPf8UulfSyvHvC6Ki8jK/o1ef1HtE6ngt+vCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=QKp+JNpZ; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="QKp+JNpZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1784706893;
	bh=ob3qR/e2vsX+1qjsXoG7FAFSH5W64ceTqvxJxmOmCUo=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=QKp+JNpZ85QW5ioAKzxWenfnv2R59MLgaiUEE9IzcpQRlgzWNCem8akyfTIRqvJhF
	 yRmOH7MlrW1uyRBDAIYjGMeNy31kjruVcNsgGpvqnnA5eA0RCjLYfEhdqbYYBDs7nc
	 VXkQQsuEcR9EToojHp1QjYwi28w5z84pjbXC6+5E=
X-QQ-mid: zesmtpsz7t1784706885tf937dd1c
X-QQ-Originating-IP: lTD3ycMX/Wwp32bRf60m3b1xQMLcYAzEX37sN8hX1YM=
Received: from = ( [120.237.158.181])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Jul 2026 15:54:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7589895340956616953
EX-QQ-RecipientCnt: 10
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jul 2026 00:54:41 -0700
Message-Id: <DK4XSEPSTY3I.O9ZFCZ9BJGNW@linux.spacemit.com>
Subject: Re: [PATCH v2] thermal: spacemit: k1: add shutdown action and
 reorder registration order
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Pei Xiao" <xiaopei01@kylinos.cn>, <shuwei.wu@mailbox.org>,
 <troy.mitchell@linux.spacemit.com>, <rafael@kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <dlan@kernel.org>, <daniel.lezcano@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <1967d2bcc8fede6fbd25fc8eee07f2873fb41472.1784184867.git.xiaopei01@kylinos.cn>
In-Reply-To: <1967d2bcc8fede6fbd25fc8eee07f2873fb41472.1784184867.git.xiaopei01@kylinos.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M4EB473hmYa3VkLIpdYraaUyE41H4rPeW2jcURyl1coWEmil6ER8NctQ
	eQW6Ad+zsIIguNXv0cBLUrXDznyXKYkd3SNbnTY3zTitTywF4tV0QYw38FDWHmwV/5GF/GA
	Q1tD+Tlr48iNKpEjS2MIBdMSvqn/w3/PdFC0XBHhKUjGnQ10qZHcGVYHLSFt8GdM6kXgSTJ
	rwhKpcsjsaOG31ojG2aNZTwOUk3IwiKOJ1pSGns5hvYn9Iy0I6wufz/jH5iF5yTGt/hTzAB
	PAzsil8bK94gDYUg45iHhHL3wUFp58COEqJsVbPpb/Wc61nfG1yBPD/BQ1Co8LPJ90jQrZd
	00if9Umsq5qfDUtUk+/8yaeZzUzORFWY9tOvMnXtOHi8ESReG6REO3H3DQC6FJlvStfEpCQ
	YMn5+5BWmMxaysPcCHzzHT+NsWhV8+mLju/1ttkRPR8yyzNp5YwliFzahUZ+nEaHTNCCb0W
	nGvx9D9LzEygJy/1+mYWnrnTDYBqgwcgXDFe3aSHP0ZA3fOJR/N1n0faBh3TxsbEgj2ylX7
	BSotYi2AWOBPYgQ59K+AePZw7xBiVnspvSX6W5HSkxolc8W+4x0gRIotDRBukpNLyZX5gID
	QXLy+iMIkc5Xg1GQiy2/US2/M2bIZBEu5eODNXdCnyAsesBW2+sc3qNvM/coknyl5erKkfI
	R0MYOv6Srr+LzInVdoqjnh1I1qZ2yw0AfCoVVjUANn47jCS5dNRQe9Ax0Pa22ffuVuNflUd
	4i+hFxrGo36S8ytY+weu6fKPo2vFnd6pgPxcDnoFK6Jizx+wGRXRHBqIsnRLOjcdsAR2tvj
	oI9ZWlcn7Pm3TjGsV5v/ngad50G3tDc6DJq0MZ2tLcCLySnKcQmyIn6FAmqU95KkYVims4O
	gzBEwqvGDb8HUngJE71MJDfMEr8ueN6jMhtwCtRCuSMZOIoI/BECGin/hOzKiwHA8VoahJH
	FBs26iyJVqXuw6BNYyiIPFrz3QjeJE0AWTrpUHgSXbckRD9nNhfm5drL03SNqGeZNeROAX8
	z+bPDqQmTJdWOHScOsFz9nueF6ORVFDuNfn/MYuuvKyM3AE8LzyrP/0iI2nZ4=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On Thu Jul 16, 2026 at 12:04 AM PDT, Pei Xiao wrote:
> Add a devm action to clean hardware interrupts, sampling, and control
> registers on driver unbind, mirroring what k1_tsensor_init() sets up.
>
> Reorder the registration order within probe(): register the thermal
> zones first, then request the IRQ, and register the shutdown action
> last.  On removal, the hardware interrupt is disabled first, then the
> IRQ is released, and finally the thermal zones are released.  This
> avoids the IRQ thread accessing an already unregistered thermal zone
> during devres cleanup.
>
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Thanks.
