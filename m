Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927456;
	b=EClygUcx45rm2BlxlHIpo9AP9kNqIeE+9k4roEpDHGd8XMImneJl0OIs6UhJWsQ3aoe4
	 uSxu1f1zwUDeWN9YfbPwOijAvq7yq5tCN8sDAW1OQ2NtUPJPMWyHO1eOjeRTkhacD8aK4
	 SRR1J49YWIESnvkMpsC/3fazUKDo3U0CKz5CwfCx6oezLa+G7qshOAG14O1yYHRyHB/Oy
	 6sh+tkh0hZnRXKSvmhUVGnHcHSZtSD1zzxYx4t82K9h1zGGi8OEcVMgVahKid8ARcAIuT
	 aTZYqpLDOD4yrLz8KIxK/+15svisJiy1qrnCmKlwdylMKoI8UhSOQ4ZAAO37t6jRZXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927456;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3HNDQJmc29jy0IK6/7l9qO0GFwyZeGN08+WQOfCbao4=;
	b=0Tdw3NR44oeknCyDyMSEEhYb3bC0k6koeoZaQBTNHhNgC6Ow0egPD0kmKwpfwALeePFU
	 xWw1f/rEfO87TImm0a0uXi5XnETSq2lMWJtK3BFEmv6xlqw4MGf8H/19yB5KA46x/qNcU
	 eBAmHJAsWOXKoS4HLhueQTg5QihRYEIADP51Z6UFRyS8LyWciowgsZWkp707eGJPH9gmj
	 EmfnrIlPX/vb7LlqARF7oNNc09i1zwtYNewFZfZfxcNQ2vrr7Hi+HIk7flJUu/fsfWg/Q
	 dUEAezXZHJxHLy4MrZH6dM5sIYJZlBDRq4WKXp2O+HqrT4vWLOYy+VLMNSdzgH0CDGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=K1DONkXq;
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8795606A31C;
	Tue, 17 Nov 2026 14:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8795606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=K1DONkXq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1794927453; x=1795186653;
	bh=3HNDQJmc29jy0IK6/7l9qO0GFwyZeGN08+WQOfCbao4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=K1DONkXqDBJE2jvxVX9QD2z5LQtCtJrMJAvtuQFlUBiPu+FdXNP8upOI1HB1LskS1
	 9M7l5Q1lOjn2QnW+I1hKW/g64/QBKGPmmnuuOq810fsiN979Wci/UYTlamuF4nlYnM
	 RICc8S5u+KdJTE17Qta3jefN0/pyQ7xVwpz4dFcSRkdIQkwGwIkGTd4vthlLAMrMLF
	 V94FcP5/jVcMjxKn+BHhQeCj+bGAGCZQ3cya1OeBZLEGxq/2lELps43ROF1yN9XfKm
	 HqKdVXxzC5BR25jfLrbgOqCSE/n/fD2KoKYddaZWOSM6JQdReVz5rl7P+xzkZBBKI3
	 Jw6hjLH2Tss8w==
Date: Tue, 17 Nov 2026 14:57:28 +0000
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Srinivas Kandagatla <srini@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v5 3/3] ARM: dts: mediatek: mt6323: add EFUSE support
Message-ID: <9o4MhYmOJZrc_PLX4fAynHoliyOLUUfB2X8kqS_FZFKiogtB45CEIgwF6MDJXEMr-jGh6fwofTSyymtxjuJOQcMQU3Zx7Lbu_OYTejzyVDs=@protonmail.com>
In-Reply-To: <3fa52671-642d-49cb-8323-8e9b4066a06d@collabora.com>
References: <20260921-mt6323-nvmem-v5-0-2f5d308369f0@protonmail.com> <20260921-mt6323-nvmem-v5-3-2f5d308369f0@protonmail.com> <hfElNICOLYWph6ayG04s_yQbkHLXmu6qzdWeR5ObRNxVsBtq86bjnERSJx427OwwrZYipLAOrUGBU8zvYtXEV1ixQ3YBzAZYQ3ypouA66T8=@protonmail.com> <3fa52671-642d-49cb-8323-8e9b4066a06d@collabora.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: bd764bf8d0257cbcd00e0a09e063d7cfc28c1ae8
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
Content-Transfer-Encoding: quoted-printable

On Tuesday, November 17th, 2026 at 4:50 PM, AngeloGioacchino Del Regno <ang=
elogioacchino.delregno@collabora.com> wrote:

> On 11/17/26 15:43, Roman Vivchar wrote:
> > Hi Angelo,
> >
> > Could you please take a look at this patch when you have some free time=
?
> > All other patches were applied by mfd and nvmem maintainers. This patch
> > will be required for enabling thermal on the mt6323 PMIC.
> >
> > Thanks,
> > Roman
>=20
>=20
> Hey,
> thanks for the ping - sometimes I just lose track of patches around - so =
don't
> worry and keep doing that.
>
> For this patch in particular, nice job about adding the efuse support, bu=
t now that
> you have it... well, adding the compatible to a devicetree alone makes it=
 probe, ok
> but then what?
>=20
> You're not using it for anything, right?
> So those 3 lines are "useless" on their own...!

We could say the same for auxadc I guess... There's no in-tree consumer
for it (yet).

>=20
> If you also add a user (someone reading an efuse from this controller) I'=
ll be
> truly happy to pick your additions ;-)

Do you suggest moving this patch to thermal series?

> This fuse array stores thermal calibration as far as I can see, so I gues=
s that the
> user will be the thermal node?

Yes, I have sent thermal patches some time ago, but I have to make a new
revision to address some feedback. I'll send it a bit later.

Best regards,
Roman

>=20
> Thanks again!
>=20
> Cheers,
> Angelo
>
