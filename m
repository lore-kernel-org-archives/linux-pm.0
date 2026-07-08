Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748913F9F35;
	Wed,  8 Jul 2026 21:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547766; cv=none; b=NDuFcu8iAJ/i8kfq8COCj40ICic9JggrGdggbDoM4e3cWzzebaIHYEGOTwpDkij4hEaUQHmbvkR1ZKW5jkBBPCAOOJryFqd5SWLWGBvljHSp0eUc6CgbyY0qYQUUAW303vdSXk19jvl717ZrelLfI3quYphnlZ8Xgk4sHcmuorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547766; c=relaxed/simple;
	bh=5XMZBVMo/Rr48h7uX5lxPLVOvHuvegfK9+ARVSjkqNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Do5UVyoPLRpeUTDYekWhjaVMdslTKG5STwtE5pclTS/jLk2REs6FGk2b9ivZtgWyq23+vAvpInf1AmBAV6g9r/m2KKLkX+dJmT6iGWEViwmz/+B39QAlQSV2fdySZhrp4hBl4goAXbPgWaHXcDn6GoggsFKRbiI48XRx+n4n2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JeqyMiQ2; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RG+Tlpl0; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JeqyMiQ2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RG+Tlpl0"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gwX3H5BbBzMlJ4;
	Wed, 08 Jul 2026 23:55:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783547755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=noNSMR2FZUDVQ5z2kMQ4SQ1DIylupR0KCUJYuOQ0gEM=;
	b=JeqyMiQ2uNG42UdiHLqHQr0H90TMFNI55r1M2aByi8vPh6iUp8NQCc+b7xZQCOqVDiOrRw
	ZKtylJ/46A9v2cXNi2o29svNu09vS/IPg0/8z8sqCmgiruzT/SyA6gIdmonrkvywUzIfSD
	oXKpT+khrQ29kC7uxNAzegSWNxxW6WVgA0VG4yPy2wEol0JgixcT2wmi4R0TYq7QCjTG7l
	jbPj3g3Q5va3cwBBeiVtnUx6ietp8p4zHgXS+od+o1VAiv98ogMuEUfpl0L1XeBf3vHWqL
	3WUUg72PAuQuPzLeoO3WOIubxy1fMImzzKlbaGCs3tVYST6VJVyxZjQtauYhCQ==
Message-ID: <a069d50d-030d-4189-ae9d-37f989829da4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783547754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=noNSMR2FZUDVQ5z2kMQ4SQ1DIylupR0KCUJYuOQ0gEM=;
	b=RG+Tlpl0+ZqCLn6GaUQY5agkWWayozmrsOsSdEZ9JKn01kODVufAcMOk64uD8EI4ZJ2QoA
	xSb3VAa9BegXwjcXrrUZlSyqKnr2iJrMx5rZgAOZiiu6F/g3Rre4TqyyIgZTgI22uC/W2w
	S/1o50wcbXKdyyJ5yFlZi0/jlvlwpcH+C4HsRs0EkLrg4PrELV04d6kw547JuY2XfipC3y
	6NBhHw3n+JCe9Vq7HYaGGkFl5J5tgQljf4TkzMfTgpVuhkbnAheayR1u8lZnGjI1weGYy1
	SrM5khm0v8ZRDqqK5N/mjtlJQaPDjEJREMdHM8IHQEAzVjxHR5YbLw5DkcpzJQ==
Date: Wed, 8 Jul 2026 14:47:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/6] pmdomain: renesas: Add R-Car X5H MDLC driver
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
 <23f979b0903ca11513ac339ab8b6dd40435603c5.1783505142.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <23f979b0903ca11513ac339ab8b6dd40435603c5.1783505142.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: dpjegc1k3oy9phznjyd4aq7euq71gaqc
X-MBO-RS-ID: 3a3f3703bc243c02f0b

On 7/8/26 12:15 PM, Geert Uytterhoeven wrote:

[...]

> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 2ab150d04bb1f1ef..d4055250de72f1fe 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -358,6 +358,7 @@ config ARCH_R8A78000
>   	default y if ARCH_RENESAS
>   	default ARCH_RENESAS

I know this ^ is not related to this patch, but is the "default y" and 
"default ARCH_RENESAS" above valid ? I can find exactly one such use of 
Kconfig in the tree.

>   	select ARCH_RCAR_GEN5
> +	select MDLC_R8A78000
>   	help
>   	  This enables support for the Renesas R-Car X5H SoC.
>   
