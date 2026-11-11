Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388457;
	b=tYqzUyoNBUP18wLkGOvnplZJtc5BN1o+Y24+sUxy04s+0C/sKULVTA8a31746nTIsYV2
	 Ss/X4MHUvSRjPQKOSZ6Ki+XgQYUJCfwlQGWQ1HM8YirfzS0nQlepCk2DCZE6E21EX7ycP
	 6jxhn6TS0f1GjpVKvpfqpi4C6IKWmMEL3DduhOxJyH7njX/kB+HdWtA6fBdsILyuRa8Gr
	 Ho9y0/KTLxY5dzfcbiqVdBImLVGXC86DGspMeaSpIVkD4GfDl1j8k/1kQz0F4uUQyw4DL
	 phpjNerP0+0XIwEp2FOFcA8U+0SKLVnxFzIZIMKaTdsU8iyhGCZuG6lk88w3Fb5lAOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388457;
	h=DMARC-Filter:Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:In-Reply-To:References:Subject:From:Cc:To:
	 Date:Message-ID:User-Agent;
	bh=b+G7hrGrlGrY3UI909QDJiCQQXsMdD5fgPKxtHlSaZQ=;
	b=YgFh4mnWlWcpK8yKrm6iIt6dF9v5eVTuBh3bucAz2Cjbae/QiwIMPArvcibCxEf0RNH7
	 OkSt2x/feoGTG3lCC8ch+aOUKX8nqYp+GWokiM8WTGROCOa1710rCiyRuf4S61eHsfAuK
	 6aK++v0I1mxtCBZq29awKR2kl7SQWJxHpCc//ZDeq3g8UPTxD/FNWMwEQQ8gnPg2nSwj4
	 sgoLIS4fICr8hPmsKkiLqpRa54N/gW7IqlxoqiACW0ggF9O9NepGpEZdY/Fd35uomtgpe
	 AYQbm+qroUSeqGIuPVvSVhUnB/rSu9lZVa48IJDjxWyhJ7LNkIdRUP19Y90Yg+R3rfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=fm8LDO15;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D2078606A326;
	Wed, 11 Nov 2026 09:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2078606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=fm8LDO15
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:e376:67cb:cc18:4691])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 7BAD58FD;
	Wed, 11 Nov 2026 10:11:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794388311;
	bh=WIquQU926rRQBDcSiSikssDBTl6Ahv9qxOLA8KCpfrs=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fm8LDO15BsEVZT2IEoysycLlz2HKCIvPAr0b76MYtEQMvubFJbA7/c9ZgYkTb4MCx
	 740dvB3nc+dXpo3H6iTw4dOCcPAww61Y64CYQ9eR8z1zWnhoYjBuQngWuXMzMH5ODg
	 CsZyvbuutGRWFoNZHoZuTSkbS5p6YQ8KFONqAiBo=
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261110-steady-kangaroo-of-mastery-5fcd7f@quoll>
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com> <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-1-1b2072e8c37e@ideasonboard.com> <20261110-steady-kangaroo-of-mastery-5fcd7f@quoll>
Subject: Re: [PATCH v4 01/13] dt-bindings: clock: renesas,r8a78000-cpg: Add CPG_SGDn_VIO_DP_{TX,OTHER}
From: Paul Elder <paul.elder@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-media@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Wed, 11 Nov 2026 18:14:08 +0900
Message-ID: <179438844820.272237.18262716067322018404@neptunite.rasen.tech>
User-Agent: alot/0.0.0

Quoting Krzysztof Kozlowski (2026-11-10 18:30:50)
> On Mon, Nov 09, 2026 at 10:34:22PM +0900, Paul Elder wrote:
> > Add the CPG_SGDn_VIO_DP_TX and CPG_SGDn_VIO_DP_OTHER clocks that are
> > used by FCPV, VSP, VCON, and DPTX cores.
> >=20
> > It should be noted that there is likely a discrepancy regarding the
> > clocks. In practice it ought not to be an issue as all the clocks derive
> > from the same SGD1_VIO_MAIN clock and none of them are programmable or
> > gateable.
> >=20
> > According to the datasheet, the FCPV[BID] and VSPD cores use
> > SGD*_VIO_DP_TX=CF=86 while the VSP[BI] cores use SGD*_VIO_DP_OTHER=CF=
=86.
> > However, educated guessing suggests that IP cores in the same pipeline
> > should be using the same clocks:
> > - FCPV[BI] -> VSP[BI]:                  SGD*_VIO_DP_OTHER=CF=86
> > - FCPVD -> VSPD -> VCON -> DPTX:        SGD*_VIO_DP_TX=CF=86
> >=20
> > Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
> >=20
> > ---
> > Changes in v4:
> > - Add all the clocks
> > - remove DNI
>=20
> What is DNI?

Do not integrate. Most of the patches here were DNI in previous versions
because they depended on a lot of downstream things, but now those dependen=
cies
are in the process of upstreaming so these can graduate from DNI status.

>=20
> What do you expect from us on this patchset?

Reviews...?

Although now that you've pointed it out the extended explanation about the
clocks probably belong in the patch adding the dt nodes and not here. I'll =
move
it over in the next version. We really only need the first paragraph for th=
is
patch specifically.


Thanks,

Paul

>=20
> Best regards,
> Krzysztof
>
