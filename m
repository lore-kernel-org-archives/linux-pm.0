Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD553FBB6B;
	Wed,  8 Jul 2026 21:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547763; cv=none; b=DrtWurjwEx6fTgES8P1TGNtV0fJTRvSqvEX96OKBiZV+wUdv6Ciz+7jebOy6xv6zwUE++bJCeoEp76kkr1rUKTA68LL87HmxT/7PcwGvUwwfsv2+OWA7/fXIuFr/eghRLmSUfFIgOZsv4FxfZaPwktddbHpmRlLGAQrfehe3BPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547763; c=relaxed/simple;
	bh=kdjKpT+assoZeilYr2LxQKuL8Nmo+KGDFz0y8VqXiEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6SLeyY5M9qsk2t6SzrE9aLTDVLkIh9lwfK/tqBiKpZIgknFYhruWeINA+oCOS1fuuVEE2uqj/snbCF80vNqGRPtA+3iBMV3DBQxn6OyzxRVu6v5pzjecUV7qSfx+UmEKzf2W2ZjFzTL30RbsQrQsQG+rQDrfWnIoRgPHUN++O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wjFK/kaf; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qj8cBGg7; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wjFK/kaf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qj8cBGg7"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gwX3N0DMLzKw3Y;
	Wed, 08 Jul 2026 23:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783547760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjBrVwKo19OFb5JA1WR5qxGZI/M4aEQHwbmWPVH9Fks=;
	b=wjFK/kaf3QZ/nDdcK3LeRFORDcRmlnZiUfoggHfLBBeTN7gSKVvaucq7jvglASAtoG5sit
	n/jo6T8f46y0Sc/sXaLsy3n4FkrQJokveJC3UtuyUqECqrvibEQmXoUHRh0Y4t8MBkgWJ/
	x2p+OZ4x73BxE3CrW6OJNpONdckpUQPHMZxK2g5Nwbu7DXQ5WzMvdGTetRilULoHb3PC6h
	jsuWaR/huwwAxV+2l813NtMEinZsTnA1O2ZcOH9ocGmg5dvVywLtcUgM3h+0d/8roN02RL
	eGweCpGG7R5mgGoHs46NaiHtb2d/aOJMzNQzviyBdzA8iBhCCqPNuM1A7KZK2g==
Message-ID: <7377ecb9-f9c7-4f48-8fb7-655822a8f526@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783547758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjBrVwKo19OFb5JA1WR5qxGZI/M4aEQHwbmWPVH9Fks=;
	b=qj8cBGg7BDmYDT3tr4495TkhB0y/gZRXQBV3ehVl0zvm4DuZP68iMhQYizADZmhUOQb3eF
	Q8coBPUBKq7g7n97/rjfX2pOWlka8Jr2cNEk22VqRc57JYl+vBsgPb4boBz/AZWHEQQZjq
	UJILwMFL06icODVX05wiIfqpCyNxMEmL9Nesl+2ehWqEC+veKpANMAp1xxtWQm4ROaBqTb
	FEecuxnXsfkMOfW3QG28KE5HUCDAv26QDIr4HMoMjdE4iAGxaAh7ifXA+7n5+QhaLQ4Lz4
	PIe2xrvIBNIs96Okks+1/mNgR0z0gnOWBreyqC4nDBAhwNaFnT/N0v9oft4yLw==
Date: Wed, 8 Jul 2026 14:51:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/6] arm64: dts: renesas: r8a78000: Add CPG node
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1783505142.git.geert+renesas@glider.be>
 <b3beaabd77ec73d3dea43cc603f2cae31290e273.1783505142.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b3beaabd77ec73d3dea43cc603f2cae31290e273.1783505142.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: u5q1xmaq9dmwg7pe7hht3rgzq961ntaq
X-MBO-RS-ID: 17fff366f2498b566c2

On 7/8/26 12:15 PM, Geert Uytterhoeven wrote:
> Add a device node for the Clock Pulse Generator (CPG) on the R-Car X5H
> (R8A78000) SoC.
> 
> Convert all (H)SCIF serial ports from dummy to CPG clocks, removing the
> need for any dummy clocks.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
