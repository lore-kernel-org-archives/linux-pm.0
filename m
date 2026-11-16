Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794817380;
	b=n0OoTOodAzHcRRCSiPGPa05S8nXvt3kUX6uSk03qZ0QydnUHhRNrWL2KkfY8wupyjN5q
	 j3+q7E0Cl7Y13HfyPggqyg2iXH+n4Qcdbq6xCjJ1N+R1StBLMPmQRuIuywPhwYqlQDUvH
	 t2qEEZ1ChGbE2ceif5Z8IC3eLJRbdWaSGBSvqr0nWZyRgpk2iu/EmSLZCpgIM1BYjH61K
	 NYCTMl+YaS++MxG3gsBDG/lSSN1lfYtt2NRF8GbwI2UBkijDzs2Gw8uOTzOQ6nr/mHT4O
	 8+brDDK4giHLVQH6Kp1/yrjoQKq6SopSK/9N5X9+phAQZ1bDLIyz3HdXIQg7FKxXLAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794817380;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=euH0BJNlYcSHq5yr15pcFlaT205pABUUGFubW7NpuMk=;
	b=G5Dx+R5y2vwj64aSXC3iNsEOg5YXkB5fFi7PG4bbWeJJGX2rwBkUfU8S8A1HxhVT9DOP
	 SuO6fDRZCVzXlxXc/ZtrbVMn3LZMf+3O2HswttMM10nwLV5hnBuc2o8AziGi2JDs2Ubu3
	 V1GvAiAtNln9vgxENJKUAb4sVsP5I6uuICkFgeaY39pLcuwQHVzei670qNUyWPog2+ZkF
	 2DCXHYZvaX4+9pRxOS2tRu+u0Vedn29um4jcNkvY0WijpZn1X+ZhRk+T9EKmNF+ELLxgw
	 PACx1zJ4ae3CXWZExbBj8n79szRNWRvl1gZy5Q+Uu4zzBcuJ9nO12xQ1Av5wu3skAzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Q95X8rex;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F49606A333
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 08:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F49606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Q95X8rex
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=euH0
	BJNlYcSHq5yr15pcFlaT205pABUUGFubW7NpuMk=; b=Q95X8rexII/3mzewfYJW
	zxeUCE/7KqQCyMLyUMmoeiOuyWjlTDU3Yc5WuzAQun5UV9NomJD+Ib327u1CS29D
	shtsvpCX0eqF0eEivl5cIuWdGSKGRcdUNH2AUiHRUHIvA3n/tvaSrHAzyc4CYfoa
	uipewViPV66CHwwtpqiRO3D6fefOqCDADfJNOpl2zduSD8JVzHk02Nu0VIHQZ9YS
	TjLAmPZw9mgkrkzy2e14AgsJ6ndq0fnQYF8CsGybikyICE2iFjgDs7qW6VY8MGj1
	laiTd9GEpgasBafTlf2S8/PayX47qKq/sVSbGcq+BQ1DSzqGvQ/lupXTlDUfliK6
	NQ==
Received: (qmail 1195362 invoked from network); 16 Nov 2026 09:22:56 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Nov 2026 09:22:56 +0100
X-UD-Smtp-Session: l3s3148p1@uvIkfGBgKooujnv5
Date: Mon, 16 Nov 2026 09:22:56 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 8/8] arm64: dts: renesas: ironhide: Enable SCMI devpd,
 sys, clock, and reset
Message-ID: <avq9YAeAsAgc-btt@shikoro>
References: <cover.1792163045.git.geert+renesas@glider.be>
 <a66c5ceda67314eb9e86224eb555adf5ce00ecbb.1792163045.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a66c5ceda67314eb9e86224eb555adf5ce00ecbb.1792163045.git.geert+renesas@glider.be>

On Fri, Oct 16, 2026 at 05:55:47PM +0200, Geert Uytterhoeven wrote:
> SCP FW SDKv4.28.0 and later for Renesas R-Car X5H Ironhide not only
> implement the SCMI base protocol, but also the SCMI power domain, system
> power, clock, and reset domain management protocols.
> 
> Enable support for the latter by adding the corresponding SCMI protocol
> subnodes.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

