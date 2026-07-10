Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F44302EE;
	Fri, 10 Jul 2026 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694965; cv=none; b=aIgqEflQ0/YQbVv6sA8TqkFBaY8QFw0SDa2gmc0q0QCaNxPn8WQCKoFfn5WX/w8i8WukSTEQ2zcLHUzACuPPTZyBbPurGs9Ruo88+CP+VahxqFF7GHq3XceI85np16VTWMRW4uS6oD51jrAJT3tMgWvWy1AJSecaZ7ruUUdkBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694965; c=relaxed/simple;
	bh=HNRMsFFW9sbOTufo575Gsp5etSe6HFFk3WWc1fICwYA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITlsRg2Y6K03oMDdSLANm3yyXrpgj0SSKAzVwN9Xgx7oYVJ2nR1ymtc7+JI0Tg40g6pouTt8xIJYeTd3BqzdivzrLDERvH/UwidXKc4w/Ms0Lo7wAxutf1iRoQMJqVv2F+FAAMtzxXE9ntJuF2ze8WR5XXKjPTO4uJNIQ4Jud3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 372F9200687;
	Fri, 10 Jul 2026 16:49:16 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wiCXU-00162F-0R;
	Fri, 10 Jul 2026 16:49:16 +0200
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1wiCXU-00000000EZW-04xu;
	Fri, 10 Jul 2026 16:49:16 +0200
Message-ID: <6fd99dbdf7930a98d3dbbd44c0b39658c1d5efd4.camel@pengutronix.de>
Subject: Re: [PATCH v2 04/10] reset: Add reset_controller_get_provider()
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Sudeep Holla	
 <sudeep.holla@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Saravana Kannan <saravanak@kernel.org>, Ulf
 Hansson	 <ulfh@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Michael Turquette	 <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney	 <bmasney@redhat.com>, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>,  Vinod Koul <vkoul@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Kevin Hilman	
 <khilman@baylibre.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Kuninori Morimoto
 <kuninori.morimoto.gx@renesas.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-clk@vger.kernel.org, 	linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 10 Jul 2026 16:49:15 +0200
In-Reply-To: <c415dc5f468e62cd0e2a6b9639abb92a82c01324.1783505329.git.geert+renesas@glider.be>
References: <cover.1783505329.git.geert+renesas@glider.be>
	 <c415dc5f468e62cd0e2a6b9639abb92a82c01324.1783505329.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mi, 2026-07-08 at 12:16 +0200, Geert Uytterhoeven wrote:
> The reset subsystem differs from the clock subsystem in multiple ways:
>   1. It does not provide a public way to lookup resets from a reset
>      provider (clock has of_clk_get_from_provider()),
>   2. The xlate callback does not return a reset object, but merely an
>      index, which is converted to a reset object by the reset core.
>=20
> Hence add a public helper reset_controller_get_provider(), which just
> returns the provider, and will be used by the R-Car X5H Module
> Controller driver.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Please don't. Only the owning reset controller driver and the reset
core should interact with struct reset_controller_dev internals.

I'd be very uncomfortable with a driver reaching directly into another
drivers reset_control_ops, bypassing the core entirely.

I think it would be better to let reset-scmi export a specialized
scmi_reset_assert/deassert/reset(id) API, and add a possibility to
suppress registering the reset-scmi reset controller, so that there
aren't two conflicting paths into scmi_reset_proto_ops.

If you want to stack two reset controllers, the upper one should go
through the proper channels: request exclusive reset controls and use
them via the reset_control_*() APIs from the ops.


regards
Philipp
