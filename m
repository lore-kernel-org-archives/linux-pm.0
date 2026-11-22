Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387863;
	b=hrxw/v5Vih6VB0UlOKX6kqViPXmP0w4BbXwNMqYmDO7tPlfJXOrrQM8AFlJY1irHTg8H
	 L0t0a2wZJVrkFZ8c3BlLmbLWDIOA8HunAs5obEjkeEsW1d1oQK2rHn2k8mrZQb5RKxR2U
	 tHNW5D+quCr7wGX/0yvhoAdZcZUKV3deRKdMndZiW00wqNWLrfcUyVMXgwmWl/FInanu5
	 bUVv7iBHN9zm0K7Qk1V/ppLjw6oNx98sDiHr2myizU312v/s6KODRBO4fWiYLNJH2Ymzq
	 mpHHbdCKnLvDr4P3J9JcLDk7JNamzdqLF/x1/Alz2eqHUtX5tLYXahYE/WtcmUw9sbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387863;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fL7U3381lRKl0leRXdHMgrHniLI1nUrxbkYQxcEjLqc=;
	b=itDPda2TK+HKhhMmfdlqGtejSF7hKiCm1DjEQ32S+VKYWgYKOEhNTppct7W1gK+YZryW
	 SldD2FgNXQWQye/5pUqff2RTo72PfdbIZpJ2KeHaLZvN9ithhs6632HgYoxl91O2Ku54P
	 1MctNe5nCbNS10DTAucwwfR33lcTM3RMRdOp+KhA18VfmF/YuSe33vpl6IWSpjFK0CYmS
	 8OqngFaiD18Oj0egbnHf4XsneQzklj+O4k7DxKRsUO0Ec00Fnj63Kdffx1Ngic316cXcB
	 8zMzCD1esY97y9e1lIv45Q2VZ7FSstN4A7fwaxaSwhLGbXuzJhXspZxEBiSMSrievzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ax3EThsO;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0468606A688;
	Sun, 22 Nov 2026 22:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0468606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ax3EThsO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=fL7U3381lRKl0leRXdHMgrHniLI1nUrxbkYQxcEjLqc=; b=ax3EThsOorRJywhBtMvHtFKJ38
	IswFG3psBt0fWq4p2CSsOGvDySCx+Z21iAS68wk6V+HfzXVUO3bRDkhzvClaRHsog4XLmyqjZXHfQ
	+in6YffJYuWjoEAUwwBnGyodjmtEVVD5EB05DlAp/H5qaEwSM6x+qAjoTMVfW5q3zQzER0lace1CH
	aEgBBXX06ABme8yHcX+/4UnFNMrddTAKO8TZSCKlKP1yqphzvmN8sEw8BJByvEonmc0fLqSoMA0G8
	9I+nLlbYNwiwh/i4ApYcd/CmbNI1bI9/b2kXznfEEUWLq3T2OEnQRdJIMpRabzRFbKwm+bX7xNm91
	hvT4NUmg==;
From: Heiko Stuebner <heiko@sntech.de>
To: ulfh@kernel.org,
	Leonard Lausen <leonard@lausen.nl>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	detlev.casanova@collabora.com,
	finley.xiao@rock-chips.com,
	zhangqing@rock-chips.com,
	inindev@gmail.com,
	linux-pm@vger.kernel.org,
	gahing@gahingwoo.com
Subject: Re: (subset) [PATCH 0/2] Fix Panfrost boot hang on NanoPi M5
Date: Sun, 22 Nov 2026 23:50:26 +0100
Message-ID: <179538782480.3150822.6529696700670964484.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019092417.391522-1-leonard@lausen.nl>
References: <20261019092417.391522-1-leonard@lausen.nl>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 Oct 2026 09:24:14 +0000, Leonard Lausen wrote:
> On the NanoPi M5, boot hangs during Panfrost initialization. Before this
> fix, booting required blacklisting Panfrost on the kernel command line.
> Loading Panfrost after boot reports a GPU power-domain acknowledgment
> timeout.
> 
> Enable regulator management for the RK3576 GPU power domain and connect
> its supply to the NanoPi M5 GPU rail.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: Fix GPU domain supply on NanoPi M5
      commit: ac5f8e47fcb2e7a5e5829968a406d2fbff63db8b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
