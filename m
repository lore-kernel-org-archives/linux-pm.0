Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173042;
	b=mrJt8wNCjjMGrySYwjdda3taMfoIsxPvs3tnYi5X8o4KTt4uZcVoep99jRQgGfSuTPUc
	 0Y6PmuOj26SH/9cWSgXXlHGlhBvDk7nz+EphFuc48su4Up8kpwgd5or6Cc2//aCbR7Hel
	 deXGIXnTRg8R7kpNu1uqZwmJBvJxwn5pK9kFG/v1FgMFA/vzNFHNlcf6n3yVHKbmpk9Hx
	 EFYFzYY3kUtA551eYKW0kVnDfF1sHPJXNYSNfVgA7Gfm1i765gbEqyz6qsvaBcCSRYNTn
	 O1Ne8aRoBgTLD6hrUI4XxF5AWRAV68QJPSBVLGDImKkMmjI2f1V8n9MORTOJlvSGh6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173042;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=P31KX+HGbOZ2m/ze0RQmiiG2ACd7jzLv4I1BkpYMPf4=;
	b=i7AsS0ZD39pmqFGVeL0gUDLdxKjdUCPKkKa/BTvTflnTcFhwvf6wuPCUHvU/T2uhDuQD
	 GrgiKa16boN01ghZiyHGgIBmTyF5KrCKkPIOFhoseVLNzz7NyiQ04/YiiyZ/CUZP2m5Vo
	 GfUgDIag85SnqGS8L27b6xckpnLbiTeZJrq81JStvRAfQL+D30FOTTYdtL8hy14KHNugO
	 SCvhTUuoQVoQpd7iy2L9xIgttxAevW7zqyjDLT1gEWk3SpVbDdKew71OyD/xyGKpryuAk
	 nhhYyc4MbPpTn2VM6LU62Vl/Cmg5P8YZYZ1I/3UhwF/PA36jMe44KvOx8Hk9QGCBtCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Obxoi06N;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F07606A32A
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 11:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56F07606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=Obxoi06N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:content-transfer-encoding
	:in-reply-to; s=k1; bh=P31KX+HGbOZ2m/ze0RQmiiG2ACd7jzLv4I1BkpYMP
	f4=; b=Obxoi06N2BzJC2E18N5zskewr6CRQuDC+9+KvJKyH9LuFwQeHEoRM8iX+
	1RN3g2hi0vRMpw9ChKCggkqpDtldXjWSxbuf15ors+C79EzQrWROtqkODXwVMioz
	AwJzyY5VTdwsnFQspH2hE8RSP1Nhf8/y7hf7KJNOdig+td/U5uqFSxRWdKIjksaV
	xUmXByPF0+tNuh7pm304XaQfgfBSY355NR4ka2paF3JigCsRB5BOfvmbMWMNBP9B
	GnaFo74Vv47qUVK4+9ZpjQSKFC89PuuUA5BL806XF5TI21wlvLZ+P+r6LUjwEDNL
	l86k8NVB2qHZ1u6bkApUglRKLQi7w==
Received: (qmail 1450248 invoked from network); 20 Nov 2026 12:10:35 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Nov 2026 12:10:35 +0100
X-UD-Smtp-Session: l3s3148p1@knAOS7Ng4JIujnuU
Date: Fri, 20 Nov 2026 12:10:34 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: =?utf-8?Q?Cl=C3=A9ment?= Le Goffic <clegoffic@baylibre.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 00/15] R-Car X5H Ironhide CPG/MDLC SCMI remapping
 support
Message-ID: <awAqqg6F2Z1t55x2@ninjato>
References: <cover.1795029012.git.geert+renesas@glider.be>
 <1e9c5ac3-d82b-4af9-9946-0302cadf7404@baylibre.com>
 <20261119234759.GB2324725@killaraus.ideasonboard.com>
 <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19c3745a-6308-46ff-bb37-3acc88fe22e2@baylibre.com>

Hi Clément,

> I don't think SCMI itself introduce instability.
> It only defines the protocol, and each firmware choose its ids.
> Could you tell me what you mean by instability?

Let me try to reword:

In the past, we wanted to support all kinds of firmware. Sadly, each new
firmware introduced different IDs here and there. So, we came up with
some stable IDs ourselves and mapped them to the IDs per firmware. This
is a n:1-mapping of firmware IDs to our stable IDs.

The support for <n> firmware versions got serious opposition from
upstream. We concluded that supporting only the latest firmware will
make most controversial discussion points vanish. So, we now have a
1:1-mapping of (the latest) firmware IDs to our stable IDs.

I guess this is what Geert means with IDs becoming "stable". <n>
firmware versions might return <n> IDs, but supporting only one firmware
we get the same "stable" ID from it.

Sadly, of course, with the next firmware update, we still might get a
different ID all the time. So, not stable in that regard and we still
need the mapping :(

Yes, this means the driver is then tied to a specific firmware version
because it only has this mapping. Not nice for a user. But we didn't see
another way moving things forward for now.

Was this understandable? Geert, did I miss something?

Happy hacking everyone,

   Wolfram

