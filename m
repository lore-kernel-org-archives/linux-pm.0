Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33770809;
	Wed,  6 May 2026 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107237; cv=none; b=kZy1pLT6Jdl++T2z5OFvOKTwS2w07cEbNtY8/uWCPMheEPSaBF0+RlY647mYlEDqUxdNBlkQkRRvS4nBGvWACM8ClH5/yeOKIXK+r8fgACa8Cz3jFt1nw9EphU9ibNKBu8to2SThtm737aTNaKLll3x6Eq6VD8lVeENHTcCKoXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107237; c=relaxed/simple;
	bh=gsK1AubfywTgARP6ZBJNFwZCqCGKnL32OBn6DpxUoug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoDKR6gN9JcE9r9S7OMoHHqE1u//yypqaIj9kuRQdbGays0c/ez9L22b/BC0nPfHdggZC4O66kh/MKWRoa3yTC6A/BS6mnfqYiDXgXS1H4ZuYXOCp79yIvyKkmdazJyL0zf/MjoKfcuA9VtLOB48nTG14k1yQ4gd/aFioPjABL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=u3artJhS; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZjG1yuH0; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u3artJhS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZjG1yuH0"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g9r1r2Ttmz9tcW;
	Thu,  7 May 2026 00:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778107232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWBO9OrNKl3GTFxm6utkM2kR6qRM8Jvldyy+o4BbU4s=;
	b=u3artJhSfM9zXA2x7lW545FTky+TIoZWzk/3CfrCYXEjwSlSgwkUBzoSj0YzXpzW3e76GJ
	X7SyyDUQLems76Yhh5ll8G1nMcwSaFNkjjp5MIaf1BP/pyEwROiPTAlsCx8TCTVW6lPPX9
	LFGsy4NKYsw1tQXy0LjhU8W9fhPzN9U16HUWROVltzLGZUrmwDiBw5rIsEjY6j73ChguJX
	TNxuJrhjHLKdRRx8diWToLDraSFVQPi9w93RIj+SVr2foNZouGU63Gv2aZIVvLlg2GMBxg
	7h6C8BpZCKJ25CYaI7YCJ6I47SzEuLyTv9i4pPGT+Wu7sJ/h/fksjIJjZ1f9kA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ZjG1yuH0;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <1670fef1-2ff7-4902-b7ae-34ffaead64e3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1778107230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWBO9OrNKl3GTFxm6utkM2kR6qRM8Jvldyy+o4BbU4s=;
	b=ZjG1yuH0ILULcGS7bEug6HuEedgWQZCNd+IFrNBSRhpDUdICgYgCmqNTHk9UJJD2TnSedT
	6cILmcmJNOUhtfdciSI87HEUGpeizo1XgPXemS8wUoGGpWDPAWpe/6ncaf4OnMBMLN5GK/
	+/ixf6H6QEfFEE7rCsBDMFNriwdjQ/V547tWGWnTL2v4G7KczKxrn2A7TKA6Q6E89c8zxa
	viwkF6b5o8RV27zeYBz6V1mQg9rBqx7EzChi4kokGc79YjybqgHxmILclGRdPUWmx4aZI0
	XIZA1yD+c1DtSnnKmzF921/ckrhh0w+W+5xWAzcYyIypRkMGzI93RERM7D63kw==
Date: Thu, 7 May 2026 00:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH/RFC 09/14] dt-bindings: clock: Document Renesas R-Car X5H
 Clock Pulse Generator
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Saravana Kannan <saravanak@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Ulf Hansson <ulfh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1776793163.git.geert+renesas@glider.be>
 <f8c98dbf6b32c0d467606d59b071e9c2bfc29dbc.1776793163.git.geert+renesas@glider.be>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f8c98dbf6b32c0d467606d59b071e9c2bfc29dbc.1776793163.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qcuenbn8cnr7hi8yath89o8qnw76r9qk
X-MBO-RS-ID: a83454511542bb04792
X-Rspamd-Queue-Id: 4g9r1r2Ttmz9tcW

On 4/21/26 8:11 PM, Geert Uytterhoeven wrote:
> Document support for the Renesas R-Car X5H Clock Pulse Generator,
> and add definitions for a very limited and preliminary set of clocks.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I managed to implement U-Boot CPG remap driver based on these bindings, 
and the bindings also fit for U-Boot on RSIP direct hardware access CPG 
driver.

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
