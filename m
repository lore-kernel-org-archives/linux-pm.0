Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712500;
	b=366QjNBaCCTJO9mcvrCQzcTksMtlSNzpl8NjmWAeAhamEGlgQKqSAxRajdJ5/nZZ8XLC
	 PzxkqfPlDWL/jpmmMUD5VQabiQ3QFKMrdxRtCDI5BnM6JAMD3gdT5nVDHbwPE1i/nmJI7
	 4rtKC12NO47ZJh7ae7pWmMlVKSgZXur5IhKk8GNYyCZeIVqaDf1ime/bzOGY1E1cTyGMJ
	 9h5o07LQdj/xwWbljjZqHsW5QQ+Nso+I69bAj5L34EaHBYLwyvIX+CMLXqIzYobm/0Cw8
	 j35MLrw9+3C4sXh+AO9XfdCTeHnKVETACUV6EOksN3RZV2KCrkaqO8WcDuRXnb1PofA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712500;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WJTpt+X9RF5ov4+gkKKicVGwQVPCzHMz365+2em8uJI=;
	b=YBOIgxitVeRyZPOBRQYmjFf/WuaniB06xx8Z7snr/SBEBIpHCd942JYIGpCs68wv2XLB
	 0S1AM2aGy5k2aE3A/ddM0tpeIy8LESxNbki0fAuDet9hEfPzqzR2vQsHsOggipr11QYUB
	 gYdlV0dzd4SFKOeYUkh0J+OxyOhLZ8TsKGGrzBoNT8l9S+r/M7I5mebfDlm2UsxIVieg+
	 2XZNYTMEpzGCLxmW1APB7CT8nLGCY1GOaAxoU/DDnI0c13YEoBixj2oycs6UsBov1O9NA
	 xXzM2SUG8AamRv4ABWfFT/KMYP0NnYApbw4c82ueUvkVZiH6v9wQDMkfNm5K7vL1TtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=V24TKzqm;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEFE606A31E;
	Thu, 26 Nov 2026 17:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DEFE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=V24TKzqm
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 97C8B210CB3E;
	Thu, 26 Nov 2026 18:01:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id 6D3D820DC677;
	Thu, 26 Nov 2026 18:01:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 6D3D820DC677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1795712498;
	bh=WJTpt+X9RF5ov4+gkKKicVGwQVPCzHMz365+2em8uJI=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=V24TKzqm6S5AO/9g3OMqRN4hLIB/rPeMeao0L2Z9/UsK/sdGBdwHBf+NEO39BH3Os
	 jb2gK6vTXGeKTCP+6Hs6EfGdpcGlMkAgJOMApZv5IZv/lX43K7V9GgTSh36ezB/MjB
	 lt3qc97uZaF5iOv6gMbkU6YJXdYTYFlXIrBD4BFgle8Ldm/+2Sw9ci3qkfXheNGsjj
	 QGWTMFQN08S7+HprJcNybEhKbE9ewkn1pDdkDIE8Cs7au6IoJeFJHN/891aJ7jP80W
	 D9cncgvx0SI3iqxmX+a2qxOf7Lrx3R69SCQ043n5GiEmMd5G9rwl2xYAPv9p6CJP2n
	 TQ6bSoUIKYXuQ==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id cJicDJtaFHn5; Thu, 26 Nov 2026 18:01:38 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id 6B332210CB3E;
	Thu, 26 Nov 2026 18:01:37 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: Yixun Lan <dlan@kernel.org>
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>,
	Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: Re: [PATCH v5 0/2] PM: spacemit: Add power domain support
Date: Thu, 26 Nov 2026 18:01:12 +0100
Message-ID: <20261126170113.905375-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118-04-k3-pm-support-v5-0-42394acdf3e3@kernel.org>
References: <20261118-04-k3-pm-support-v5-0-42394acdf3e3@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Yixun,

Tested v5 on a Banana Pi BPI-F3 (v7.4-rc4 plus your two CCU pm-aux
patches): the seven K1 domains register and unused ones are turned off
at boot. With Iker's PowerVR GPU node (v2), the gpu domain turns on when
the driver binds and the firmware loads. No new warnings; W=3D1 build is
clean. Reboot from this kernel is clean.
Testing done with the help of Claude (AI assistant).

Tested-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr> # BPI-F3

Fr=C3=A9d=C3=A9ric
