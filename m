Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866F53F6C50;
	Wed,  8 Jul 2026 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547758; cv=none; b=e7YYcqbvIPVxKc5xnSfbYtRDdCgSo078e8o7rqX1YyI7Zk4cXltBShDtzmBGvZWfU1MzviPmPmMTsJ47VILouyKKfLVGOYOJYLgq32JHQR18GO9pJYS1ZeqtLDHJLXGkKK83Jg8r1k4Oej2n3FiSrXFBKpIXSQ5x6yDCg/6FHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547758; c=relaxed/simple;
	bh=E13s4px4HpU1DHPkDGA690/6O5c9oaQoSSbxK1RW4Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfj918S53XuE8fQyh0ALjUoj0UDmqCVy6chu4NXsOWhtwdyOPxOiyQ84FhdWHAu/aUn1TrSZ9xWO+XHe+SbehRw9VDlRHJ4Muyq9IHnI8uUzb6zEHooUa5DiOsEOygSB5wK+PemU1bg+AWPz5bXpIRuKMmmxB3eB0FLgHmcNZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vLvb3sDh; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nYaqeC9A; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vLvb3sDh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nYaqeC9A"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gwX385Sw4zKw3Y;
	Wed, 08 Jul 2026 23:55:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783547748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUt8rJZ/0AQq1r05KhxBp9d1v78gt9AIlJqD+iFhvcE=;
	b=vLvb3sDhhB6nPt89m4m8Uz15sXDTqI7whoSF1zVP9CNL2mH3EzfYRLOHY/O4UD0bB++5yZ
	omii7FWlBOpRA5FTGV9aH9DoVwsH4zQU9eN5pv8ZOl4Wf+BH9PiGxp58OzAfHaud+tCFf7
	Y3e2YgQ8ip13t/2HJ2k0fP+qnBzQ7ID/HV2V/y7ZvVJTXipJ7JqvKOBRt1OCB2NODce4Kz
	rY1U6+b25Vh0hxo1bsW/lBI3y8V2XUI+3kZoCTI5G+Zm2++0d+T4O1nFssZmCGqQpo9Vxw
	Bowl+WrgNZbssBRczd4H53E8eGCd0CsQRid6jCFeO+wFR17gaVqvMlsReSZW3w==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=nYaqeC9A;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <9c29915b-0b57-41b9-a6cf-5d970756527c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783547747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OUt8rJZ/0AQq1r05KhxBp9d1v78gt9AIlJqD+iFhvcE=;
	b=nYaqeC9ARNfKvDhiZffpXJQxY+Z+/gFn3LTQ+2FfP/4KjwAy0vs4L9K09YtlYcSgZRPeZA
	pJseT5WmLFAzE+ynTiyoXCK1pe98XaCHQskMCYmFbp2JTEHb9q+muRm2a/jpa0WtJ2aX5h
	xCsgQzeOdrSQhaDRynfr3zTk3PH2nD5VZs/9ECt65Hgq2MtE1yA59S2qmUr+qbMg6RWD4z
	/FfKx7oMhtOJMe/C5pOsOunw0SIDas7YPAxRukba7uiEKQiJUl4wfmzUqP4GuFdfeEeKqX
	Kd+s6+WBA5jV6cVpiWaM7Fa2GGZVFmZ9OnLKOfvPGk7o76Is+xIdthEEfvhJFg==
Date: Wed, 8 Jul 2026 14:38:06 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/6] dt-bindings: power: Document Renesas R-Car X5H
 Module Controller
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
 <1d79020a5eb2f269ea7ebb354cdfdf880049721c.1783505142.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <1d79020a5eb2f269ea7ebb354cdfdf880049721c.1783505142.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d9791c4cacc79975d9f
X-MBO-RS-META: owwmi4kprmaabd8g38rhbdeqr9d9i8uo
X-Rspamd-Queue-Id: 4gwX385Sw4zKw3Y

On 7/8/26 12:15 PM, Geert Uytterhoeven wrote:
> Document support for Renesas R-Car X5H Module Controllers, and add
> binding definitions for power domains not backed by registers.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
