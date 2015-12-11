From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2] cpufreq: i.MX6: -EPROBE_DEFER fixes
Date: Fri, 11 Dec 2015 18:23:11 +0100
Message-ID: <1449854591.29174.2.camel@pengutronix.de>
References: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55792 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752507AbbLKRXQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 12:23:16 -0500
In-Reply-To: <1446019154-16384-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>

Am Mittwoch, den 28.10.2015, 08:59 +0100 schrieb Sascha Hauer:
> The i.MX6 cpufreq driver can't cope with -EPROBE_DEFER returned from
> regulator_get/clk_get. This series fix that and some other small
> issues.
>=20
> Shawn, Could you give me your ack for patch 4/5?
>=20
> Sascha
>=20
What's the status of this series? I think I only had some minor
comments on the last round. Can you please fix those and resend the
series? It would be a shame if this misses 4.5, as it includes some
really nice cleanups and fixes.

Regards,
Lucas

> Changes since v1:
>=20
> - Fix Coding style nitpicks
> - drop unnecessary platform_device argument from
> =C2=A0 imx6q_cpufreq_get_resources
> - Add more comments
> - Use id_table to distinguish between SoCs
> - make PU regulator non optional on SoCs that need it and don't
> request
> =C2=A0 it on SoCs that don't need it
>=20
> ----------------------------------------------------------------
> Sascha Hauer (5):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq: imx6q: Fix goto wrong er=
ror label
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq: imx6q: Fix wrong device =
in devm_kzalloc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq: imx6q: Fix regulator/clo=
ck error handling
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq: imx6q: Use id_table to d=
istinguish between SoCs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpufreq: imx6q: pu regulator is n=
ot optional
>=20
> =C2=A0arch/arm/mach-imx/mach-imx6sl.c |=C2=A0=C2=A0=C2=A02 +-
> =C2=A0arch/arm/mach-imx/mach-imx6sx.c |=C2=A0=C2=A0=C2=A02 +-
> =C2=A0arch/arm/mach-imx/mach-imx6ul.c |=C2=A0=C2=A0=C2=A02 +-
> =C2=A0drivers/cpufreq/imx6q-cpufreq.c | 213 +++++++++++++++++++++++++=
+--
> ------------
> =C2=A04 files changed, 145 insertions(+), 74 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.html
