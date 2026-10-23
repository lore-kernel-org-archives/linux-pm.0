Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820113;
	b=SZ3MCsw87wzQmBc8wgsW6+nGog5oRoVYlOD8EfGyfQXDFz+DdyV5gncNLHMBgxlb6XU2
	 lctCqL5XdhSayapDRZaWXlZwAwqdxcqW+q6ZTOhoAiLpDW5h27rKg48/yBeOCFU9Ni2wq
	 a43H8ZnyuhAgJ9VrpqrojooJmnM/L9Uvxk+Rn8oncPXT7s5eFUReJ8bD5gIf75DC9n7+Y
	 dWx4QtrXVXbwVhq349c9FjNp+g8gTmQ5OSpvfIIeJjxk08K8LJ0W/wjwOQK6sCrdPbqKL
	 /ylrCp9+/kuhRYME5sbMVXzk7eijCmqIzoVIC0L6hp4H0cRA2DzvOPFh3WWarnD21jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820113;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=MiVht9ym0EURv1bddnJJbI5enBTslXQ1JEWYlf28Cto=;
	b=31/NJVYA03+/puCmtY1s+jTtffLJOILV5YBvZM5/o+HxncaA+JtwEhV5bkkydRg53vpz
	 53yu4LCRwq//rdimkrfNPglsxszoRajDbvU0Cup5YahXbXsXPbrwStGV06nTZFOSdWIoK
	 bDzH8Hg1Ls9zZ//BEFYyNgFGvVummO/OnmhGS6+GDnKFKS/8ak+24BFEOiDkfzOdzKwBT
	 gr4hek5fS7dv2K0wYpMggil+K0pEReGcRk35eqYSCOA08iwXLg3HpopbSYza11S0Z7GQN
	 LrqxJyT3UQQAuO4gPSaHEv2pw/2v5TOzDSqDP/xRm3AVwjuKzjaFqwFg7b+TlzKaMiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=prTvNw0e;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE9606A33B;
	Sat, 24 Oct 2026 05:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FCE9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=prTvNw0e
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jBT9m5Z5pzKnCD;
	Sat, 24 Oct 2026 07:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792820108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MiVht9ym0EURv1bddnJJbI5enBTslXQ1JEWYlf28Cto=;
	b=prTvNw0enYprIWmGhaUdr7P6UZhA+faYgPuaALUaN5kRnUv5IOQZXOpqRtooY2lDAjCSP1
	7Vpi3t81dZta8GKCcNAj+qBQ0oEuqO/ft8xClKZvXGUHAhg0CJ00xyLWulOlIDLn5TWZ9z
	rDxV8v0zN3isDvgThk8CJ3jZflJPxvmniS2D8z3mmiGWcYm+LRy+x7exPXgqV7lH0nlcXG
	DHPRW36n+VLby7NhHJo76mMt838CfUfpE9XO91XL35NNk7dKNcS12AUoi0d03MzkXcG9V3
	hNgIUS+wSCdgRbsqH/iprgRu10tHbIQMu11ZPjV5QlYEix+YxjnTh2vqceqfmg==
Message-ID: <d870c163-8d90-48c0-bae0-5f6e0e38c5bc@mailbox.org>
Date: Fri, 23 Oct 2026 22:51:33 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] arm64: dts: renesas: r8a78000: Add GPIO controller
 nodes
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Magnus Damm
 <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <cover.1792776697.git.geert+renesas@glider.be>
 <f9de8214043ad4c8748fadce7fd2cc2fa95b1291.1792776697.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f9de8214043ad4c8748fadce7fd2cc2fa95b1291.1792776697.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 67d5bdyjkzczox9iyuyt8upuxs5tyx3t
X-MBO-RS-ID: a841861d307c1214dd9

On 10/23/26 7:50 PM, Geert Uytterhoeven wrote:
> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Add device nodes for the General-Purpose Input/Output Ports (GPIO) on
> the Renesas R-Car X5H (R8A78000) SoC.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Co-developed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Changes compared to Marek's original:
>    - Use hardware clocks/power-domains/resets instead of direct SCMI
>      references,
>    - Drop gpio-ranges properties for now, as upstream lacks Pin Function
>      Controller (PFC) support.

Is that ^ OK ? If so, good, TIL.

The rest is

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thank you !
