Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E43E5EC6;
	Thu, 30 Jul 2026 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452261; cv=none; b=ghq0gC5vMrGPPXsLdpoO78jMUwC1YefBqOrUNGR0ePLKYucyYlr08OJhLoMNxqUd7kvfZ3m27qQ3pZtYo5JvFBECyZVBRacto4Vlr/TXO/x5wZ/EaLb4RJubLjKIQDS4LC/u9VGb1fXAxFtKusJoUFhc4VNKwp64YFUlaPh7knI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452261; c=relaxed/simple;
	bh=AptO/UMO35Wdw/MyDJX6/5WzVJzXi7dd1ndUzlUeJBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJwiOYyBs0GmAV/KYAsJQDPfttA0s1mTajvc4U9pFdkrGKieUq40zT2CCGYikrr0eakMNt2DUs+LXfXVcDfFW7dLUTwujQjHPsXLoXfq4upEk98kVmpxX6ox5Q6vCdyPn/AhTft8T5efQoyC/o013ddVCx8oXXdMwX4twC/WREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2ttGjQq6; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2ttGjQq6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=rq6DhXoJSfP2dTmR2uAW9IXm4yZ2ZNBtw1Qq8dDX+to=; b=2ttGjQq6wv/PFdL46LUIruGsJs
	x0IWZtDuHz4T2vVpzCJwdPaGOmT1vJq1THzn7zLG1w0FgQ4VTYnM5r2sltBEKYG7oAiESZNMrXbhR
	8S9xvDph4SY2dxBB9BbZ63PFbwEIE322ZVZGF1caxXAq9F5LvG2RQ22kOfUNjD7BEVn5dVpaLkrHY
	6GRkUGfw9S9Vk3kvpNjuPXd15a3DYfxTQ8qi/rC7oV3P9d1urDQiYZjX7STv/n74BnrRvSI6uMpS6
	YZunVSm3ECSbT83vL+TqGT9SV0fUar5VkJ6ON20mrD5ZKsB67JchJYXuLpI5wp5+DQDobRjenxdA7
	mTKIqsbg==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject:
 Re: [RFC PATCH v2 2/8] pmdomain/rockchip: add optional per-domain power-on
 settle delay
Date: Fri, 31 Jul 2026 00:57:33 +0200
Message-ID: <10568528.L8ug28u51p@diego>
In-Reply-To: <20260730113239.1417912-1-gahing@gahingwoo.com>
References:
 <20260718031146.3368811-3-gahing@gahingwoo.com> <3322194.D8ZAKjAxdT@diego>
 <20260730113239.1417912-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 30. Juli 2026, 13:32:38 Mitteleurop=C3=A4ische Sommerzeit sc=
hrieb Jiaxing Hu:
> Hi Heiko,
>=20
> Thanks for looking.
>=20
> Understood on the naming. The suffixes describe the fields the macro
> sets, so a variant that also carries a wakeup delay should say so. In v3
> I will add
>=20
>   DOMAIN_M_O_R_G_W(..., g_mask, delay, wakeup)
>=20
> and leave DOMAIN_M_O_R_G with its current signature, with DOMAIN_RK3576
> switched over to the _W form. That also keeps the diff off the macro
> every other SoC goes through, which is nicer than what I sent.
>=20
> One note while I am there: DOMAIN_RK3576 is DOMAIN_M_O_R_G's only
> in-tree user, so after this the plain form has no callers left. I will
> keep it as you asked; say the word if you would rather it just gained
> the parameter after all.

Please this ... i.e. not keep the then unused variant around.
As you said RK3576 is the only user, so just rename that DOMAIN_*
macro please.

Heiko


