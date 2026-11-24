Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551011;
	b=nORAjUbA/TBCPFuT9t09BAW2+I/bQgkTO8kztLsDWrPmiqMhnzQZ5yvlNiTSFGJKe4Uv
	 aCPW4ICJ93RDV4Mo2DY5mLZAVENOcyKeSkDKV1iP675WkHonCqbmkQOhHxFFLjvOq9kEe
	 3OcWeDk3NS2jD1BqnRGw64sWe8KHRykIiBNjRh7Rwax8tYfmuf2miFbevVyCNIsgbECRa
	 Ki0xh2Rpw9/SWpZf0TrmRcuk3Sv2+9VUsH8K+UTnzYUlPVZ9A8uQkLw0jEQt+BzifyGLH
	 OfIsQ0SC5y6KYiC2DnV0WO6tYJ9zR2IP0ZuYSCa7FmDp0n/ftWgepgC/PhWbVZaFxxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551011;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=5Xz6Dtq+wq+1buX+CnU2zQmWn060HNZJMe0vWvAGlqs=;
	b=ier3Hvv1IHvebA/hzpGj0VZDllouEBfw4kf8tX1tjKbP5bNYVn1px1ZCVtgdWe7JfrxN
	 Oox0fbNk/tZsGvLiTAH3DZeSOeEaOa3c2oQkkBHHGYr6h2rnzkMxGxv4y/tPHghT8+IxJ
	 zLbzOCGwD8uGpyTvZzdAoJ5qdvEC0Iy6hmomOfy58S9werCsJApZ6QwtkeybdVrGuaIWM
	 jBbrWkibCsCayFDKJn9r10hHC6GcGQ/q/UnA2Gy1vNGw9xlFax5BEAj2uA2SJZgyZjo2w
	 wYVJudyEFdsH6YFKjxNe0z4DHKIaRa/M/AlXaBtc8QaONV6smbXMUgeCfv7gWsMzp+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="btpT5X/q";
	arc=none smtp.remote-ip=212.227.17.20
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6E606A326
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 20:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7E6E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=btpT5X/q
DKIM2-Signature:  i=1; m=1; t=1795551008;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.de;
 s=s31663417:rsa-sha256:LpBrOfsxtyeLQ0TQ3cNVDGmOngSC
   /ncNi1/M2DwDUcmi80gs6ZkocNXhJh55cB1iGGgjg5qFJ8Zz3QhPiLrCbL1YrPW3jfhInaQLR5+
   +7nkr6dux9OYiBdUHExY6Ya1HBv4GXAnEdjOS+m2LXUNXPI5fkrsfTELMq1PRlkbLTJlSwdig0x
   i15QYS5oPkcMJ0+/Y0znHuwzxunMRAdFlf21dVUllmR/v5jyAulgOCsQX570/ILe0V6XbY36B2M
   4KxHKxXEvJo/n96isySxbIZ7p11C8eS9+iG50BTl+s48A6uM3CB2xr/J7PL0QiupniRNq1LfUhs
   xa2KLWmAx5cEtQ==;
Message-Instance:  m=1;
 h=sha256:
   LJjM84DaSF355nmHVclyASiMa51azJtV0asniBpOgPM=:
   5Xz6Dtq+wq+1buX+CnU2zQmWn060HNZJMe0vWvAGlqs=,
  sha512:
   Ubk7aEVnEpcqyNA8crhP5yO3NGidV4kjEH3LEUEF4Avz24w/h7azpjmxW1Wri3io+LPI8jlpWGn3FrlKE+k93Q==:
   7GGJe1BDeAuqjnunq3H81JFNeh1nE8uRfXuFYALm8A0rSZXDtGQV9Kcx3TBLjxhuTAL42AMhIrfWAuksOXz9JQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795551005; x=1796155805; i=w_armin@gmx.de;
	bh=5Xz6Dtq+wq+1buX+CnU2zQmWn060HNZJMe0vWvAGlqs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=btpT5X/qQg5HIJESxqPy1mXt67WHiEvznvmxukkyg5vjZ3uOeFRqza1xj2hXoChW
	 LW94ffX02KYXEY5IP3YYiHgUlj5NgNLA9BNIZgQun6CyxAdlzRibf8dX8yhS3gXcI
	 SVZYN5NtMqr+1tTuvQDUQ4BjcMYzmi/Qo7u12FMyTDgGmYqtcnDSvqHYIKvQCRfB5
	 hAYHWtfyADvkI2CawuaAE7sFIH6Zzktlruue9PjVAwyOA0vOX89ezQCLHPFWcis6I
	 DPCj9bzJXbI9cYB73YCj9+ip5CymAIKRlM+gZ0ETbBdIzPzyc7UQh9hlubnodXjal
	 Q/2Fl7Cx81TK0Al4Gg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWigq-1y2qrk30hc-00YcOT; Tue, 24
 Nov 2026 21:10:04 +0100
Message-ID: <4258d1af-f088-4d04-835d-b769264d1f9b@gmx.de>
Date: Tue, 24 Nov 2026 21:10:03 +0100
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
Subject: Re: [PATCH v1 0/5] ACPI: fan: Assorted cleanups
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <3985766.kQq0lBPeGt@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3985766.kQq0lBPeGt@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NfEfoIsBd1T3Q88J/8HjnheasBPtpNCKb3Fodm9zmYatjDfvP1W
 AevmWUM8nltBEzkG5pzWwf/2eum3SiYHwHdQUjVE1dpk/3z3ehtWA/fhLvEfqantkOX7GMD
 7BSLdNrx4DmEIBf1xDjVNjWNgA8CyY4/oLk+dxnyGOKjSCgY/rer3wHRpLp3MUZZxuCF5JP
 b4veZ44qp3936NhMwhH4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:T3BTyPjNFPw=;LUE1WcvigR4sTUhCqnrdCDZBFZu
 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
 UD7WNbSi92KVkNJEjywAHWp0R/KEOp7wekcQ==

Am 24.11.26 um 16:45 schrieb Rafael J. Wysocki:

> Hi All,
>
> This is a series of assorted ACPI fan driver cleanup.
>
> Thanks!

For the whole series:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

